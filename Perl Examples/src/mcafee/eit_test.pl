#!/usr/bin/perl
use strict;

my $sample_file   = $ARGV[0];
my $restart_scanner   = $ARGV[1];
my $results_dir   = "/Volumes/work/reports/Engine Integration Test/091026/interface/av_scanerror/oas";
my $msm_log       = "/var/log/McAfeeSecurity.log";
my $msm_debug_log = "/var/log/McAfeeSecurity_Debug.log";
my $reporter_dir  = "/usr/local/McAfee/AntiMalware/var/.Report";
my $picture_dir   = "/Users/sgupta6/Desktop";
my $dat_path      = '/usr/local/McAfee/AntiMalware/dats/10';
my $scanner_path  = '/Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist';

die "Usage: $0 <sample_file_path> [1]\n" unless @ARGV;
#die "$restart_scanner does not exist \n" unless -e $sample_file;


# if current loaded dat is not same reload the dat
if($restart_scanner) {
    &stop_scanner();
#    &change_dat($new_dat_dir) if -e $new_dat_dir;
    &start_scanner(); exit;
}
if (-f $sample_file) {
    &perform_oas($sample_file, $results_dir);
} elsif( -d $sample_file) {
    opendir(DH, $sample_file);
    my @files = readdir(DH);
    closedir DH;

    foreach my $file (@files) {
        next if $file eq '.' or $file eq '..';
        next unless -f "$sample_file/$file";
	next if -d "$sample_file/$file";
        print "Performing for $sample_file/$file\n";
        &perform_oas("$sample_file/$file", "${results_dir}_$file");
    }
}
sub perform_oas {
    my $sample_file = $_[0];
    my $results_dir = $_[1];
print "creating $results_dir\n";
    system("mkdir -p '$results_dir'") unless -e $results_dir;
print "copying\n";
    system("cp $sample_file /tmp");
print "sleeping\n";
    sleep 5;
print "capturing logs\n";
    system("mv $msm_log $msm_debug_log '$results_dir'");
    system("mv $picture_dir/Picture*.png '$results_dir'");
    system("mv $reporter_dir/.R* '$results_dir'"); 
    system("ls -l '$results_dir'\n");
}
# temporary method to save the information
# &save_current_dat_info();


sub change_dat {
   my $avv_path = $_[0];
   system("rm $dat_path/*");
   system("cp $avv_path/*.dat $dat_path");
}
sub stop_scanner {
    system("launchctl unload $scanner_path");
}

sub start_scanner {
    system("launchctl load $scanner_path");
    my @output;
    do {
        @output = `ps -eaf | grep /usr/local/McAfee/AntiMalware/VShieldScanner`;
        chomp @output;
	sleep(15);
        print scalar @output,"\n";
	last if @output >= 5;
   } while (@output != 5);
}