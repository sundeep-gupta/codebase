#!/usr/bin/perl
use Includes::Virex;


#&ChangePlist("ods.plist");
sleep 10;
#&VirexDaemonStatus;


$value1=&ConfigReaderValue ("VirexLogPath");
$value2=&ConfigReaderValue ("VirexApplication");
$value3=&ConfigReaderValue ("ODS_CleanDatasetPath");
$value4=&ConfigReaderValue ("VirexLauncherPath");
$value10=&ConfigReaderValue ("ReportFile");
$value11=&ConfigReaderValue ("CommandOnTestOver");
$value15=&ConfigReaderValue ("MainScriptpath");
$value99=&ConfigReaderValue ("VirexTaskDb");
$value98=&ConfigReaderValue ("VirexTaskID");


$calculationtmp = "/tmp/calculationtmp.tmp";
system (`rm $calculationtmp`);
$counter_value="cat counter.txt";
chomp $counter_value;

system ("sudo cat /dev/null > $value1"); 
system (`touch $value10`);
system (`echo "~~~~~~~~~~~~~~~~ODS-clean~~~~~~~~~~~~~~" >> $value10`);
$starttime =`date`;
print("$starttime");
chomp $starttime;
system(`echo "$starttime" >> $value10`);
system (`echo "$starttime" >> $calculationtmp`);
$startepoch=time();

#Start scan of dataset here
print "starting on-demand scanning\n";
&StartODS($value3, $value99, $value98); # (scanpath, VirexTaskdb, TaskID)

$endepoch=time();
$timetaken = $endepoch - $startepoch;

$endtime =`date`;
print("$endtime");
chomp $endtime;
system(`echo "$endtime" >> $value10`);
system (`echo "$endtime" >> $calculationtmp`);

#$timetaken = &CalculateTimeTaken($calculationtmp);

system(`echo "Time taken in seconds for this scan : $timetaken seconds" >> $value10`); 


############$timetaken = &CalculateTimeTaken($calculationtmp);
#system (`perl calculation.pl`);

#############system(`echo "Time taken in seconds for this scan : $timetaken seconds" >> $value10`); 

system (`echo "~~~~~~~~~~~~~~~~..~~~~~~~~~~~~~~" >> $value10`);

$counter_value=`cat counter.txt`;

#print("$counter_value\n");

$newcountervalue=$counter_value+1;
#print("$newcountervalue\n");
system(`echo "$newcountervalue"> counter.txt`);

#&VirexDaemonStatus;
##############
system(`$value11`);
##############
