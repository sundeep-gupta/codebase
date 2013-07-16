#!/usr/bin/perl
########################################### Record CPU/Mem utilization ##########################################
#                                                                                                               #
# Description : This script is used to capture CPU/Mem utilization                                              #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 4-Sep-2009                                                                                      #
#                                                                                                               #
########################################### Record CPU/Mem utilization ##########################################
use lib "/Volumes/DATA/msmc_perf";
use Includes::Virex;
use strict;

my $root_path = '/Volumes/DATA/msmc_perf';
$ENV{ROOT_PATH} = $root_path;

my $log_file; 

if ($ARGV[0] == 1)
{ 
  $log_file ="$root_path/Reports/Cpu_Mem_Install.log";
} 

if ($ARGV[0] == 3)
{ 
  $log_file ="$root_path/Reports/Cpu_Mem_Update.log";
} 

if ($ARGV[0] == 4)
{ 
  $log_file ="$root_path/Reports/Cpu_Mem_Scan.log";
} 

while (1)
{
 system (`top -s 1 -l 1 >> $log_file`);
 sleep 30;
}  
