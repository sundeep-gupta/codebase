#!/usr/bin/perl
#
# Copyright:			Citrix, 2006
# Created By:			AppLabs
# Created On:			2006/08/28
# Revision:			1.2
# Last Modified:		2006/10/10
# 
# Script ID:			MCR-052
# Script Name:			MCR-052.pl
# Description:			Verifies integrity of non-compressible-data transferred using FTP in multi-session [same data] from server to client at first level of compression
# Pass/Fail Criteria:		Pass if transferred data is accurate, otherwise Fail.
# Exit value:			0=Pass; 1=Fail; 2=Error

use ORAPP::WAN_Scalar;
use ORAPP::WAN_Simulator;
use ORAPP::Config;
use ORAPP::Global_Library;
use ORAPP::Remote_Library;
use ORAPP::Device_Setting;
use XMLRPC::Lite;
use File::Find;
use Getopt::Long;
use Cwd;
use strict;

my $size = 10240; #in Bytes
my $bw = 300;
my $delay = 0;
my $plr = 0;
my $help;

my $TYPE_OF_FILE = 2; #0=Compressible; 1=Medium Compressible; 2=Non-compressible
my $CONNECTIONS = 3;

GetOptions("help"		 => \$help,
		   "size=i"      => \$size,
		   "bw=i"	 => \$bw,
		   "delay=i"     => \$delay,
		   "plr=i"       => \$plr);	

if ($help) {
	print "Usage: #perl mcr-052.pl [--size  <size of file>
			  --bw    <bandwidth of WAN Simulator> 
			  --delay <delay value of WAN Simulator> 
			  --plr   <plr value of WAN Simulator>         ]";
	exit;
}

#Declaring variable(s)
my ($file, $source_checksum, $ref_target_checksums, $ctr, @source_files, @target_files);

#Creating object(s)
my $config = Config::new();
my $global_library = Global_Library::new();
my $device_setting = Device_Setting::new();
my $remote_library = Remote_Library::new();

#Get server ip and share information from ORAPP::Config
my $server = $config->{"NODE1"};
my $client = $config->{"NODE2"};
my $share = $config->{"SHARE"};
my $share_path = $config->{"SHARE_PATH"};
my $ftpusr = $config->{"FTP_USER"};
my $ftppasswd = $config->{"FTP_PASSWORD"};

#Preparing data set to be transferred
if (($file = $remote_library->prepare_data($server, $share_path, $TYPE_OF_FILE, $size)) eq undef) {
	exit 2;
}

#Calculate checksum at source
if (($source_checksum = $remote_library->calculate_checksum($server,"$share_path/$TYPE_OF_FILE",$file)) eq undef) {
	exit 2;
}
if (!$device_setting->config_wan_scalars({"Compression.EnableCompression"=>1,"UI.Softboost"=>1})) {
	exit 2;
}
if (!$device_setting->config_wan_simulator({"bandwidth" => $bw,"delay" => $delay,"plr" => $plr})) {
	exit 2;
}

for ($ctr=0;$ctr<$CONNECTIONS;$ctr++) {
	$source_files[$ctr] = $file;
	$target_files[$ctr] = $file.$ctr;
}
#Transfer file
if ((!$remote_library->get_ftp_using_threads($client, $server, $ftpusr, $ftppasswd, "/$TYPE_OF_FILE",\@source_files,"$share_path/$TYPE_OF_FILE",\@target_files))) {
	exit 2;
}
#Calculate checksum at destination
if (($ref_target_checksums = $remote_library->calculate_multi_checksums($client,"$share_path/$TYPE_OF_FILE",\@target_files)) eq undef) {
	exit 2;
}
#Comparing checksum at source & destination
if ($global_library->verify_checksums($source_checksum,$ref_target_checksums)) {
	print "\n\nTest Status: Pass\n\n";
	exit 0;
} else {
	print "\n\nTest Status: Fail\n\n";
	exit 1;
}