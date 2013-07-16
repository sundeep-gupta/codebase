# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Conf::Mac::Consumer::BuildVerification;

use Const;
use strict;
use Conf;
use Cwd;
our @ISA = qw(Conf);

my $TEST_CONFIG = {
    'product_name'       => $MAC_CONSUMER,
    
    'test_case_list'    => [

############################################ SECTION : INSTALL CHECK ########################################    
          { 
            'name'    => 'Install',
            'tc_desc' => 'install of product',
            'execute' => 1,
            'automatic_build_identification' => $TRUE,
            'build'   => {
			    'url'   => 'http://bngweb.corp.nai.org/Builds/TOPS Consumer/MS-CONS',
				'version'  => '1.0',
				'name' => 'McAfee Internet Security for Mac',
                'build' => 236,
                'lang'  => 'en-us',
                'type'  => 'RTW',
            },
            'verify'  => {
                'services'    => 1,
            },
        }, 
        
############################################ SECTION : OAS CHECK ########################################    
        {
            'name'     => 'OASMixed',
            'tc_desc'  => 'OAS with clean - quarantine',
            'execute'   =>  0,
            'data_dir' => 'OASMixed', # We'll remove this in future
            'product_pref' => {
			    'qatt' => [
	                '3 OAS_AV_ScannerSecondaryAction 2' ,
				]
            },
            'read' => 0,
            'write' => {
                'data'       =>  'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*',
                'file_count' => 1,
            },
            'verify' => {},
        },

        # OAS Mixed with Delete as secondary action
        {
            'name'     => 'OASMixed',
            'tc_desc'  => 'OAS with clean - delete',
            'execute'  => 0,
            'data_dir' => 'OASMixed', # We'll remove this in future
            'product_pref' => {
				'qatt' => [
                	'3 OAS_AV_ScannerSecondaryAction  3',
				]
            },
            'read' => 0,
            'write' => {
                'data'       => 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*',
                'file_count' => 1,
            },
            'verify' => {},
       },
       # OAS Mixed with Quarantine as secondary action
        {
            'name'     => 'OASMixed',
            'tc_desc'  => 'OAS with file in exclusion list',
            'execute'   =>  0,
            'data_dir' => 'OASMixed', # We'll remove this in future
            'product_pref' => {
				'qatt' => [ 
	                '3 OAS_Exclusion_List ' . &Cwd::abs_path( "$DATA_DIR/OASMixed" ),
				]
            },
            'read' => 0,
            'write' => {
                'data'       => 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*',
                'file_count' => 1,
            },
            'verify' => {},
        },

 

############################################ SECTION : ODS CHECK ########################################    
        {
            'name'     => 'ODSMixed',
            'tc_desc'  => 'ODS with clean - delete',
            'execute'  => 0,
            'data_dir' => 'ODSMixed',
            'product_pref' => {
				'qatt' => [ 
                	'3 ODS_AV_ScannerSecondaryAction 3', 
				]
            },
            'source_dir' => '/Volumes/DATA/ods-mixed-1',
            'verify' => {},
       },
       
        {
            'name'     => 'ODSMixed',
            'tc_desc'  => 'ODS with clean - quarantine', 
            'execute'  => 0,
            'data_dir' => 'ODSMixed',
            'product_pref' => {
                'qatt' => [
					'3 ODS_AV_ScannerSecondaryAction 2',
				]	
            },
            'source_dir' => '/Volumes/DATA/ods-mixed-1',
            'verify' => {},
       },

       # ODS WIth Exclusion List
       {
            'name'     => 'ODSMixed',
            'tc_desc'  => 'ODS with exclusion list',
            'execute'  => 0,
            'data_dir' => 'ODSMixed',
            'product_pref' => {
				'qatt' => [
                '3 ODS_Exclusion_List'. &Cwd::abs_path( "$DATA_DIR/ODSMixed" ),
				]
            },
            'source_dir' => '/Volumes/DATA/ods-mixed-1',
            'verify' => {},
       },
################################### APPLICATION PROTECTION CHECKS ############################
 		{
            'name' => 'DefaultAPPref',
            'tc_desc' => 'Application Protection : Check Default Preferences',
            'execute' => 0,
            'verify' => {},
        },
  		{
 			'name' => 'Applaunch',
 			'tc_desc' => 'Application protection check for apple signed binary with default settings',
 			'execute' => 0,
 			'applications' => ['Safari'],
 			'verify' => {},
 		},		
  		{
 			'name' => 'Applaunch',
 			'tc_desc' => 'Application protection check for unknown binary with default settings',
 			'execute' => 0,
 			'applications' => ['Firefox'],
 			'verify' => {},
 		},	 		
 		{
 			'name' => 'Applaunch',
 			'tc_desc' => 'Application protection with application denied',
 			'execute' => 0,
 			'applications' => ['Firefox'],
 			'product_pref' => {
 				'aptt' => [ 
 				    # Command to deny an application
 					'20000 /Applications/Firefox.app 0 1 1',
 				],
 			},
 			'verify' => {},
 		},
 		
 		{
 			'name' => 'Applaunch',
 			'tc_desc' => 'Application launch with deny and app in exclusion list',
 			'execute' => 0,
 			'applications' => ['Firefox'],
 			'product_pref' => {
 				'aptt' => [
 					# Add rule to deny and also exclude the given application.
 					'20000 /Applications/Firefox.app 0 1 1',
 					'20007 /Applications/Firefox.app'
 				]
 			},
 			'verify' => {},
 		},
 		
 		{
 			'name' => 'Applaunch',
 			'tc_desc' => 'Application launch with restricted network access',
 			'execute' => 0,
 			'applications' => ['Firefox'],
 			'product_pref' => {
 				'aptt' => [
 					# TODO: Add rule to allow application with restricted network access.
 				]
 			},
 			'verify' => {},
 		},
######################################## SECTION : FIREWALL CHECKS ############################
       {
            'name' => 'DefaultFWPref',
            'tc_desc' => 'Firewall : Check Default Preferences',
            'execute' => 0,
            'verify' => {},
        },
 
        {
            'name' => 'Telnet',
            'tc_desc' => 'Firewall : Check for Telnet',
            'execute' => 0,
            'product_pref' => {
                                'fwtt' => [ ' 5 0 0 0 4 ',
                                            ' 7 telnet 2 3 1 me 1-65535 any 1-65535 en0 '] 
            },
            'fwtest_mc' => 'Purvang-Mac-Mini.local',
            'fwtest_mc_userid' => 'Purvang',
            'fwtest_mc_password' => 'test',
            'telnet_type' => 'deny',
            'verify' => {},
        },
 
        {
            'name' => 'Ping',
            'execute' => 0,
            'tc_desc' => 'Firewall : Test for Ping Packets',
            'product_pref' => { 
                                'fwtt' => [ ' 5 0 0 0 4 ',
                                            ' 23 ping 1 3 1 me any ']
            },
            'fwtest_mc' => 'Purvang-Mac-Mini.local',
            'ping_type' => 'allow',
            'verify' => {},
            
        },

        {
            'name' => 'Trusted_List',
            'execute' => 0,
            'tc_desc' => 'Firewall : Check for Trusted list ',
            'fwtest_mc' => 'Purvang-Mac-Mini.local',
            'ping_type' => 'allow',
            'product_pref' => {
                                'fwtt' => [ ' 5 0 0 0 4 ',
                                            ' 23 ping 2 3 1 me any ',
                                            ' 11 my_group 1 1 Purvang-Mac-Mini.local ']        	              
            },
            'verify' => {},
        },


        {
            'name' => 'NetworkOperation',
            'tc_desc' => 'Firewall : Check for telnet blocking',
            'execute' => 0,
            
            'server' => 'msmc-performance-server.local',
            'user' => 'performance',
            'password' => 'test',
            'protocol' => 'telnet',
            'product_pref' => {
                                'fwtt' => [ ' 5 0 0 0 4 ',
                                            ' 7 telnet 2 3 1 me 1-65535 any 1-65535 en0 '] ,
            }
        },
 
        {
            'name' => 'NetworkOperation',
            'execute' => 0,
            'tc_desc' => 'Firewall : Check for allow ping',
            'server' => 'msmc-performance-server.local',
            'protocol' => 'icmp',
            'product_pref' => {
                # Set preference to add rule to change telnet session 
                
                                'fwtt' => [ ' 5 0 0 0 4 ',
                                            ' 23 ping 1 3 1 me any ']
            }
        },

        {
            'name' => 'NetworkCopy',
            'execute' => 0,
            'tc_desc' => 'Firewall : FTP from site in trusted list',
            'server'            => 'productc-performance-server.local',
            'user'              => 'performance',
            'password'          => 'test',
            'source'            => 'Sites/performance',
            'target'            => 'NetworkCopy',
            'files'             => ['test_download_1.zip', 'test_download_2.zip'],
            'product_pref' => {
            # TODO : Set preference to create trusted list
 
                 'fwtt' => [ ' 5 0 0 0 4 ',
                             ' 23 ping 2 3 1 me any ',
                             ' 11 my_group 1 1 Purvang-Mac-Mini.local ']        	    
            }
        },
########################################### SECTION : UPDATE CHECKS ############################
        {
            'name' => 'Update',
            'tc_desc' => 'Update ',
            'dat'     =>  '5855',
            'plist'   =>  'com.mcafee.ssm.antimalware.plist',
            'execute' => 0,
            'verify' => {},
        },
########################################## SECTION : UNINSTALL CHECK ############################        
        {
            'name'    => 'Uninstall',
            'tc_desc' => 'Uninstall',
            'execute' => 0,
            'verify' => {},
        },
    ], # END OF TEST CASES    
};


sub new {
    my ($package) = @_;
    my $self = Conf->new();
    $self->{'config'}=$TEST_CONFIG;
    bless $self, $package;
    return $self;
}
##### INFO FOR SQLITE 
#1. /usr/local/McAfee/fmp/var/FMP.db
#2. Table : recentEvents
#3. CREATE TABLE recentEvents ( i_msgId integer primary key, i_repTime varchar(64), i_repFM integer key, i_repDetailMsg varchar(64)
#)


1;
