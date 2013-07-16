# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Security::McAfee::Mac;
use strict;
use Const;

$Security::McAfee::Mac::config = {

################## COMMON LOCATIONS OF MAC PRODUCTS ########################
    'dat_paths'     => [ '/usr/local/McAfee/AntiMalware/dats' ],
    'uninstaller'   => '/usr/local/McAfee/uninstallMSC',
    'am_pref'      => '/Library/Preferences/com.mcafee.ssm.antimalware.plist',
    'ap_pref'       => '/Library/Preferences/com.mcafee.ssm.appprotection.plist',
    'root_dir'      => '/usr/local/McAfee',
    'fmp_bin'       => 'fmp/bin/fmp',
    'fmp_bin_path'   => 'fmp/bin',
    'fmp_config_path' => 'fmp/config',
    'scanner_plist' => '/Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist',

};
1;
