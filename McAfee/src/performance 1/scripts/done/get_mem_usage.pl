#!/usr/bin/perl


use lib "$ENV{ROOT_PATH}/ssm_perf/";
use Includes::Virex;

my $value = &ConfigReaderValue ("list_of_scripts");
my $scan;
$scan = "OAS" if ($value =~ /oas/);
$scan = "ODS" if ($value =~ /ods/);
$scan = "OAS AND ODS" if ($value =~ /oas/ && $value =~ /ods/);

if (-e "/tmp/mem.txt")
{

my $log_file = "$ENV{ROOT_PATH}/ssm_perf/Reports/Mem.log";
my $head =  "PID COMMAND      %CPU   TIME   #TH #PRTS #MREGS RPRVT  RSHRD  RSIZE  VSIZE \n\n";
my $count = 1;
my $temp;
while (1)
{
system(`echo "\n----------------MEMORY USAGE DETAILS DURING $scan RUNS----------------------\n\n" >> $log_file`);
#    $temp = "\n" . '----Run No:' .  $count . "----\n\n";
    open (FP,">>$log_file");
#    print FP "$temp";
    close (FP);
    system(`top -s 1 -l 1 | grep PID >> $log_file`);
    system (`top -s 1 -l 1 | grep VShield >> $log_file`);
    system (`top -s 1 -l 1 | grep cma >> $log_file`);
    system (`top -s 1 -l 1 | grep fmpd >> $log_file`);
    system (`top -s 1 -l 1 | grep Menulet >> $log_file`);
    system (`top -s 1 -l 1 | grep VM: >> $log_file`);
    system (`top -s 1 -l 1 | grep "CPU usage" >> $log_file`);
    system (`top -s 1 -l 1 | grep PhysMem >> $log_file`);
system(`echo "-----------------------------------------END---------------------------------------\n\n" >> $log_file`);
sleep 20;
}
}else {
print "EXITING";
exit;}
