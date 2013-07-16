package Conf::Mac::Enterprise::Stress;
##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################
use Const;
use strict;
use Conf;

our @ISA = qw(Conf);
my $TEST_CONFIG = {

'capture_frequency'  => 30,
'delay_time'         => 120,
'product_name'       => $MAC_CONSUMER,
'run_stress'         => 1,
'stress_delay'       => 5,
'delay_between_ods' => 7200,
'run_qatest_tools' => 1, # TODO Not yet implemented.
'firewall_rules' => [ 
{
'Rule'   => 'Rule1',
'Action' => 'Deny',
'Protocol' => 'IP',
'Direction' => 'Outgoing',
'Interface' => 'en0',
'Source'  => 'Me',
'Destination' =>'Others',
'Source_IP' => 'NA',
'Destination_IP' => '74.125.127.100',
'Source_port' => '1-65535',
'Destination_port'=> '1-65535',
},
{
'Rule'   => 'Rule2',
'Action' => 'Allow',
'Protocol' => 'IP',
'Direction' => 'Both',
'Interface' => 'en0',
'Source'  => 'Me',
'Destination' =>'Others',
'Source_IP' => 'NA',
'Destination_IP' => '69.147.114.224',
'Source_port' => '1-65535',
'Destination_port'=> '1-65535',
},
{
'Rule'   => 'Rule3',
'Action' => 'Deny',
'Protocol' => 'IP',
'Direction' => 'Outgoing',
'Interface' => 'en0',
'Source'  => 'Me',
'Destination' =>'Others',
'Source_IP' => 'NA',
'Destination_IP' => '209.85.225.83',
'Source_port' => '1-65535',
'Destination_port'=> '1-65535',
},
],

'appprot_rules' => [
{
'Application'   => '/Application/Address Book.app/Contents/MacOS/Address Book',
'Action'        => 'Allow Execution with full Network Access',
'Restrictions'  => {}, # Currently Not Implemented So No use of providing :-)
},
{
'Application' => '/Applications/Utilities/Activity Monitor.app/Contents/MacOS/Activity Monitor',
'Action'      => 'Allow Execution with full Network Access',
},
{
'Application' => '/Applications/Utilities/Console.app/Contents/MacOS/Console',
'Action'      => 'Allow Execution with full Network Access',
},
{
'Application' => '/Applications/iTunes.app/Contents/MacOS/iTunes',
'Action'      => 'Allow Execution with full Network Access',
},
{
'Application' => '/Applications/Mail.app/Contents/MacOS/Mail',
'Action'      => 'Allow Execution with full Network Access',
},
{
'Application' => '/Applications/Microsoft Office 2008/Microsoft Excel.app/Contents/MacOS/Microsoft Excel',
'Action'      => 'Allow Execution with full Network Access',
},
{
'Application' => '/Applications/Microsoft Office 2008/Microsoft Word.app/Contents/MacOS/Microsoft Word',
'Action'      => 'Allow Execution with full Network Access',
},
{
'Application' => '/Applications/Microsoft Office 2008/Microsoft PowerPoint.app/Contents/MacOS/Microsoft PowerPoint',
'Action'      => 'Allow Execution with full Network Access',
},
],
'test_case_list'    => [
# CONFIG FOR Firewall test case				   
{ 'name' => 'Firewall', 'execute' => 1,
'URLs' => ["http://74.125.127.100/", "http://69.147.114.224/", "http://209.85.225.83/"],
'ping' => ['www.google.co.in', 'www.yahoo.com'],
},

# CONFIG FOR AppProt test case				   
{ 'name' => 'AppProt' , 'execute' => 1,
},


{ 'name' => 'OASClean', 'execute' => 1,   
'data_dir'           => 'oas-clean',
},
{ 'name' => 'ODSClean', 'execute' => 1,
'data_dir'           => 'ods-clean',
},
# CONFIG FOR Firewall test case				   
{ 'name' => 'Applaunch', 'execute'    => 1,
'applications'       => ['Address Book', 'Activity Monitor', 'Console', 'Disk Utility',
'Network Utility', 'Mail', 'Safari', 'Adium', 'Firefox', 'iTunes',
'NetNewsWire', 'Remote Desktop Connection', 'TinkerTool', 'VNCViewer',
'Microsoft Entourage', 'Microsoft Excel', 'Microsoft Powerpoint', 'Microsoft Word',
],
},
{ 'name' => 'ODSClean', 'execute' => 1, 
'data_dir' => 'ods-clean',
},
# CONFIG FOR Firewall test case				   
{ 'name' => 'Appusage', 'execute' => 1,  
'applications' => [ 'apple_mail', 'entourage', 'word','powerpoint', 'excel' ]
},
# CONFIG FOR Firewall test case				   
{ 'name' => 'Compress', 'execute' => 1,
'source'  => 'compress' ,
'target'  => 'compress.tar'
},			  
# CONFIG FOR Firewall test case				   
{ 'name' => 'Uncompress', 'execute' =>  1,
'source' => 'uncompress.tar',
'target' => 'uncompress',
}	
]
};

#sub routine to fetch variable values from config file

sub new {
	my ($package) = @_;
	my $self      = Conf->new();
	$self->{'config'}=$TEST_CONFIG;
	bless $self, $package;
	return $self;

}

1;
