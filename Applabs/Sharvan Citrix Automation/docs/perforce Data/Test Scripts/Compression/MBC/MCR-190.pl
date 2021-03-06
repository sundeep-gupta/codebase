#!/usr/bin/perl
#
# Copyright:			Citrix, 2006
# Created By:			AppLabs
# Created On:			2006/10/18
# Revision:				1.1
# Last Modified:		2006/10/23
#
# Script ID:			MCR-190
# Script Name:			MCR-190.pl
# Description:			Verifies compression-ratio of compressible-data transferred using wget HTTP in multi-session [different set of data] from server to client at first level of compression
# Pass/Fail Criteria:	Pass if compression-ratio is as expected, otherwise Fail.
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
my $CONNECTIONS = 3;

GetOptions("help"		 => \$help,
		   "size=i"      => \$size,
		   "bw=i"		 => \$bw,
		   "delay=i"     => \$delay,
		   "plr=i"       => \$plr);	

if ($help) {
	print "Usage: #perl mcr-190.pl [--size  <size of file>
			  --bw    <bandwidth of WAN Simulator> 
			  --delay <delay value of WAN Simulator> 
			  --plr   <plr value of WAN Simulator>         ]";
	exit;
}

#Declaring variable(s)
my ($file, $ref_source_checksums, $target_checksum, $ctr, $ref_files, $first_pass, $url);

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

#Preparing data set to be transferred
if (($ref_files = $remote_library->prepare_multi_data($server, $CONNECTIONS, $share_path, $TYPE_OF_FILE, $size)) eq undef) {
	exit 2;
}
#Calculate checksum at source
if (($ref_source_checksums = $remote_library->calculate_multi_checksums($server,"$share_path/$TYPE_OF_FILE",$ref_files)) eq undef) {
	exit 2;
}
my %source_checksums = %{$ref_source_checksums};
if (!$device_setting->config_wan_scalars({"Compression.EnableCompression"=>1,"UI.Softboost"=>1})) {
	exit 2;
}
if (!$device_setting->config_wan_simulator({"bandwidth" => $bw,"delay" => $delay,"plr" => $plr})) {
	exit 2;
}
for ($ctr=0;$ctr<$CONNECTIONS;$ctr++) {
	if (!$device_setting->reset_perf_counters()) {
		exit 2;
	}
	if (!$device_setting->reset_compression_history()) {
		exit 2;
	}
	$file=@{$ref_files}[$ctr];
	#Transfer file
	$url = "http://".$server."/http-path/$TYPE_OF_FILE/$file";
	if ((!$remote_library->wget_http($client, $url,"$share_path/$TYPE_OF_FILE/$file"))) {
		exit 2;
	}
	#Calculate checksum at destination
	if (($target_checksum = $remote_library->calculate_checksum($client,"$share_path/$TYPE_OF_FILE","$file")) eq undef) {
		exit 2;
	}
	#Comparing checksum at source & destination
	if (!$global_library->verify_checksum($source_checksums{$file},$target_checksum)) {
		exit 2;
	}
	if (($first_pass = $global_library->get_recv_compression_ratio($config->{"ORBITAL1"})) eq undef) {
		exit 2;
	}
	#Verifying the compression ratio
	if (!$global_library->verify_compression_ratio($first_pass)) {
		print "\n\nTest Status: Fail\n\n";
		exit 1;
	}
}
print "\n\nTest Status: Pass\n\n";
exit 1;