# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Security::McAfee::Mac::Const;
use strict;
require Exporter;
our @ISA = qw(Exporter);

our @EXPORT = ();

#push @EXPORT, qw($app_name $btn_Cancel $btn_create $btn_plus $btn_minus $btn_OK $btn_cancel);
#$Security::McAfee::Mac::Const::btn_Cancel    = 'Cancel';
#$Security::McAfee::Mac::Const::btn_create    = 'Create';
#$Security::McAfee::Mac::Const::btn_plus      = '+';
#$Security::McAfee::Mac::Const::btn_minus     = '-';
#$Security::McAfee::Mac::Const::btn_OK        = 'OK';
#$Security::McAfee::Mac::Const::btn_cancel    = 'cancel'; 

# TABS 
#push @EXPORT, qw($win_general $btn_general $btn_app_prot $win_app_prot $btn_anti_malware $win_antimalware );
#$Security::McAfee::Mac::Const::win_general   = 'General';
#$Security::McAfee::Mac::Const::btn_general     = 'General';
#$Security::McAfee::Mac::Const::btn_app_prot  = 'Application Protection';
#$Security::McAfee::Mac::Const::win_app_prot  = 'Application Protection';
#$Security::McAfee::Mac::Const::btn_anti_malware = 'Anti-malware';
#$Security::McAfee::Mac::Const::win_antimalware  = 'Anti-malware';


# SUB TABS
#push @EXPORT, qw($btn_rules $btn_exclusions $btn_excl $btn_oas $btn_ods $btn_trusted);

#$Security::McAfee::Mac::Const::btn_rules        = 'Rules';
#$Security::McAfee::Mac::Const::btn_exclusions   = 'Exclusions';
#$Security::McAfee::Mac::Const::btn_excl         = 'Exclusions';
#$Security::McAfee::Mac::Const::btn_oas          = 'On-access Scan';
#$Security::McAfee::Mac::Const::btn_ods          = 'On-demand Scan';
#$Security::McAfee::Mac::Const::btn_trusted     = 'Trusted Networks';

# OTHERS
#push @EXPORT, qw($btn_scan_now $btn_start_update $btn_go $btn_choose $btn_select 
#		 $win_select $btn_open $str_icmp $btn_start_scan $btn_stop_scan);
#$Security::McAfee::Mac::Const::btn_scan_now    = 'Scan Now';
#$Security::McAfee::Mac::Const::btn_start_scan    = 'Start Scan';
#$Security::McAfee::Mac::Const::btn_stop_scan    = 'Stop Scan';
#$Security::McAfee::Mac::Const::btn_start_update = 'Start Update';
#$Security::McAfee::Mac::Const::btn_stop_update  = 'Stop Update';
#$Security::McAfee::Mac::Const::btn_choose       = 'Choose...';
#$Security::McAfee::Mac::Const::btn_go           = 'Go';
#$Security::McAfee::Mac::Const::btn_open         = 'Open';
#$Security::McAfee::Mac::Const::btn_select       = 'Select';
#$Security::McAfee::Mac::Const::win_select       = 'Select';

#$Security::McAfee::Mac::Const::str_icmp  = 'ICMP';


#push @EXPORT, qw($btn_firewall $win_firewall $btn_update $win_update);
#$Security::McAfee::Mac::Const::btn_firewall    = 'Desktop Firewall';
#$Security::McAfee::Mac::Const::win_firewall    = 'Desktop Firewall';
#$Security::McAfee::Mac::Const::btn_update      = 'Update'; 
#$Security::McAfee::Mac::Const::win_update      = 'Update'; 



#push @EXPORT, qw($btn_repository $btn_proxy $btn_schedule $btn_stop_now $btn_start_now );
#$Security::McAfee::Mac::Const::btn_repository = 'Repository List';
#$Security::McAfee::Mac::Const::btn_proxy      = 'Proxy Settings';
#$Security::McAfee::Mac::Const::btn_schedule   = 'Schedule';
#$Security::McAfee::Mac::Const::btn_stop_now   = 'Stop Now';
#$Security::McAfee::Mac::Const::btn_start_now   = 'Start Now';
#
# TODO: Change foconsumer

# Index based menu items
push @EXPORT, qw/$app_menu_main $mi_app_menu_pref $mi_app_menu_about/;
#$Security::McAfee::Mac::Const::app_menu_main = 'McAfee Security';
$Security::McAfee::Mac::Const::mi_app_menu_pref = 3;  
$Security::McAfee::Mac::Const::mi_app_menu_about = 1;

#################### PATHS
#push @EXPORT, qw/ $p_btn_plus_appprot_pref /;
########################################## CONSOLE - UPDATE WINDOW UI ELEMENTS ##################################################
push @EXPORT, qw/$p_start_updbtn $p_stop_updbtn $p_start_scanbtn $p_stop_nowbtn/ ;
$Security::McAfee::Mac::Const::p_start_updbtn  = "button \"Start Update\" of group 1 of group 1 of splitter group 1 of window 1";
$Security::McAfee::Mac::Const::p_stop_updbtn   = "button \"Stop Update\" of group 1 of group 1 of splitter group 1 of window 1";
$Security::McAfee::Mac::Const::p_start_scanbtn = "button \"Start Scan\" of group 3 of group 1 of splitter group 1 of window 1";  
$Security::McAfee::Mac::Const::p_stop_nowbtn   = "button \"Stop Now\" of group 3 of group 1 of splitter group 1 of window 1";

push @EXPORT, qw( $p_left_menu_old $p_left_menu $p_left_menu2 $p_btn_go_finder $p_btn_open_finder $p_btn_lock_pref);
$Security::McAfee::Mac::Const::p_left_menu_old   = "outline 1 of scroll area 1 of splitter group 1 of window 1";
$Security::McAfee::Mac::Const::p_left_menu       = "outline 1 of scroll area 1 of window 1";#
$Security::McAfee::Mac::Const::p_left_menu2      = "group 2 of group 1 of splitter group 1 of window 1 ";
$Security::McAfee::Mac::Const::p_btn_go_finder   = "button \"Go\" of sheet 1 of sheet 1 of window 1";
$Security::McAfee::Mac::Const::p_btn_open_finder = "button \"Open\" of sheet 1 of window 1";

$Security::McAfee::Mac::Const::p_btn_lock_pref                  = "button 4 of window 1";

############################### GUI PATHS OF UI ELEMENTS ON THE MAIN PREFERENCE WINDOW ########################################
push @EXPORT, qw( $p_btn_plus_appprot_pref $p_btn_cancel_add_rule_appprot
                $p_btn_appname_add_rule_appprot $p_btn_go_finder_add_rule_appprot );
$Security::McAfee::Mac::Const::p_btn_plus_appprot_pref            = "button \"+\" of tab group 1 of window 1";
$Security::McAfee::Mac::Const::p_btn_cancel_add_rule_appprot    = "button \"Cancel\" of sheet 1 of window 1";
$Security::McAfee::Mac::Const::p_btn_appname_add_rule_appprot   = "button 1 of group 1 of sheet 1 of window 1";
$Security::McAfee::Mac::Const::p_btn_go_finder_add_rule_appprot = "button \"Go\" of sheet 1 of window 1";

push @EXPORT, qw( $p_btn_ok_finder_add_rule_appprot $p_btn_ok_add_rule_appprot $p_btn_ok2_add_rule_appprot
                $p_pbtn_rest_add_rule_appprot);
                
$Security::McAfee::Mac::Const::p_btn_ok_finder_add_rule_appprot = "button \"OK\" of window 1";
$Security::McAfee::Mac::Const::p_btn_ok_add_rule_appprot        = "button \"OK\" of window 1";
$Security::McAfee::Mac::Const::p_btn_ok2_add_rule_appprot       = "button \"OK\" of sheet 1 of window 1";
$Security::McAfee::Mac::Const::p_pbtn_rest_add_rule_appprot     = "pop up button 1 of group 1 of sheet 1 of window 1";

push @EXPORT, qw( $p_tab_general_pref $p_tab_am_pref $p_tab_appprot_pref $p_tab_fw_pref);
$Security::McAfee::Mac::Const::p_tab_general_pref               = "button 1 of tool bar 1 of window 1";
$Security::McAfee::Mac::Const::p_tab_am_pref                    = "button 2 of tool bar 1 of window 1";
$Security::McAfee::Mac::Const::p_tab_appprot_pref               = "button 3 of tool bar 1 of window 1";
$Security::McAfee::Mac::Const::p_tab_fw_pref                    = "button 4 of tool bar 1 of window 1";

###################################################### UI ELEMENTS OF APPLICATION PROTECTION PREFERENCES #######################
push @EXPORT, qw($p_excltab_appprot_pref $p_ruletab_appprot_pref $p_minusbtn_appprot_pref);
$Security::McAfee::Mac::Const::p_excltab_appprot_pref  = "radio button \"Exclusions\" of tab group 1 of window 1";                                
$Security::McAfee::Mac::Const::p_ruletab_appprot_pref  = "radio button \"Rules\" of tab group 1 of window 1";   
$Security::McAfee::Mac::Const::p_minusbtn_appprot_pref = "button 2 of tab group 1 of window 1"; 

################################################## UI ELEMENTS OF ANTIMALWARE PREFERENCES ######################################
push @EXPORT, qw($p_oastab_am_pref $p_odstab_am_pref $p_excltab_am_pref);
$Security::McAfee::Mac::Const::p_oastab_am_pref  = "radio button \"On-access Scan\" of tab group 1 of window 1";  
$Security::McAfee::Mac::Const::p_odstab_am_pref  = "radio button \"On-demand Scan\" of tab group 1 of window 1"; 
$Security::McAfee::Mac::Const::p_excltab_am_pref = "radio button \"Exclusions\" of tab group 1 of window 1"; 

################################################# UI ELEMENTS OF FIREWALL PREFERENCES ##########################################
push @EXPORT ,qw($p_ruletab_fw_pref $p_excltab_fw_pref $p_trustedtab_fw_pref $p_custom_btn_fw_pref);
$Security::McAfee::Mac::Const::p_ruletab_fw_pref    = "radio button \"Rules\" of tab group 1 of window 1"; 
$Security::McAfee::Mac::Const::p_excltab_fw_pref    = "radio button \"Exclusions\" of tab group 1 of window 1"; 
$Security::McAfee::Mac::Const::p_trustedtab_fw_pref = "radio button \"Trusted Networks\" of tab group 1 of window 1"; 
$Security::McAfee::Mac::Const::p_custom_btn_fw_pref = "radio button 3 of radio group 1 of tab group 1 of window 1"; 



###############################################################################################################################

###################### GUI PATHS OF ADD FIREWALL RULE PREFERENCE WINDOW ###############################################
push @EXPORT, qw( $p_btn_plus_firewall_pref $p_btn_ok_add_firewall_rule $p_pbtn_action_add_firewall_rule
                $p_pbtn_prot_add_firewall_rule $p_pbtn_dir_add_firewall_rule $p_pbtn_if_add_firewall_rule
                $p_pbtn_src_add_firewall_rule $p_pbtn_dst_add_firewall_rule $p_txt_dst_port_add_firewall_rule
                $p_txt_src_port_add_firewall_rule );
$Security::McAfee::Mac::Const::p_btn_plus_firewall_pref         = 'button "+" of tab group 1 of window 1';
$Security::McAfee::Mac::Const::p_btn_ok_add_firewall_rule       = 'button "OK" of sheet 1 of window 1';
$Security::McAfee::Mac::Const::p_pbtn_action_add_firewall_rule  = "pop up button 1 of group 2 of sheet 1 of window 1";
$Security::McAfee::Mac::Const::p_pbtn_prot_add_firewall_rule    = "pop up button 2 of group 2 of sheet 1 of window 1";
$Security::McAfee::Mac::Const::p_pbtn_dir_add_firewall_rule     = "pop up button 3 of group 2 of sheet 1 of window 1";
$Security::McAfee::Mac::Const::p_pbtn_if_add_firewall_rule      = "pop up button 4 of group 2 of sheet 1 of window 1";
$Security::McAfee::Mac::Const::p_pbtn_src_add_firewall_rule     = "pop up button 1 of group 3 of sheet 1 of window 1";
$Security::McAfee::Mac::Const::p_pbtn_dst_add_firewall_rule     = "pop up button 2 of group 3 of sheet 1 of window 1";
$Security::McAfee::Mac::Const::p_txt_dst_port_add_firewall_rule = "text field 1 of group 3 of sheet 1 of window 1";
$Security::McAfee::Mac::Const::p_txt_src_port_add_firewall_rule = "text field 2 of group 3 of sheet 1 of window 1";

########################################################################################################################


# Only for ENTERPRISE -- from Enterprise/GUI.pm
push @EXPORT, qw( $p_btn_plus_scheduled_task $p_pbtn_choose_add_ods_task $p_btn_minus_add_ods_task
                $p_row_ods_task_table $p_btn_create_add_ods_task );
$Security::McAfee::Mac::Const::p_btn_plus_scheduled_task = "button \"+\" of group 1 of window 1";
$Security::McAfee::Mac::Const::p_pbtn_choose_add_ods_task = "pop up button 1 of scroll area 1 of group 2 of group 1 of splitter group 1 of window 1";
$Security::McAfee::Mac::Const::p_btn_minus_add_ods_task = "button 2 of group 1 of window 1";
$Security::McAfee::Mac::Const::p_row_ods_task_table     =  'row 8 of outline 1 of scroll area 1 of splitter group 1 of window 1 ';
$Security::McAfee::Mac::Const::p_btn_create_add_ods_task =  'button "Create" of sheet 1 of window 1';


# Only for CONSUMER - For Consumer/GUI.pm
push @EXPORT, qw( $p_pbtn_choose_custom_scan $p_pbtn_choose_custom_scan_old $p_btn_start_custom_scan_old $p_btn_start_custom_scan);
$Security::McAfee::Mac::Const::p_pbtn_choose_custom_scan = 'pop up button 1 of scroll area 1 of group 1 of group 1 of splitter group 1 of window 1';
$Security::McAfee::Mac::Const::p_pbtn_choose_custom_scan_old  = 'pop up button 1 of scroll area 1 of group 1 of group 2 of window 1'  ;
$Security::McAfee::Mac::Const::p_btn_start_custom_scan_old = "button \"Start Scan\" of group 2 of group 2 of window 1 ";
$Security::McAfee::Mac::Const::p_btn_start_custom_scan  = "button \"Start Scan\" of group 2 of group 1 of splitter group 1 of window 1";





