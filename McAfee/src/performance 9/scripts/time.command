#!/usr/bin/perl

use Time::Local;
use lib "/Volumes/DATA/msmc_perf";
use Includes::Virex;
use strict;

my $root_path = '/Volumes/DATA/msmc_perf';
$ENV{ROOT_PATH} = $root_path;

#####################
#Name : main function
#####################

my $log = '/var/log/system.log';
my $final_log = "$root_path/Reports/BootTime.log";
my $log_file = '/tmp/log';

my $command = `cp $log $log_file`; 
my $date = `date`;
chomp($date);
my $append = "$date" . " Logging in now";
open(FP,">>$log_file");
print FP $append;
print FP "\n";
close (FP);

$command = "cat $log_file" . ' | grep ' . "\"Login Window Started Security Agent\"";
my $output = `$command`;
my $count = scalar(split('\n',$output));
$command = "cat $log_file" . ' | grep ' . "\"reboot\"";
$output = `$command`;
my $Count = scalar(split('\n',$output));

open(FP,$log_file);
my @lines = <FP>;
close(FP);

my $cnt = 0;
my $Cnt = 0;
my $time_line_1;
my $time_line_2;
my $time_line_3;
my $time_line_4;

open (FP1,">>$root_path/Reports/time_test");
foreach my $line (@lines) {
    if ($line =~ /Login Window Started Security Agent/) {
        $cnt++;
        if ($cnt == $count) {
            $time_line_1 = $line;
            print "$time_line_1\n";
            print FP1 "$time_line_1\n"; 
        }
    }
    if ($line =~ /Logging in now/) {
        $time_line_2 = $line;
        print "$time_line_2\n";
        print FP1 "$time_line_2\n";
    }
    if ($line =~ /reboot/) {
        $Cnt++;
        if ($Cnt == $Count) {
            $time_line_3 = $line;
            print "$time_line_3 \n";
            print FP1 "$time_line_3\n";
        }
    }
}

close (FP1);

my @temp_1 = split (' ',$time_line_1);
my $t1 = $temp_1[2];

my @temp_2 = split (' ',$time_line_2);
my $t2 = $temp_2[3]; 

my @temp_3 = split(' ',$time_line_3);
my $t3 = $temp_3[2];

print "time1 = $t1 .. time2 = $t2 .. time3 = $t3\n";

my $time1 = convert_to_secs($t1);
my $time2 = convert_to_secs($t2);
my $time3 = convert_to_secs($t3);

print "time1 - $time1 .. time2 = $time2 .. time3 - $time3 \n";

my ($se) = difference($time2,$time1);
my $t = "\n\n LOGIN TIME : $se secs \n";
($se) = difference($time2,$time3);
$t .= "REBOOT TIME : $se secs \n";

print "$t\n";

open (FP,">>/$final_log");
print FP "$t\n";
close (FP);

#######################
# Sub : difference 
#######################


sub difference {
    my ($var1,$var2) = @_;
    my  $diff;
    if ($var1 > $var2) {
        $diff = $var1 - $var2;
    } else {
        $diff = $var2 - $var1;
    }
    return ($diff);
}

#######################
# Sub : convert_to_secs 
#######################

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
}

########### End of Code ###############
