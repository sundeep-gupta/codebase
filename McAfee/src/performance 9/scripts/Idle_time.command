#!/usr/bin/perl
#################################### CPU/Mem Utilization during system is Idle ##################################
#                                                                                                               #
# Description : This script is used to calculate CPU/Mem utilization during system is idle                      #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 4-Sep-2009                                                                                      #
#                                                                                                               #
#################################### CPU/Mem Utilization during system is Idle ##################################

use strict;
use lib "/Volumes/DATA/msmc_perf";
use Includes::Virex;
my $root_path = '/Volumes/DATA/msmc_perf';
$ENV{ROOT_PATH} = $root_path;


my $counter_file = &ConfigReaderValue ("CounterFile");
my $countervalue = &ConfigReaderValue ("counter");
my $cnt=`cat $root_path/$counter_file`;
print "Conter file is $counter_file --- counter is $countervalue \n";
sleep 3;
chomp($cnt);

if ($cnt > $countervalue)
{
  exit;
}

main ();

sub main 
{ 
  my $log_file;

  # Keep the system Idle for 15 minutes...
  print "\nIteration No ::: $cnt\n"; 
  print "\nSystem will be Idle for 15 minutes\n";
  #sleep 900; 
  sleep 10; 
    
  $log_file ="$root_path/Reports/Cpu_Mem_Idle.log"; 

  system (`top -s 1 -l 1 >> $log_file`);
}
