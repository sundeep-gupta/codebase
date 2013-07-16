#!/usr/bin/perl

use lib '/Volumes/DATA/msmc_perf';
use Includes::Virex;
use strict;

my $root_path = '/Volumes/DATA/msmc_perf';
$ENV{ROOT_PATH} = $root_path;

my $countervalue = &ConfigReaderValue ("counter");
my $var = "----ODS-THROUGHPUT-TEST---- ----  ";
for (my $i = 1;$i<=$countervalue;$i++) {
    $var .= "Run-$i   ";
}
$var .= " Average-Time\n";
my @search = ('Time taken in seconds for this scan');
system("rm $root_path/Reports/ods_mod_rep") if (-e "$root_path/Reports/ods_mod_rep");
open (FP,">$root_path/Reports/ods_mod_rep");
print FP "Test Run with McAfee Security Console Installed \n" if (-e "/usr/local/McAfee/Antimalware");
#print FP "----ODS-THROUGHPUT-TEST----  ----   REBOOT:1-Run-1  Run-2  REBOOT:2-Run-1  Run-2  REBOOT:3-Run-1  Run-2  REBOOT:4-Run-1  Run-2  REBOOT:5-Run-1  Run-2  Average-Time\n";
print FP "$var";
foreach my $t (@search) {
if (-e "$root_path/Reports/ODS-CLEAN.log") {
my $val1 = `cat $root_path/Reports/ODS-CLEAN.log | grep '$t'`;
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
foreach my $n (@arr) {
    if ($n =~ /\d+/) {
        $sum = $sum + $n;
        $num++;
    }
}
$sum = $sum/$num;
$b .= '   ' . $sum;
print FP "CLEAN  $t  $b\n";
}
}
foreach my $t (@search) {
if (-e "$root_path/Reports/ODS-MIXED.log" ) {
my $val1 = `cat $root_path/Reports/ODS-MIXED.log | grep '$t'`;
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
foreach my $n (@arr) {
    if ($n =~ /\d+/) {
        $sum = $sum + $n;
        $num++;
    }
}
$sum = $sum/$num;
$b .= '  ' . $sum;
print FP "MIXED  $t  $b\n";
}
}
close (FP);



### Make Another copy for summary report
if (-e "/usr/local/McAfee") {
    `cp $root_path/Reports/ods_mod_rep $root_path/Reports/ods_mod_msc`;
}
if (-e "/usr/local/vscanx") {
    `cp $root_path/Reports/ods_mod_rep $root_path/Reports/ods_mod_vsmac`;
}
