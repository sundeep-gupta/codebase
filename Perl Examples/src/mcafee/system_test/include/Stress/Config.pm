package Stress::Config;

use MSMConst;
use strict;
use MSMConfig;

our @ISA = qw(MSMConfig);
my $TEST_CONFIG = {

                   'capture_frequency'  => 15,
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
                   'test_case_list'    => {

						# CONFIG FOR Firewall test case				   
				   	   'Firewall'  => {'execute' => 1,
							'URLs' => ["http://74.125.127.100/", "http://69.147.114.224/", "http://209.85.225.83/"],
							'ping' => ['www.google.co.in', 'www.yahoo.com'],
   	   				    },

						# CONFIG FOR AppProt test case				   
				   	   'AppProt'  => {'execute' => 1,

					   },


					   'OASClean'   => {
					   	    'data_dir'           => 'oas-clean',
					   },
					   'ODSClean'   => {
					   	    'data_dir'           => 'ods_clean',
					   },
						# CONFIG FOR Firewall test case				   
				       'Applaunch'   => {
					     'applications'       => ['Address Book', 'Activity Monitor', 'Console', 'Disk Utility',
               									      'Network Utility', 'Mail', 'Safari', 'Adium', 'Firefox', 'iTunes',
               									      'NetNewsWire', 'Remote Desktop Connection', 'TinkerTool', 'VNCViewer',
              									      'Microsoft Entourage', 'Microsoft Excel', 'Microsoft Powerpoint', 'Microsoft Word',
					      ],

			          },

					  'ODSClean'  => { 
							'data_dir' => 'ods_clean',
					  },
						# CONFIG FOR Firewall test case				   
			         'Appusage' => { 
					      			'applications' => [ 'apple_mail', 'entourage', 'word','powerpoint', 'excel' ]
					  },


						# CONFIG FOR Firewall test case				   
					  'Compress' => { 
					  				  'source'  => 'compress' ,
									  'target'  => 'compress.tar'
					  },			  
						# CONFIG FOR Firewall test case				   
					  'Uncompress' => { 
					  				    'source' => 'uncompress.tar',
										'target' => 'uncompress',
									  }	

			}
	 };

#sub routine to fetch variable values from config file
sub get_config {
    my($self, $param) = @_;
	my $config = $self->{'config'};
    return $config->{$param};
}

sub get_testcase_config {
	my ($self, $testcase) = @_;
    return unless $_[0];
	my $testcase_config = $self->get_config('test_case_list');
    return $testcase_config->{$testcase};
}

sub get_testcase_param {
	my ($self, $testcase, $param)  = @_;
	return $self->get_testcase_config($testcase)->{$param};
}
sub new {
	my ($package) = @_;

	my $self = MSMConfig->new();
	$self->{'config'}=$TEST_CONFIG;
	bless $self, $package;
	return $self;

}

sub get_testcases {
	my ($self) = @_;
	return $self->get_config('test_case_list');
}
1;
