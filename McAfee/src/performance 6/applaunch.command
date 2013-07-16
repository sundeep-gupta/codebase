#!/usr/bin/perl

use Time::Local;

sleep 20;

my $final_log = '/Volumes/DATA/ssm_perf/Reports/Application-Launch.log';
my $info;

open (FP,"/Volumes/Data/ssm_perf/AppList.txt") || warn "Couldn't open config file for Application Launch Performance Test\n";
my @readme = <FP>;
close (FP);


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
    print "\n\nStarting the Application launch Execution\n\n";
    $total_time = 0; 
    foreach my $testcase(@readme) {
        chomp ($testcase);
        #get the start time
        $stime = time();
        #launch and close the app (through applescript)
        system (`osascript /Volumes/Data/ssm_perf/Includes/LaunchCloseApps.scpt "$testcase"`); 
        #get the end time
        $etime = time();
    
        $time=$etime-$stime;
        $total_time = $total_time+$time;

        $info .= "$testcase  \t\t$time secs\n";
    }
    print "\n\nEnding the Application launch Execution\n\n";
}



### Generate the log
open (FP,">>$final_log");
print FP "\n----APPLICATION-LAUNCH-TEST----\n\n" if ($check == 1); 
#print FP "\n----Run-No:$check----\n\n";
print FP "\n----$on_access_info----\n\n";
print FP "$info\n";
print FP "LAUNCH&CLOSE~TOTALTIME \t $total_time \n";
close (FP);
