#!/usr/bin/perl
use strict;
$root_path = '/Volumes/DATA/msmc_perf';
$ENV{ROOT_PATH} = $root_path;

use Time::Local;


my $final_log = "$root_path/Reports/Application-Launch.log";
my $info;

open (FP,"$root_path/AppList.txt") || warn "Couldn't open config file for Application Launch Performance Test\n";
my @readme = <FP>;
close (FP);

my $var = `ps -ax | grep /usr/local/McAfee/AntiMalware/VShieldScanner`;
my $tmp_count = scalar(split('\n',$var));
my $on_access_info;
if ($tmp_count > 2) {
    $on_access_info = "----ON-ACCESS-SCAN-IS-RUNNING----\n";
} else {
    $on_access_info = "----ON-ACCESS-SCAN-IS-NOT-RUNNING----\n";
}

execute();

sub execute (){
    print "\n\nStarting the Application launch Execution\n\n";
    $total_time = 0; 
    print "$on_access_info";
    foreach my $testcase(@readme) {
        chomp ($testcase);
        #get the start time
        $stime = time();
        #launch and close the app (through applescript)
        system (`osascript $root_path/Includes/LaunchCloseApps.scpt "$testcase"`); 
        #get the end time
        $etime = time();
    
        $time=$etime-$stime;
print "$stime --- $etime \n";
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
