#!/usr/bin/perl

### Get Memory and CPU Usage Details
my $mem = "/Volumes/DATA/stress_soak/soak_stress/get_mem_usage-v6.pl &";
system ($mem);
print "Memory & CPU usage details will be logged to -- logs/mem_cpu_usage.log ... \n\n";

### Get Page Faults Details
my $pd = "/Volumes/DATA/stress_soak/soak_stress/get_info.pl &";
system($pd);
print "Page Fault and Port information will be logged to -- logs/info.log ... \n\n";

### Get Disk Space Details
my $ds = "/Volumes/DATA/stress_soak/soak_stress/diskinfo.sh &";
system($ds);
print "The Disk Space info will be logged to -- logs/freedisk.log ... \n\n";

### Kick off Application Usage
my $au = "/Volumes/DATA/stress_soak/soak_stress/appusage.pl &";
system($au);
print "Application Usage will be logged to -- logs/Application_Usage.log ... \n\n";


