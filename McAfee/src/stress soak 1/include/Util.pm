package Util;


sub disk_info {
   return `du -ahm`;
}


sub capture_cpu_memory {

my $mem = "/Volumes/DATA/stress_soak/soak_stress/get_mem_usage.pl &";
system ($mem);
print "Memory & CPU usage details will be logged to -- logs/mem_cpu_usage.log ... \n\n";
}

sub capture_page_faults {

### Get Page Faults Details
my $pd = "/Volumes/DATA/stress_soak/soak_stress/get_info.pl &";
system($pd);
print "Page Fault and Port information will be logged to -- logs/info.log ... \n\n";

}

sub disk_space_info {


### Get Disk Space Details
my $ds = "/Volumes/DATA/stress_soak/soak_stress/diskinfo.sh &";
system($ds);
print "The Disk Space info will be logged to -- logs/freedisk.log ... \n\n";


}

1;
