#!/usr/bin/perl
########################################### Record CPU/Mem utilization ##########################################
#                                                                                                               #
# Description : This script is used to capture CPU/Mem utilization                                              #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 4-Sep-2009                                                                                      #
#                                                                                                               #
########################################### Record CPU/Mem utilization ##########################################

use lib "$ENV{ROOT_PATH}/ssm_perf/";

my $log_file; 

if ($ARGV[0] == 1)
{ 
  $log_file ="$ENV{ROOT_PATH}/ssm_perf/Reports/Cpu_Mem_Install.log";
} 

if ($ARGV[0] == 3)
{ 
  $log_file ="$ENV{ROOT_PATH}/ssm_perf/Reports/Cpu_Mem_Update.log";
} 

if ($ARGV[0] == 4)
{ 
  $log_file ="$ENV{ROOT_PATH}/ssm_perf/Reports/Cpu_Mem_Scan.log";
} 

while (1)
{
 system (`top -s 1 -l 1 >> $log_file`);
 sleep 30;
}  
