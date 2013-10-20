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


package Monitor;

use System::Environment;
use Modules::Config;
use Modules::Metrics;
use Linux::Statistics;
use vars qw($METRICS);
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

my $METRICS = { 
    "CPU_STATS"       => getCpuCounters(),
    "MEMORY_STATS"    => getMemoryCounters(),
    "NETWORK_STATS"   => getNetworkCounters(),
    "PROCESSES"       => getProcessCounters(),
    "PAGE_SWAP_STATS" => getPageSwapCounters(),
    "SOCKET_STATS"    => getSocketCounters(),
    "DISK_STATS"      => getDiskCounters(),
    "DATABASE_STATS"  => getDatabaseCounters(),
    "DISK_USAGE"      => getDiskUsageCounters(),
    "LOAD_AVG"        => getLoadAvgCounters(),
    "FILE_STATS"      => getFileStatCounters(),
    "PROCESS_UTIL"    => getProcessUtilCounters(),
    "PROCESSOR_STATS" => getProcessorStatCounters()
};

# -----------------------------------------------------------
# MAIN FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input:  None
# Output: Object for performance monitoring
sub new {
    
    my $MONITOR = {
        "METRICS"    => $METRICS,
        "SESSION_ID" => time(),         # This is the directory of where the results are stored
        "START_TIME" => 0,              # Start time of the performance monitor
        "END_TIME"   => 0,              # End time of the performance monitor
        "SYSINFO"    => getSystemInfo()
    };
    
    bless $MONITOR, 'Monitor';   # Tag object with pkg name
    return $MONITOR;
}

#
# createResultsDir() - Create the directory where our results will be placed
# Input:  $MONITOR - Object
#         $session_id - The name of the folder where our current test run results will be stored (represents UNIX timestamp)
# Output: Returns zero on success or undef on failure
sub createResultsDir {
    my($MONITOR) = shift;
    my($session_id) = @_;
    
    # Make sure we have a valid session ID value
    unless (defined($session_id) && $session_id ne "") {
        print "ERROR: Did not receive a session ID value for createResultsDir().\n";
        exit;
    }
    
    my $resultsPath = $CONFIG->{'AGENT_PATH'} . "Results" . ( ($^O =~ /MSWin32/) ? "\\" : "/" );
    my $resultsDir = $resultsPath . $session_id . ( ($^O =~ /MSWin32/) ? "\\" : "/" );
    
    # Check if our directory already exists
    if (-d $resultsDir) {
        return;
    }
    
    # Make sure we remember where we are
    use Cwd;
    my $oldPath = cwd;
    if ($^O =~ /MSWin32/) {
        $oldPath =~ s/\//\\/g;
    }
    
    # Change into the directory where our results exist
    chdir($resultsPath) || die "Cannot chdir to: $resultsPath ($!) \n";
    
    # Define our current path
    my $currentPath = cwd;
    if ($^O =~ /MSWin32/) {
        $currentPath =~ s/\//\\/g;
    }
    
    # Create our directory
    mkdir($session_id,0777) || die "Cannot mkdir [$session_id]: $! \n";
    
    # Change back to old path when we finish, so relative paths continue to make sense
    chdir($oldPath);
    
    return 1;
}

#
# formatMetrics() - Format the performance metrics into a comma-delimited string
# Input:  $MONITOR - Object
#         $metrics - Array or Hash reference to the performance metrics captured
# Output: String containing our formatted performance metrics
sub formatMetrics {
    my($MONITOR) = shift;
    my($metrics) = shift;
    
    # Make sure we have values to format
    unless (defined($metrics)) {
        print "[" . time() . "]: An error occurred!  There were no performance metrics returned for formatting. Exiting....\n";
        exit;
    }
    
    # Define the following
    my $stdout;
    
    # If our data type is a hash, then we have network or process metrics
    if (ref($metrics) eq 'HASH') {
        while (my($key,$value) = each %{$metrics}) {
            my $tmp_stdout = "";
            foreach my $stat (@$value) {
                $tmp_stdout .= $stat . ",";
            }
            $tmp_stdout =~ s/(,)$//;
            
            # Return our metrics per device
            $stdout->{$key} = $tmp_stdout;
        }
    }
    else {
        # Iterate through each performance metrics and format the values
        $stdout = "";
        foreach my $stat (@$metrics) {
            $stdout .= $stat . ",";
        }
        $stdout =~ s/(,)$//;
    }
    
    return ($stdout);
}

#
# formatMetricHeadings() - Formats the headings of the performance metrics
# Input:  $MONITOR - Object
#         $headings - Array reference to the metric headings
# Output: Returns a string containing the formatted metric headings
sub formatMetricHeadings {
    my($MONITOR) = shift;
    my($headings) = shift;
    
    # Make sure we are receiving a valid array reference
    unless (ref($headings) eq 'ARRAY') {
        print "ERROR: The data type received in formatMetricHeadings() was not a valid array reference.\n";
        exit;
    }
    
    my @keys = @$headings;
    
    # Define the following
    my $stdout = "";
    
    # Iterate through each performance counter and format the values
    for (my $i=0; $i <= ($#keys); $i++) {
        $stdout .= $keys[$i] . ",";
    }
    
    $stdout =~ s/(,)$//;
    
    return ($stdout);
}

#
# recordMetrics() - Record the performance metrics to the results file
# Input:  $filename - String containing the file name of the metrics to record.
#         $content  - String or hash reference containing the performance metrics to record
#         $headings - Array reference containing a list of the performance counter names
# Output: Returns 1 if our file was successfully written, or undef on failure
sub recordMetrics {
    my($MONITOR) = shift;
    my($filename) = shift;
    my($content) = shift;
    my($headings) = shift;
    
    # Make sure we have the content
    unless (defined($content)) {
        print "[" . time() . "]: An error occurred!  The content could not be found for the performance metrics. Exiting....\n";
        exit;
    }

    # Define the following
    my $resultsPath = $CONFIG->{'AGENT_PATH'} . "Results" . ( ($^O =~ /MSWin32/) ? "\\" : "/" );
    my $resultsDir  = $resultsPath . $MONITOR->{'SESSION_ID'} . ( ($^O =~ /MSWin32/) ? "\\" : "/" );
    my $resultsFile = $resultsDir . $filename;
    
    my $rv;
    unless (-d $resultsDir) {
        $rv = $MONITOR->createResultsDir($MONITOR->{'SESSION_ID'});
        #logEvents("[Event]: Created results directory for session ID: [" . $MONITOR->{'SESSION_ID'} . "].");
    }
    
    # If our data type is a hash reference then we are dealing with network or process statistics
    if (ref($content) eq 'HASH') {
        # Find out what kind of metrics we are recording
        if ($filename =~ m/netstat/i) {
            foreach my $key (keys (%{$content})) {
                my $tmpResultsFile = $resultsDir . "network_" . $key . ".csv";
                # Append
                if (-e $tmpResultsFile) {
                    open(OUTFILE, ">>$tmpResultsFile") || die "Cannot append to $tmpResultsFile: $!\n";
                    print OUTFILE $content->{$key}."\n";
                    close(OUTFILE);
                }
                # Create
                else {
                    my $metric_headings = $MONITOR->formatMetricHeadings($headings);
                    open(OUTFILE, ">$tmpResultsFile") || die "Cannot create $tmpResultsFile: $!\n";
                    print OUTFILE "$metric_headings\n";
                    print OUTFILE $content->{$key}."\n";
                    close(OUTFILE);
                }
            }
        }
        elsif ($filename =~ m/process/i) {
            foreach my $key (keys (%{$content})) {
                my @procArray = split /,/, $content->{$key};
                my $procName = $procArray[30];
                $procName =~ s/^\(//;
                $procName =~ s/\)$//;
                my $tmpResultsFile = $resultsDir . "process_" . $procName . "_" . $key . ".csv";
                # Append
                if (-e $tmpResultsFile) {
                    open(OUTFILE, ">>$tmpResultsFile") || die "Cannot append to $tmpResultsFile: $!\n";
                    print OUTFILE $content->{$key}."\n";
                    close(OUTFILE);
                }
                # Create
                else {
                    my $metric_headings = $MONITOR->formatMetricHeadings($headings);
                    open(OUTFILE, ">$tmpResultsFile") || die "Cannot create $tmpResultsFile: $!\n";
                    print OUTFILE "$metric_headings\n";
                    print OUTFILE $content->{$key}."\n";
                    close(OUTFILE);
                }
            }
        }
        elsif ($filename =~ m/utilization/i) {
            foreach my $key (keys (%{$content})) {
                my @procArray = split /,/, $content->{$key};
                my $procName = $procArray[4];
                $procName =~ s/^\(//;
                $procName =~ s/\)$//;
                my $tmpResultsFile = $resultsDir . "utilization_" . $procName . "_" . $key . ".csv";
                # Append
                if (-e $tmpResultsFile) {
                    open(OUTFILE, ">>$tmpResultsFile") || die "Cannot append to $tmpResultsFile: $!\n";
                    print OUTFILE $content->{$key}."\n";
                    close(OUTFILE);
                }
                # Create
                else {
                    my $metric_headings = $MONITOR->formatMetricHeadings($headings);
                    open(OUTFILE, ">$tmpResultsFile") || die "Cannot create $tmpResultsFile: $!\n";
                    print OUTFILE "$metric_headings\n";
                    print OUTFILE $content->{$key}."\n";
                    close(OUTFILE);
                }
            }
        }
        elsif ($filename =~ m/procstat/i) {
            foreach my $key (keys (%{$content})) {
                my $tmpResultsFile = $resultsDir . "procstat_" . $key . ".csv";
                # Append
                if (-e $tmpResultsFile) {
                    open(OUTFILE, ">>$tmpResultsFile") || die "Cannot append to $tmpResultsFile: $!\n";
                    print OUTFILE $content->{$key}."\n";
                    close(OUTFILE);
                }
                # Create
                else {
                    my $metric_headings = $MONITOR->formatMetricHeadings($headings);
                    open(OUTFILE, ">$tmpResultsFile") || die "Cannot create $tmpResultsFile: $!\n";
                    print OUTFILE "$metric_headings\n";
                    print OUTFILE $content->{$key}."\n";
                    close(OUTFILE);
                }
            }
        }
        else {
            # Do nothing
        }
    }
    else {
        # Append
        if (-e $resultsFile) {
            open(OUTFILE, ">>$resultsFile") || die "Cannot append to $resultsFile: $!\n";
            print OUTFILE "$content\n";
            close(OUTFILE);
        }
        # Create
        else {
            my $metric_headings = $MONITOR->formatMetricHeadings($headings);
            open(OUTFILE, ">$resultsFile") || die "Cannot create $resultsFile: $!\n";
            print OUTFILE "$metric_headings\n";
            print OUTFILE "$content\n";
            close(OUTFILE);
        }
    }
    
    return 1;
}

#
# getCpuMetrics() - Capture the CPU metrics and output the results to an array
# Input:  
# Output: Array reference to the CPU metrics captured
sub getCpuMetrics {
    my ($MONITOR) = shift;
    my ($elapsed_time) = shift;
    my @statinfo;
    
    if ($^O =~ /MSWin32/) {
        
    }
    else {
        my $obj = Linux::Statistics->new( ProcStats => 1 );
        my $stats = Linux::Statistics->ProcStats();
        @statinfo = (
            $stats->{'User'},
            $stats->{'Nice'},
            $stats->{'System'},
            $stats->{'Idle'},
            $stats->{'IOWait'},
            $stats->{'Uptime'},
            $stats->{'New'}
        );
    }
    
    unshift(@statinfo,$elapsed_time);
    
    return (\@statinfo);
}

#
# getMemoryMetrics() - Capture the memory metrics and output the results to an array
# Input:  
# Output: Array reference to the memory metrics captured
sub getMemoryMetrics {
    my ($MONITOR) = shift;
    my ($elapsed_time) = shift;
    my @statinfo;
    
    if ($^O =~ /MSWin32/) {
        
    }
    else {
        my $obj = Linux::Statistics->new( MemStats => 1 );
        my $stats = Linux::Statistics->MemStats();
        @statinfo = (
            $stats->{'MemUsed'},
            $stats->{'MemFree'},
            $stats->{'MemUsedPer'},
            $stats->{'MemTotal'},
            $stats->{'Buffers'},
            $stats->{'Cached'},
            $stats->{'SwapUsed'},
            $stats->{'SwapFree'},
            $stats->{'SwapUsedPer'},
            $stats->{'SwapTotal'}
        );
    }
    
    unshift(@statinfo,$elapsed_time);
    
    return (\@statinfo);
}

#
# getNetworkMetrics() - Capture the network metrics and output the results to an array
# Input:  
# Output: Hash reference to the network metrics captured per device
sub getNetworkMetrics {
    my ($MONITOR) = shift;
    my ($elapsed_time) = shift;
    my %statinfo;
    
    my @exclude = qw(lo sit0);   # Network devices to exclude from returning
    
    if ($^O =~ /MSWin32/) {
        
    }
    else {
        my $obj = Linux::Statistics->new( NetStats => 1 );
        my ($net,$sum) = Linux::Statistics->NetStats();
        DEV: while(my($key,$value) = each %{$net}) {
            foreach my $dev (@exclude) {
                next DEV if ($key eq $dev);
            }
            my @stats_array = (
                $elapsed_time,
                $value->{'RxBytes'},
                $value->{'RxPackets'},
                $value->{'RxErrs'},
                $value->{'RxDrop'},
                $value->{'RxFifo'},
                $value->{'RxFrame'},
                $value->{'RxCompr'},
                $value->{'RxMulti'},
                $value->{'TxBytes'},
                $value->{'TxPackets'},
                $value->{'TxErrs'},
                $value->{'TxDrop'},
                $value->{'TxFifo'},
                $value->{'TxColls'},
                $value->{'TxCarr'},
                $value->{'TxCompr'}
            );
            $statinfo{$key} = \@stats_array;
        }
    }
    
    return (\%statinfo);
}

#
# getPageSwapMetrics() - Capture the page swap metrics and output the results to an array
# Input:  
# Output: Array reference to the page swap metrics captured
sub getPageSwapMetrics {
    my ($MONITOR) = shift;
    my ($elapsed_time) = shift;
    my @statinfo;
    
    if ($^O =~ /MSWin32/) {
        
    }
    else {
        my $obj = Linux::Statistics->new( PgSwStats => 1 );
        my $stats = Linux::Statistics->PgSwStats();
        @statinfo = (
            $stats->{'PageIn'},
            $stats->{'PageOut'},
            $stats->{'SwapIn'},
            $stats->{'SwapOut'}
        );
    }
    
    unshift(@statinfo,$elapsed_time);
    
    return (\@statinfo);
}

#
# getSocketMetrics() - Capture the socket metrics and output the results to an array
# Input:  
# Output: Array reference to the socket metrics captured
sub getSocketMetrics {
    my ($MONITOR) = shift;
    my ($elapsed_time) = shift;
    my @statinfo;
    
    if ($^O =~ /MSWin32/) {
        
    }
    else {
        my $obj = Linux::Statistics->new( SockStats => 1 );
        my $stats = Linux::Statistics->SockStats();
        @statinfo = (
            $stats->{'Used'},
            $stats->{'Tcp'},
            $stats->{'Udp'},
            $stats->{'Raw'},
            $stats->{'IpFrag'}
        );
    }
    
    unshift(@statinfo,$elapsed_time);
    
    return (\@statinfo);
}

#
# getDiskMetrics() - Capture the disk metrics and output the results to an array
# Input:  
# Output: Array reference to the disk metrics captured
sub getDiskMetrics {
    my ($MONITOR) = shift;
    my ($elapsed_time) = shift;
    my @statinfo;
    
    if ($^O =~ /MSWin32/) {
        
    }
    else {
        my $obj = Linux::Statistics->new( DiskStats => 1 );
        my $stats = Linux::Statistics->DiskStats();
        @statinfo = (
            $stats->{'Major'},
            $stats->{'Minor'},
            $stats->{'ReadRequests'},
            $stats->{'ReadBytes'},
            $stats->{'WriteRequests'},
            $stats->{'WriteBytes'},
            $stats->{'TotalRequests'},
            $stats->{'TotalBytes'}
        );
    }
    
    unshift(@statinfo,$elapsed_time);
    
    return (\@statinfo);
}

#
# getDiskUsageMetrics() - Capture the disk usage metrics and output the results to an array
# Input:  
# Output: Array reference to the disk usage metrics captured
sub getDiskUsageMetrics {
    my ($MONITOR) = shift;
    my ($elapsed_time) = shift;
    my %statinfo;
    
    if ($^O =~ /MSWin32/) {
        
    }
    else {
        my $obj = Linux::Statistics->new( DiskUsage => 1 );
        my $stats = Linux::Statistics->DiskUsage();
        
        while (my($key,$value) = each %{$stats}) {
            my @stats_array = (
                $elapsed_time,
                $value->{'Total'},
                $value->{'Usage'},
                $value->{'Free'},
                $value->{'UsagePer'},
                $value->{'MountPoint'}
            );
            $statinfo{$key} = \@stats_array;
        }
    }
    
    return (\%statinfo);
}

#
# getLoadAvgMetrics() - Capture the load average metrics and output the results to an array
# Input:  
# Output: Array reference to the load average metrics captured
sub getLoadAvgMetrics {
    my ($MONITOR) = shift;
    my ($elapsed_time) = shift;
    my @statinfo;
    
    if ($^O =~ /MSWin32/) {
        
    }
    else {
        my $obj = Linux::Statistics->new( LoadAVG => 1 );
        my $stats = Linux::Statistics->LoadAVG();
        @statinfo = (
            $stats->{'AVG_1'},
            $stats->{'AVG_5'},
            $stats->{'AVG_15'},
            $stats->{'RunQueue'},
            $stats->{'Count'}
        );
    }
    
    unshift(@statinfo,$elapsed_time);
    
    return (\@statinfo);
}

#
# getFileStatsMetrics() - Capture the file stats metrics and output the results to an array
# Input:  
# Output: Array reference to the file stats metrics captured
sub getFileStatsMetrics {
    my ($MONITOR) = shift;
    my ($elapsed_time) = shift;
    my @statinfo;
    
    if ($^O =~ /MSWin32/) {
        
    }
    else {
        my $obj = Linux::Statistics->new( FileStats => 1 );
        my $stats = Linux::Statistics->FileStats();
        @statinfo = (
            $stats->{'fhAlloc'},
            $stats->{'fhFree'},
            $stats->{'fhMax'},
            $stats->{'inAlloc'},
            $stats->{'inFree'},
            $stats->{'inMax'},
            $stats->{'Dentries'},
            $stats->{'Unused'},
            $stats->{'AgeLimit'},
            $stats->{'WantPages'}
        );
    }
    
    unshift(@statinfo,$elapsed_time);
    
    return (\@statinfo);
}

#
# getProcessMetrics() - Capture the given process metrics and output the results to an array
# Input:  
# Output: Hash reference to the process metrics captured
sub getProcessMetrics {
    my ($MONITOR) = shift;
    my ($processes) = shift;
    my ($elapsed_time) = shift;
    my %statinfo;
    
    if ($^O =~ /MSWin32/) {
        
    }
    else {
        my $procs = $MONITOR->getProcessesByName($processes);
        my $stats = $MONITOR->ProcessesByID($procs);   # Returns hash reference
        while(my($key,$value) = each %{$stats}) {
            my @stats_array = (
                $elapsed_time,
                $value->{'PPid'},
                $value->{'Owner'},
                $value->{'State'},
                $value->{'PGrp'},
                $value->{'Session'},
                $value->{'TTYnr'},
                $value->{'MinFLT'},
                $value->{'CMinFLT'},
                $value->{'MayFLT'},
                $value->{'CMayFLT'},
                $value->{'CUTime'},
                $value->{'STime'},
                $value->{'UTime'},
                $value->{'CSTime'},
                $value->{'Prior'},
                $value->{'Nice'},
                $value->{'StartTime'},
                $value->{'ActiveTime'},
                $value->{'VSize'},
                $value->{'NSwap'},
                $value->{'CNSwap'},
                $value->{'CPU'},
                $value->{'Size'},
                $value->{'Resident'},
                $value->{'Share'},
                $value->{'TRS'},
                $value->{'DRS'},
                $value->{'LRS'},
                $value->{'DT'},
                $value->{'Comm'},
                $value->{'CMDLINE'},
                $value->{'Pid'}
            );
            $statinfo{$key} = \@stats_array;
        }
    }
    
    return (\%statinfo);
}

#
# getProcessUtilMetrics() - Function that captures the given process CPU and Memory utilization statistics 
#                           and returns it as an array reference
# Input:  
# Output: Array reference to the process utilization metrics captured
sub getProcessUtilMetrics {
    my ($MONITOR) = shift;
    my ($processes) = shift;
    my ($elapsed_time) = shift;
    my %statinfo;
    
    if ($^O =~ /MSWin32/) {
        
    }
    else {
        my $procs = $MONITOR->getProcessesByName($processes);
        my $stats = $MONITOR->ProcessUtilizationByID($procs);   # Returns hash reference
        my @stats_array;
        while (my($key,$value) = each %{$stats}) {
            my @stats_array = (
                $elapsed_time,
                $value->{'PercentCPU'},
                $value->{'PercentMemory'},
                $value->{'PID'},
                $value->{'Command'},
                $value->{'ProcessMemUsed'},
                $value->{'MemUsed'},
                $value->{'MemFree'},
                $value->{'MemUsedPer'},
                $value->{'MemTotal'},
                $value->{'Buffers'},
                $value->{'Cached'},
                $value->{'SwapUsed'},
                $value->{'SwapFree'},
                $value->{'SwapUsedPer'},
                $value->{'SwapTotal'}
            );
            $statinfo{$key} = \@stats_array;
        }
    }
    
    return (\%statinfo);
}

#
# getProcessorStatMetrics() - Capture the CPU times of each processor and return the results as a hash reference
# Input:  $elapsed_time - 
# Output: Hash reference containing CPU times of each processor
sub getProcessorStatMetrics {
    my ($MONITOR) = shift;
    my ($elapsed_time) = shift;
    my %statinfo;
    
    if ($^O =~ /MSWin32/) {
        
    }
    else {
        my $stats = $MONITOR->ProcessorCpuStats();   # Returns hash reference
        my @stats_array;
        while (my($key,$value) = each %{$stats}) {
            my @stats_array = (
                $elapsed_time,
                $value->{'PercentUser'},
                $value->{'PercentNice'},
                $value->{'PercentSystem'},
                $value->{'PercentIOwait'},
                $value->{'PercentIRQ'},
                $value->{'PercentSoft'},
                $value->{'PercentIdle'},
                $value->{'InterruptsPerSec'}
            );
            $statinfo{$key} = \@stats_array;
        }
    }
    
    return (\%statinfo);
}

#
# getSystemInfo() - Capture some basic system information and return the results as a hash reference
# Input:  Nothing
# Output: Hash reference containing some basic system information
sub getSystemInfo {
    # Return info based upon OS
    my $stats;
    if ($^O =~ /MSWin32/) {
        
    }
    else {
        my $obj = Linux::Statistics->new( SysInfo => 1 );
        $stats = Linux::Statistics->SysInfo();
    }
    
    return ($stats);
}

#
# ProcessesByID() - Returns a list of process stats based upon a given process list
# Input:  $procList - Array reference containing a list of all the processes (by name) we want to capture stats for.
# Output: 
sub ProcessesByID {
    my ($self) = shift;
    my ($procList) = shift;
    
    my (%sps,%userids);
    
    # We parse our process list
    my @prc;
    my %procRef = %$procList;
    foreach my $key (keys %procRef) {
        foreach my $prx ( @{$procRef{$key}} ) {
            push (@prc, $prx);
        }
    }
    
    # Define the following files
    my $passwd_file = "/etc/passwd";
    my $uptime_file = "/proc/uptime";
    my $procdir     = "/proc";
    
    # we trying to get the UIDs for each linux user
    open my $fhp, '<', $passwd_file or die die "Statistics: can't open $passwd_file";
    
    while (defined (my $line = <$fhp>)) {
        next if $line =~ /^(#|$)/;
        my ($user,$uid) = (split /:/,$line)[0,2];
        $userids{$uid} = $user;
    }
    
    close $fhp;
    
    open my $fhu, '<', $uptime_file or die "Statistics: can't open $uptime_file";
    my $uptime = (split /\s+/, <$fhu>)[0];
    close $fhu;
    
    foreach my $pid (@prc) {
        #  memory usage for each process
        if (open my $fhm, '<', "$procdir/$pid/statm") {
            @{$sps{$pid}}{qw(Size Resident Share TRS DRS LRS DT)} = split /\s+/, <$fhm>;
            close $fhm;
        } else {
            delete $sps{$pid};
            next;
        }
        
        #  different other informations for each process
        if (open my $fhp, '<', "$procdir/$pid/stat") {
            @{$sps{$pid}}{qw(
                Pid Comm State PPid PGrp Session TTYnr MinFLT
                CMinFLT MayFLT CMayFLT UTime STime CUTime CSTime
                Prior Nice StartTime VSize NSwap CNSwap CPU
            )} = (split /\s+/, <$fhp>)[0..6,9..18,21..22,35..36,38];
            close $fhp;
        } else {
            delete $sps{$pid};
            next;
        }
        
        # calculate the active time of each process
        my $s = sprintf('%li',$uptime - $sps{$pid}{StartTime} / 100);
        my $m = 0;
        my $h = 0;
        my $d = 0;
        
        $s >= 86400 and $d = sprintf('%i',$s / 86400) and $s = $s % 86400;
        $s >= 3600  and $h = sprintf('%i',$s / 3600)  and $s = $s % 3600;
        $s >= 60    and $m = sprintf('%i',$s / 60);
        
        $sps{$pid}{ActiveTime} = sprintf '%02d:%02d:%02d', $d, $h, $m;
        
        # determine the owner of the process
        if (open my $fhu, '<', "$procdir/$pid/status") {
            while (defined (my $line = <$fhu>)) {
                $line =~ s/\t/ /;
                next unless $line =~ /^Uid:\s+(\d+)/;
                $sps{$pid}{Owner} = $userids{$1} if $userids{$1};
            }
            
            $sps{$pid}{Owner} = 'n/a' unless $sps{$pid}{Owner};
            close $fhu;
        } else {
            delete $sps{$pid};
            next;
        }
        
        #  command line for each process
        if (open my $fhc, '<', "$procdir/$pid/cmdline") {
            $sps{$pid}{CMDLINE} =  <$fhc>;
            $sps{$pid}{CMDLINE} =~ s/\0/ /g if $sps{$pid}{CMDLINE};
            $sps{$pid}{CMDLINE} =  'n/a' unless $sps{$pid}{CMDLINE};
            chomp $sps{$pid}{CMDLINE};
            close $fhc;
        }
    }
    
    return \%sps;
}

#
# getProcessesByName() - 
# Input: 
# Output:
sub getProcessesByName {
    my ($MONITOR) = shift;
    my ($procList) = shift;
    
    unless (defined($procList)) {
        return;
    }
    
    my %processes;
    foreach my $proc (@$procList) {
        my $procName = $proc->{'ProcessName'};
        my $cmd = "ps -C " . $procName . " -o pid=";
        my @output = `$cmd`;
        foreach (@output) {
            $_ =~ s/^\s+//;
            $_ =~ s/\s+$//;
        }
        $processes{$procName} = \@output;
    }
    
    return (\%processes);
}

#
# ProcessUtilizationByID() - 
# Input: 
# Output: 
sub ProcessUtilizationByID {
    my ($MONITOR) = shift;
    my ($processes) = shift;
    
    my %procs;
    
    # We parse our process list
    my @prc;
    my %procRef = %$processes;
    foreach my $key (keys %procRef) {
        foreach my $prx ( @{$procRef{$key}} ) {
            push (@prc, $prx);
        }
    }
    
    my $obj = Linux::Statistics->new( MemStats => 1 );
    my $stats = Linux::Statistics->MemStats();
    
    foreach my $pid (@prc) {
        my $cmd = 'ps -p ' . $pid . ' -o %cpu,%mem,pid,comm --no-heading';
        my $output = `$cmd`;
        $output =~ s/^\s+//;
        $output =~ s/\s+$//;
        my @stats = split /\s+/, $output;
        $procs{$pid} = {
            'PercentCPU'     => $stats[0],
            'PercentMemory'  => $stats[1],
            'PID'            => $stats[2],
            'Command'        => $stats[3],
            'ProcessMemUsed' => (($stats->{'MemTotal'} / 100) * $stats[1]),
            'MemUsed'        => $stats->{'MemUsed'},
            'MemFree'        => $stats->{'MemFree'},
            'MemUsedPer'     => $stats->{'MemUsedPer'},
            'MemTotal'       => $stats->{'MemTotal'},
            'Buffers'        => $stats->{'Buffers'},
            'Cached'         => $stats->{'Cached'},
            'SwapUsed'       => $stats->{'SwapUsed'},
            'SwapFree'       => $stats->{'SwapFree'},
            'SwapUsedPer'    => $stats->{'SwapUsedPer'},
            'SwapTotal'      => $stats->{'SwapTotal'}
        };
    }
    
    return \%procs;
}

#
# ProcessorCpuStats() - 
# Input: 
# Output: 
sub ProcessorCpuStats {
    my ($MONITOR) = shift;
    
    my %procs;   # Hash to return that contains our processor stats
    
    my $cmd = 'mpstat -P ALL';
    my @output = `$cmd`;
    PROCS:
    for (my $i=0; $i <= ($#output); $i++) {
        $output[$i] =~ s/^\s+//;
        $output[$i] =~ s/\s+$//;
        next PROCS if ($i < 3);
        next PROCS if ($output[$i] eq "");
        my @stats = split /\s+/, $output[$i];
        $procs{$stats[2]} = {
            'PercentUser'      => $stats[3],
            'PercentNice'      => $stats[4],
            'PercentSystem'    => $stats[5],
            'PercentIOwait'    => $stats[6],
            'PercentIRQ'       => $stats[7],
            'PercentSoft'      => $stats[8],
            'PercentIdle'      => $stats[9],
            'InterruptsPerSec' => $stats[10]
        };
    }
    
    return \%procs;
}

#
# logHistory() - This function logs any data passed to it. The history log contains server actions.
# Input:  $content - String containing the content to be logged
# Output: Returns 1 if successful and undef if failed
sub logHistory {
    my($content) = @_;
    
    my $log_file = $CONFIG->{'LOG_PATH'} . $CONFIG->{'LOG_FILE'};
    my $timestamp = fetchDate();
    
    # Make sure our content is defined
    if (defined($content) && ($content ne "")) {
        $content = "[$timestamp]: $content";
    }
    else {
        return;
    }
    
    # Append
    if (-e $log_file) {
        open(OUTFILE, ">>$log_file") || die "Cannot append to $log_file: $!\n";
        print OUTFILE "$content\n";
        close(OUTFILE);
    }
    # Create
    else {
        open(OUTFILE, ">$log_file") || die "Cannot create $log_file: $!\n";
        print OUTFILE "$content\n";
        close(OUTFILE);
    }
    
    return 1;
}

#
# logEvent() - This function logs any data passed to it. The event log contains command events (i.e. read, write, execute).
# Input:  $content - String containing the content to be logged
# Output: Returns 1 if successful and undef if failed
sub logEvent {
    my($content) = @_;
    
    my $log_file = $CONFIG->{'LOG_PATH'} . $CONFIG->{'EVENT_LOG'};
    my $timestamp = fetchDate();
    
    # Make sure our content is defined
    if (defined($content) && ($content ne "")) {
        $content = "[$timestamp]: $content";
    }
    else {
        return;
    }
    
    # Append
    if (-e $log_file) {
        open(OUTFILE, ">>$log_file") || die "Cannot append to $log_file: $!\n";
        print OUTFILE "$content\n";
        close(OUTFILE);
    }
    # Create
    else {
        open(OUTFILE, ">$log_file") || die "Cannot create $log_file: $!\n";
        print OUTFILE "$content\n";
        close(OUTFILE);
    }
    
    return 1;
}

#
# fetchDate() - This function creates a basic formatted timestamp
# Input:  Nothing
# Output: Returns the local time in the format of: 'MM/DD/YY - HH:MM:SS'
sub fetchDate {
    # Time Information
    my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    $year = $year + 1900;
    $mon  = $mon + 1;
    my $localtime = "$mon/$mday/$year - $hour:$min:$sec";
    return $localtime;
}



1;

__END__
