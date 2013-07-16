#!/usr/bin/perl
use lib '/Volumes/DATA/msmc_perf';
use Includes::Virex;
use strict;

my $root_path = '/Volumes/DATA/msmc_perf';
$ENV{ROOT_PATH} = $root_path;

my $countervalue = &ConfigReaderValue ("counter");
my $var = "----TIME-DETAILS----  ";
for (my $i = 1;$i<=$countervalue;$i++) {
    $var .= "Run-$i  ";
}
$var .= "  Average-Time\n";

my @search;
my $check = `cat $root_path/Reports/Boottime.log`;
if ($check =~ /LOGIN/) {
    push (@search,'LOGIN TIME','REBOOT TIME');
}
if ($check =~ /SHUTDOWN/) {
    push(@search,'SHUTDOWN TIME','START TIME');
}

#my @search = ('LOGIN TIME','REBOOT TIME','SHUTDOWN TIME','START TIME');
system("$root_path/Reports/time_mod_rep") if (-e "$root_path/Reports/time_mod_rep");
open (FP,">$root_path/Reports/time_mod_rep");
print FP "Test Run with McAfee Security Console Installed \n" if (-e "/usr/local/McAfee/Antimalware");
#print FP "----TIME-DETAILS----  Run-1  Run-2  Run-3  Run-4  Run-5  Average-Time\n";
print FP "$var";
foreach my $t (@search) {
my $val1 = `cat $root_path/Reports/Boottime.log | grep '$t'`;
my @tmp1 = split('\n',$val1);
my $b;
foreach my $a (@tmp1) {
    chomp($a);
    $b .= $a;
}
$b =~ s/$t/ /g;
$b =~ s/:/ /g;
$b =~ s/secs/ /g;
my $sum = 0;
my @arr = split(/\s+/,$b);
my $num = 0;
foreach my $n (@arr) {
    if ($n =~ /\d+/) {
        $sum = $sum + $n;
        $num++;
    }
}
$sum = $sum/$num;
$b .= '   ' . $sum;
print FP "$t  $b\n";
}
close(FP);
