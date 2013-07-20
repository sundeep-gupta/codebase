#!/usr/bin/perl

########################################################
# Name: perf_test.command
#       This script is a wrapper script which is used to 
#       carry out performance tests depending upon the
#       settings in the config file PerfConfig.txt 
# Author: Purvang Vora
#########################################################  

$cmd_path =`cat /var/tmp/rootdir`;
chomp($cmd_path);
$ENV{ROOT_PATH}=$cmd_path;

use lib "$cmd_path/ssm_perf/";
use Includes::Virex;

### Check if the user is root
if ($< != 0) {
    print "ERROR: You must login as root to execute this script. Exiting now ... \n\n";
    exit ( 1 );
}

##$ my $args = scalar(@ARGV);
my $counter_file = &ConfigReaderValue ("CounterFile");
my $countervalue = &ConfigReaderValue ("counter");
my $value = &ConfigReaderValue ("list_of_scripts");

### Empty the VirusScan.log file at the start of each run

if (-e "/usr/local/McAfee" || -e "/usr/local/vscanx") {
    print "Emptying VirusScan.log file \n";
    system ("cat /dev/null > /var/log/VirusScan.log");
}
#sleep 60;

my $c = `cat $ENV{ROOT_PATH}/ssm_perf/$counter_file`;

chomp($c);
if ($c == 0) {
    $c = $c + 1;
    system(`echo $c > $ENV{ROOT_PATH}/ssm_perf/$counter_file`);
    system(`reboot`);
}

my @arr = split(' ',$value);
foreach my $run (@arr) {
    chomp($run);
    my $t = $cmd_path."/ssm_perf/scripts/".$run.'.command';
    system($t);
    system($t) if ($t !~ /ods/ && $t !~ /time/);
}

### Check and increment the counter
my $check = `cat $ENV{ROOT_PATH}/ssm_perf/$counter_file`;
chomp($check);
$check = $check + 1;
system(`echo $check > $ENV{ROOT_PATH}/ssm_perf/$counter_file`);

### Reboot the system till the iterations are completed
### Once all the iterations are completed, stop 

if ($check <= $countervalue) {
    print "Rebooting the System ... \n";
    system(`reboot`);
} 
else {
    print "All runs completed !! Please check under $ENV{ROOT_PATH}/ssm_perf/Reports/ for the logs. \n";
}

############################# END #####################################