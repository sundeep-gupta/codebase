#!/usr/bin/perl
###########################################  Start time calculation  ############################################
#                                                                                                               #
# Description : This script is used to calculate Reboot time based on System CPU utilization                    #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 25-Aug-2009                                                                                     #
#                                                                                                               #
###########################################  Start time calculation  ############################################

use lib "$ENV{ROOT_PATH}/ssm_perf/";
use Includes::Virex;

my $counter_file = &ConfigReaderValue ("CounterFile");
my $countervalue = &ConfigReaderValue ("counter");

my $cnt=`cat $ENV{ROOT_PATH}/ssm_perf/$counter_file`;
chomp($cnt);

if ($cnt > $countervalue)
{
  exit;
}


### Check if the user is root
if ($< != 0) {
    print "ERROR: You must login as root to execute this script. Exiting now ... \n\n";
    exit ( 1 );
}

my $boottime_log = "$ENV{ROOT_PATH}/ssm_perf/Reports/BootTime.log";
my $first_idletime=0;
my $shutdown_secs=shutdown_time(); 

main () ;

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

sub main 
{

  CPU_usage(); 

  my $temp_time=`cat /var/tmp/starttime`;
  my @temp_time=split(/[ ]+/,$temp_time);
  my $reb_start_time=convert_to_secs($temp_time[3]);
  my $reb_end_time=convert_to_secs($first_idletime);
  my $sht_end_time=convert_to_secs($shutdown_secs);
  
  my $reb_seconds = difference($reb_start_time,$reb_end_time); 
  my $sht_seconds = difference($reb_end_time,$sht_end_time); 
  #print "\nReboot start Time : $temp_time[3], Reboot end time : $first_idletime \n";

  open (FP,">>$boottime_log");
  print FP "START TIME : $sht_seconds secs \n"; 
  print FP "REBOOT TIME : $reb_seconds secs \n"; 
  close (FP);
}

sub shutdown_time
{ 
  my $log = '/var/log/system.log';
  my $log_file = '/tmp/log';
  my $command = `cp $log $log_file`;

  my $date = `date`;
  chomp($date);
  my $append = "$date" . " Logging in now";
  open(FP,">>$log_file");
  print FP $append;
  print FP "\n";
  close (FP);

  $command = "cat $log_file" . ' | grep ' .  "\"halt by\"";
  $output = `$command`;
  my $count_1 = scalar(split('\n',$output));

  $command = "cat $log_file" . ' | grep ' . "npvhash";
  my $output = `$command`;
  my $count_2 = scalar(split('\n',$output));

  open(FP,$log_file);
  my @lines = <FP>;
  close(FP);

  my $cnt_1 = 0;
  my $cnt_2 = 0;
  my $line_1;
  my $line_2;
  my $line_3;
  my $flag = 0;
  foreach my $line (@lines) {
      if ($line =~ /halt by/) {
          $cnt_1++;
          if ($cnt_1 == $count_1) {
              $line_1 = $line;
              #print "$line_1\n";
          }
      }
      if ($line =~ /npvhash/) {
         $cnt_2++;
         if ($cnt_2 == $count_2) {
              $line_2 = $line;
              $flag = 1;
              #print "$line_2\n";
          }
      }
      if ($line =~ /Logging in now/) {
          $line_4 = $line;
          #print "$line_4\n";
      }
  } 

  my @temp_1 = split (' ',$line_1);
  my $t1 = $temp_1[2];
  my @temp_2 = split (' ',$line_2);
  my $t2 = $temp_2[2];

  #print "\n Shutdown end time : $t2\n";
  
  return $t2;

} 
############################# END #####################################
