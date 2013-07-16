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
use lib "$ENV{ROOT_PATH}/ssm_perf/";
use Includes::Virex;

my $counter_file = &ConfigReaderValue ("CounterFile");
my $countervalue = &ConfigReaderValue ("counter");
my $memusage; 
my $cnt=`cat $ENV{ROOT_PATH}/ssm_perf/$counter_file`;
chomp($cnt);

if ($cnt > $countervalue)
{ 
  exit;
}

main ();

sub main 
{ 
  my $start_time; 
  my $end_time; 
  my $total_time_taken; 
  my $installtime_log = "$ENV{ROOT_PATH}/ssm_perf/Reports/InstallTime.log";
  open (FP,">>$installtime_log");
  
  $memusage = "$ENV{ROOT_PATH}/ssm_perf/scripts/Record_memory_usage.pl 1 &";
  system ($memusage);

  system_cleanup (); 
  $start_time=convert_to_secs(`date "+%H:%M:%S"`);
  install_product (); 
  $end_time=convert_to_secs(`date "+%H:%M:%S"`);
  $total_time_taken=difference($start_time,$end_time);
  print "\nIteration No ::: $cnt ::: Total time taken for installation is : $total_time_taken seconds\n\n\n"; 
  print FP "\n\nINSTALL TIME : $total_time_taken secs \n\n";
  sleep 10;
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
 
 $out=`installer -pkg $ENV{ROOT_PATH}/ssm_perf/Builds/MSM/*.mpkg -target /Applications/ 2>/dev/null`;
 
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
