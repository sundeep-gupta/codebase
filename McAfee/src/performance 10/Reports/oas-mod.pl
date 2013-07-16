#!/usr/bin/perl

use lib "/Volumes/DATA/msmc_perf";
use Includes::Virex;
my $root_path = '/Volumes/DATA/msmc_perf';
$ENV{ROOT_PATH} = $root_path;


my $countervalue = &ConfigReaderValue ("counter");
my $var = "----OAS-THROUGHPUT-TEST----  ----  ";
for ($i = 1;$i<=$countervalue;$i++) {
    $var .= "REBOOT:$i-Run-1  REBOOT:$i-Run-2  ";
}
$var .= "  Average-Time-Run-1   Average-Time-Run-2\n";
my @search = ('Time taken in seconds for this scan');

system("rm $root_path/Reports/oas_mod_rep") if (-e "$root_path/Reports/oas_mod_rep");
open (FP,">$root_path/Reports/oas_mod_rep");
print FP "Test Run with McAfee Security Console Installed \n" if (-e "/usr/local/McAfee/Antimalware");
#print FP "----OAS-THROUGHPUT-TEST----  ----   REBOOT:1-Run-1  Run-2  REBOOT:2-Run-1  Run-2  REBOOT:3-Run-1  Run-2  REBOOT:4-Run-1  Run-2  REBOOT:5-Run-1  Run-2  Average-Time\n";
print FP "$var\n";
foreach my $t (@search) {
if (-e "$root_path/Reports/OAS-CLEAN.log" ) {
my $val1 = `cat $root_path/Reports/OAS-CLEAN.log | grep '$t'`;
my @tmp1 = split('\n',$val1);
my $b;
foreach my $a (@tmp1) {
    chomp($a);
    $b .= $a;
}
$b =~ s/$t/ /g;
$b =~ s/:/ /g;
$b =~ s/seconds/ /g;
my $sum = 0;
my @arr = split(/\s+/,$b);
my $num = 0;
my ($sum_run_1,$sum_run_2) = (0,0);
my $s = scalar(@arr);

for ($i=1;$i<$s+1;$i=$i+2) {
    if ($arr[$i] =~ /\d+/) {
        $sum_run_1 = $sum_run_1 + $arr[$i];
        $num++;
    }
}
$sum_run_1 = $sum_run_1/$num;
$b .= '   ' . $sum_run_1;
$num = 0;
for ($j=0;$j<$s+1;$j=$j+2) {
    if ($arr[$j] =~ /\d+/) {
        $sum_run_2 = $sum_run_2 + $arr[$j];
        $num++;
    }
}
$sum_run_2 = $sum_run_2/$num;
$b .= '   ' . $sum_run_2;

print FP "CLEAN  $t  $b\n";
}
}

foreach my $t (@search) {
if (-e "$root_path/Reports/OAS-MIXED.log" ) {
my $val1 = `cat $root_path/Reports/OAS-MIXED.log | grep '$t'`;
my @tmp1 = split('\n',$val1);
my $b;
foreach my $a (@tmp1) {
    chomp($a);
    $b .= $a;
}
$b =~ s/$t/ /g;
$b =~ s/:/ /g;
$b =~ s/seconds/ /g;
my $sum = 0;
my @arr = split(/\s+/,$b);
my $num = 0;
my ($sum_run_1,$sum_run_2) = (0,0);
my $s = scalar(@arr);

for ($i=1;$i<$s+1;$i=$i+2) {
    if ($arr[$i] =~ /\d+/) {
        $sum_run_1 = $sum_run_1 + $arr[$i];
        $num++;
    }
}
$sum_run_1 = $sum_run_1/$num;
$b .= '   ' . $sum_run_1;
$num = 0;
for ($j=0;$j<$s+1;$j=$j+2) {
    if ($arr[$j] =~ /\d+/) {
        $sum_run_2 = $sum_run_2 + $arr[$j];
        $num++;
    }
}
$sum_run_2 = $sum_run_2/$num;
$b .= '   ' . $sum_run_2;

print FP "MIXED  $t  $b\n";
}
}
close(FP);

### Make Another copy for summary report
if (-e "/usr/local/McAfee") {
    `cp $root_path/Reports/oas_mod_rep $root_path/Reports/oas_mod_msc`;
}
if (-e "/usr/local/vscanx") {
    `cp $root_path/Reports/oas_mod_rep $root_path/Reports/oas_mod_vsmac`;
}

