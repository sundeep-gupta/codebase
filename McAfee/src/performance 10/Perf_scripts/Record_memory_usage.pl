#!/usr/bin/perl
########################################### Record CPU/Mem utilization ##########################################
#                                                                                                               #
# Description : This script is used to capture CPU/Mem utilization                                              #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 4-Sep-2009                                                                                      #
#                                                                                                               #
########################################### Record CPU/Mem utilization ##########################################

use lib '/Volumes/Data/ssm_perf/';

my $log_file; 

if ($ARGV[0] == 1)
{ 
  $log_file ='/Volumes/DATA/ssm_perf/Reports/Cpu_Mem_Install.log';
} 

if ($ARGV[0] == 3)
{ 
  $log_file ='/Volumes/DATA/ssm_perf/Reports/Cpu_Mem_Update.log';
} 

if ($ARGV[0] == 4)
{ 
  $log_file ='/Volumes/DATA/ssm_perf/Reports/Cpu_Mem_Scan.log';
} 

`> $log_file`;

open (FP,">>$log_file");

while (1)
{
 system (`top -s 1 -l 1 >> $log_file`);
 sleep 10;
}  
