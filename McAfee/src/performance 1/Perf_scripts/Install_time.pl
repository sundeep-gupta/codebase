#!/usr/bin/perl
######################################### Product Installation Time #############################################
#                                                                                                               #
# Description : This script is used to install the product and measure the time required                        #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 4-Sep-2009                                                                                      #
# Input/Pre-requisit :                                                                                          # 
#      > 'root' user previlage is needed to run this script.                                                    #
#      > Copy Products installer package (i.e *.mpkg) to 'Builds/[MSM | VSMAC]/' directory                      #
# Output : Product will installed and time taken will be calculated                                             #
#                                                                                                               #
######################################### Product Installation Time #############################################

use strict;
use lib '/Volumes/Data/ssm_perf/';
use Includes::Virex;

main (); 

sub kill_memusage
{ 
 `ps -ax | grep Record_memory_usage.pl | awk ' { print $1;  } ' | xargs kill -9 2>/dev/null 1>/dev/null`; 
}

sub main 
{ 
  my $counter_file = &ConfigReaderValue ("CounterFile");
  my $maxcount = &ConfigReaderValue ("counter");
  my $cnt = `cat $counter_file`;
  chomp($cnt); 
  my $start_time; 
  my $end_time; 
  my $total_time_taken; 
  my $avg_Install_time=0; 
  my $installtime_log = '/Volumes/DATA/ssm_perf/Reports/InstallTime.log';
  open (FP,">>$installtime_log");
  
  ` > $installtime_log`;

  my $memusage; 
  $memusage = '/Volumes/Data/ssm_perf/Record_memory_usage.pl 1 &';
  system ($memusage);

  if ( $< != "0" )
  { 
    print "\nError : Only ROOT user can run this script\n";
    exit 1;
  } 
  
  while ( $cnt <= $maxcount ) 
  { 
    system_cleanup (); 
    $start_time=convert_to_secs(`date "+%H:%M:%S"`);
    install_product (); 
    $end_time=convert_to_secs(`date "+%H:%M:%S"`);
    $total_time_taken=difference($start_time,$end_time);
    $avg_Install_time=$avg_Install_time+$total_time_taken;
    print "\nIteration No ::: $cnt ::: Total time taken for installation is : $total_time_taken seconds\n\n\n"; 
    print FP "\n\nINSTALL TIME : $total_time_taken secs \n\n";
    $cnt = $cnt + 1;
    sleep 10;
  }
  
  $avg_Install_time=$avg_Install_time/$maxcount;
  print FP "\n\n.....Average Install Time is....... = $avg_Install_time\n\n"; 
  close (FP);
  kill_memusage ();
  
  $memusage = '/Volumes/Data/ssm_perf/Calculate_cpu_memory.pl 1 &';
  system ($memusage);
  
} 

#Un-install the product and make the system clean for installation
sub system_cleanup { 
  if ( -e "/usr/local/McAfee/" || -e "/Library/McAfee/cma/" )
  { 
     print "\nSome product components are already installed\n"; 
     print "\nUn-Installing the product components\n";
     `/usr/local/McAfee/uninstallMSC >/dev/null 2>&1`;
     `/Library/McAfee/cma/uninstall.sh >/dev/null 2>&1`; 
     print "\nProduct components are Un-installed\n";
     print "\nSystem is clean for installation\n";
  } 
} 

#Function to convert time to seconds
sub convert_to_secs {
   my $arg = shift;
   my ($hour, $min, $sec) = split (/:/, $arg);
   my $total_secs = 0;
   my $temp;
   if ($hour > 0) {
       $total_secs = $hour * 60 * 60;
   }
   if ($min > 0){
       $temp = $min * 60;
       $total_secs = $total_secs + $temp;
   }
   if ($sec > 0) {
       $total_secs = $total_secs + $sec;
   }
   return $total_secs ;
} 

#Function to get the difference between times 
sub difference
{
    my ($var1,$var2) = @_;
    my  $diff;
    if ($var1 > $var2)
    {
        $diff = $var1 - $var2;
    } else
    {
        $diff = $var2 - $var1;
    }
    return ($diff);
} 

#Function to Install the product 
sub install_product
{
 my $out;
 
 print "\nInstalling the Product, Please wait...\n";
 
 $out=`installer -pkg Builds/MSM/*.mpkg -target /Applications/ 2>/dev/null`;
 
 if ( $out=~/installer: The install was successful/ )
 { 
   print "\nProduct Insrtallation is done\n"; 
 }  
 else 
 { 
   print "\nProduct installation is failed\n";
   exit 1;  
 } 
} 
