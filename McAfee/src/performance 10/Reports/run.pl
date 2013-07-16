#!/usr/bin/perl

use lib '/Volumes/DATA/msmc_perf';
use Includes::Virex;
use strict;
my $root_path = '/Volumes/DATA/msmc_perf';
$ENV{ROOT_PATH} = $root_path;


my $value = &ConfigReaderValue ("list_of_scripts");
my $cmd = "$root_path/Reports/generate_report " . "\"|\"" . " $root_path/Reports/version_info ";

if (-e "/usr/local/vscanx" || -e "/usr/local/McAfee/Antimalware") {
    `$root_path/Reports/version_info.pl`;
}
if ($value =~ /oas-clean/ || $value =~ /oas-mixed/) {
    `$root_path/Reports/oas-mod.pl`;
    $cmd .= "$root_path/Reports/oas_mod_rep ";
}
if ($value =~ /ods-clean/ || $value =~ /ods-mixed/) {
    `$root_path/Reports/ods-mod.pl`;
    $cmd .= "$root_path/Reports/ods_mod_rep ";
}
if ($value =~ /applaunch/) {
    `$root_path/Reports/app-launch-mod.pl`;
    $cmd .= "$root_path/Reports/app_launch_mod_rep ";
}
if ($value =~ /appusage/) {
    `$root_path/Reports/app-usage-mod.pl`;
    $cmd .= "$root_path/Reports/app_usage_mod_rep ";
}
if ($value =~ /time/) {
    `$root_path/Reports/time-mod.pl`;
    $cmd .= "$root_path/Reports/time_mod_rep ";
}

if ($value =~ /ods/ || $value =~ /oas/) {
    $cmd .= "$root_path/Reports/Mem.log ";
}

`$cmd`;

print "$cmd \n";
#`open $root_path/Reports/*.xls`;
