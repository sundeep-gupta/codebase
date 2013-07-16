package McAfeeSecurity::Mac;

use strict;
use AppleScript;
use McAfeeSecurity::Mac::Const;


sub new {
    my ($package) = @_;
    my $self = {};
    bless $self, $package;
}

sub launch {
     my ($self) = @_;
     &AppleScript::launch_application($app_name);
}

# Quit the Mac Application
sub quit {
	my ($self) = @_;
     &AppleScript::close_application($app_name);
	my $apple_script = AppleScript->new();
	$apple_script->quit_application($app_name);
}

sub activate {
     &AppleScript::activate_application($app_name);
}


# Quit the preferences window.
sub quit_preferences {
    my ($self) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event("keystroke \"w\" using command down");
    $apple_script->run();
}


sub open_about_box {
    my ($self) = @_;
    &_launch_menu_item(1, 'McAfee Security');
}

sub open_preferences {
    my ($self) = @_;
    &_launch_menu_item(3, "McAfee Security");
}

sub show_all {
  # &_launch_menu_item('Show All', 'McAfee Security');
}

sub hide_others { 
  # &_launch_menu_item('Show All', 'McAfee Security');
 }



sub _launch_menu_item {
    my ($menu_item, $menubar) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event("click menu item $menu_item of menu 1 of menu bar item \"$menubar\" of menu bar 1 of application process \"$app_name\"");
    $apple_script->run();
   
}




######################## Preferences Window functions ####################

sub general_window_on_top {
    my ($self) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("set front_window to (name of front window of process \"$app_name\") as string");
    $apple_script->append("repeat while front_window is not \"$win_general\"");
    $apple_script->append("set front_window to (name of front window of process \"$app_name\") as string");
    $apple_script->append("end repeat");
    $apple_script->end_system_event();
    $apple_script->run();
}
sub select_general {
    my ($self) = @_;
    $self->_select_preference_tab($btn_general);
}


sub select_application_protection {
    my ($self) = @_;
    $self->_select_preference_tab($btn_app_prot);

} 

sub select_antimalware {
  my ($self) = @_;
  $self->_select_preference_tab($btn_anti_malware);
}

sub select_firewall {
    my ($self) = @_;
    $self->_select_preference_tab($btn_firewall);
}

sub _select_preference_tab {
    my ($self, $tab_name) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("click button \"$tab_name\" of tool bar 1 ".
			  "of window 1 of application process \"$app_name\"");
    $apple_script->end_system_event();
    $apple_script->run();
}


######################## Clicking sub-tabs under preferences ##########################
####################### SUB TABS in Preferences Window ... ###########

sub select_pref_ods {
    my ($self) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("set thevalue to value of pop up button 1 of tab group 1 of window \"$win_antimalware\" of application process \"$app_name\"");
    $apple_script->append("repeat while thevalue is not theName");
    $apple_script->append("set thevalue to value of pop up button1 of tab group 1 of window \"$win_antimalware\" of application process \"$app_name\"");
    $apple_script->append("end repeat");
    $apple_script->end_system_event();
    $apple_script->run();
}

sub select_pref_appprot_excl {
    my ($self) = @_;
    $self->_select_subtab_in_pref($win_app_prot, $btn_exclusions);
}

sub select_pref_appprot_rules {
    my ($self) = @_;
    $self->_select_subtab_in_pref($win_app_prot, $btn_rules);
}

sub select_pref_antimalware_oas {
    my ($self) = @_;
    $self->_select_subtab_in_pref($win_antimalware, $btn_oas);
}


sub select_pref_antimalware_ods {
    my ($self) = @_;
    $self->_select_subtab_in_pref($win_antimalware, $btn_ods);
}

sub select_pref_antimalware_excl {
    my ($self) = @_;
    $self->_select_subtab_in_pref($win_antimalware, $btn_excl);
}

sub select_pref_firewall_rules {
    my ($self) = @_;
    $self->_select_subtab_in_pref($win_firewall, $btn_rules);
}

sub select_pref_firewall_trusted {
    my ($self) = @_;
    $self->_select_subtab_in_pref($win_firewall, $btn_trusted);

}

sub _select_subtab_in_pref {
    my ($self, $tab, $subtab) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("click radio button \"$subtab\" of tab group 1 of window \"$tab\" of application process \"$app_name\"");
    $apple_script->end_system_event();
    $apple_script->run();
}

############################# ACTIONS INSIDE THE PREFERENCES TABS ##########################
sub clean_appprot_rules {
	my ($self) = @_;
	my $apple_script = AppleScript->new();
	$apple_script->append("tell application \"System Events\"");
#	$apple_script->append("click checkbox 1 of row 1 of table 1 of scroll area 1 of tab group 1 of window 1 of application process $app_name");
#	$apple_script->append("click pop up button 1 of row 1 of table 1 of scroll area 1 of tab group 1 of window 1 of application process $app_name"); 
#	$apple_script->append("delay 2");
#	$apple_script->append("keystroke return");
#<D-d>	$apple_script->append("select row 1 of table 1 of scroll area 1 of tab group 1 of window \"Application Protection\" of application process $app_name");
	$apple_script->append("try");
   $apple_script->append("tell text field 1 of row 1 of table 1 of scroll area 1 of tab group 1 of window \"Application Protection\" of application process $app_name");
      $apple_script->append("set {xPosition, yPosition} to position");
      $apple_script->append("set {xSize, ySize} to size");
   $apple_script->append("end tell");
#   -- modify offsets if hot spot is not centered:
   $apple_script->append("click at {xPosition + (xSize div 2), yPosition + (ySize div 2)}");
$apple_script->append("end try");

#	$apple_script->append("delay 2");
	$apple_script->append("repeat while button 2 of tab group 1 of window 1 of application process $app_name is enabled");
#	$apple_script->append("click checkbox 1 of row 1 of table 1 of scroll area 1 of tab group 1 of window 1 of application process $app_name");
	$apple_script->append("click button 2 of tab group 1 of window 1 of application process $app_name");
	$apple_script->append("end repeat");
	$apple_script->append("end tell");
	$apple_script->run();
}

################ ADD RULES TO APP PROT ###################
sub add_appprot_rule {

    my ($self, $rh_rule) = @_;
	my $application = $rh_rule->{'Application'};
	my $action      = $rh_rule->{'Action'};
	my $rh_restrict = $rh_rule->{'Restrictions'};

    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("click button \"$btn_plus\" of tab group 1 of window \"$win_app_prot\" of application process \"$app_name\"");
	$apple_script->append("repeat while button \"$btn_Cancel\" of sheet 1 of window \"$win_app_prot\" ".
						  "of application process \"$app_name\" is not enabled");
	$apple_script->append("end repeat");
	$apple_script->append("click button 1 of group 1 of sheet 1 of window \"$win_app_prot\" of application process \"$app_name\"");
	$apple_script->append("key down shift");
	$apple_script->append("key down command");
	$apple_script->append("keystroke \"g\"");
	$apple_script->append("key up shift");
	$apple_script->append("key up command");
	$apple_script->append("keystroke \"$application\"");
	$apple_script->append("click button \"$btn_go\" of sheet 1 of window \"$win_select\" of application process \"$app_name\"");
	$apple_script->append("repeat while button \"$btn_OK\" of window \"$win_select\" of application process \"$app_name\" is not enabled");
	$apple_script->append("end repeat");
	$apple_script->append("click button \"$btn_OK\" of window \"$win_select\" of application process \"$app_name\"");
	$apple_script->append("repeat while button \"$btn_OK\" of sheet 1 of window \"$win_app_prot\" of ".
						  "application process \"$app_name\" is not enabled");
	$apple_script->append("end repeat");
	$apple_script->append("delay 1");
	$apple_script->append("click pop up button 1 of group 1 of sheet 1 of window \"$win_app_prot\" of application process \"$app_name\"");
	$apple_script->append("delay 1");
    $apple_script->append("click menu item \"$action\" of menu 1 of pop up button 1 of group 1 of sheet 1 of ".
						  "window \"$win_app_prot\" of application process \"$app_name\"");
	$apple_script->append("delay 1");
	$apple_script->append("click button \"$btn_OK\" of sheet 1 of window \"$win_app_prot\" of application process \"$app_name\"");
    $apple_script->end_system_event();
   $apple_script->run();


}


############### ADD FIREWALL RULE #######################
sub add_firewall_rule {
    my ($self, $rh_rule) = @_;
	
    my $apple_script = "tell application \"System Events\"\n".
"click button \"$btn_plus\" of tab group 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"repeat while button \"$btn_OK\" of sheet 1 of window \"$win_firewall\" of application process \"$app_name\" is not enabled\n".
"end repeat\n".
"keystroke \"$rh_rule->{'Rule'}\"\n".

"click pop up button 1 of group 2 of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"click menu item \"$rh_rule->{'Action'}\" of menu 1 of pop up button 1 of group 2 of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"delay 1\n".
"click pop up button 2 of group 2 of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"click menu item \"$rh_rule->{'Protocol'}\" of menu 1 of pop up button 2 of group 2 of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"delay 1\n".
"click pop up button 3 of group 2 of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"click menu item \"$rh_rule->{'Direction'}\" of menu 1 of pop up button 3 of group 2 of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"delay 1\n".
"click pop up button 4 of group 2 of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"click menu item \"$rh_rule->{'Interface'}\" of menu 1 of pop up button 4 of group 2 of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"delay 1\n".	
"click pop up button 1 of group 3 of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"click menu item \"$rh_rule->{'Source'}\" of menu 1 of pop up button 1 of group 3 of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"delay 1\n".
"click pop up button 2 of group 3 of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"click menu item \"$rh_rule->{'Destination'}\" of menu 1 of pop up button 2 of group 3 of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"delay 1\n".
"keystroke \"$rh_rule->{'Destination_IP'}\"\n";

if($rh_rule->{'Protocol'} ne 'ICMP') {
$apple_script .= 
	"select text field 4 of group 3 of sheet 1 of window 1 of application process \"$app_name\"\n".
	"delay 1\n".
	"set value of text field 4 of group 3 of sheet 1 of window 1 of application process \"$app_name\" to \"$rh_rule->{'Destination_port'}\"\n".
	"delay 1\n".
    "set value of text field 2 of group 3 of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"  to \"$rh_rule->{'Source_port'}\"\n".
	"delay 1\n";

}

$apple_script .= 
"click button \"$btn_OK\" of sheet 1 of window \"$win_firewall\" of application process \"$app_name\"\n".
"end tell\n";
&Mac::AppleScript::RunAppleScript($apple_script);

}


sub pref_firewall_select_custom {
    my ($self) = @_;
    &AppleScript::activate_application($app_name);

    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("click radio button 3 of radio group 1 of tab group 1 of window 1 of application process \"$app_name\""); 
    $apple_script->end_system_event();
    $apple_script->run();
}





#############################   ACTION ON CONSOLE UI ##################################






############################ on Console UI @@@@@@@@@@@@@@@

sub start_update {
    my ($self) = @_;
    $self->_click_update($btn_stop_now);
}

sub stop_update {
    my ($self) = @_; 
   $self->_click_update($btn_start_scan);
}

sub _click_update {
    my ($self, $btn_name) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("click button \"$btn_name\" of group 1 of group 1 of splitter group 1 of window 1 of application process \"$app_name\"");
    $apple_script->end_system_event();
    $apple_script->run();
}

sub _click_scan {

    my ($self, $btn_name) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("click button \"$btn_name\" of group 3 of group 1 of splitter group 1 of window 1 of application process \"$app_name\"");
    $apple_script->end_system_event();

    $apple_script->run();

}




sub start_scan {
    my ($self) = @_;
    $self->_click_scan($btn_start_scan);;
}

sub stop_scan {

    my ($self) = @_;
    $self->_click_update($btn_stop_now);
}

######################## SELECT THE VARIOUS TEXTFILEDS on RIGHT ########################




# TODO: Not able to do this in GUI
sub select_dashboard {

    my ($self) = @_;
    $self->_select_row(2);
}
sub select_history {
    my ($self) = @_;
    $self->_select_row(3);
    $self->_wait_till_active(1);

}

sub select_quarantine {
    my ($self) = @_;
    $self->_select_row(4);
    $self->_wait_till_active(1);
}

sub select_update_now {
   my ($self) = @_;
    $self->_select_row(6);
    $self->_wait_till_active($btn_start_update);

}

sub select_scan_now {
    my ($self) = @_;
    $self->_select_row(7);
    $self->_wait_till_active($btn_scan_now);


}


# TODO: Not able to do this in GUI
sub select_ods_task {


}

sub _select_row {
    my ($self, $row) = @_;

    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("select row $row of outline 1 of scroll area 1 of splitter group 1 of ".
		   "window 1 of application process \"$app_name\"");
    $apple_script->end_system_event();
    $apple_script->run();
}

sub _wait_till_active {
    my ($self, $btn_active) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("repeat while button \"$btn_active\" of group 2 of group 1 of splitter group 1 of window 1 of application process \"$app_name\" is not enabled");
    $apple_script->append("end repeat");
    $apple_script->end_system_event();
    $apple_script->run();

}


sub wait_till_quit {
    my ($self, $application) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("set var_process to name of every process as list");
    $apple_script->append("repeat while var_process contains \"$application\"");
    $apple_script->append("set var_process to name of every process as list");
    $apple_script->append("end repeat");
    $apple_script->end_system_event();
    $apple_script->run();
}



sub pref_enable_admin {
    my ($self) = @_;
    my $apple_script = AppleScript->new();
    return unless ($ENV{'USER'} eq 'root');

    $apple_script->start_system_event();
    $apple_script->append("click button 4 of window 1 of application process \"$app_name\"");
    $apple_script->end_system_event();
    $apple_script->run();

}


sub _select_path_in_finder {
	my ($self, $path) = @_;
	my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("key down shift");
    $apple_script->append("key down command");
    $apple_script->keystroke("\"g\"");
    $apple_script->append("key up shift");
    $apple_script->append("key up command");
    $apple_script->keystroke("\"$path\"");
    $apple_script->append("click button \"$btn_go\" of sheet 1 of sheet 1 of window 1 of application process \"$app_name\"");
    $apple_script->append("click button \"$btn_open\" of sheet 1 of window 1 of application process \"$app_name\"");
    $apple_script->end_system_event();
    $apple_script->run();
}

sub change_screen {
	my ($self) = @_;
	my $ra_screens = $self->{'screens'};
	my $rand = $ra_screens->[ rand( scalar @$ra_screens) ];
	$self->activate();
	$self->_select_row($rand);
}


sub get_product_process {
    my ($self) = @_;
    return $self->{'process'};
}

sub get_product_paths {
	return $_[0]->{'product_paths'};
}

sub get_dat_paths {
	return $_[0]->{'dat_paths'};
} 
1;
