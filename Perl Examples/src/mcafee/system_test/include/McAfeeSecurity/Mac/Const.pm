package McAfeeSecurity::Mac::Const;
use strict;
require Exporter;
our @ISA = qw(Exporter);

our @EXPORT = ();

push @EXPORT, qw($app_name $btn_Cancel $btn_create $btn_plus $btn_minus $btn_OK $btn_cancel);
$McAfeeSecurity::Mac::Const::app_name      ='McAfee Security';
$McAfeeSecurity::Mac::Const::btn_Cancel    = 'Cancel';
$McAfeeSecurity::Mac::Const::btn_create    = 'Create';
$McAfeeSecurity::Mac::Const::btn_plus      = '+';
$McAfeeSecurity::Mac::Const::btn_minus     = '-';
$McAfeeSecurity::Mac::Const::btn_OK        = 'OK';
$McAfeeSecurity::Mac::Const::btn_cancel    = 'cancel'; 

# TABS 
push @EXPORT, qw($win_general $btn_general $btn_app_prot $win_app_prot $btn_anti_malware $win_antimalware );
$McAfeeSecurity::Mac::Const::win_general   = 'General';
$McAfeeSecurity::Mac::Const::btn_general     = 'General';
$McAfeeSecurity::Mac::Const::btn_app_prot  = 'Application Protection';
$McAfeeSecurity::Mac::Const::win_app_prot  = 'Application Protection';
$McAfeeSecurity::Mac::Const::btn_anti_malware = 'Anti-malware';
$McAfeeSecurity::Mac::Const::win_antimalware  = 'Anti-malware';


# SUB TABS
push @EXPORT, qw($btn_rules $btn_exclusions $btn_excl $btn_oas $btn_ods $btn_trusted);

$McAfeeSecurity::Mac::Const::btn_rules        = 'Rules';
$McAfeeSecurity::Mac::Const::btn_exclusions   = 'Exclusions';
$McAfeeSecurity::Mac::Const::btn_excl         = 'Exclusions';
$McAfeeSecurity::Mac::Const::btn_oas          = 'On-access Scan';
$McAfeeSecurity::Mac::Const::btn_ods          = 'On-demand Scan';
$McAfeeSecurity::Mac::Const::btn_trusted     = 'Trusted Networks';

# OTHERS
push @EXPORT, qw($btn_scan_now $btn_start_update $btn_go $btn_choose $btn_select 
		 $win_select $btn_open $str_icmp $btn_start_scan $btn_stop_scan);
$McAfeeSecurity::Mac::Const::btn_scan_now    = 'Scan Now';
$McAfeeSecurity::Mac::Const::btn_start_scan    = 'Start Scan';
$McAfeeSecurity::Mac::Const::btn_stop_scan    = 'Stop Scan';
$McAfeeSecurity::Mac::Const::btn_start_update = 'Start Update';
$McAfeeSecurity::Mac::Const::btn_choose       = 'Choose...';
$McAfeeSecurity::Mac::Const::btn_go           = 'Go';
$McAfeeSecurity::Mac::Const::btn_open         = 'Open';
$McAfeeSecurity::Mac::Const::btn_select       = 'Select';
$McAfeeSecurity::Mac::Const::win_select       = 'Select';

$McAfeeSecurity::Mac::Const::str_icmp  = 'ICMP';


push @EXPORT, qw($btn_firewall $win_firewall $btn_update $win_update);
$McAfeeSecurity::Mac::Const::btn_firewall    = 'Desktop Firewall';
$McAfeeSecurity::Mac::Const::win_firewall    = 'Desktop Firewall';
$McAfeeSecurity::Mac::Const::btn_update      = 'Update'; 
$McAfeeSecurity::Mac::Const::win_update      = 'Update'; 



push @EXPORT, qw($btn_repository $btn_proxy $btn_schedule $btn_stop_now $btn_start_now );
$McAfeeSecurity::Mac::Const::btn_repository = 'Repository List';
$McAfeeSecurity::Mac::Const::btn_proxy      = 'Proxy Settings';
$McAfeeSecurity::Mac::Const::btn_schedule   = 'Schedule';
$McAfeeSecurity::Mac::Const::btn_stop_now   = 'Stop Now';
$McAfeeSecurity::Mac::Const::btn_start_now   = 'Start Now';


