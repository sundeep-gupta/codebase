#!/usr/bin/perl 
my $root_path = '/Volumes/DATA/msmc_perf';

$ENV{ROOT_PATH}=$root_path;

use lib '/Volumes/DATA/msmc_perf';

use Includes::Virex;

### Check if the user is root
if ($< != 0) {
    print "ERROR: You must login as root to execute this script. Exiting now ... \n\n";
    exit ( 1 );
}

my $counter_file = &ConfigReaderValue ("CounterFile");
my $countervalue = &ConfigReaderValue ("counter");
my $value = &ConfigReaderValue ("list_of_scripts");
my $command;

my $check = `cat $root_path/$counter_file`;
chomp($check);
if ($check == 0) {
    $check = $check + 1;
    system(`echo $check > $root_path/$counter_file`);
    system ("date > /var/tmp/starttime");
    system(`reboot`);
}

my @arr = split(' ',$value);
my $cmd = $arr[0]; 

foreach my $run (@arr) {
    chomp($run);
    $command = "$root_path/scripts/${run}.command";
    system($command); 
}

### Reboot the system till the iterations are completed
### Once all the iterations are completed, stop 

my $memusage; 

if ($check <= $countervalue) {
    $check = $check + 1;
    system(`echo $check > $root_path/$counter_file`);
    print "Rebooting the System ... \n";
    system ("date > /var/tmp/starttime");
    system(`reboot`);
} 
else {
    if ( $cmd =~ /Install_time/ ) 
    { 
      $memusage = "$root_path/scripts/Calculate_cpu_memory.pl 1 &";
      system ($memusage);
    }
    if ( $cmd =~ /Idle_time/ ) 
    { 
      $memusage = "$root_path/scripts/Calculate_cpu_memory.pl 2 &";
      print "\n\nMemusage is : $memusage\n";
      system ($memusage);
    } 
    if ( $cmd =~ /Update_time/ ) 
    { 
      $memusage = "$root_path/scripts/Calculate_cpu_memory.pl 3 &";
      system ($memusage);
    }
    if ( $cmd =~ /Scan_time/ ) 
    { 
      $memusage = "$root_path/scripts/Calculate_cpu_memory.pl 4 &";
      system ($memusage);
    }
 
    print "All runs completed !! Please check under $root_path/Reports/ for the logs. \n";
}

############################# END #####################################
