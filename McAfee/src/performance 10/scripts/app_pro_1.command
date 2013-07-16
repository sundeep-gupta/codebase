#!/usr/bin/perl

use lib '/Volumes/DATA/msmc_perf';
use Includes::Virex;
my $root_path = '/Volumes/DATA/msmc_perf';
$ENV{ROOT_PATH} = $root_path;



### Do scp for files of different sizes and capture time taken

my $scp_dest = &ConfigReaderValue ("scp_destination");
my $scp_files = &ConfigReaderValue ("scp_files");
my @files = split(',',$scp_files);
my $apppro_log = "$root_path/Reports/app_pro.log";
open (FP,">>$apppro_log");
foreach my $file (@files) {
    print "\nCopying file -- $file\n\n";
    my $file_size = `du -sk $file`;
    chomp($file_size);
    $file_size =~ s/$file//;
#    `( time ls ) 2>> $apppro_log`;
    my $start = `date +%s`;
    system("scp -r $file root\@$scp_dest:/Volumes/DATA/ >> /dev/null");
    my $end = `date +%s`;
    my $total_time = $end - $start;
    print FP "MODE  FILE-SIZE  TIME-TAKEN\n"; 
    print FP "scp  $file_size  $total_time\n";
}
close (FP);


