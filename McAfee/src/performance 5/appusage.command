#!/usr/bin/perl

use Time::Local;

my $final_log = "$ENV{ROOT_PATH}/ssm_perf/Reports/Application-Usage.log";
my $info;
my $var = `ps -ax | grep /usr/local/McAfee/AntiMalware/VShieldScanner`;
my $tmp_count = scalar(split('\n',$var));
my $on_access_info;
if ($tmp_count > 2) {
    $on_access_info = "----ON-ACCESS-SCAN-IS-RUNNING----";
} else {
    $on_access_info = "----ON-ACCESS-SCAN-IS-NOT-RUNNING----";
}

execute();

sub execute (){
    print "\n\nStarting the Application Usage Execution\n\n";
    $total_time = 0; 
    print "$on_access_info\n";

    $starttime1=time();
    system (`osascript $ENV{ROOT_PATH}/ssm_perf/Includes/AppleMail-Usage.scpt`);
    $endtime1 = time();
    $time1=$endtime1-$starttime1;
    $info1 .= "APPLE MAIL                 \t\t $time1\n";
    $starttime2=time();
    system (`osascript $ENV{ROOT_PATH}/ssm_perf/Includes/Entourage-Usage.scpt`);
    $endtime2 = time();
    $time2=$endtime2-$starttime2;
    $info2 .= "MICROSOFT ENTOURAGE        \t\t $time2\n";
    $starttime3=time();
    system (`osascript $ENV{ROOT_PATH}/ssm_perf/Includes/Word-Usage.scpt`);
    $endtime3 = time();
    $time3=$endtime3-$starttime3;
    $info3 .= "MICROSOFT WORD             \t\t $time3\n";
    $starttime4=time();
    system (`osascript $ENV{ROOT_PATH}/ssm_perf/Includes/PP-Usage.scpt`);
    $endtime4 = time();
    $time4=$endtime4-$starttime4;
    $info4 .= "MICROSOFT POWERPOINT       \t\t $time4\n";
    $starttime5=time();
    system (`osascript $ENV{ROOT_PATH}/ssm_perf/Includes/XL-Usage.scpt`);
    $endtime5 = time();
    $time5=$endtime5-$starttime5;
    $info5 .= "MICROSOFT EXCEL            \t\t $time5\n";

    $total_time = $total_time+$time1+$time2+$time3+$time4+$time5;

print "\n\nEnding the Application Usage Execution\n\n";
}

### Generate the log
open (FP,">>$final_log");
print FP "\n\n----APPLICATION-USAGE-TEST----\n";
#print FP "\n----RunNo:$check----\n\n";
print FP "\n----$on_access_info----\n\n";
print FP "$info1\n";
print FP "$info2\n";
print FP "$info3\n";
print FP "$info4\n";
print FP "$info5\n";

print FP "APPLICATION-USAGE-TOTALTIME\t\t$total_time \n";
close (FP);
