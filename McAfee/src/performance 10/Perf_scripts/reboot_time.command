#!/usr/bin/perl
########################################### Reboot time calculation  ############################################
#                                                                                                               #
# Description : This script is used to calculate Reboot time based on System CPU utilization                    #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 25-Aug-2009                                                                                     #
#                                                                                                               #
########################################### Reboot time calculation  ############################################

use lib '/Volumes/Data/ssm_perf/';
use Includes::Virex;

### Check if the user is root
if ($< != 0) {
    print "ERROR: You must login as root to execute this script. Exiting now ... \n\n";
    exit ( 1 );
}

my $counter_file = &ConfigReaderValue ("CounterFile");
my $countervalue = &ConfigReaderValue ("counter");
my $cmd_path = '/Volumes/Data/ssm_perf/';
my $boottime_log = '/Volumes/DATA/ssm_perf/Reports/BootTime.log';

my $c = `cat $counter_file`;
chomp($c);

if ($c > $countervalue)
{ 
  exit; 
} 

if ($c == 0) 
{
    print "\n\n$c Run of $countervalue....\n\n";
    $c = $c + 1;
    system(`echo $c > $counter_file`);
    print "Rebooting the System ... \n";
    system ("date > /var/tmp/starttime"); 
    system(`reboot`);
}

my $first_idletime=0;

print "\n\n$c Run of $countervalue....\n\n";
CPU_usage(); 

my $temp_time=`cat /var/tmp/starttime`;
my @temp_time=split(/[ ]+/,$temp_time);
my $reb_start_time=convert_to_secs($temp_time[3]);
my $reb_end_time=convert_to_secs($first_idletime);

my $reb_seconds = difference($reb_start_time,$reb_end_time); 

open (FP,">>$boottime_log");
print FP "REBOOT TIME : $reb_seconds secs \n"; 
close (FP);

### Check and increment the counter
my $check = `cat $counter_file`;
chomp($check);
$check = $check + 1;
system(`echo $check > $counter_file`);

### Reboot the system till the iterations are completed
### Once all the iterations are completed, stop 

if ($check <= $countervalue) {
    print "Rebooting the System ... \n";
    system ("date > /var/tmp/starttime"); 
    system(`sudo reboot`);

} 
else {
    print "All runs completed !! Please check under /Volumes/DATA/ssm_perf/Reports/ for the logs. \n";
}

###################################################################################################
# This sub routine checks the CPU utilization and gives the time when system become stable        #
# Input : NONE                                                                                    #
# Output : Will set the global variable "first_idletime" to the time when system become stable    #
###################################################################################################

sub CPU_usage()
{ 
 my $counter=0;

 while( 1 )
 {
   $cpu=`sar -u 1 1 | sed -n '4p'`;
   ($time,$user,$nice,$sys,$idle)=split(/[ ]+ /,$cpu);

   if ($idle >= 90)
   {
     $counter++;
     print "Time : ".$time."    CPU Usage is : ".(100-$idle)."% \n";
     if ($counter == 1)
     {
       $first_idletime=$time;
     }

   } 
   else
   {
     print "Time : ".$time."    CPU Usage is : ".(100-$idle)."% \n";
     $counter=0;
   }

   if ($counter == 10)
   {
     last;
   }

 } # End of <while>

} # End of CPU_usage 

sub convert_to_secs {
   my $in = shift;
   my ($hour, $min, $sec) = split (/:/, $in);
   my $secs = 0;
   my $temp;
   if ($hour > 0) {
       $secs = $hour * 60 * 60;
   }
   if ($min > 0){
       $temp = $min * 60;
       $secs = $secs + $temp;
   }
   if ($sec > 0) {
       $secs = $secs + $sec;
   }
   return $secs;
} # End of convert_to_secs

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
} # End of difference

############################# END #####################################
