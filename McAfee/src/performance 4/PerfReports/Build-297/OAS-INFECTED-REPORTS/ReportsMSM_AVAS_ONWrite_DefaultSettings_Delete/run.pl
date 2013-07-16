#!/usr/bin/perl

use lib '/Volumes/Data/ssm_perf/';
use Includes::Virex;


my $value = &ConfigReaderValue ("list_of_scripts");
my $cmd = "/Volumes/Data/ssm_perf/Reports/generate_report " . "\"|\"" . " /Volumes/Data/ssm_perf/Reports/version_info ";

if (-e "/usr/local/vscanx" || -e "/usr/local/McAfee/Antimalware") {
    `/Volumes/Data/ssm_perf/Reports/version_info.pl`;
}
if ($value =~ /oas-clean/ || $value =~ /oas-mixed/) {
    `/Volumes/Data/ssm_perf/Reports/oas-mod.pl`;
    $cmd .= "/Volumes/Data/ssm_perf/Reports/oas_mod_rep ";
}
if ($value =~ /ods-clean/ || $value =~ /ods-mixed/) {
    `/Volumes/Data/ssm_perf/Reports/ods-mod.pl`;
    $cmd .= "/Volumes/Data/ssm_perf/Reports/ods_mod_rep ";
}
if ($value =~ /applaunch/) {
    `/Volumes/Data/ssm_perf/Reports/app-launch-mod.pl`;
    $cmd .= "/Volumes/Data/ssm_perf/Reports/app_launch_mod_rep ";
}
if ($value =~ /appusage/) {
    `/Volumes/Data/ssm_perf/Reports/app-usage-mod.pl`;
    $cmd .= "/Volumes/Data/ssm_perf/Reports/app_usage_mod_rep ";
}
if ($value =~ /time/) {
    `/Volumes/Data/ssm_perf/Reports/time-mod.pl`;
    $cmd .= "/Volumes/Data/ssm_perf/Reports/time_mod_rep ";
}

if ($value =~ /ods/ || $value =~ /oas/) {
    $cmd .= "/Volumes/Data/ssm_perf/Reports/Mem.log ";
}

#my $cmd = "/Volumes/Data/ssm_perf/Reports/generate_report " . "\"|\"" . " /Volumes/Data/ssm_perf/Reports/version_info /Volumes/Data/ssm_perf/Reports/oas_mod_rep /Volumes/Data/ssm_perf/Reports/ods_mod_rep /Volumes/Data/ssm_perf/Reports/time_mod_rep /Volumes/Data/ssm_perf/Reports/app_launch_mod_rep /Volumes/Data/ssm_perf/Reports/app_usage_mod_rep /Volumes/Data/ssm_perf/Reports/Mem.log";
`$cmd`;

print "$cmd \n";
`open /Volumes/DATA/ssm_perf/Reports/*.xls`;
