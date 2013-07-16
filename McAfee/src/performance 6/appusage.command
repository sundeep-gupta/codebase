#!/usr/bin/perl

use Time::Local;

sleep 20;

my $final_log = '/Volumes/DATA/ssm_perf/Reports/Application-Usage.log';
my $info;

if ("/usr/local/McAfee") {

    print "\n\t\t---MSM-SERVICE-INFO---\n";
    my $var1 = `ps -ax | grep /usr/local/McAfee/AntiMalware/VShieldScanner`;
    my $var2 = `ps -ax | grep /usr/local/McAfee/AppProtection/bin/appProtd`;
    my $var3 = `ps -ax | grep /usr/local/McAfee/Firewall/bin/FWService`;
    my $services_on_info;
    my $tmp_count_1 = scalar(split('\n',$var1));
    my $tmp_count_2 = scalar(split('\n',$var2));
    my $tmp_count_3 = scalar(split('\n',$var3));

    if ($tmp_count_1 > 3) {
        print "\t----ON-ACCESS-SCAN-IS-RUNNING----\n";
    #    $services_on_info = "----ON-ACCESS-SCAN-IS-RUNNING----\n";
    } else {
    #    $services_on_info = "----ON-ACCESS-SCAN-IS-NOT-RUNNING----\n";
        print "\t----ON-ACCESS-SCAN-IS-NOT-RUNNING----\n";
    }

    if ($tmp_count_2 > 1) {
        print "\t----appProtd-IS-RUNNING----\n";
    #    $services_on_info = "----ON-ACCESS-SCAN-IS-RUNNING----\n";
    } else {
    #    $services_on_info = "----ON-ACCESS-SCAN-IS-NOT-RUNNING----\n";
        print "\t----appProtd-SCAN-IS-NOT-RUNNING----\n";
    }

    if ($tmp_count_3 > 1) {
        print "\t----FWService-SCAN-IS-RUNNING----\n";
    #    $services_on_info = "----ON-ACCESS-SCAN-IS-RUNNING----\n";
    } else {
    #    $services_on_info = "----ON-ACCESS-SCAN-IS-NOT-RUNNING----\n";
        print "\t----FWService-SCAN-IS-NOT-RUNNING----\n";
    }

}

sleep 5;
execute();

sub execute (){
    print "\n\nStarting the Application Usage Execution\n\n";
    $total_time = 0; 

    $starttime1=time();
    system (`osascript /Volumes/Data/ssm_perf/Includes/AppleMail-Usage.scpt`);
    $endtime1 = time();
    $time1=$endtime1-$starttime1;
    $info1 .= "APPLE MAIL                 \t\t $time1\n";
    $starttime2=time();
    system (`osascript /Volumes/Data/ssm_perf/Includes/Entourage-Usage.scpt`);
    $endtime2 = time();
    $time2=$endtime2-$starttime2;
    $info2 .= "MICROSOFT ENTOURAGE        \t\t $time2\n";
    $starttime3=time();
    system (`osascript /Volumes/Data/ssm_perf/Includes/Word-Usage.scpt`);
    $endtime3 = time();
    $time3=$endtime3-$starttime3;
    $info3 .= "MICROSOFT WORD             \t\t $time3\n";
    $starttime4=time();
    system (`osascript /Volumes/Data/ssm_perf/Includes/PP-Usage.scpt`);
    $endtime4 = time();
    $time4=$endtime4-$starttime4;
    $info4 .= "MICROSOFT POWERPOINT       \t\t $time4\n";
    $starttime5=time();
    system (`osascript /Volumes/Data/ssm_perf/Includes/XL-Usage.scpt`);
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
