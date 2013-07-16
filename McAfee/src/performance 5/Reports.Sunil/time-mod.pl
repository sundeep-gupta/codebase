#!/usr/bin/perl

use lib "$ENV{ROOT_PATH}/ssm_perf/";
use Includes::Virex;

my $countervalue = &ConfigReaderValue ("counter");
my $var = "----TIME-DETAILS----  ";
for ($i = 1;$i<=$countervalue;$i++) {
    $var .= "Run-$i  ";
}
$var .= "  Average-Time\n";

my @search;
my $check = `cat $ENV{ROOT_PATH}/ssm_perf/Reports/Boottime.log`;
if ($check =~ /LOGIN/) {
    push (@search,'LOGIN TIME','REBOOT TIME');
}
if ($check =~ /SHUTDOWN/) {
    push(@search,'SHUTDOWN TIME','START TIME');
}

#my @search = ('LOGIN TIME','REBOOT TIME','SHUTDOWN TIME','START TIME');
system("$ENV{ROOT_PATH}/ssm_perf/Reports/time_mod_rep") if (-e "$ENV{ROOT_PATH}/ssm_perf/Reports/time_mod_rep");
open (FP,">$ENV{ROOT_PATH}/ssm_perf/Reports/time_mod_rep");
print FP "Test Run with McAfee Security Console Installed \n" if (-e "/usr/local/McAfee/Antimalware");
#print FP "----TIME-DETAILS----  Run-1  Run-2  Run-3  Run-4  Run-5  Average-Time\n";
print FP "$var";
foreach my $t (@search) {
my $val1 = `cat $ENV{ROOT_PATH}/ssm_perf/Reports/Boottime.log | grep '$t'`;
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
