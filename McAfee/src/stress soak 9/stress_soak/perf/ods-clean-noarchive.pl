#!/usr/bin/perl
use Includes::Virex;


&ChangePlist("ods-noarchive.plist");
sleep 10;
&VirexDaemonStatus;


$value1=&ConfigReaderValue ("VirexLogPath");
$value2=&ConfigReaderValue ("VirexApplication");
$value3=&ConfigReaderValue ("ODS_CleanDatasetPath");
$value4=&ConfigReaderValue ("VirexLauncherPath");
$value10=&ConfigReaderValue ("ReportFile");
$value11=&ConfigReaderValue ("CommandOnTestOver");
$value15=&ConfigReaderValue ("MainScriptpath");

$calculationtmp = "/tmp/calculationtmp.tmp";
$counter_value="cat counter.txt";
chomp $counter_value;


system ("sudo cat /dev/null > $value1"); 
$starttime =`date`;
print("$starttime");

#launching virex here
system ("open $value2"); 

sleep 8;
#Start scan of dataset here
system (`$value4 -s $value3`); 



system (`touch $value10`);

#print "sleeping for 2 seconds\n";
sleep 2;
system (`echo "~~~~~~~~~~~~~~~~ods-noarchive~~~~~~~~~~~~~~" >> $value10`);
system(`echo "$starttime" >> $value10`);
system (`cat $value1 | grep --binary-files=text 'scan manually started' >> $value10`);

print("waiting for the scan task to complete"); 
do {
$scanoverstring = `cat $value1 | grep --binary-files=text 'scan stopped' `;
system (`cat $value1 | grep --binary-files=text 'scan stopped' > perftmp.log`);
#Cleaning Virex log here
system ("sudo cat /dev/null > $value1"); 
print "$scanoverstring";
sleep 200;
print(".."); 
   } until ($scanoverstring ne "");


sleep 5;
system (`cat perftmp.log | grep --binary-files=text 'scan stopped' >> $value10`);
sleep 5;
system (`rm -r $calculationtmp`);
system (`tail -2 $value10 > $calculationtmp`);

############$timetaken = &CalculateTimeTaken($calculationtmp);
#system (`perl calculation.pl`);

#############system(`echo "Time taken in seconds for this scan : $timetaken seconds" >> $value10`); 

system (`echo "~~~~~~~~~~~~~~~~..~~~~~~~~~~~~~~" >> $value10`);

$counter_value=`cat counter.txt`;

#print("$counter_value\n");

$newcountervalue=$counter_value+1;
#print("$newcountervalue\n");
system(`echo "$newcountervalue"> counter.txt`);

&VirexDaemonStatus;
##############
system(`$value11`);
##############

