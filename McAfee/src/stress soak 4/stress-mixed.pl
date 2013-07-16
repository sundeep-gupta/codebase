#!/usr/bin/perl
use Includes::Virex;

#################CHANGE THIS TO CORRECT PATH BEFORE RUNNING THE TEST
#$perf_data_set ="/Volumes/DATA/perf-test-dataset/mixed";

$mixed_ods=&ConfigReaderValue ("ODS_MixedDatasetPath");
system (`ln -s $mixed_ods /private/tmp/ScanFolder`); 

$mixed=&ConfigReaderValue ("OAS_MixedDatasetPath");

system("get_mem_usage-v6.pl");

print("~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
print("Opening files for OAS test\n");
print("~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

$get_time = `date`;
print $get_time, "\n";
$count = 0;

while ($count < 1) {
print("~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
print("Opening files for OAS test\n");
print("~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
        &OpenFiles($mixed);
        sleep 5400;
        $get_time = `date`;
        system (`echo "$get_time" >> runs.log`);
	print $get_time, "\n";
}
