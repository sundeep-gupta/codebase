# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Security::McAfee::Mac::Consumer;
use strict;
use  Const;


$Security::McAfee::Mac::Consumer::config = {
    'gui_mode'      => 0, 
    'old_build'     => 0,

########################## SERVICES AND PROCESSES ###############################    
    'process'       =>  [ 
            'VShieldScanMana', 'fmpd', 'Menulet', 'appProtd',
            'FWService', 'SiteAdvisorFM', 'McAfee Rep',
            'VShieldService', 'Menulet','VShieldScanner',
            'McAfee Internet Security'
    ],
    
    'primary_services' => [ 'VShieldScanner', 'fmpd', 'Menulet',
        'FWService', 'SiteAdvisorFM', 'VShieldService', 'VShieldScanM' ],
    
    'update_service' => 'AntiMalwareUpdate',
    'aw_process'     => 'ActivationWizard',
################### LOCATIONS ##############################
    'product_log' => 'McAfee Internet Security.log',
    'instru_file' => '/usr/local/McAfee/fmp/var/instru.xml',
    'product_paths' =>  [ 
            '/usr/local/McAfee', 
            '/Library/Application Support/McAfee', 
            '/Library/Application Support/Mozilla/Extensions/'.
                    '{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/{1650a312-02bc-40ee-977e-83f158701739}',

            '/Library/Receipts/sainst.pkg',
            '/Library/Receipts/AntiMalware.pkg',
            '/Library/Receipts/AppProtection.pkg',
            '/Library/Receipts/FMP.pkg',
            '/Library/Receipts/Firewall.pkg',
            '/Library/Receipts/MSCUI.pkg',
            '/Library/Receipts/SiteAdvisorFM.pkg',

            '/Library/Frameworks/SACore.framework',
            '/Library/Frameworks/Scanbooster.framework',
            '/Library/Frameworks/AVEngine.framework',
            '/Library/Frameworks/VirusScanPreferences.framework',


            '/Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist',
            '/Library/LaunchDaemons/com.mcafee.virusscan.fmpd.plist',
    
            '/Library/Preferences/com.mcafee.ssm.antimalware.plist',
            '/Library/Preferences/com.mcafee.ssm.appprotection.plist',
            '/Library/Preferences/com.mcafee.ssm.firewall.plist',
                                  
            '/Applications/McAfee Internet Security.app',      
            '/etc/periodic/daily/555.siteadvisor',
            '/Users/Shared/.McAfee',
	    '/Library/Documentation/Help/McAfeeSecurity.help'
    ],

    'log_path' => ['/var/log/McAfeeInternetSecurity.log', '/var/log/McAfeeInternetSecurityDebug.log',
        '/var/log/install.log', '/var/log/kernel.log'
    ],

########################## UI RELATED TODO SHOULD BE MOVED TO CONST.PM ###########################
    'screens'     => [2, 3, 4, 6, 7, 8, 9],

################################### TOOLS ########################################################
    'tools' => {
		'qatt' => {
			'bin'    =>'lib'.'/tools/Consumer/QATT/QATestTool', 
			'config' => 'lib'.'/tools/Consumer/QATT/FMConfig.xml',
		},

		'fwtt' => {
			'bin' =>'lib'.'/tools/Consumer/FWTT/FWTestTool',
			'config' => 'lib'.'/tools/Consumer/FWTT/FMConfig.xml',
		},

		'aptt' => {
			'bin' => 'lib'.'/tools/Consumer/APTT/appProtTestTool',
			'config' => 'lib'.'/tools/Consumer/APTT/FMConfig.xml',
		},
	}


};


###################### REPORTER UI CONFIGURATIONS and COMMANDS FOR APPLESCRIPT ##########################

##  $reporter_app_name = 'McAfee Reporter',
#   $reporter_close_btn = 'Close', 
#   $reporter_close_btn_path =  'click button 1 of group 1 of group 3 of window 1'
#   $reporter_close_btn_with_more_path = 'click button 1 of group 2 of group 3 of window 1',
#   $repoter_more_btn_path   = 'click UI element 5 of group 3 of group 3 of window 1',
#   $reporter_less_btn_path  = 'click UI element 5 of group 4 of group 3 of window 1'
#   $reporter_detection_msg_path = 'get value of static text 1 of group 3 of group 3 of window 1'; # e.g., 1 Dections on your Mac
#   $reporter_
#
##  # Details of the table shown during 'more' is not captured
#
#########################################################################################################


################# ACTIVATION WIZARD : Configurations and applescript #####################################
# $act_email_addr_path = 'set value of text field 2 of group 1 of group 1 of window 1 to "<string>"'
# $act_password_path   = 'select text field 1 of group 1 of group 1 of window 1' # This is Securte TExtfield and thus may not be able to set password

# $act_forgot_link_path = 'click UI element 1 of group 1 of UI element 1 of scroll area 1 of group 1 of group 1 of window 1',
# $act_cancel_btn_path = 'click button 1 of group 1 of group 1 of window 1',
# $act_next_btn_path   = 'click button 2 of group 1 of group 1 of window 1',
# $act_remind_later_path = 'click button 1 of group 1 of group 1 of window 1',
# $act_back_btn_path   = 'click button 2 of group 1 of group 1 of window 1',
# $act_finish_btn_path = 'click button 2 of group 1 of group 1 of window 1',
# $act_act_succ_msg_path = 'get value of static text 1 of group 1 of UI element 1 of scroll area 1 of group 1 of group 1 of window 1',

# TODO: In applescript find if an element / UI exist or not before acting on it.
#        $rror Handling in AppleScript.pm
##########################################################################################################


################# SOME CONSOLE UI PATH ##############################
# $btn_renw_path = 'click button 1 of group 2 of group 2 of window 1',
# $btn_
######################


####################################### PREFERENCES WINDOW PATHS ###########################################
#
# $pref_window_title_path = 'get value of static text 7 of window 1', # GENERAL
 #  'get value of static text 2 of window 1' # ANTIMALWARE
 # 
# $pref_toolbar_general   = 'click button 1 of tool bar 1 of window 1'
# $pref_toolbar_am        = 'click button 2 of tool bar 1 of window 1',
# $pref_toolbar_approt    = 'click button 3 of tool bar 1 of window 1',
# #pref_toolbar_firewall  = 'click button 4 of tool bar 1 of window 1',
# 
# $gen_lock_enabled_msg = 'get value of static text 6 of window 1',
# $pref_lock_path       = 'click button 4 of window 1'; # GENERAL
#  click button 5 of window 1' AntiMalware
#
# $pref_am_on  = 'click radio button 1 of radio group 5 of window 1',
# $pref_am_off = 'click radio button 2 of radio group 5 of window 1',
#
# $pref_spyware_on = 'click radio button 1 of radio group 4 of window 1',
# $pref_spyware_off= 'click radio button 2 of radio group 4 of window 1',
#
# $pref_approt_on = 'click radio button 1 of radio group 3 of window 1',
# $pref_approt_off = 'click radio button 2 of radio group 3 of window 1',
# $pref_firewall_on = 'click radio button 1 of radio group 2 of window 1',
# $pref_firewall_off = 'click radio button 2 of radio group 2 of window 1',
# $pref_update_on = 'click radio button 1 of radio group 1 of window 1',
# $pref_update_off = 'click radio button 2 of radio group 1 of window 1',
#
#
#

#
#
###############################################

1;
