#!/usr/bin/perl
#
# Copyright:			Citrix, 2006
# Created By:			AppLabs
# Created On:			2006/09/25
# Revision:				1.2
# Last Modified:		2006/10/11
# 
# Script ID:			MCR-101
# Script Name:			MCR-101.pl
# Description:			Verifies integrity of mid-compressible-data transferred using CIFS in multi-session [different set of data] from server to client at second level of compression
# Pass/Fail Criteria:	Pass if transferred data is accurate, otherwise Fail.
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

my $TYPE_OF_FILE = 1; #0=Compressible; 1=Medium Compressible; 2=Non-compressible
my $CONNECTIONS = 3;

GetOptions("help"		 => \$help,
		   "size=i"      => \$size,
		   "bw=i"		 => \$bw,
		   "delay=i"     => \$delay,
		   "plr=i"       => \$plr);	

if ($help) {
	print "Usage: #perl mcr-101.pl [--size  <size of file>
			  --bw    <bandwidth of WAN Simulator> 
			  --delay <delay value of WAN Simulator> 
			  --plr   <plr value of WAN Simulator>         ]";
	exit;
}

#Declaring variable(s)
my ($file, $ref_source_checksums, $ref_target_checksums, $ctr, $ref_files);

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
if (!$remote_library->share_folder($server, $share, $share_path)) {
	exit 2;
}
#Calculate checksum at source
if (($ref_source_checksums = $remote_library->calculate_multi_checksums($server,"$share_path/$TYPE_OF_FILE",$ref_files)) eq undef) {
	exit 2;
}
if (!$device_setting->config_wan_scalars({"Compression.EnableCompression"=>1,"UI.Softboost"=>1})) {

}
if (!$device_setting->config_wan_simulator({"bandwidth" => $bw,"delay" => $delay,"plr" => $plr})) {

}

#Transfer file
if ((!$remote_library->copy_files_using_threads($client, "//$server/$share/$TYPE_OF_FILE",$ref_files,"$share_path/$TYPE_OF_FILE",$ref_files))) {
	exit 2;
}
if ((!$remote_library->delete_files_using_threads($client,"$share_path/$TYPE_OF_FILE",$ref_files))) {
	exit 2;
}
if ((!$remote_library->copy_files_using_threads($client, "//$server/$share/$TYPE_OF_FILE",$ref_files,"$share_path/$TYPE_OF_FILE",$ref_files))) {
	exit 2;
}
#Calculate checksum at destination
if (($ref_target_checksums = $remote_library->calculate_multi_checksums($client,"$share_path/$TYPE_OF_FILE",$ref_files)) eq undef) {
	exit 2;
}
#Comparing checksum at source & destination
if ($global_library->verify_multi_checksums($ref_source_checksums,$ref_target_checksums)) {
	print "\n\nTest Status: Pass\n\n";
	exit 0;
} else {
	print "\n\nTest Status: Fail\n\n";
	exit 1;
}