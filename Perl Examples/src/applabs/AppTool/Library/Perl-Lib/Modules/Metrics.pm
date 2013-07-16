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
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------


#
# getCpuCounters() - 
# Input:  
# Output: 
sub getCpuCounters {
    my $counters;
    if ($^O =~ /MSWin32/) {
        $counters = [
            "Elapsed Time",
            "User",
            "Nice",
            "System",
            "Idle",
            "IO_Wait",
            "IRQ",
            "Soft_IRQ"
        ];
    }
    else {
        $counters = [
            "Elapsed Time",
            "User",
            "Nice",
            "System",
            "Idle",
            "IOWait",
            "Uptime",
            "New"
        ];
    }
    return ($counters);
}

#
# getMemoryCounters() - 
# Input:  
# Output: 
sub getMemoryCounters { 
    my $counters;
    if ($^O =~ /MSWin32/) {
        $counters = [
            "Elapsed Time",
            "MemTotal",
            "MemFree",
            "Buffers",
            "Cached",
            "SwapCached",
            "Active",
            "Inactive",
            "HighTotal",
            "HighFree",
            "LowTotal",
            "LowFree",
            "SwapTotal",
            "SwapFree",
            "Dirty",
            "Writeback",
            "Mapped",
            "Slab",
            "Committed_AS",
            "PageTables",
            "VmallocTotal",
            "VmallocUsed",
            "VmallocChunk",
            "HugePages_Total",
            "HugePages_Free",
            "Hugepagesize",
        ];
    }
    else {
        $counters = [
            "Elapsed Time",
            "MemUsed",
            "MemFree",
            "MemUsedPer",
            "MemTotal",
            "Buffers",
            "Cached",
            "SwapUsed",
            "SwapFree",
            "SwapUsedPer",
            "SwapTotal"
        ];
    }
    return ($counters);
}

#
# getPageSwapCounters() - 
# Input:
# Output: 
sub getPageSwapCounters {
    my $counters;
    if ($^O =~ /MSWin32/) {
        $counters = [
            ""
        ];
    }
    else {
        $counters = [
            "Elapsed Time",
            "PageIn",
            "PageOut",
            "SwapIn",
            "SwapOut"
        ];
    }
    return ($counters);
}

#
# getNetworkCounters() - 
# Input: 
# Output: 
sub getNetworkCounters {
    my $counters;
    if ($^O =~ /MSWin32/) {
        $counters = [
            ""
        ];
    }
    else {
        $counters = [
            "Elapsed Time",
            "RxBytes",
            "RxPackets",
            "RxErrs",
            "RxDrop",
            "RxFifo",
            "RxFrame",
            "RxCompr",
            "RxMulti",
            "TxBytes",
            "TxPackets",
            "TxErrs",
            "TxDrop",
            "TxFifo",
            "TxColls",
            "TxCarr",
            "TxCompr"
        ];
    }
    return ($counters);
}

#
# getSocketCounters() - 
# Input: 
# Output:
sub getSocketCounters {
    my $counters;
    if ($^O =~ /MSWin32/) {
        $counters = [
            ""
        ];
    }
    else {
        $counters = [
            "Elapsed Time",
            "Used",
            "Tcp",
            "Udp",
            "Raw",
            "IpFrag"
        ];
    }
    return ($counters);
}

#
# getDiskCounters() - 
# Input: 
# Output:
sub getDiskCounters {
    my $counters;
    if ($^O =~ /MSWin32/) {
        $counters = [
            ""
        ];
    }
    else {
        $counters = [
            "Elapsed Time",
            "Major",
            "Minor",
            "ReadRequests",
            "ReadBytes",
            "WriteRequests",
            "WriteBytes",
            "TotalRequests",
            "TotalBytes"
        ];
    }
    return ($counters);
}

#
# getDiskUsageCounters() - 
# Input: 
# Output: 
sub getDiskUsageCounters {
    my $counters;
    if ($^O =~ /MSWin32/) {
        $counters = [
            ""
        ];
    }
    else {
        $counters = [
            "Elapsed Time",
            "Total",
            "Usage",
            "Free",
            "UsagePer",
            "MountPoint"
        ];
    }
    return ($counters);
}

#
# getLoadAvgCounters() - 
# Input: 
# Output: 
sub getLoadAvgCounters {
    my $counters;
    if ($^O =~ /MSWin32/) {
        $counters = [
            ""
        ];
    }
    else {
        $counters = [
            "Elapsed Time",
            "AVG_1",
            "AVG_5",
            "AVG_15",
            "RunQueue",
            "Count"
        ];
    }
    return ($counters);
}

#
# getFileStatCounters() - 
# Input: 
# Output: 
sub getFileStatCounters {
    my $counters;
    if ($^O =~ /MSWin32/) {
        $counters = [
            ""
        ];
    }
    else {
        $counters = [
            "Elapsed Time",
            "fhAlloc",
            "fhFree",
            "fhMax",
            "inAlloc",
            "inFree",
            "inMax",
            "Dentries",
            "Unused",
            "AgeLimit",
            "WantPages"
        ];
    }
    return ($counters);
}

#
# getProcessCounters() - 
# Input: 
# Output: 
sub getProcessCounters {
    my $counters;
    if ($^O =~ /MSWin32/) {
        $counters = [
            ""
        ];
    }
    else {
        $counters = [
            "Elapsed Time",
            "PPid",
            "Owner",
            "State",
            "PGrp",
            "Session",
            "TTYnr",
            "MinFLT",
            "CMinFLT",
            "MayFLT",
            "CMayFLT",
            "CUTime",
            "STime",
            "UTime",
            "CSTime",
            "Prior",
            "Nice",
            "StartTime",
            "ActiveTime",
            "VSize",
            "NSwap",
            "CNSwap",
            "CPU",
            "Size",
            "Resident",
            "Share",
            "TRS",
            "DRS",
            "LRS",
            "DT",
            "Comm",
            "CMDLINE",
            "Pid"
        ];
    }
    return ($counters);
}

#
# getProcessUtilCounters() - 
# Input: 
# Output: 
sub getProcessUtilCounters {
    my $counters;
    if ($^O =~ /MSWin32/) {
        $counters = [
            ""
        ];
    }
    else {
        $counters = [
            "Elapsed Time",
            "\%CPU Utilization",
            "\%Memory Utilization",
            "PID",
            "Command",
            "Process Memory Used",
            "Memory Used",
            "Memory Free",
            "\%Memory Used",
            "Memory Total",
            "Buffers",
            "Cached",
            "Swap Used",
            "Swap Free",
            "\%Swap Used",
            "Swap Total"
        ];
    }
    return ($counters);
}

#
# getProcessorStatCounters() - 
# Input: 
# Output: 
sub getProcessorStatCounters {
    my $counters;
    if ($^O =~ /MSWin32/) {
        $counters = [
            ""
        ];
    }
    else {
        $counters = [
            "Elapsed Time",
            "\%User",
            "\%Nice",
            "\%System",
            "\%IOwait",
            "\%IRQ",
            "\%Soft",
            "\%Idle",
            "Intr/sec."
        ];
    }
    return ($counters);
}

#
# getDatabaseCounters() - 
# Input: 
# Output: 
sub getDatabaseCounters {
    my $counters;
    if ($^O =~ /MSWin32/) {
        $counters = [
            ""
        ];
    }
    else {
        $counters = [
            ""
        ];
    }
    return ($counters);
}



1;

__END__
