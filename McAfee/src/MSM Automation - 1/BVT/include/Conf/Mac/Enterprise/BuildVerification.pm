# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Conf::Mac::Enterprise::BuildVerification;

use Const;
use strict;
use Conf;
use Cwd;
our @ISA = qw(Conf);

my $TEST_CONFIG = {
    'product_name'       => $MAC_ENTERPRISE,
    'test_case_list'    => [

############################################ SECTION : INSTALL CHECK ########################################    
        { 
            'name'    => 'Install',
            'tc_desc' => 'Product installation check',
            'execute' => 1,
            'build_url'   => 'http://bngweb.corp.nai.org/Builds/TOPS/MSC/676/McAfee Security for Mac-1.0-RTW-676.dmg',
            'verify'  => {},
         },
        
         {
             'name'  => 'CommonServices',
             'tc_desc'  => 'Common services check',
             'execute' => 1,
             'services' => [ 'VShieldScanner', 'VShieldScanManager', 'fmpd', 'cma',
                            'McAfee Rep', 'VShieldService' ],
             'verify' => {},
         },
         
         {
             'name'  => 'MenuletService',
             'tc_desc'  => 'Menulet service check',
             'execute' => 1,
             'services' => [ 'Menulet' ],
             'verify' => {},
         },
         
	 {
             'name'  => 'OtherServices',
             'tc_desc'  => 'Other services check',
             'execute' => 1,
             'services' => [ 'appProtd', 'FWService' ],
             'verify' => {},
         },
         
         {
             'name' => 'ConsoleAppLaunch',
             'tc_desc' => 'Console application launch check',
             'execute' => 1,
             'applications' => ['McAfee Security'],
             'verify' => {},
        },

############################################ SECTION : OAS CHECK ########################################    
        {
            'name'     => 'OASInstallCheck',
            'tc_desc'  => 'OAS install check',
            'execute'   => 1,
            'data_dir' => 'OASMixed', # We'll remove this in future
            'product_pref' => {},
            'read' => 0,
            'write' => {
                'data'       =>  'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*',
                'file_count' => 1,
            },
            'verify' => {},
            'needs_module'  => 'VShieldService',
        },

        {
            'name'     => 'OASExclusion',
            'tc_desc'  => 'OAS exclusion check',
            'execute'   => 1,
            'data_dir' => 'OASMixed', # We'll remove this in future
            'product_pref' =>  {
				'qatt' => [" 3 OAS_Exclusion_List ".&Cwd::abs_path( "$DATA_DIR/OASMixed" ) ]
			},
            'read' => 0,
            'write' => {
                'data'       => 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*',
                'file_count' => 1,
            },
            'verify' => {},
            'needs_module'  => 'VShieldService',
        },
        
	{
            'name'     => 'OASQuarantine',
            'tc_desc'  => 'OAS quarantine check',
            'execute'   => 1,
            'data_dir' => 'OASMixed', # We'll remove this in future
            'product_pref' => {},
            'read' => 0,
            'write' => {
                'data'       =>  'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*',
                'file_count' => 1,
            },
            'verify' => {},
            'needs_module'  => 'VShieldService',
        },

############################################ SECTION : ODS CHECK ########################################    
        {
            'name'     => 'ODSInstallCheck',
            'tc_desc'  => 'ODS install check',
            'execute'  => 1,
            'data_dir' => 'ODSMixed',
            'product_pref' => {},
            'data'       => 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*',
            'verify' => {},
            'needs_module'  => 'VShieldService',
       },
       
       # ODS With Exclusion List
       {
            'name'     => 'ODSExclusion',
            'tc_desc'  => 'ODS exclusion check',
            'execute'  => 1,
            'data_dir' => 'ODSMixed',    
            'product_pref' => {
				'qatt' => [ 
					' 3 ODS_Exclusion_List '. &Cwd::abs_path( "$DATA_DIR/ODSMixed" ) 
					]
			},
            'data'       => 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*',
            'verify' => {},
            'needs_module'  => 'VShieldService',
       },
        
	{
            'name'     => 'ODSQuarantine',
            'tc_desc'  => 'ODS quarantine check',
            'execute'  => 1,
            'data_dir' => 'ODSMixed',
            'product_pref' => {},
            'data'       => 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*',
            'verify' => {},
            'needs_module'  => 'VShieldService',
       },
       
########################################### SECTION : UPDATE CHECKS ############################
        {
            'name' => 'Update',
            'tc_desc' => 'Update check',
            'dat'     =>  '5970',
            'plist'   =>  'com.mcafee.ssm.antimalware.plist',
            'execute' => 1,
            'verify' => {},
            'needs_module'  => 'VShieldService',
        },
       
################################### APPLICATION PROTECTION CHECKS ############################
        {
            'name' => 'AppProtDefaultPref',
            'tc_desc' => 'Application Protection default preferences check',
            'execute' => 1,
            'verify' => {},
            'needs_module'  => 'AppProtection',
        },

	{
            'name' => 'AppProtDenyAccess',
            'tc_desc' => '',
            'execute' => 1,
            'applications' => ['Chess'],
            'product_pref' => {
 		'aptt' => [ '',],
             },
             'verify' => {},
             'needs_module'  => 'AppProtection',
 	},
 		
	{
            'name' => 'AppProtExclusion',
            'tc_desc' => '',
            'execute' => 1,
            'applications' => ['Chess'],
            'product_pref' => {
 		'aptt' => [ '',],
             },
             'verify' => {},
             'needs_module'  => 'AppProtection',
 	},
 		
 	{
             'name' => 'AppProtNoNetworkAccess',
             'tc_desc' => 'Application protection launch without network access check',
             'execute' => 1,
             'app_name' => 'nslookup',
             'app_src_dir' => '/usr/bin',
             'data_dir' => 'applaunch',
             'verify' => {},
             'needs_module'  => 'AppProtection',
 	},
 
######################################## SECTION : FIREWALL CHECKS ############################
        {
            'name' => 'FWDefaultPref',
            'tc_desc' => 'Firewall default preferences check',
            'execute' => 1,
            'verify' => {},
            'needs_module'  => 'Firewall',
        },
 
        {
            'name' => 'FWDenyAccess',
            'tc_desc' => 'Firewall deny access check',
            'execute' => 1,
            'product_pref' => {
                                'fwtt' => [ ' 5 0 0 0 4 ',
                                            ' 7 telnet 2 3 1 me 1-65535 any 1-65535 en0 '] 
            },
            'fwtest_mc' => 'Purvang-Mac-Mini.local',
            'fwtest_mc_userid' => 'Purvang',
            'fwtest_mc_password' => 'test',
            'telnet_type' => 'deny',
            'verify' => {},
            'needs_module'  => 'Firewall',
        },
 
        {
            'name' => 'FWAllowAccess',
            'execute' => 1,
            'tc_desc' => 'Firewall allow access check',
            'product_pref' => { 
                                'fwtt' => [ ' 5 0 0 0 4 ',
                                            ' 23 ping 1 3 1 me any ']
            },
            'fwtest_mc' => '192.168.215.127',
            'ping_type' => 'allow',
            'verify' => {},
            'needs_module'  => 'Firewall',
        },

        {
            'name' => 'FWTrustedList',
            'execute' => 1,
            'tc_desc' => 'Firewall trusted list check',
            'fwtest_mc' => '192.168.215.127',
            'ping_type' => 'allow',
            'product_pref' => {
                                'fwtt' => [ ' 5 0 0 0 4 ',
                                            ' 11 my_group 1 1 192.168.215.127 ',
                                            ' 23 ping 2 3 1 me any ']

            },
            'verify' => {},
            'needs_module'  => 'Firewall',
        },

########################################## SECTION : UNINSTALL CHECK ############################        
        {
            'name'    => 'Uninstall',
            'tc_desc' => 'Product Uninstallation check',
            'execute' => 1,
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



1;
