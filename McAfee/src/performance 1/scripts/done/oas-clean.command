#!/usr/bin/perl

use lib "$ENV{ROOT_PATH}/ssm_perf/";
use Includes::Virex;

sleep(60);
print "STARTING OAS CLEAN SCAN ... \n";
#my $value12 = &ConfigReaderValue ("Scan_Config"); 
#if (!$value12 || $value12 > 3) {
#    print "Scan_config is not set to valid values (1,2,3) in PerfConfig.txt. Hence Exiting.. \n";
#    exit;
#}
#$value3=&ConfigReaderValue ("Scan_Type");
#$value3=&ConfigReaderValue ("OAS_CleanDatasetPath");
#chomp($value3);
#if (! -e $value3) {
#    print "ERROR: The path specified: $value3 does not exist. Hence Exiting ..\n";
#    exit;
#}
system('>/var/log/McAfeeSecurity.log');

#$value13 = &ConfigReaderValue("change_pref");

#&ChangePlist("1","1");
#sleep 20;
#if ($value13 == 1) {
#    &ChangePlist("1","1");
#    sleep 20;
#    &ChangePlist("11","$value12");
#}

#my $a = `cat /var/log/VirusScanDebug.log | grep 'Before AVInitialize'`;
#my @a_arr = split('\n',$a);
#my $b = `cat /var/log/VirusScanDebug.log | grep 'After AVInitialize'`;
#my @b_arr = split('\n',$b);
#my @t1 = split(' ',$a_arr[$#a_arr]);
#my @t2 = split(' ',$b_arr[$#b_arr]);
#my $time_1 = convert_to_secs($t1[2]);
#my $time_2 = convert_to_secs($t2[2]);
#my $time = $time_2 - $time_1;
sub convert_to_secs {
   my $in = shift;
   my ($hour, $min, $sec) = split (/:/, $in);
   my $secs = 0;
   my $temp;
   if ($hour > 0) {
       $secs = $hour * 60 * 60;
   }
   if ($min > 0){
       $temp = $min * 60;
       $secs = $secs + $temp;
   }
   if ($sec > 0) {
       $secs = $secs + $sec;
   }
   return $secs;
}

sleep 10;

#system ('touch /tmp/mem.txt');

#my $mem = "$ENV{ROOT_PATH}/ssm_perf/get_mem_usage.pl &";

#system ($mem);

$value1=&ConfigReaderValue ("VirexLogPath");
$value2=&ConfigReaderValue ("VirexApplication");
$value4=&ConfigReaderValue ("VirexLauncherPath");
$value11=&ConfigReaderValue ("CommandOnTestOver");
$calculationtmp = "/tmp/calculationtmp.tmp";
$touchlist = "/tmp/touch-list.tmp";
$value10 = "$ENV{ROOT_PATH}/ssm_perf/Reports/OAS-CLEAN.log";
#$scanpath=$value3;

ExecuteTest();

sub ExecuteTest(){

    system(`rm -r /tmp/clean*`);
    system("rm -f $touchlist") if (-e "$touchlist");
    system (`rm -r $calculationtmp`) if (-e $calculationtmp);
    system ("sudo cat /dev/null > $value1"); 
    #$starttime =`date`;
    #print("$starttime");
    print "Touching files...............";

#    &TouchFilesPSS($scanpath);

    &CreateFilesPSS("clean");
    #sleep 8;

    #create a new report file if not exists
    system (`touch $value10`);

    #sleep 120;
    #sleep 10;
    system (`echo "~~~~~~~~~~~~~~~~OAS-CLEAN on $value3~~~~~~~~~~~~~~" >> $value10`);
    #system(`echo "$starttime" >> $value10`);

    #sleep 120;
    #sleep 10;

    system (`head -1 $touchlist >> $value10`);
    system (`tail -1 $touchlist >> $value10`);

    system (`tail -2 $value10 > $calculationtmp`);

    $timetaken = &CalculateTimeTaken($calculationtmp);

    system(`echo "Time taken in seconds for this scan : $timetaken seconds" >> $value10`); 

    system (`echo "~~~~~~~~~~~~~~~~..~~~~~~~~~~~~~~" >> $value10`);
}

#system ('rm /tmp/mem.txt');

#system(`cat eicar >> $value10`);

##############
print "COMPLETED OAS CLEAN SCAN \n\n";
exit;
#system(`$value11`);
##############