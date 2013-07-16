#!/usr/bin/perl
#
# Copyright:			Citrix, 2006
# Created By:			AppLabs
# Created On:			2006/10/11
# Revision:			1.1
# Last Modified:		2006/10/18
# 
# Script ID:			MCR-128
# Script Name:			MCR-128.pl
# Description:			Verifies compression-ratio of compressible-data transferred using FTP from client to server at second level of compression
# Pass/Fail Criteria:		Pass if compression-ratio is as expected, otherwise Fail.
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

my $TYPE_OF_FILE = 0; #0=Compressible; 1=Medium Compressible; 2=Non-compressible

GetOptions("help"		 => \$help,
		   "size=i"      => \$size,
		   "bw=i"	 => \$bw,
		   "delay=i"     => \$delay,
		   "plr=i"       => \$plr);	

if ($help) {
	print "Usage: #perl mcr-128.pl [ --size  <size of file>
			  --bw    <bandwidth of WAN Simulator> 
			  --delay <delay value of WAN Simulator> 
			  --plr   <plr value of WAN Simulator>         ]";
	exit;
}

#Declaring variable(s)
my ($file, $source_checksum, $target_checksum, $first_pass, $second_pass);

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
if (($file = $remote_library->prepare_data($client, $share_path, $TYPE_OF_FILE, $size)) eq undef) {
	exit 2;
}

#Calculate checksum at source
if (($source_checksum = $remote_library->calculate_checksum($client,"$share_path/$TYPE_OF_FILE",$file)) eq undef) {
	exit 2;
}
if (!$device_setting->config_wan_scalars({"Compression.EnableCompression"=>1,"UI.Softboost"=>1})) {
	exit 2;
}
#if (!$device_setting->reset_perf_counters()) {
#	exit 2;
#}
#if (!$device_setting->reset_compression_history()) {
#	exit 2;
#}
if (!$device_setting->config_wan_simulator({"bandwidth" => $bw,"delay" => $delay,"plr" => $plr})) {
	exit 2;
}
#Transfer file
if ((!$remote_library->put_ftp($client, $server, $ftpusr, $ftppasswd, "$share_path/$TYPE_OF_FILE/$file","/$TYPE_OF_FILE/$file"))) {
	exit 2;
}
#Calculate checksum at destination
if (($target_checksum = $remote_library->calculate_checksum($server,"$share_path\\$TYPE_OF_FILE",$file)) eq undef) {
	exit 2;
}
#Comparing checksum at source & destination
if (!$global_library->verify_checksum($source_checksum,$target_checksum)) {
	exit 2;
}
if (($first_pass = $global_library->get_trans_compression_ratio($config->{"ORBITAL1"})) eq undef) {
	exit 2;
}
if ((!$remote_library->delete_file($server,"$share_path/$TYPE_OF_FILE/$file"))) {
	exit 2;
}
if ((!$remote_library->put_ftp($client, $server, $ftpusr, $ftppasswd, "$share_path/$TYPE_OF_FILE/$file","/$TYPE_OF_FILE/$file"))) {
	exit 2;
}
#Calculate checksum at destination
if (($target_checksum = $remote_library->calculate_checksum($server,"$share_path\\$TYPE_OF_FILE",$file)) eq undef) {
	exit 2;
}
#Comparing checksum at source & destination
if (!$global_library->verify_checksum($source_checksum,$target_checksum)) {
	exit 2;
}
if (($second_pass = $global_library->get_trans_compression_ratio($config->{"ORBITAL1"})) eq undef) {
	exit 2;
}
#Verifying the compression ratio
if ($global_library->verify_compression_ratio($first_pass, $second_pass)) {
	print "\n\nTest Status: Pass\n\n";
	exit 0;
} else {
	print "\n\nTest Status: Fail\n\n";
	exit 1;
}
