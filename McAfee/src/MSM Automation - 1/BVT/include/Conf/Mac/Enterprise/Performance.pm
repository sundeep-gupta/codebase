# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Conf::Mac::Enterprise::Performance;

use Const;
use strict;
use Conf;
our @ISA = qw(Conf);


my $TEST_CONFIG = {
    'capture_frequency'  => 1,
    'product_name'       => $MAC_ENTERPRISE,
        'product_install_check'  => 0,
	'delay_time'         => 0,
	'count'              => 5,
	'reboot_required'    => 1,


    'test_case_list'    => [
        { 'name' => 'Applaunch',    'execute'            => 0,
            'tc_desc' => 'Application launch ', 
            'runs_per_iteration' => 2,
            'applications'       => ['Address Book', 'Activity Monitor', 'Console', 'Disk Utility',
                    'Network Utility', 'Mail', 'Safari', 'Adium', 'Firefox', 'iTunes',
                    'NetNewsWire', 'TinkerTool', 'VNCViewer',
                    'Microsoft Entourage', 'Microsoft Excel', 'Microsoft Powerpoint', 'Microsoft Word',
            ],
        },

        {
            'name' => 'Applaunch' , 'execute' => 0,
             'tc_desc' => 'Close Firefox', 
             'runs_per_iteration' => 1,
             'applications' => [ 'Firefox' ],
             'close_time' => $TRUE,
        },
        {
            'name' => 'Applaunch', 'execute' => 0,
            'tc_desc' => 'Open Firefox',
            'runs_per_iteration' => 1,
            'applications' => ['Firefox' ],
            
        },
        
        {
            'name' => 'Applaunch', 'execute' =>0,
            'tc_desc'=> 'Safari launch time',
            'runs_per_iteration' => 1,
            'applications' => ['Safari'],
        },
        {
            'name' => 'Applaunch',   'execute' => 1,
            'tc_desc' => 'McAfee Security launch ',
	    'runs_per_iteration' => 1,
            'applications' => [ 'McAfee Security' ],
        },

        
        { 
          'name' => 'OASClean' ,   'execute' => 0,
          'tc_desc' => 'On access scan clean data ',
          'runs_per_iteration' => 2,
          'data_dir' => 'oas-clean',
          'write'    => { 'file_count' => 100000 ,
                          'data'       => 'Content for clean data',
          },
          'capture_cpu_memory' => 0,
        },
        { 
            'name' => 'OASMixed'   , 'execute'            => 0,
            'runs_per_iteration' => 1,
            'data_dir'           => 'oas-mixed',
            'write' => {
                'file_count'         => 10,
                'data'               => "X5O\!P\%\@AP\[4\\PZX54\(P\^\)7CC\)7\}\$EICAR\-STANDARD\-ANTIVIRUS\-TEST\-FILE\!\$H\+H\*",
            },
            'product_pref' => {'OAS_Scanner_SecondaryAction' => 3 },
            'capture_cpu_memory' => 0,
        },
        {
            'name' => 'ODSClean',   'execute'            => 0,
            'runs_per_iteration' => 2,
            'data_dir'           => 'ods-clean',
            'capture_cpu_memory' => 1,
        },
        { 'name' => 'ODSMixed' ,   'execute'            => 0,
            'runs_per_iteration' => 1,
            'data_dir'           => 'ods-mixed',
            'capture_cpu_memory' => 1,
            'ods_action'         => 'delete',
            'source_dir'         => '/Volumes/DATA/PERF_DATASET/ods-mixed',
        },

        { 'name' => 'Install' ,     'execute'            => 1,
            'runs_per_iteration' => 1,
            'build'              => 178,
            'capture_cpu_memory'  => 1,
            'capture_frequency'  => 5,
        },

        { 'name' => 'Shutdown', 'execute'            => 0,
            'runs_per_iteration' => 1,
        },

        { 'name' => 'IdleTime',    'execute'            => 1,
          'tc_desc' => 'Idle time',
            'runs_per_iteration' => 1,
            'sleep_time'         => 5,
        },

        {'name' =>'RebootTime',  'execute'            => 0,
            'runs_per_iteration' => 1,
        },

        { 'name' => 'DiskSpace', 'execute'            => 1,
            'runs_per_iteration' => 1,
        },


######################################## TEST CASE REQUIRE NETWORK ACCESS ###############################################
        { 'name' => 'Appusage',    'execute'            => 0,
            'runs_per_iteration' => 2,
            'to_email'           => 'performance@vsmac.com',
            'to_name'            => 'Performance',
            'attachment'         => "$DATA_DIR/appusage/mail_attachment.txt",
            'body_file'          => "$DATA_DIR/appusage/content_for_email.txt",
            'applications' => [ 'apple_mail', 'entourage', 'word','powerpoint', 'excel' ],            
        },

        { 'name' => 'NetworkCopy',    'execute'            => 0,
            'protocol' => 'afp',
            'tc_desc'           => 'afp copy',
            'runs_per_iteration' => 1,
            'server'            => 'msmc-performance-server.local',
            'user'              => 'performance',
            'password'          => 'test',
            'server_dir'        => 'performance',
            'target'            => 'NetworkCopy',
            'mount'            => '/Volumes/performance',
            'files'             => ['test_download_1.zip','test_download_2.zip'],
        },

        { 'name' =>  'NetworkCopy',     'execute'            => 0,
            'tc_desc'           => 'scp copy',
            'protocol' => 'scp',
            'runs_per_iteration' => 1,
            'server'            => 'msmc-performance-server.local',
            'user'              => 'root',
            'password'          => 'test',
            'source'            => '/Users/performance/Sites/performance',
            'target'            => 'NetworkCopy',
            'files'             => ['test_download_1.zip', 'test_download_2.zip'],
        },

        { 'name' => 'NetworkCopy',     'execute'            => 0,
            'tc_desc' => 'ftp copy',
            'protocol' => 'ftp',
            'runs_per_iteration' => 1,
            'server'            => 'msmc-performance-server.local',
            'user'              => 'performance',
            'password'          => 'test',
            'source'            => 'Sites/performance',
            'target'            => 'NetworkCopy',
            'files'             => ['test_download_1.zip', 'test_download_2.zip'],
        },

        { 'name' => 'NetworkCopy',    'execute' => 1,
            'tc_desc' => 'http copy',
            'protocol' => 'http',
            'runs_per_iteration' => 1,
            'server'            => 'msmc-performance-server.local',
            'user'              => 'performance',
            'password'          => 'test',
            'source'            => '~performance/performance',
            'target'            => 'NetworkCopy',
            'files'             => ['test_download_1.zip', 'test_download_2.zip'],
        },


   ],
};



sub new {
    my ($package) = @_;
    my $self = Conf->new();
    $self->{'config'}=$TEST_CONFIG;
    bless $self, $package;
    return $self;
}

sub get_test_state {
    my ($self) = @_;
    my $ra_tc = $self->get_testcases();
    my $total = $self->get_config('count');
    my $ra_tc_state = [];
    foreach my $tc ( @$ra_tc) {
	push @{$ra_tc_state}, {'name' => $tc->{'name'},
			 'total' => $total};
    }
    return TestState->new($ra_tc_state);
}



1;
