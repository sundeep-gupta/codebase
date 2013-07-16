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

use System::Environment;
use Modules::Config;
use Modules::Logger;
use Modules::IO;
use vars qw($DBI_DATABASE $DEFAULT_SQL_FILE);
use DBI;
use Time::HiRes qw(gettimeofday tv_interval);
use XML::Simple;
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();
my $IO = IO::new();

my $DBI_DATABASE = "NULL";

SWITCH: {
    if ($CONFIG->{'DB_DRIVER'} =~ /db2/i) { require DBD::DB2; $DBI_DATABASE = "DB2"; last SWITCH; }
    if ($CONFIG->{'DB_DRIVER'} =~ /mssql/i) { require DBD::ODBC; $DBI_DATABASE = "ODBC"; last SWITCH; }
    if ($CONFIG->{'DB_DRIVER'} =~ /mysql/i) { require DBD::mysql; $DBI_DATABASE = "mysql"; last SWITCH; }
    if ($CONFIG->{'DB_DRIVER'} =~ /oracle/i) { require DBD::Oracle; $DBI_DATABASE = "Oracle"; last SWITCH; }
    if ($CONFIG->{'DB_DRIVER'} =~ /postgres/i) { require DBD::Pg; $DBI_DATABASE = "Pg"; last SWITCH; }
    1;
}

my $DEFAULT_SQL_FILE = "apptest_select.sql";

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# stressDatabase() - Performs a stress test on a pre-defined database by creating multiple concurrent
#                    connections (threads), using a given SQL file
# Input:  $filename - String containing the file name of the given SQL file
#         $timestamp - String containing the timestamp of the results and directory extension where the results will be stored
# Output: $retval - String containing the query time of the given SQL query
sub stressDatabase {
    my ($filename) = shift;
    my ($timestamp) = shift;
    
    # Make sure we've defined our SQL file
    if (($filename eq "") || (!defined($filename))) {
        $filename = $DEFAULT_SQL_FILE;
    }
    
    # Check if we have persistent database connections or not (connections that remain open until the
    # stress test is complete
    my $retval;
    if (exists($CONFIG->{'PERSISTENT_CONN'}) && $CONFIG->{'PERSISTENT_CONN'} =~ /true/i) {
        persistentStress($filename);
    }
    else {
        $retval = queryDatabase($filename);
        if (!defined($retval)) {
            logEvent("[" . time() . "]: An error occurred. The SQL query [$filename] returned no data.");
        }
    }
    
    return ($retval);
}

#
# persistentStress() - Maintain a consistent and open database connection until our test ends
#                      TODO: copy queryDatabase() function, except keep db->connection open
# Input:  $filename - String containing the file name of the given SQL file
# Output: N/A
sub persistentStress {
    my ($filename) = shift;
    
    # We enter a never ending loop till we are given a 'Ctrl-C' value, then we exit gracefully
    STRESS: {
        queryDatabase($filename);
        sleep $CONFIG->{'INTERVAL'};
        redo STRESS;
    }
}

#
# queryDatabase() - Queries a database with a pre-defined SQL query, or uses a query from a given file
# Input:  $filename - String: Contains a string with the file name to use for the SQL query
# Output: String:  Contains the query time in seconds
sub queryDatabase {
    my ($filename) = shift;
    
    # Fetch our SQL statement
    my $sql;
    my $sql_file = $CONFIG->{'SQL_PATH'} . $filename;
    if (-e $sql_file) {
        $sql = getSqlQuery($sql_file);
    }
    else {
        $sql = getSqlQuery($CONFIG->{'SQL_PATH'} . $DEFAULT_SQL_FILE);
    }
    
    # Make sure we returned something
    unless (defined($sql)) {
        my $tempTime = time();
        logEvent("[" . $tempTime . "]: An error occurred. There was no SQL query that was returned from the file: [" . $sql_file . "].");
        logEvent("[" . $tempTime . "]: DB-Stress is stopping.");
        exit;
    }
    
    # We configure our DSN (data source name) based upon which type of database we are connecting to
    my $dsn;
    if ($CONFIG->{'DB_DRIVER'} =~ /^oracle/i) {
        $dsn = "DBI:Oracle:host=" . $CONFIG->{'DB_SERVER'} . ";sid=" . $CONFIG->{'DB_NAME'} . ";port=1521";
    }
    elsif ($CONFIG->{'DB_DRIVER'} =~ /^mssql/i) {
        $dsn = "DBI:ODBC:driver={SQL Server};server=" . $CONFIG->{'DB_SERVER'} . ";database=" . $CONFIG->{'DB_NAME'};
    }
    else {
        $dsn = "DBI:$DBI_DATABASE:" . $CONFIG->{'DB_NAME'} . ":" . $CONFIG->{'DB_SERVER'};
    }
    
    # Connect to our database
    my $dbh = DBI->connect( $dsn, $CONFIG->{'DB_USER'}, $CONFIG->{'DB_PASSWORD'} ) 
        or die "Can't connect to " . $CONFIG->{'DB_DRIVER'} . " at " . $CONFIG->{'DB_NAME'} . ":" . $CONFIG->{'DB_SERVER'};
    
    $dbh->{RaiseError} = 1;
    
    my $sth = $dbh->prepare($sql) or return undef;
    
    # Fetch our start time
    my $t0 = [gettimeofday];
    
    $sth->execute() or return undef;
    
    # Depending on the query type, perform the following
    my $rows;
    if ($sql =~ /insert/i) {
        #$rows = $sth->rows;
    }
    elsif ($sql =~ /select/i) {
        #$rows = $dbh->selectall_hashref($sql,1);
    }
    
    $sth->finish;
    $dbh->disconnect();
    
    # Fetch our end time
    my $t1 = [gettimeofday];
    my $elapsed = tv_interval ($t0, $t1);
    
    return ($elapsed);
}

#
# getSqlQuery() - Fetch the SQL query within the given file name and return it as a string
# Input:  $file_name - String containing the name of the file where the SQL query resides
# Output: String containing the SQL query or undef if an error occurs
sub getSqlQuery {
    my($filename) = @_;
    
    # Open up the selected file. If the file does not exist, then return an error message.
    unless (open INFILE, $filename) {
        return undef;
    }
    my @contents = <INFILE>;
    close (INFILE);
    
    my $rv;
    for (my $i=0; $i <= $#contents; $i++) {
        $contents[$i] =~ s/^\s+//;
        $contents[$i] =~ s/\s+$//;
        $rv .= $contents[$i];
    }
    return ($rv);
}

#
# writeQueryMetricsXML() - Function that outputs our query time and connection metrics to an xml file.
# Input:  Hash reference containing our metrics to output.
# Output: Returns 1 on success and 0 on failure.
sub writeQueryMetricsXML {
    my ($ref) = shift;
    
    my $hashref = { 
        "query_metrics" => {
            "query_time" => [ $ref->{'query_time'} ],
            "threads"    => [ $ref->{'threads'} ],
            "connected"  => [ $ref->{'connected'} ]
        }
    };
    
    my $xs = new XML::Simple(ForceArray => 1, KeepRoot => 1);
    my $xml = $xs->XMLout($hashref);
    
    # Output contents to our XML file
    my $xml_file = $CONFIG->{'LOG_PATH'} . "Temp" . ( ($CONFIG->{'OS'} =~ /MSWin32/) ? "\\" : "/" ) . $ref->{'query_type'} . ".xml";
    
    # Create
    open(OUTFILE, ">$xml_file") || die "Cannot write to $xml_file: $!\n";
    print OUTFILE "$xml\n";
    close(OUTFILE);
    
    return 1;
}


1;

__END__
