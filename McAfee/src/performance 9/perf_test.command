#!/usr/bin/perl

########################################################
# Name: perf_test.command
#       This script is a wrapper script which is used to 
#       carry out performance tests depending upon the
#       settings in the config file PerfConfig.txt 
# Author: Purvang Vora
#########################################################  
BEGIN {
use lib '/Volumes/DATA/msmc_perf';
use Includes::Virex;
}

my $root_path = &get_lib_path();
$root_path = '/Volumes/DATA/msmc_perf';
exit(1) unless &is_root();

# Read the config files to know test parameters
my $counter_file = &ConfigReaderValue ("CounterFile");
my $countervalue = &ConfigReaderValue ("counter");
my $value = &ConfigReaderValue ("list_of_scripts");

&clear_scan_log();

my $c = &get_current_run_count("$root_path/$counter_file");


if ($c == 0) {
    &set_current_run_count(1, "$root_path/$counter_file");
    system("reboot");
}

my @test_cases = split(' ',$value);
foreach my $test_case (@test_cases) {
    my $test_script = "$root_path/scripts/".$test_case.'.command';
    system($test_script);
   # system($t) if ($t !~ /ods/ && $t !~ /time/);
}

### Check and increment the counter
my $current_counter = &get_current_run_count("$root_path/$counter_file");
&set_current_run_count($current_counter+1, "$root_path/$counter_file");

if($current_counter <= $countervalue) {
	print "MSM INFO: Rebooting the machine for next run...\n";
	system("reboot");
}


my $check = `cat $root_path/$counter_file`;
chomp($check);
$check = $check + 1;
system(`echo $check > $root_path/$counter_file`);

### Reboot the system till the iterations are completed
### Once all the iterations are completed, stop 

if ($check <= $countervalue) {
    print "Rebooting the System ... \n";
    system(`reboot`);
} else {
    print "All runs completed !! Please check under $root_pathf/Reports/ for the logs. \n";
}

sub set_current_run_count {
	my $count = $_[0];
	my $counter_file = $_[1];
	`echo $count > $counter_file`;
}

sub get_lib_path {
	$ENV{ROOT_PATH} = '/Volumes/DATA/msmc_perf';
	return '/Volumes/DATA/msmc_perf';
}

sub is_root {
	if ($< != 0 ) {
		print "MSM ERROR: You must be 'root' to run this test.\nExiting Now...\n\n";
		return 0;
	} 
	return 1;
}

sub get_current_run_count {
	my $counter_file = $_[0];
	print "MSM ERROR: $counter_file does not exist\n" unless -f $counter_file;

    open (my $fh, $counter_file);
    my @lines = <$fh>;
    chomp @lines;
    my $c = $lines[0];
    close $fh;
    return $c;
}

sub clear_scan_log {

### Empty the VirusScan.log file at the start of each run

    if (-e "/usr/local/McAfee" || -e "/usr/local/vscanx") {
        print "Emptying VirusScan.log file \n";
        system ("cat /dev/null > /var/log/VirusScan.log");
    }
}
############################# END #####################################
