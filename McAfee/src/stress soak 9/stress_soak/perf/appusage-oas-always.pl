#!/usr/bin/perl
use Includes::Virex;


#&ChangePlist("oas-always.plist");
#sleep 10;
#&VirexDaemonStatus;

$value10=&ConfigReaderValue ("ReportFile");
$value11=&ConfigReaderValue ("CommandOnTestOver");
sleep 30;
system(`cat eicar >> $value10`);

$counter_value=`cat counter.txt`;
chomp $counter_value;

#open (CONFIG, "AppUsageConfig.txt")  || warn "Couldn't open config file for Application Launch Perf test cases\n";
#my @configlines = <CONFIG>;
#close (CONFIG);

ExecuteTest();
ExecuteTest();

sub ExecuteTest(){
print "\n\nin execute test\n\n";
$time = 0; 
  system (`echo "~~~~~~~~~~~~~~~~OAS-AppUage Test 9 ALWAYS)~~~~~~~~~~~~~~" >> $value10`);
    #get the start time
    $stime = time();
    #launch and close the app (thru applescript)
   system (`osascript ../Includes/AppUsage.scpt`);  
   #get the end time
   $etime = time();
   $time=$etime-$stime;
    print("TOTAL TIME-----$time\n");
   system (`echo "TOTAL TIME-----$time" >> $value10`);
   system (`echo "~~~~~~~~~~~~~~~~..~~~~~~~~~~~~~~" >> $value10`);
}

$newcountervalue=$counter_value+1;
#print("$newcountervalue\n");
system(`echo "$newcountervalue"> counter.txt`);
#&VirexDaemonStatus;

system(`cat eicar >> $value10`);

##############Restart#####
system (`echo "~~~~~~~~~~~~~~~~reboot~~~~~~~~~~~~~~" >> $value10`);
system(`$value11`);
########################

