#!/usr/bin/perl
use strict;
use Shell;
my $max = $ARGV[0] || 2;
my $series = $ARGV[1] || 'ADE_3.2.4_LINUX';
my $script_home = $ENV{HOME}."/ade_certify/scripts";
my $log_home = $ENV{HOME}."/ade_certify/logs";
my $certify_script = "$script_home/certify";
my $shell = Shell->new();
my @label = $shell->ade("showlabels -latest -series $series");
chomp @label;
my $label_name =  $label[$#label] ;
my $platform   = lc $^O ;
my $hostname = lc ($shell->hostname());
chomp $hostname;
my $view_tmpl =  "${platform}_${hostname}_lrg";
`ln -s /ade_autofs/ade_pledev/unix \$HOME/regress` unless -e $ENV{HOME}."/regress";

for (my $i = 1; $i <= $max; $i++) {
    my $done_file = "$log_home/$label_name/$view_tmpl$i.done";
    $shell->rm($done_file) if -e $done_file;
    if((my $pid = fork()) == 0) {      
           my $index = $i;
        print STDOUT "Starting the LRG for $view_tmpl$index\n";
        my $cmd = "$script_home/certify $index $view_tmpl $label_name> ".
        "$log_home/$label_name/$view_tmpl$index.log";
        `mkdir -p $log_home/$label_name/`;
        print $cmd;
        `touch $done_file`;
        print STDOUT "\n Finished $view_tmpl$index\n";
        exit;
    }
}

