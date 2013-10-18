#!/usr/bin/perl
#
# Copyright:			Citrix, 2006
# Created By:			AppLabs
# Created On:			2006/08/28
# Revision:				1.1
# Last Modified:		2006/09/01
# 
# Script ID:			MCR-057
# Script Name:			MCR-057.pl
# Description:			Verifies integrity of transferred data at second level of compression
# Pass/Fail Criteria:	Pass if transferred data is accurate, otherwise Fail.
# Exit value:			0=Pass; 1=Fail; 2=Error

use ORAPP::WAN_Scalar;
use ORAPP::WAN_Simulator;
use ORAPP::Config;
use ORAPP::Global_Library;
use File::Find;
use Getopt::Long;
use Cwd;
use strict;

#my $working_folder = getcwd;
my $working_folder = getcwd."/tmp";
my $size = 10240; #in Bytes
my $bw = 300;
my $delay = 0;
my $plr = 0;
my $system_type = "c";
my $help;
my $CONNECTIONS = 3;

my $TYPE_OF_FILE = 1; #0=Compressible; 1=Medium Compressible; 2=Non-compressible

GetOptions("help"		 => \$help,
		   "path=s"      => \$working_folder,
		   "size=i"      => \$size,
		   "bw=i"		 => \$bw,
		   "delay=i"     => \$delay,
		   "plr=i"       => \$plr,
		   "stype=s"	 => \$system_type);	

if ($help) {
	print "Usage: #perl mcr-057.pl [ --stype <type of system, script is running on>
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
my ($file, $source_checksum, $target_checksum, $mapped_folder, $transfer_time);

#Making working folder name consistent
$working_folder =~ s/\\/\//g;
if (substr($working_folder,length $working_folder, 1) ne "/") {
	$working_folder = $working_folder."/";
}

#Getting WAN Simulator info into a HASH
my $wan_sim_info = {
				bandwidth => $bw,
				delay     => $delay,
				plr       => $plr
             };


#Preparing data set to be transferred
if (($file = $global_library->prepare_data($working_folder, $TYPE_OF_FILE, $size)) eq undef) {
	exit 2;
}

#Calculate checksum at source
if (($source_checksum = $global_library->calculate_checksum("$working_folder$TYPE_OF_FILE/",$file)) eq undef) {
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

my ($ctr, $pid, @cpids, @target_checksums);
my $ppid = $$;
for ($ctr=1;$ctr<=$CONNECTIONS;$ctr++) {
	if (!defined($pid = fork())) {
		$global_library->print_message("Can't fork!");
		exit 2;
	}elsif ($pid == 0) {
		if (($transfer_time = $global_library->copy_file("$working_folder$TYPE_OF_FILE/$file", "//$server/$share/$file$ctr")) eq undef) {
			kill 9, $ppid;
			kill 9, @cpids;
			exit 2;
		}
		exit 0;
	}else {
		push(@cpids,$pid);
	}
}

foreach (@cpids) {
	waitpid($_,0);
}
#Delete file from destination
if (!$global_library->delete_file($mapped_folder."*.*")) {
	exit 2;
}
for ($ctr=1;$ctr<=$CONNECTIONS;$ctr++) {
	if (!defined($pid = fork())) {
		$global_library->print_message("Can't fork!");
		exit 2;
	}elsif ($pid == 0) {
		if (($transfer_time = $global_library->copy_file("$working_folder$TYPE_OF_FILE/$file", "//$server/$share/$file$ctr")) eq undef) {
			kill 9, $ppid;
			kill 9, @cpids;
			exit 2;
		}
		exit 0;
	}else {
		push(@cpids,$pid);
	}
}

foreach (@cpids) {
	waitpid($_,0);
}
for ($ctr=1;$ctr<=$CONNECTIONS;$ctr++) {
	if (($target_checksum = $global_library->calculate_checksum($mapped_folder,"$file$ctr")) eq undef) {
		exit 2;
	}else {
		push(@target_checksums,$target_checksum);
	}
}

#Delete file from destination
if (!$global_library->delete_file($mapped_folder."*.*")) {
	exit 2;
}

#Comparing checksum at source & destination
for ($ctr=1;$ctr<=$CONNECTIONS;$ctr++) {
	if ($global_library->verify_checksum($source_checksum,$target_checksums[$ctr])) {
		print "\n\nTest Status: Pass\n\n";
		exit 0;
	} else {
		print "\n\nTest Status: Fail\n\n";
		exit 1;
	}
}