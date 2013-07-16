#!/usr/bin/perl 

use Time::Local;


#####################
#Name : main function
#####################

my $log = '/var/log/system.log';
my $final_log = "$ENV{ROOT_PATH}/ssm_perf/Reports/BootTime.log";
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
#$command = "cat $log_file" . ' | grep ' . "\"McAfee Agent stopped\"";
my $output = `$command`;
my $count_2 = scalar(split('\n',$output));

open(FP,$log_file);
my @lines = <FP>;
close(FP);


open(FP1,">>$ENV{ROOT_PATH}/ssm_perf/Reports/time_test");

my $cnt_1 = 0;
my $cnt_2 = 0;
my $line_1;
my $line_2;
my $line_3;
my $flag = 0;
foreach my $line (@lines) {
#    if ($flag == 1) {
#        $flag = 0;
#        $line_3 = $line;
#        print "$line_3\n";
#    }

    if ($line =~ /halt by/) {
        $cnt_1++;
        if ($cnt_1 == $count_1) {
            $line_1 = $line;
            print "$line_1\n";
            print FP1 "$line_1\n";
        }
    }
#    if ($line =~ /McAfee Agent stopped/) {
if ($line =~ /npvhash/) {
       $cnt_2++;
       if ($cnt_2 == $count_2) {
            $line_2 = $line;
            $flag = 1;
            print "$line_2\n";
            print FP1 "$line_2\n";
        }
    }
    if ($line =~ /Logging in now/) {
        $line_4 = $line;
        print "$line_4\n";
        print FP1 "$line_4\n";
    }
}
close(FP1);
my @temp_1 = split (' ',$line_1);
my $t1 = $temp_1[2];

my @temp_2 = split (' ',$line_2);
my $t2 = $temp_2[2];

#my @temp_3 = split (' ',$line_3);
#my $t3 = $temp_3[2];

my @temp_4 = split (' ',$line_4);
print "line_4 = $line_4\n";
my $t4 = $temp_4[3];
print "t4 = $t4 \n";

print "t1 = $t1 and t = $t2\n";
my $time1 = convert_to_secs($t1);
my $time2 = convert_to_secs($t2);
#my $time3 = convert_to_secs($t3);
#print "time3 = $time3 \n";
my $time4 = convert_to_secs($t4);
print "time4 = $time4 \n";

my ($se) = difference($time2,$time1);
my $t = "\n\n SHUTDOWN TIME : $se secs \n";

($se) = difference($time4,$time2);
$t .= "START TIME : $se secs \n";

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
   $secs = $hour * 60 * 60 if ($hour > 0);
   if ($min > 0){
       $temp = $min * 60;
       $secs = $secs + $temp;
   }
   $secs = $secs + $sec if ($sec > 0);
   return $secs;
}

########### End of Code ###############
 
