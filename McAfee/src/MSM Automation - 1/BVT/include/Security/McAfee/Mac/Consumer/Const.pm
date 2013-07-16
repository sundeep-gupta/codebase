# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Security::McAfee::Mac::Consumer::Const;
use strict;
require Exporter;
our @ISA = qw(Exporter);

our @EXPORT = ();

push @EXPORT, qw($app_name $app_menu_main );
push @EXPORT, qw($btn_Cancel $btn_create $btn_plus $btn_minus $btn_OK $btn_cancel);
$Security::McAfee::Mac::Consumer::Const::app_name      ='McAfee Internet Security';
$Security::McAfee::Mac::Consumer::Const::app_menu_main = 'McAfee Internet Security';

$Security::McAfee::Mac::Consumer::Const::btn_Cancel    = 'Cancel';
$Security::McAfee::Mac::Consumer::Const::btn_create    = 'Create';
$Security::McAfee::Mac::Consumer::Const::btn_plus      = '+';
$Security::McAfee::Mac::Consumer::Const::btn_minus     = '-';
$Security::McAfee::Mac::Consumer::Const::btn_OK        = 'OK';
$Security::McAfee::Mac::Consumer::Const::btn_cancel    = 'cancel'; 

# Names of different buttons in preferences window.
push @EXPORT, qw($win_general $btn_general $btn_app_prot $win_app_prot $btn_anti_malware $win_antimalware );
$Security::McAfee::Mac::Consumer::Const::btn_general     = 'General';
$Security::McAfee::Mac::Consumer::Const::btn_app_prot  = 'Application Protection';
$Security::McAfee::Mac::Consumer::Const::btn_anti_malware = 'Anti-malware';

# Window titles of different preferences windows 
$Security::McAfee::Mac::Consumer::Const::win_app_prot  = 'Application Protection';
$Security::McAfee::Mac::Consumer::Const::win_general   = 'General';
$Security::McAfee::Mac::Consumer::Const::win_antimalware  = 'Anti-malware';

# SUB TABS
push @EXPORT, qw($btn_rules $btn_exclusions $btn_excl $btn_oas $btn_ods $btn_trusted);

$Security::McAfee::Mac::Consumer::Const::btn_rules        = 'Rules';
$Security::McAfee::Mac::Consumer::Const::btn_exclusions   = 'Exclusions';
$Security::McAfee::Mac::Consumer::Const::btn_excl         = 'Exclusions';
$Security::McAfee::Mac::Consumer::Const::btn_oas          = 'On-access Scan';
$Security::McAfee::Mac::Consumer::Const::btn_ods          = 'On-demand Scan';
$Security::McAfee::Mac::Consumer::Const::btn_trusted     = 'Trusted Networks';

# OTHERS
push @EXPORT, qw($btn_scan_now $btn_start_update $btn_go $btn_choose $btn_select 
                 $win_select $btn_open $str_icmp $btn_start_scan $btn_stop_scan);
                 $Security::McAfee::Mac::Consumer::Const::btn_scan_now    = 'Scan Now';
                 $Security::McAfee::Mac::Consumer::Const::btn_start_scan    = 'Start Scan';
                 $Security::McAfee::Mac::Consumer::Const::btn_stop_scan    = 'Stop Scan';
                 $Security::McAfee::Mac::Consumer::Const::btn_start_update = 'Start Update';
                 $Security::McAfee::Mac::Consumer::Const::btn_choose       = 'Choose...';
                 $Security::McAfee::Mac::Consumer::Const::btn_go           = 'Go';
                 $Security::McAfee::Mac::Consumer::Const::btn_open         = 'Open';
                 $Security::McAfee::Mac::Consumer::Const::btn_select       = 'Select';
                 $Security::McAfee::Mac::Consumer::Const::win_select       = 'Select';

                 $Security::McAfee::Mac::Consumer::Const::str_icmp  = 'ICMP';
                 
