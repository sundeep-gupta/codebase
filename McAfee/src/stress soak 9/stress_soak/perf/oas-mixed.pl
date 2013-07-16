#!/usr/bin/perl
use Includes::Virex;


&ChangePlist("oas-always.plist");
sleep 10;

&VirexDaemonStatus;



$value1=&ConfigReaderValue ("VirexLogPath");
$value2=&ConfigReaderValue ("VirexApplication");
$value3=&ConfigReaderValue ("OAS_MixedDatasetPath");
$value4=&ConfigReaderValue ("VirexLauncherPath");
$value10=&ConfigReaderValue ("ReportFile");
$value11=&ConfigReaderValue ("CommandOnTestOver");

$calculationtmp = "/tmp/calculationtmp.tmp";
$touchlist = "/tmp/touch-list.tmp";

$counter_value="cat counter.txt";
chomp $counter_value;

ExecuteTest();
ExecuteTest();

sub ExecuteTest(){

system (`rm -r $calculationtmp`);

system ("sudo cat /dev/null > $value1"); 
$starttime =`date`;
print("$starttime");

print "touching files";
#system (`perl touch-macv2.pl $value3 > touch-list.tmp`);

&TouchFilesPSS($value3);

sleep 8;

system (`touch $value10`);

sleep 120;
system (`echo "~~~~~~~~~~~~~~~~OAS-mixed~~~~~~~~~~~~~~" >> $value10`);
system(`echo "$starttime" >> $value10`);

sleep 120;

system (`head -1 $touchlist >> $value10`);
system (`tail -1 $touchlist >> $value10`);
system (`tail -2 $value10 > $calculationtmp`);

$timetaken = &CalculateTimeTaken($calculationtmp);

#system (`perl calculation.pl`);
system(`echo "Time taken in seconds for this scan : $timetaken seconds" >> $value10`); 

system (`echo "~~~~~~~~~~~~~~~~..~~~~~~~~~~~~~~" >> $value10`);

}

$counter_value=`cat counter.txt`;

#print("$counter_value\n");

$newcountervalue=$counter_value+1;
#print("$newcountervalue\n");
system(`echo "$newcountervalue"> counter.txt`);

&VirexDaemonStatus;
##############
system(`$value11`);
##############
