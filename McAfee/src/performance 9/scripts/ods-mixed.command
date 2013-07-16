#!/usr/bin/perl

use lib "/Volumes/DATA/msmc_perf";
use Includes::Virex;
use strict;

my $root_path = '/Volumes/DATA/msmc_perf';
$ENV{ROOT_PATH} = $root_path;



$value3=&ConfigReaderValue ("ODS_MixedDatasetPath");
#if (! -e $value3) {
#    print "ERROR: The path specified: $value3 does not exist. Hence Exiting ..\n";
#    exit;
#}
print "VAlue 3 = $value3\n";
print "STARTING ON DEMAND MIXED SCAN ... \n"; 
system('>/var/log/McAfeeSecurity.log'); 
#print "Disabling On Access Scanning ..\n";
#&ChangePlist("1","0");

sleep 10;

system ('touch /tmp/mem.txt');

my $mem = "$root_path/get_mem_usage.pl &";

system ($mem);

$value1=&ConfigReaderValue ("VirexLogPath");
$value2=&ConfigReaderValue ("VirexApplication");
$value4=&ConfigReaderValue ("VirexLauncherPath");
$value11=&ConfigReaderValue ("CommandOnTestOver");
$value15=&ConfigReaderValue ("MainScriptpath");
$value99=&ConfigReaderValue ("VirexTaskDb");
$value98=&ConfigReaderValue ("VirexTaskID");
$value10 = "$root_path/Reports/ODS-MIXED.log";
$calculationtmp = "/tmp/calculationtmp.tmp";
system (`rm $calculationtmp`) if (-e $calculationtmp);

system ("sudo cat /dev/null > $value1"); 
system (`touch $value10`);
system (`echo "~~~~~~~~~~~~~~~~ODS-MIXED on $value3~~~~~~~~~~~~~~" >> $value10`);
$starttime =`date`;
print("$starttime");
chomp $starttime;
system(`echo "$starttime" >> $value10`);
system (`echo "$starttime" >> $calculationtmp`);
$startepoch=time();

#Start scan of dataset here
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

system (`echo "~~~~~~~~~~~~~~~~..~~~~~~~~~~~~~~" >> $value10`);


system ('rm /tmp/mem.txt');

##############
#system(`$value11`);
print "COMPLETED ON DEMAND MIXED SCAN \n\n";
exit;
##############
