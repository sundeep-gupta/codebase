#!/usr/bin/perl

use lib "/Volumes/DATA/msmc_perf";
use Includes::Virex;
use strict;

my $root_path = '/Volumes/DATA/msmc_perf';
$ENV{ROOT_PATH} = $root_path;


my $value3=&ConfigReaderValue ("ODS_CleanDatasetPath");
chomp($value3);
#if (! -e $value3) {
#    print "ERROR: The path specified: $value3 does not exist. Hence Exiting ..\n";
#    exit;
#}
print "STARTING ODS CLEAN SCAN ... \n";
system('>/var/log/McAfeeSecurity.log');
#print "Disabling On Access Scanning ..\n";
#&ChangePlist("1","0");

sleep 10;

system ('touch /tmp/mem.txt');

my $mem = "$root_path/get_mem_usage.pl &";

system ($mem);

my $value1=&ConfigReaderValue ("VirexLogPath");
my  $value2=&ConfigReaderValue ("VirexApplication");
my $value4=&ConfigReaderValue ("VirexLauncherPath");
my $value11=&ConfigReaderValue ("CommandOnTestOver");
my $value15=&ConfigReaderValue ("MainScriptpath");
my $value99=&ConfigReaderValue ("VirexTaskDb");
my $value98=&ConfigReaderValue ("VirexTaskID");
my $value10 = "$root_path/Reports/ODS-CLEAN.log";
my $calculationtmp = "/tmp/calculationtmp.tmp";
system (`rm $calculationtmp`) if (-e $calculationtmp);

system ("sudo cat /dev/null > $value1"); 
system (`touch $value10`);
system (`echo "~~~~~~~~~~~~~~~~ODS-CLEAN ON $value3~~~~~~~~~~~~~~" >> $value10`);
my $starttime =`date`;
print("$starttime");
chomp $starttime;
system(`echo "$starttime" >> $value10`);
system (`echo "$starttime" >> $calculationtmp`);
my $startepoch=time();
&StartODS($value3, $value99, $value98); # (scanpath, VirexTaskdb, TaskID)
my $endepoch=time();
my $timetaken = $endepoch - $startepoch;
my $endtime =`date`;
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
