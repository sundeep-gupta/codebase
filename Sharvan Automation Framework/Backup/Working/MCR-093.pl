#!/usr/bin/perl
#
# Copyright:			Citrix, 2006
# Created By:			AppLabs
# Created On:			2006/09/25
# Revision:				1.1
# Last Modified:		2006/09/29
# 
# Script ID:			MCR-093
# Script Name:			MCR-093.pl
# Description:			Verifies integrity of mid-compressible-data transferred using CIFS in multi-session [different set of data] from client to server at second level of compression
# Pass/Fail Criteria:	Pass if transferred data is accurate, otherwise Fail.
# Exit value:			0=Pass; 1=Fail; 2=Error

use ORAPP::WAN_Scalar;
use ORAPP::WAN_Simulator;
use ORAPP::Config;
use ORAPP::Global_Library;
use File::Find;
use Getopt::Long;
use Cwd;
use ORAPP::Thread_Library;
use strict;


#my $working_folder = getcwd;
my $working_folder = getcwd."/tmp";
my $size = 10240; #in Bytes
my $bw = 300;
my $delay = 0;
my $plr = 0;
my $system_type = "c";
my $help;
my $CONNECTIONS = 5;

my $TYPE_OF_FILE = 1; #0=Compressible; 1=Medium Compressible; 2=Non-compressible

GetOptions("help"		 => \$help,
		   "path=s"      => \$working_folder,
		   "size=i"      => \$size,
		   "bw=i"		 => \$bw,
		   "delay=i"     => \$delay,
		   "plr=i"       => \$plr,
		   "stype=s"	 => \$system_type);	

if ($help) {
	print "Usage: #perl mcr-093.pl [ --stype <type of system, script is running on>
			  --path  <working folder path> 
			  --size  <size of file>
			  --bw    <bandwidth of WAN Simulator> 
			  --delay <delay value of WAN Simulator> 
			  --plr   <plr value of WAN Simulator>         ]";
	exit;
}

#Creating object(s)
my $config = Config::new();
my $global_library = Global_Library::new();
my $thread_library = Thread_Library::new();

#Get server ip and share information from ORAPP::Config
my $server = $config->{"SERVER"};
my $share = $config->{"SHARE"};
my $share_path = $config->{"SHARE_PATH"};

#Checking for Server/Client where script is running
if (uc($system_type) eq "S") {
	$global_library->print_message("This system is a server");
	if ($global_library->share_folder($share, $share_path)) {
		exit 0;
	}
	exit 2;
}

#Declaring variable(s)
my (@files, %source_checksums, %target_checksums, $mapped_folder);

#Making working folder name consistent
$working_folder =~ s/\\/\//g;
if (substr($working_folder,length $working_folder, 1) ne "/") {
	$working_folder = $working_folder."/";
}

if ((@files = $thread_library->prepare_multi_data($CONNECTIONS, $working_folder, $TYPE_OF_FILE, $size)) eq undef){
	exit 2;
}
#Calculate checksum at source
if ((%source_checksums = $thread_library->calculate_multi_checksums("$working_folder$TYPE_OF_FILE", \@files)) eq undef) {
	exit 2;
}
#Map the share
if (($mapped_folder = $global_library->map_share($server, $share)) eq undef) {
	exit 2;
}
$mapped_folder = $mapped_folder."/";
#Creating Orbital(s) object
my $wan_scalar1 = WAN_Scalar::new($config->{"ORBITAL1"});
my $wan_scalar2 = WAN_Scalar::new($config->{"ORBITAL2"});

#Creating WAN Simulator object
my $wan_sim = WAN_Simulator::new($config->{"WAN_SIMULATOR"});

#Set BW
my $wan_sim_info = {
				bandwidth => $bw,
				delay     => $delay,
				plr       => $plr
             };

#Creating Orbital(s) object
my $wan_scalar1 = WAN_Scalar::new($config->{"ORBITAL1"});
my $wan_scalar2 = WAN_Scalar::new($config->{"ORBITAL2"});

#Creating WAN Simulator object
my $wan_sim = WAN_Simulator::new($config->{"WAN_SIMULATOR"});

#Configuring WAN Simulator
#$wan_sim->configure_wansimulator($wan_sim_info);

#Set compression on
if (!$wan_scalar1->set_parameter('Compression.EnableCompression',1)){
	exit 2;
}
if (!$wan_scalar2->set_parameter('Compression.EnableCompression',1)){
	exit 2;
}

#Set Softboost on
if (!$wan_scalar1->set_parameter('UI.Softboost',1)){
	exit 2;
}
if (!$wan_scalar2->set_parameter('UI.Softboost',1)){
	exit 2;
}
#Copying files
if (!$thread_library->copy_multi_files("$working_folder$TYPE_OF_FILE/",\@files,"//$server/$share/",\@files)) {
	exit 2;
}
#Delete file from destination
if (!$global_library->delete_file($mapped_folder."*.*")) {
	exit 2;
}
#Copying files again
if (!$thread_library->copy_multi_files("$working_folder$TYPE_OF_FILE/",\@files,"//$server/$share/",\@files)) {
	exit 2;
}
#Calculate checksum at target
if ((%target_checksums = $thread_library->calculate_multi_checksums($mapped_folder, \@files)) eq undef) {
	exit 2;
}

if (!$thread_library->verify_multi_checksums(\%source_checksums, \%target_checksums)) {
	#Delete file from destination
	if (!$global_library->delete_file($mapped_folder."*.*")) {
		exit 2;
	}
}

#Delete file from destination
if (!$global_library->delete_file($mapped_folder."*.*")) {
	exit 2;
}
print "\n\nTest Status: Pass\n\n";
exit 0;