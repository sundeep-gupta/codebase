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
use Modules::Monitor;
use Modules::Logger;
use Getopt::Long;
use Pod::Usage;
use Tie::Hash;
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

# Fetch our global configuration information
my $CONFIG = Config::new();

# Create our performance monitor
my $MONITOR = Monitor::new();

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

sub INT_handler {
    # Send error message to log file
    print "\n[" . $MONITOR->{'SESSION_ID'} . "]: AppMonitor is stopping....\n";
    logHistory("[" . $MONITOR->{'SESSION_ID'} . "]: AppMonitor is stopping....");
    exit(0);
}

$SIG{'INT'} = 'INT_handler';

# -----------------------------------------------------------
# MAIN:
# -----------------------------------------------------------

##print "The AppTool Performance Monitor is starting....\n";
logHistory("[" . $MONITOR->{'SESSION_ID'} . "]: AppMonitor is starting....");

# Capture the start time
my $startTime = time();
my $currentTime = 0;
my $elapsedTime = 0;
my $lastTimeValue = 0;
my $elapsed;

# We enter a never ending loop till we are given a 'Ctrl-C' value, then we exit gracefully
PERFMON: while ($elapsedTime <= $CONFIG->{'TEST_TIME_LENGTH'}) {
    ##print "Performance monitor on [localhost]: running....\n";
    
    # Collect the CPU metrics
    if ($CONFIG->{'CPU_STATS'}->{'COLLECT'} == 1) {
        my $info   = $MONITOR->getCpuMetrics($elapsedTime);
        my $stdout = $MONITOR->formatMetrics($info);
        my $retval = $MONITOR->recordMetrics($CONFIG->{'CPU_STATS'}->{'FILE'}, $stdout, $MONITOR->{'METRICS'}->{'CPU_STATS'});
    }
    
    # Collect the Memory metrics
    if ($CONFIG->{'MEMORY_STATS'}->{'COLLECT'} == 1) {
        my $info   = $MONITOR->getMemoryMetrics($elapsedTime);
        my $stdout = $MONITOR->formatMetrics($info);
        my $retval = $MONITOR->recordMetrics($CONFIG->{'MEMORY_STATS'}->{'FILE'}, $stdout, $MONITOR->{'METRICS'}->{'MEMORY_STATS'});
    }
    
    # Collect the Network metrics
    if ($CONFIG->{'NETWORK_STATS'}->{'COLLECT'} == 1) {
        my $info   = $MONITOR->getNetworkMetrics($elapsedTime);
        my $stdout = $MONITOR->formatMetrics($info);
        my $retval = $MONITOR->recordMetrics($CONFIG->{'NETWORK_STATS'}->{'FILE'}, $stdout, $MONITOR->{'METRICS'}->{'NETWORK_STATS'});
    }
    
    # Collect the Page Swap metrics
    if ($CONFIG->{'PAGE_SWAP_STATS'}->{'COLLECT'} == 1) {
        my $info   = $MONITOR->getPageSwapMetrics($elapsedTime);
        my $stdout = $MONITOR->formatMetrics($info);
        my $retval = $MONITOR->recordMetrics($CONFIG->{'PAGE_SWAP_STATS'}->{'FILE'}, $stdout, $MONITOR->{'METRICS'}->{'PAGE_SWAP_STATS'});
    }
    
    # Collect the Socket metrics
    if ($CONFIG->{'SOCKET_STATS'}->{'COLLECT'} == 1) {
        my $info   = $MONITOR->getSocketMetrics($elapsedTime);
        my $stdout = $MONITOR->formatMetrics($info);
        my $retval = $MONITOR->recordMetrics($CONFIG->{'SOCKET_STATS'}->{'FILE'}, $stdout, $MONITOR->{'METRICS'}->{'SOCKET_STATS'});
    }
    
    # Collect the Disk metrics
    if ($CONFIG->{'DISK_STATS'}->{'COLLECT'} == 1) {
        my $info   = $MONITOR->getDiskMetrics($elapsedTime);
        my $stdout = $MONITOR->formatMetrics($info);
        my $retval = $MONITOR->recordMetrics($CONFIG->{'DISK_STATS'}->{'FILE'}, $stdout, $MONITOR->{'METRICS'}->{'DISK_STATS'});
    }
    
    # Collect the Disk Usage metrics
    if ($CONFIG->{'DISK_USAGE'}->{'COLLECT'} == 1) {
        my $info   = $MONITOR->getDiskUsageMetrics($elapsedTime);
        my $stdout = $MONITOR->formatMetrics($info);
        my $retval = $MONITOR->recordMetrics($CONFIG->{'DISK_USAGE'}->{'FILE'}, $stdout, $MONITOR->{'METRICS'}->{'DISK_USAGE'});
    }
    
    # Collect the Load Average metrics
    if ($CONFIG->{'LOAD_AVG'}->{'COLLECT'} == 1) {
        my $info   = $MONITOR->getLoadAvgMetrics($elapsedTime);
        my $stdout = $MONITOR->formatMetrics($info);
        my $retval = $MONITOR->recordMetrics($CONFIG->{'LOAD_AVG'}->{'FILE'}, $stdout, $MONITOR->{'METRICS'}->{'LOAD_AVG'});
    }
    
    # Collect the File Stats metrics
    if ($CONFIG->{'FILE_STATS'}->{'COLLECT'} == 1) {
        my $info   = $MONITOR->getFileStatsMetrics($elapsedTime);
        my $stdout = $MONITOR->formatMetrics($info);
        my $retval = $MONITOR->recordMetrics($CONFIG->{'FILE_STATS'}->{'FILE'}, $stdout, $MONITOR->{'METRICS'}->{'FILE_STATS'});
    }
    
    # Collect the Process metrics
    if ($CONFIG->{'PROCESSES'}->{'COLLECT'} == 1) {
        my $info   = $MONITOR->getProcessMetrics($CONFIG->{'PROCESSES'}->{'LIST'},$elapsedTime);
        my $stdout = $MONITOR->formatMetrics($info);
        my $retval = $MONITOR->recordMetrics($CONFIG->{'PROCESSES'}->{'FILE'}, $stdout, $MONITOR->{'METRICS'}->{'PROCESSES'});
    }
    
    # Collect the Process Utilization metrics
    if ($CONFIG->{'PROCESS_UTIL'}->{'COLLECT'} == 1) {
        my $info   = $MONITOR->getProcessUtilMetrics($CONFIG->{'PROCESS_UTIL'}->{'LIST'},$elapsedTime);
        my $stdout = $MONITOR->formatMetrics($info);
        my $retval = $MONITOR->recordMetrics($CONFIG->{'PROCESS_UTIL'}->{'FILE'}, $stdout, $MONITOR->{'METRICS'}->{'PROCESS_UTIL'});
    }
    
    # Collect the Processor Stats for each processor
    if ($CONFIG->{'PROCESSOR_STATS'}->{'COLLECT'} == 1) {
        my $info   = $MONITOR->getProcessorStatMetrics($elapsedTime);
        my $stdout = $MONITOR->formatMetrics($info);
        my $retval = $MONITOR->recordMetrics($CONFIG->{'PROCESSOR_STATS'}->{'FILE'}, $stdout, $MONITOR->{'METRICS'}->{'PROCESSOR_STATS'});
    }
    
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
    
    last PERFMON if ($elapsedTime > $CONFIG->{'TEST_TIME_LENGTH'});
    
    sleep $CONFIG->{'INTERVAL'};
    
    redo PERFMON;
}

logHistory("[" . $MONITOR->{'SESSION_ID'} . "]: AppMonitor is stopping....");


__END__
