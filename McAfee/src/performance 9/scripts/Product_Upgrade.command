#!/usr/bin/perl
####################################### Upgrade the product from VSMAC to MSM ###################################
#                                                                                                               #
# Description : This script is used to calculate the time taken to upgrade the product from VSMAC to MSM        #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 4-Sep-2009                                                                                      #
#                                                                                                               #
####################################### Upgrade the product from VSMAC to MSM ###################################
use lib "/Volumes/DATA/msmc_perf";
use Includes::Virex;
use strict;

my $root_path = '/Volumes/DATA/msmc_perf';
$ENV{ROOT_PATH} = $root_path;

my $counter_file = &ConfigReaderValue ("CounterFile");
my $countervalue = &ConfigReaderValue ("counter");
my $cnt=`cat $root_path/$counter_file`;
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
  my $upgradetime_log = "$root_path/Reports/UpgradeTime.log";
  open (FP,">>$upgradetime_log");
  
  if ( $< != "0" )
  { 
    print "\nError : Only ROOT user can run this script\n";
    exit 1;
  }
 
  system_cleanup (); 
  install_product (2); 
  $start_time=convert_to_secs(`date "+%H:%M:%S"`);
  install_product (1); 
  $end_time=convert_to_secs(`date "+%H:%M:%S"`);
  $total_time_taken=difference($start_time,$end_time);
  print "\nIteration No ::: $cnt ::: Total time taken for Upgradation is : $total_time_taken seconds\n";
  print FP "\n\nProduct Upgradation TIME : $total_time_taken secs \n\n";
  close (FP);
} 

#Un-install the product and make the system clean for installation
sub system_cleanup { 
  if ( -e "/usr/local/McAfee/" || -e "/Library/McAfee/cma/" || -e "/usr/local/vscanx/" )
  { 
     print "\nSome product components are already installed\n"; 
     print "\nUn-Installing the product components\n";
     `/usr/local/McAfee/uninstallMSC >/dev/null 2>&1`;
     `"/usr/local/vscanx/VirusScan Uninstall.command" >/dev/null 2>&1`;
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
 my @arg=@_;
 
 if ( $arg[0] == 2 )
 { 
   print "\nInstalling VSMAC Product, Please wait...\n";
   $out=`installer -pkg $root_path/Builds/VSMAC/*.mpkg -target /Applications/ 2>/dev/null`;
   if ( $out=~/installer: The install was successful/ )
   { 
     print "\nVSMAC Product Insrtallation is done\n"; 
   }  
 }  
 
 if ( $arg[0] == 1 )
 { 
   print "\nUpgrading the Product from VSMAC to MSM, Please wait...\n";
   $out=`installer -pkg $root_path/Builds/MSM/*.mpkg -target /Applications/ 2>/dev/null`;
   if ( $out=~/installer: The upgrade was successful/ )
   { 
     print "\nProduct is Upgraded to MSM\n"; 
   }  
 }  
} 