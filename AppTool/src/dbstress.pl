#!/usr/bin/perl -w
#
# Copyright:     AppLabs Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision:  $
# Last Modified: $Date:  $
# Modified By:   $Author:  $
# Source:        $Source:  $
#
####################################################################################
##
##

BEGIN {
    push @INC, "Library/Perl-Lib";
    push @INC, "Library/Perl-Lib/Modules";
} 

use Modules::Config;
use Modules::Stress;
use Modules::Logger;
use Modules::IO;
use Getopt::Long;
use Pod::Usage;
use threads;
use Tie::Hash;
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

# Fetch our global configuration information
my $CONFIG = Config::new();

my $IO = IO::new();

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

sub INT_handler {
    # Send error message to log file
    print "\n[" . time() . "]: DB-Stress is stopping....\n";
    logEvent("[" . time() . "]: DB-Stress is stopping.");
    exit(0);
}

$SIG{'INT'} = 'INT_handler';

# -----------------------------------------------------------
# MAIN:
# -----------------------------------------------------------

# Define our options
my $myThreads  = "";     # The number of threads to create
my $myFilename = "";     # The file name of the sql to pass to the stress tool
my $myOutput   = 0;      # Optional value that determines whether we should print any output or not

# Get our command line options
GetOptions (
    "t=s" => \$myThreads,
    "f=s" => \$myFilename,
    "p!"  => \$myOutput
);

# If they don't give us the correct parameters, then send a how-to
if (($myThreads eq "") || ($myThreads =~ m/[A-Za-z]/g)) {
    pod2usage(-exitstatus => 0);
}

# Find out what type of query we are using
my $query_type;
if ($myFilename =~ /select/gi) { $query_type = "select"; }
elsif ($myFilename =~ /insert/gi) { $query_type = "insert"; }
elsif ($myFilename =~ /update/gi) { $query_type = "update"; }
elsif ($myFilename =~ /delete/gi) { $query_type = "delete"; }

# Capture the start time
my $startTime = time();
my $currentTime = 0;
my $elapsedTime = 0;
my $lastTimeValue = 0;
my $elapsed;
print "Execution Start Time: \t $startTime \n" if ($myOutput == 1);
print "Starting database stress test with $myThreads thread(s)...... continuing.....\n\n" if ($myOutput == 1);
logEvent("[$startTime]: DB-Stress is starting.");
logEvent("[$startTime]: Starting database stress test with $myThreads thread(s).");

# Let's configure our results directory
my $results_timestamp = $IO->configureResultsDir($startTime);

# We enter a never ending loop till we are given a 'Ctrl-C' value, then we exit gracefully
DBSTRESS: while ($elapsedTime <= $CONFIG->{'TEST_TIME_LENGTH'}) {
    my $thread_count = 0;
    my @thread_list;
    my $avg_query_time = 0;
    
    print "Elapsed Time : $elapsedTime \t Test Time Length: " . $CONFIG->{'TEST_TIME_LENGTH'} . "\n\n" if ($myOutput == 1);
    
    # Encapsulate our database stress tests into threads
    for (my $i=0; $i < $myThreads; $i++) {
        # Put our threads into an array
        my ($thr) = threads->create( \&stressDatabase, $myFilename, $startTime );
        $thread_list[$thread_count] = $thr;
        $thread_count++;
        
        print "[Thread]: Database stress test initiated for thread " . $thread_count . ". \n" if ($myOutput == 1);
    }
    
    # Output status of threads
    print "\n[Status]: Completed sending request $thread_count out of $myThreads thread(s).... continuing.... \n\n" if ($myOutput == 1);
    
    # Harvest our threads
    my $count = 0;
    for (my $i=0; $i <= $#thread_list; $i++) {
        $count++;
        
        # Fetch our threads and any output (We assume the results are complete, since we've gotten this far)
        my @retval = $thread_list[$i]->join();
        my $response = join("", @retval);
        
        print "[Thread]: Query time for thread $count = $response \n" if ($myOutput == 1);
        $avg_query_time += $response;
    }
    
    # Calculate the average query time for each thread
    $avg_query_time = $avg_query_time / $count;
    print "[Average Query Time]: $avg_query_time \n" if ($myOutput == 1);
    
    # Calculate our elapsed time values
    $currentTime = time();
    if ($elapsedTime == 0) {
        $elapsed = $currentTime - $startTime
    }
    else {
        $elapsed = $currentTime - $lastTimeValue;
    }
    $elapsedTime += $elapsed;
    $lastTimeValue = $currentTime;

    # Capture our performance metrics
    my $metrics = $IO->getMetrics($elapsedTime, $avg_query_time);
    
    # Format our performance metrics
    my $stdout = $IO->formatMetrics($metrics);
    
    # Record the results
    my $temp_file = "query_" . $query_type . ".csv";
    my @headings = ("Elapsed Time", "Query Time");
    my $metric_retval = $IO->recordMetrics($results_timestamp, $temp_file, $stdout, \@headings);
    
    print "\n[Status]: Completed receiving response $count out of $myThreads thread(s).... continuing.... \n\n" if ($myOutput == 1);
    
    my $metric_ref = {
        "query_time" => $avg_query_time,
        "threads"    => $myThreads,
        "connected"  => $count,
        "query_type" => $query_type
    };
    writeQueryMetricsXML($metric_ref);
    
    last DBSTRESS if ($elapsedTime > $CONFIG->{'TEST_TIME_LENGTH'});
    
    sleep $CONFIG->{'INTERVAL'};
    
    redo DBSTRESS;
}

# Capture the end time
my $endTime = time();

logEvent("[" . $startTime . "]: DB-Stress is stopping.");

print "Execution End Time: \t $endTime \n" if ($myOutput == 1);
print "Execution Elapsed Time: \t " . ($endTime - $startTime) . " secs. \n" if ($myOutput == 1);
print "Execution 100\% Complete.\n\n" if ($myOutput == 1);

exit;


__END__

=head1 dbstress.pl - Creates multiple database connections which stress the given database.

=head1 SYNOPSIS

dbstress.pl [options] [file ...] 

    Options:
        --t     Number of concurrent connections to create
        --f     File name of the sql to use
        --p     Optional, if set will print to standard output

