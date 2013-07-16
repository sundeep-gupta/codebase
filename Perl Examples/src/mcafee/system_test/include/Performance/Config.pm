package Performance::Config;

use MSMConst;
use strict;
use MSMConfig;
our @ISA = qw(MSMConfig);

my $TEST_CONFIG = {
    'capture_frequency'  => 15,
	'product_name'       => $MAC_ENTERPRISE,
	'delay_time'         => 120,
	'count'              => 20,
	'reboot_required'    => 1,


	'test_case_list'    => {
		'CloseFirefox' => { 'execute' => 0,
		                   'runs_per_iteration' => 1,
   	    },

					   'LaunchConsole'  => { 'execute' => 0, 
								'runs_per_iteration' => 2 },

					   'OpenFirefox' => {  'execute'            => 0,
							          'runs_per_iteration' => 1,
								 
								 },
					   'OpenSafari' => { 'execute'            => 0,
							          'runs_per_iteration' => 1,
								 
								 },
					   'OASClean'   => { 'execute'            => 1,
							     'runs_per_iteration' => 2,
							     'data_dir'           => 'oas-clean',
							     'file_count'         => 100000,
							     'capture_cpu_memory' => 0,
							     'data'               => 'Content for clean data',
							    },

					   'OASMixed'   => { 'execute'            => 1,
							     'runs_per_iteration' => 2,
							     'data_dir'           => 'oas-mixed',
							     'file_count'         => 100000,
							     'capture_cpu_memory' => 1,
                                 'data'               => "X5O\!P\%\@AP\[4\\PZX54\(P\^\)7CC\)7\}\$EICAR\-STANDARD\-ANTIVIRUS\-TEST\-FILE\!\$H\+H\*",
							    },
                                           'ODSClean'   => { 'execute'            => 0,
							     'runs_per_iteration' => 2,
							     'data_dir'           => 'ods-clean',
							     'capture_cpu_memory' => 1,
							     'ods_action'         => 'delete',
							    							    },

				           'ODSMixed'   => { 'execute'            => 0,
							     'runs_per_iteration' => 1,
							     'data_dir'           => 'ods-mixed',
							     'capture_cpu_memory' => 1,
							     'ods_action'         => 'delete',
							     'source_dir'         => '/Volumes/DATA/mixed',
							    },
					   'InstallMSM'     => { 'execute'            => 0,
							     'runs_per_iteration' => 1,
							     'build_file'         => 'McAfee Security for Mac-1.0-81.mpkg',
							     'capture_cpu_memory'  => 1,
							     'capture_frequency'  => 5,
							    },
					   'Shutdown'=> {  'execute'            => 0,
							     'runs_per_iteration' => 1,
							    },
					   'IdleTime'   => {'execute'            => 0,
							     'runs_per_iteration' => 1,
							     'sleep_time'         => 60,
							    },
					   'RebootTime' => {'execute'            => 0,
							     'runs_per_iteration' => 1,
							    },
					   'DiskSpace'  => {'execute'            => 0,
									     'runs_per_iteration' => 1,
							    },
				           'Applaunch'   => { 'execute'            => 0,
							     'runs_per_iteration' => 2,
							     'applications'       => ['Address Book', 'Activity Monitor', 'Console', 'Disk Utility',
               									      'Network Utility', 'Mail', 'Safari', 'Adium', 'Firefox', 'iTunes',
               									      'NetNewsWire', 'Remote Desktop Connection', 'TinkerTool', 'VNCViewer',
              									      'Microsoft Entourage', 'Microsoft Excel', 'Microsoft Powerpoint', 'Microsoft Word',
										     ],

							    },


######################################## TEST CASE REQUIRE NETWORK ACCESS ###############################################
				           'Appusage'    => { 'execute'            => 0,
							     'runs_per_iteration' => 2,
							     'to_email'           => 'performance@vsmac.com',
							     'to_name'            => 'Performance',
 							     'attachment'         => "$DATA_DIR/appusage/mail_attachment.txt",
							     'body_file'          => "$DATA_DIR/appusage/content_for_email.txt",
							   'applications' => [ 'apple_mail', 'entourage', 'word','powerpoint', 'excel' ],            
							    },
					   'AFPCopy'    => { 'execute'            => 0,
							     'runs_per_iteration' => 1,
							     'server'            => 'tests-mac-mini.local',
							     'user'              => 'test',
							     'password'          => 'performance',
							     'server_dir'        => 'performance',
							     'source'            => 'scp_copy',
							     'target'            => '/Volumes/performance',
							     'files'             => ['test_download_1.zip','test_download_2.zip'],
							    },

					   'SCPCopy'    => {'execute'            => 0,
							     'runs_per_iteration' => 1,
							     'server'            => 'tests-mac-mini.local',
							     'user'              => 'root',
							     'password'          => 'test',
							     'source'            => '/Users/test/Sites/performance',
							     'target'            => 'scp_copy',
							     'files'             => ['test_download_1.zip', 'test_download_2.zip'],
							    },
					   
					   'FTPCopy'    => { 'execute'            => 0,
							     'runs_per_iteration' => 1,
							     'server'            => 'tests-mac-mini.local',
							     'user'              => 'test',
							     'password'          => 'performance',
							     'source'            => 'Sites/performance',
							     'target'            => 'ftp_copy',
							     'files'             => ['test_download_1.zip', 'test_download_2.zip'],
							    },

					   'HTTPCopy'    => { 'execute'            => 0,
							     'runs_per_iteration' => 1,
							     'server'            => 'tests-mac-mini.local',
							     'user'              => 'test',
							     'password'          => 'performance',
							     'source'       => '~test/performance',
							     'target'         => 'http_copy',
							     'files'             => ['test_download_1.zip', 'test_download_2.zip'],
							    },

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
	my $rh_all_tc = $self->{'config'}->{'test_case_list'};
    my $rh_tc = {};
    foreach my $key (keys %$rh_all_tc) {
        $rh_tc->{$key} = $rh_all_tc->{$key} if $rh_all_tc->{$key}->{'execute'} == 1;
    }
    return $rh_tc;
}

sub get_test_state {

    my ($self) = @_;
    my $rh_tc = $self->get_testcases();
    my $total = $self->get_config('count');
    my $ra_tc = [];
    foreach my $tc (keys %$rh_tc) {
	push @{$ra_tc}, {'name' => $tc,
			 'total' => $total};
    }
    return Performance::TestState->new($ra_tc);
}


1;
