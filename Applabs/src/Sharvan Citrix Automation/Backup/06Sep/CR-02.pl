#!/usr/bin/perl
#
# Copyright:			AppLabs, 2006
# Created By:			AppLabs
# Created On:			2006/08/28
# Revision:				1.1
# Last Modified:		2005/10/18
# 
# Script ID:			CR-02
# Script Name:			CR-02.pl
# Description:			Verifies that the BW utilization value after enabling the orbital should be approximately 80% of the BW utilized without orbital enabled. And also the time taken for transferring the files should be less than that compared without orbital enabled.
# Pass/Fail Criteria:	Pass if BW utilization value with Orbital enabled is approx. 80% of without Orbital, otherwise Fail.
# Exit value:			0=Pass; 1=Fail; 2=Error

use ORAPP::WAN_Scalar;
use ORAPP::WAN_Simulator;
use ORAPP::Config;
use ORAPP::Global_Library;
use File::Find;
use Getopt::Long;
use Cwd;

my $working_folder = getcwd;
my $size = 102400; #in Bytes
my $bw = 300;
my $delay = 0;
my $plr = 0;
my $system_type = "c";
my $help;

my $TYPE_OF_FILE = 0; #0=Compressible; 1=Medium Compressible; 2=Non-compressible

GetOptions("help"		 => \$help,
		   "path=s"      => \$working_folder,
		   "size=i"      => \$size,
		   "bw=i"		 => \$bw,
		   "delay=i"     => \$delay,
		   "plr=i"       => \$plr,
		   "stype=s"	 => \$system_type);	

if ($help) {
	print "Usage: #perl cr-02.pl [ --stype <type of system, script is running on>
			--path  <working folder path> 
			--size  <size of file>
			--bw    <bandwidth of WAN Simulator> 
			--delay <delay value of WAN Simulator> 
			--plr   <plr value of WAN Simulator>         ]";
	exit;
}

my $config = Config::new();
my $global_library = Global_Library::new();


#Get server ip and share from ORAPP::Config
my $server = $config->{"SERVER"};
my $share = $config->{"SHARE"};
my $share_path = $config->{"SHARE_PATH"};

my $mapped_destination = "";
my $transfer_time = 0;

if (uc($system_type) eq "S") {
	$global_library->print_message("This system is a server");
	$global_library->share_folder($share, $share_path);
	exit;
}

$working_folder =~ s/\//\\\\/g;
$working_folder = $working_folder."\\\\";


#Creating Orbital(s) object
my $wan_scalar1 = WAN_Scalar::new($config->{"ORBITAL1"});
my $wan_scalar2 = WAN_Scalar::new($config->{"ORBITAL2"});

#Creating WAN Simulator object
my $wan_sim = WAN_Simulator::new($config->{"WAN_SIMULATOR"});

#Declaring variable(s)
my $file = "";

#Disabling Orbital(s)
if (!$wan_scalar1->set_parameter('PassThrough',1)){
	exit 2;
}

if (!$wan_scalar2->set_parameter('PassThrough',1)){
	exit 2;
}

#Set BW
my $wan_sim_info = {
				bandwidth => $bw,
				delay     => $delay,
				plr       => $plr
             };
#$wan_sim->configure_wansimulator($wan_sim_info);


if (!-d $working_folder) {
	if (!$global_library->create_directory($working_folder)) {
		exit 2;
	}
	else {
		if (!$global_library->create_directory("$working_folder$TYPE_OF_FILE")) {
			exit 2;
		}
		else {
			if (($file = $global_library->create_file("$working_folder$TYPE_OF_FILE",$TYPE_OF_FILE, $size)) eq undef){
				exit 2;
			}
		}
	}
}
else {
	if(! -d "$working_folder$TYPE_OF_FILE") {
		if (!$global_library->create_directory("$working_folder$TYPE_OF_FILE")){
			exit 2;
		}
		else {
			if (($file = $global_library->create_file("$working_folder$TYPE_OF_FILE",$TYPE_OF_FILE, $size)) eq undef){
				exit 2;
			}
		}
	}
	else {
		#Search the matching file(s)
		if (($file = $global_library->check_matching_file("$working_folder$TYPE_OF_FILE",$size)) eq undef) {
			if (($file = $global_library->create_file("$working_folder$TYPE_OF_FILE",$TYPE_OF_FILE, $size)) eq undef){
				exit 2;
			}
		}
	}
}


#Map the share
if (($mapped_destination = $global_library->map_share($server, $share)) eq undef) {
	exit 2;
}

#Transfer file(s)
if (($transfer_time = $global_library->copy_file("$working_folder$TYPE_OF_FILE\\$file", $mapped_destination)) eq undef) {
	exit 2;
}

#Find out throughput
my $throughput_without_orbitals = $global_library->calculate_throughput($size, $transfer_time);

#Delete file from destination
if (!$global_library->delete_file("$mapped_destination\\$file")) {
	exit 2;
}

#Enable Orbital(s)
if (!$wan_scalar1->set_parameter('PassThrough',0)){
	exit 2;
}

if (!$wan_scalar2->set_parameter('PassThrough',0)){
	exit 2;
}


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

#Transfer file(s) again using the same BW
if (($transfer_time = $global_library->copy_file("$working_folder$TYPE_OF_FILE\\$file", $mapped_destination)) eq undef) {
	exit 2;
}

#Delete file from destination
if (!$global_library->delete_file("$mapped_destination\\$file")) {
	exit 2;
}

#Find out throughput
my $throughput_with_orbitals = $global_library->calculate_throughput($size, $transfer_time);

#Compare both the BW and decide Pass/Fail
$global_library->print_message("Throughput without Orbital(s): ".$throughput_without_orbitals);
$global_library->print_message("Throughput with Orbital(s)   : ".$throughput_with_orbitals);
if ($throughput_with_orbitals >= $throughput_without_orbitals) {
	print "\n\nTest Status: Pass\n\n";
	exit 0;
}
else{
	print "\n\nTest Status: Fail\n\n";
	exit 1;
}
