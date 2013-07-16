#!/usr/bin/perl

use lib '/Volumes/DATA/msmc_perf';
use Includes::Virex;

my $root_path = '/Volumes/DATA/msmc_perf';
$ENV{ROOT_PATH} = $root_path;

my $countervalue = &ConfigReaderValue ("counter");
my $var = "----APPLICATIONS-LAUNCH-TEST----  ";
for ($i = 1;$i<=$countervalue;$i++) {     
    $var .= "REBOOT:$i-Run-1  REBOOT:$i-Run-2  ";
}
$var .= "  Average-Time-Run-1   Average-Time-Run-2\n";
my @search = ('Address Book','Activity Monitor','Console','Disk Utility','Network Utility','Mail','Safari','Adium','Firefox','Google Earth','iTunes','NetNewsWire','Remote Desktop Connection','TinkerTool','VNCViewer','Microsoft Entourage','Microsoft Excel','Microsoft PowerPoint','Microsoft Word','LAUNCH&CLOSE~TOTALTIME');
system("rm $root_path/Reports/app_launch_mod_rep") if (-e "$root_path/Reports/app_launch_mod_rep");
open (FP,">$root_path/Reports/app_launch_mod_rep");
print FP "Test Run with McAfee Security Console Installed \n" if (-e "/usr/local/McAfee/Antimalware");

#print FP "----APPLICATIONS-LAUNCH-TEST----  REBOOT:1-Run-1  Run-2  REBOOT:2-Run-1  Run-2  REBOOT:3-Run-1  Run-2  REBOOT:4-Run-1  Run-2  REBOOT:5-Run-1  Run-2  Average-Time\n";
print FP "$var\n";
foreach my $t (@search) {
my $val1 = `grep '$t' $root_path/Reports/Application-Launch.log`;

my @lines = split('\n',$val1);


chomp @lines;

my $b = '';
foreach my $line (@lines) {
   $b .= $line;
}

$b =~ s/$t/ /g;
$b =~ s/secs/ /g;

my $sum = 0;
my @arr = split(/\s+/,$b);
my $num = 1;
my ($sum_run_1,$sum_run_2) = (0,0);
my $s = scalar(@arr);
print "Total iterations run : $s\n";
for ($i=1;$i<$s+1;$i=$i+2) {
    if ($arr[$i] =~ /\d+/) {
        $sum_run_1 = $sum_run_1 + $arr[$i];
        $num++;
    }
}
$sum_run_1 = $sum_run_1/$num;
$b .= '   ' . $sum_run_1;
$num = 1;
for ($j=0;$j<$s+1;$j=$j+2) {
    if ($arr[$j] =~ /\d+/) {
        $sum_run_2 = $sum_run_2 + $arr[$j];
        $num++;
    }
}
$sum_run_2 = $sum_run_2/$num;
$b .= '   ' . $sum_run_2;

print FP "$t  $b\n";
}
close(FP);

### Make Another copy for summary report
if (-e "/usr/local/McAfee") {
    `cp $root_path/Reports/app_launch_mod_rep $root_path/Reports/app_launch_msc`;
}
if (-e "/usr/local/vscanx") {
    `cp $root_path/Reports/app_launch_mod_rep $root_path/Reports/app_launch_vsmac`;
}
if ( ! -e "/usr/local/McAfee" && ! -e "/usr/local/vscanx") {
    `cp $root_path/Reports/app_launch_mod_rep $root_path/Reports/app_launch`;
}

 
