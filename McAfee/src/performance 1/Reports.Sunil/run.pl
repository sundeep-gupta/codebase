#!/usr/bin/perl

$cmd_path =`cat /var/tmp/rootdir`;
chomp($cmd_path);
$ENV{ROOT_PATH}=$cmd_path;
use lib "$cmd_path/ssm_perf/";
use Includes::Virex;

my $value = &ConfigReaderValue ("list_of_scripts");
my $cmd = "$ENV{ROOT_PATH}/ssm_perf/Reports/generate_report " . "\"|\"" . " $ENV{ROOT_PATH}/ssm_perf/Reports/version_info ";

if (-e "/usr/local/vscanx" || -e "/usr/local/McAfee/Antimalware") {
    `$ENV{ROOT_PATH}/ssm_perf/Reports/version_info.pl`;
}
if ($value =~ /oas-clean/ || $value =~ /oas-mixed/) {
    `$ENV{ROOT_PATH}/ssm_perf/Reports/oas-mod.pl`;
    $cmd .= "$ENV{ROOT_PATH}/ssm_perf/Reports/oas_mod_rep ";
}
if ($value =~ /ods-clean/ || $value =~ /ods-mixed/) {
    `$ENV{ROOT_PATH}/ssm_perf/Reports/ods-mod.pl`;
    $cmd .= "$ENV{ROOT_PATH}/ssm_perf/Reports/ods_mod_rep ";
}
if ($value =~ /applaunch/) {
    `$ENV{ROOT_PATH}/ssm_perf/Reports/app-launch-mod.pl`;
    $cmd .= "$ENV{ROOT_PATH}/ssm_perf/Reports/app_launch_mod_rep ";
}
if ($value =~ /appusage/) {
    `$ENV{ROOT_PATH}/ssm_perf/Reports/app-usage-mod.pl`;
    $cmd .= "$ENV{ROOT_PATH}/ssm_perf/Reports/app_usage_mod_rep ";
}
if ($value =~ /time/) {
    `$ENV{ROOT_PATH}/ssm_perf/Reports/time-mod.pl`;
    $cmd .= "$ENV{ROOT_PATH}/ssm_perf/Reports/time_mod_rep ";
}

if ($value =~ /ods/ || $value =~ /oas/) {
    $cmd .= "$ENV{ROOT_PATH}/ssm_perf/Reports/Mem.log ";
}

`$cmd`;

print "$cmd \n";
`open $ENV{ROOT_PATH}/ssm_perf/Reports/*.xls`;
