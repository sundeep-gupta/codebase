#!/usr/bin/perl
use POSIX ":sys_wait_h";
use strict;

if (@ARGV < 2) {
	print "Usage: ade_certify.pl <series_name> <no_of_sessions>\n\n";
	exit;
}
my $script_home    = $ENV{HOME}."/ade_certify/";
my $log_home       = $ENV{HOME}."/ade_certify/logs";
my $certify_script = "$script_home/certify.pl";

my $series     = $ARGV[0] ;
my $max        = $ARGV[1];
my $label_name = get_label($series);
my $platform   = lc  $^O ;
my $hostname   = lc(`hostname`); chomp $hostname;
my $view_tmpl  =  "${platform}_${hostname}_lrg";
print "Latest label found $label_name\n";
# Create the views and remove the done scripts
my $log_dir = "$log_home/$label_name";
system("mkdir -p $log_dir") unless -e $log_dir;
# create symlink to /home/regress
system("ln -s /ade_autofs/ade_pledev/unix ".$ENV{HOME}"./regress");

for (my $i = 1; $i <= $max; $i++) {
    my @cv_o = `ade createview -label $label_name $view_tmpl$i -force`;
    if ($cv_o[$#cv_o] !~ /\s+view\s+.*has been created/) {
	print "Failed to create view $view_tmpl$i\n";
	next;
    }
    if((my $pid = fork()) == 0) {
        my $index = $i;
	my $log_file = "$log_dir/$view_tmpl$index";
        my $done_file = "$log_dir/$view_tmpl$index.done";
        unlink $done_file if -e $done_file;
	print STDOUT "Starting the LRG for $view_tmpl$index\n";
	my $cmd = "$script_home/ade_certify $index $view_tmpl ";
	print `$cmd > $log_file 2>&1`;
	`touch $done_file`;
	print STDOUT "\n Finished $view_tmpl$index\n";
        exit 0;
    } else {
	print "$pid: Process id\n";
    }
}
print "Waiting for lrg to complete...\n";
wait_till_lrg_complete($max);
run_diff_script($label_name);
print "Finished Certification Tests...$label_name\n\n";

sub run_diff_script {
	my $label_part = $label_name;
	$label_part =~ s/^${series}_//;
	my $date_str = `grep "^# date" /ade_autofs/ade_linux/$series.rdd/RELEASE_3.2.4.9.0/nde/.labellog.emd`;
	chomp $date_str;
	$date_str =~ s/^# date\s*(\S*)/$1/;
	my $diff_label = "ADE_3.2_LINUX_$date_str";
	print STDOUT `lfe results -label $diff_label`;
}

sub wait_till_lrg_complete {
	my $max = $_[0];
my $do = 0;
while ($do == 0) {
	$do= 1;
	for (my $i = 1 ;$i<=$max; $i++) {
		my $done_file = "$log_dir/$view_tmpl$i.done";
		$do = 0 unless -e $done_file;
	}
}
}
sub get_label {
	my $series = $_[0];
	my @label = `ade showlabels -latest -series $series`;
	chomp @label;
	return  $label[$#label] ;
}

sub ok_to_start {
	my ($series, $session_cnt) = @_;

	#TODO: CHECK if series exist 
	# Validate the count of sessions
}
