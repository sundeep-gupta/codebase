use Getopt::Std;
use Data::Dumper;
#use strict;


my($val)={};
getopt("cnFPf",$val);
getopts("u");

die("Incorrect syntax. IP not specified\n") if (!( defined($val->{'c'})));


if(!defined($val->{'n'}) && ! defined($val->{'F'}) ) {
    die("Incorrect Syntax. Must specify size or file (not both)");
}elsif(!defined($val->{'n'}) && ! defined($val->{'F'}) ) {
    die("Incorrect Syntax. Must specify size or file(not both)");
}

print $opt_n."\n".$opt_F."\n".$opt_P;
my($cmd) = "iperf.exe -c  $val->{'c'} -f k";
$cmd = $cmd." -F $val->{'F'} " if defined($val->{'F'});
$cmd = $cmd." -n $val->{'n'} " if defined($val->{'n'});
$cmd = $cmd." -P $val->{'P'} " if defined($val->{'P'});
$log_file = defined($val->{'P'}) ?"tcp_accel_log_".$val->{'P'}.".txt" :"tcp_accel_log.txt"  ;
$log_file = defined($val->{'u'}) ? (defined($val->{'P'}) ?"udp_log_$val->{'P'}.txt" :"udp_log.txt" ):$log_file;


open(FILE,">$log_file");
print FILE $cmd;
print FILE `$cmd 2>&1`;
close(FILE);

create_done();

sub create_done {
    my $done_file = defined($val->{'P'}) ?"tcp_accel_done_".$val->{'P'}.".txt" :"tcp_accel_done.txt"  ;
    $done_file = defined($val->{'u'}) ? (defined($val->{'P'}) ?"udp_done_$val->{'P'}.txt" :"udp_done.txt" ):$done_file;

    open(GOTOFILE,">$done_file");
    print GOTOFILE "done";
    close(GOTOFILE);
}