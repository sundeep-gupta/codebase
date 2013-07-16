#!/usr/bin/perl

use lib '/Volumes/Data/ssm_perf/';
use Includes::Virex;

my $log_file = "/Volumes/DATA/ssm_perf/Reports/app_pro.log";
my $file_size;

### Do http and download files and capture time taken

my $http_dest = &ConfigReaderValue ("http_destination");
my $download_file = &ConfigReaderValue ("download_file");
#system ("rm -rf /Volumes/DATA/ssm_perf/Reports/apppro.log") if (-e "/Volumes/DATA/ssm_perf/Reports/apppro.log");
system ("rm -rf /Volumes/DATA/$download_file") if (-e "/Volumes/DATA/$download_file");

my $part_file = "/Volumes/DATA/$download_file" . "\.part";
my $d_file = "/Volumes/DATA/$download_file";
my $down_file = "/Volumes/DATA/$download_file" . "\.download";

$file_size = `du -km $download_file`;
chomp($file_size);
$file_size =~ s/$download_file//;
print "Executing -- /Applications/Firefox.app/ http://$http_dest/$download_file\n";
system("/Applications/Firefox.app/Contents/MacOS/firefox-bin http://$http_dest:/$download_file &");
system("date \"+FIREFOX-HTTP-START-TIME: %H:%M:%S\" >> $log_file");
my $start = `date +%s`;
my $end;
sleep 4;
while(1) {
    if ( (! -e "$part_file") && (-e "$d_file"))  {
        system("date \"+FIREFOX-HTTP-END-TIME: %H:%M:%S\" >> $log_file");
        $end = `date +%s`;
        print "Download of $download_file completed using Firefox\n\n";
        last;
    }
}
my $total_time = $end - $start;
system("echo TIME TAKEN FIREFOX-HTTP   $file_size   $total_time >> $log_file");
system("./quit Firefox");

sleep 5;

system ("rm -rf /Volumes/DATA/$download_file") if (-e "/Volumes/DATA/$download_file");
system("echo \"\n------------\n\" >> $log_file");
$file_size = `du -km $download_file`;
chomp($file_size);
$file_size =~ s/$download_file//;
print "Executing -- /Applications/Safari.app/ http://$http_dest/$download_file\n";
system ("open /Applications/Safari.app/ http://$http_dest/$download_file");
system("date \"+SAFARI-HTTP-START-TIME: %H:%M:%S\" >> $log_file");
$start = `date +%s`;
sleep 4;
while(1) {
    if ((! -e "$down_file") && (-e "$d_file")) { 
        system("date \"+SAFARI-HTTP-END-TIME: %H:%M:%S\" >> $log_file");
        $end = `date +%s`;
        print "Download of $download_file completed using Safari\n\n";
        last;
    }
}
$total_time = $end - $start;
system("echo TIME TAKEN SAFARI-HTTP   $file_size   $total_time >> $log_file");

system("./quit Safari");
sleep 5;

### Do ftp and download files and capture time taken

my $ftp_dest = &ConfigReaderValue ("ftp_destination");
my $ftp_user = &ConfigReaderValue ("ftp_username");
my $ftp_password = &ConfigReaderValue("ftp_password");

system ("rm -rf /Volumes/DATA/$download_file") if (-e "/Volumes/DATA/$download_file");
system("echo \"\n------------\n\" >> $log_file");
$file_size = `du -km $download_file`;
chomp($file_size);
$file_size =~ s/$download_file//;
#my $url = "ftp://purvang" . ":" . "test" . "@" . "$ftp_dest" . "/" . "$download_file";
my $url = "ftp://" . "$ftp_user" . ":" . "test" . "@" . "$ftp_dest" . "/" . "$download_file";
print "Executing -- /Applications/Firefox.app/Contents/MacOS/firefox-bin $url \n";
system("/Applications/Firefox.app/Contents/MacOS/firefox-bin $url &");
system("date \"+FIREFOX-FTP-START-TIME: %H:%M:%S\" >> $log_file");
$start = `date +%s`;
sleep 4;
while(1) {
    if ((! -e "$part_file") && (-e "$d_file")) {
        system("date \"+FIREFOX-FTP-END-TIME: %H:%M:%S\" >> $log_file");
        $end = `date +%s`;
        print "Download of $download_file completed using Safari\n\n";
        last;
    }
}
$total_time = $end - $start;
system("echo TIME TAKEN FIREFOX-FTP   $file_size   $total_time >> $log_file");

system("./quit Firefox");

