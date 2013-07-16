#!/usr/bin/perl
#################################### CPU/Mem Utilization during system is Idle ##################################
#                                                                                                               #
# Description : This script is used to calculate CPU/Mem utilization during system is idle                      #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 4-Sep-2009                                                                                      #
#                                                                                                               #
#################################### CPU/Mem Utilization during system is Idle ##################################

use strict;
use lib '/Volumes/Data/ssm_perf/';
use Includes::Virex;

main (); 

sub main 
{ 
  my $log_file;
  my $memusage; 

 
  # Keep the system Idle for 15 minutes...
  sleep 900; 

    
  $log_file ='/Volumes/DATA/ssm_perf/Reports/Cpu_Mem_Idle.log'; 
  ` > $log_file `; 

  system (`top -s 1 -l 1 > $log_file`);
  
  $memusage = '/Volumes/Data/ssm_perf/Calculate_cpu_memory.pl 2 &';
  system ($memusage);
  
}
