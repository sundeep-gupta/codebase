#!/usr/bin/perl

use lib '/Volumes/Data/ssm_perf/';
use Includes::Virex;

$value3=&ConfigReaderValue ("ODS_CleanDatasetPath");
chomp($value3);
#if (! -e $value3) {
#    print "ERROR: The path specified: $value3 does not exist. Hence Exiting ..\n";
#    exit;
#}
print "STARTING ODS CLEAN SCAN ... \n";
system('>/var/log/VirusScanDebug.log');
#print "Disabling On Access Scanning ..\n";
#&ChangePlist("1","0");

sleep 10;

system ('touch /tmp/mem.txt');

#my $mem = '/Volumes/Data/ssm_perf/get_mem_usage.pl &';

#system ($mem);

$value1=&ConfigReaderValue ("VirexLogPath");
$value2=&ConfigReaderValue ("VirexApplication");
$value4=&ConfigReaderValue ("VirexLauncherPath");
$value11=&ConfigReaderValue ("CommandOnTestOver");
$value15=&ConfigReaderValue ("MainScriptpath");
$value99=&ConfigReaderValue ("VirexTaskDb");
$value98=&ConfigReaderValue ("VirexTaskID");
$value10 = '/Volumes/DATA/ssm_perf/Reports/ODS-CLEAN.log';
$calculationtmp = "/tmp/calculationtmp.tmp";
system (`rm $calculationtmp`) if (-e $calculationtmp);

system ("sudo cat /dev/null > $value1"); 
system (`touch $value10`);
system (`echo "~~~~~~~~~~~~~~~~ODS-CLEAN ON $value3~~~~~~~~~~~~~~" >> $value10`);
$starttime =`date`;
print("$starttime");
chomp $starttime;
system(`echo "$starttime" >> $value10`);
system (`echo "$starttime" >> $calculationtmp`);
$startepoch=time();
&StartODS($value3, $value99, $value98); # (scanpath, VirexTaskdb, TaskID)
$endepoch=time();
$timetaken = $endepoch - $startepoch;
$endtime =`date`;
print("$endtime");
chomp $endtime;
system(`echo "$endtime" >> $value10`);
system (`echo "$endtime" >> $calculationtmp`);
system(`echo "Time taken in seconds for this scan : $timetaken seconds" >> $value10`); 
system (`echo "~~~~~~~~~~~~~~~~..~~~~~~~~~~~~~~" >> $value10`);


system ('rm /tmp/mem.txt');

##############
print "COMPLETED ODS CLEAN SCAN \n\n";
#system(`$value11`);
exit;
##############
