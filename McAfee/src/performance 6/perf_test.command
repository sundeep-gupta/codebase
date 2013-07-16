#!/usr/bin/perl

########################################################
# Name: perf_test.command
#       This script is a wrapper script which is used to 
#       carry out performance tests depending upon the
#       settings in the config file PerfConfig.txt 
# Author: Purvang Vora
#########################################################  


use lib '/Volumes/Data/ssm_perf/';
use Includes::Virex;

### Check if the user is root
if ($< != 0) {
    print "ERROR: You must login as root to execute this script. Exiting now ... \n\n";
    exit ( 1 );
}

my $args = scalar(@ARGV);
my $counter_file = &ConfigReaderValue ("CounterFile");
my $countervalue = &ConfigReaderValue ("counter");
my $cmd_path = '/Volumes/Data/ssm_perf/';
my $value = &ConfigReaderValue ("list_of_scripts");

### Add AppPro rules if test is being run for full package

my $package = &ConfigReaderValue ("package");
if ($package =~ /full/) {
    print "Test is being run for Full package of product\n"; 
    if (!-e "/usr/local/McAfee" || !(-e "/usr/local/McAfee/Firewall" || -e "/usr/local/McAfee/AppProtection") ) {
        print "Either the product is not installed or full package of product is not installed! " .
              "\n Please check and run the test again. Exiting now ...\n";
        exit( 1 );
    } 
    print "Adding Rules to Application Protection. This might take sometime ...\n";
    system("osascript addAppProRules.scpt");
    sleep 5;
}
exit; 

### Empty the VirusScan.log file at the start of each run

if (-e "/usr/local/McAfee" || -e "/usr/local/vscanx") {
    print "Emptying VirusScan.log file \n";
    system ("cat /dev/null > /var/log/VirusScan.log");
}

my $c = `cat $counter_file`;
chomp($c);
if ($c == 0) {
    $c = $c + 1;
    system(`echo $c > $counter_file`);
    system(`reboot`);
}

my @arr = split(' ',$value);
foreach my $run (@arr) {
    chomp($run);
    my $t = $cmd_path.$run.'.command';
    system($t);
    system($t) if ($t !~ /ods/ && $t !~ /time/);
}

### Check and increment the counter
my $check = `cat $counter_file`;
chomp($check);
$check = $check + 1;
system(`echo $check > $counter_file`);

### Reboot the system till the iterations are completed
### Once all the iterations are completed, stop 

if ($check <= $countervalue) {
    print "Rebooting the System ... \n";
   system(`sudo reboot`);
} 
else {
    print "All runs completed !! Please check under /Volumes/DATA/ssm_perf/Reports/ for the logs. \n";
}

############################# END #####################################
