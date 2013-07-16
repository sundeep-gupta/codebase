#!/usr/bin/perl

use Term::ANSIColor;

my $log_file = "./logs/mem_cpu_usage.log";
system (`rm $log_file`) if (-e "$log_file");

$pwd =`pwd`;

system(`echo "~~~~~~~~~~~MEMORY-&-CPU-USAGE-DETAILS~~~~~~~~~~~~~~~~~~~~~~~~\n\n" >> $log_file`);
system(`top -s 1 -l 1 | grep PID >> $log_file`);


while (1) 

{
    system(`echo "\n\n" >> $log_file`);
    system (`top -s 1 -l 1 | grep VM: >> $log_file`);
    system (`top -s 1 -l 1 | grep "CPU usage" >> $log_file`);
    system (`top -s 1 -l 1 | grep PhysMem >> $log_file`); 
    system (`top -s 1 -l 1 | grep VShield* >> $log_file`);
    system (`top -s 1 -l 1 | grep cma >> $log_file`);
    system (`top -s 1 -l 1 | grep fmpd >> $log_file`);
    system (`top -s 1 -l 1 | grep Menulet >> $log_file`);
    system (`top -s 1 -l 1 | grep appProtd >> $log_file`);
    system (`top -s 1 -l 1 | grep FWService >> $log_file`);
    system (`top -s 1 -l 1 | grep McAfee* >> $log_file`);    
 
    sleep 5;     

}
