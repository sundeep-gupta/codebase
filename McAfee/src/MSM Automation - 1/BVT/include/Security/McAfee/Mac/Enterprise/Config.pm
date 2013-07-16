# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Security::McAfee::Mac::Enterprise;
use strict;
use Exporter;
use Const;
our @ISA = qw(Exporter);

our @EXPORT = qw($config);
$Security::McAfee::Mac::Enterprise::config = {
   
########################## SERVICES AND PROCESSES ###############################     
    'process'       => [ 'VShieldScanManager', 'fmpd', 'appProtd', 'FWService', 'cma', 'McAfee Rep',
                         'VShieldService', 'Menulet','VShieldScanner' ],

    'avas_services'       => [ 'VShieldScanManager', 'fmpd','cma', 'McAfee Rep',
                         'VShieldService', 'Menulet','VShieldScanner', ],
    'fw_services'      =>    'FWService',
    'apppro_services'   =>   'appProtd',
    'update_service' => 'VShieldUpdate',                     

################### LOCATIONS ##############################
    'product_paths' => [ '/usr/local/McAfee',
                         '/Library/Application Support/McAfee',
                         '/Library/Preferences/com.mcafee.ssm.antimalware.plist',
                         '/Library/McAfee/cma',
                        ],
    
    'product_log'      => '/var/log/McAfeeSecurity.log',		
    'cma_root_dir'    => '/Library/McAfee/cma',
    'cma_uninstaller'   => '/Library/McAfee/cma/uninstall.sh',
    'crash'           => [ '/Library/Logs/DiagnosticReports/',
			   '/Library/Logs/CrashReporter/',
			 ],

    'screens'           => [2, 3, 4, 6, 7],
##################### TOOL SPECIFIC CONFIGURATION ##########################

    'tools' => {
		'qatt' => {
			'bin'    =>$LIB_DIR.'/tools/Enterprise/QATT/QATestTool', 
			'config' => $LIB_DIR.'/tools/Enterprise/QATT/FMConfig.xml',
		},

		'fwtt' => {
			'bin' =>$LIB_DIR.'/tools/Enterprise/FWTT/FWTestTool',
			'config' => $LIB_DIR.'/tools/Enterprise/FWTT/FMConfig.xml',
		},

		'aptt' => {
			'bin' =>$LIB_DIR.'/tools/Enterprise/APTT/appProtTestTool',
			'config' => $LIB_DIR.'/tools/Enterprise/APTT/FMConfig.xml',
		},
	}

};

1;
