#!/usr/bin/perl
use Includes::Virex;


&ChangePlist("ods.plist");
sleep 10;

&VirexDaemonStatus;


$value10=&ConfigReaderValue ("ReportFile");
$value11=&ConfigReaderValue ("CommandOnTestOver");

$counter_value=`cat counter.txt`;
chomp $counter_value;

open (CONFIG, "AppListConfig.txt")  || warn "Couldn't open config file for Application Launch Perf test cases\n";
my @configlines = <CONFIG>;
close (CONFIG);

ExecuteTest();
ExecuteTest();

sub ExecuteTest(){
print "\n\nin execute test\n\n";

# Execute each test case taking each line from config file

 my $perflogfile = "/tmp/perf_application_list.tmp";
`rm -f $perflogfile`;
$total_time = 0; 
  system (`echo "~~~~~~~~~~~~~~~~OAS-Applaunch Test (NONE)~~~~~~~~~~~~~~" >> $value10`);
   foreach my $testcase(@configlines)
 
   { 
    
    chomp ($testcase);
    #get the start time
    $stime = time();
    #print "$testcase\n";
    #launch and close the app (thru applescript)
    system (`osascript ../Includes/LaunchCloseApps.scpt "$testcase"`); 
   
   #get the end time
   $etime = time();
    
   $time=$etime-$stime;
   $total_time = $total_time+$time;

   print("$testcase------$time\n");

	system (`echo "$testcase------$time" >> $value10`);
   }
print("TOTAL TIME-----$total_time\n");
system (`echo "TOTAL TIME-----$total_time" >> $value10`);

system (`echo "~~~~~~~~~~~~~~~~..~~~~~~~~~~~~~~" >> $value10`);

}

$newcountervalue=$counter_value+1;
#print("$newcountervalue\n");
system(`echo "$newcountervalue"> counter.txt`);
&VirexDaemonStatus;

##############Restart#####
system (`echo "~~~~~~~~~~~~~~~~reboot~~~~~~~~~~~~~~" >> $value10`);
system(`$value11`);
########################

