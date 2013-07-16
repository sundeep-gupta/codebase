# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Security::McAfee::Mac;

use Security::McAfee::Mac::Const;
use Security::McAfee::Mac::Consumer::Const;
# This module is an extension of Security::McAfee::Mac and is not a separate package.
# Its just helps me to have loads of functions under single package name but in different file.

################################# LAUNCH and CLOSE functions ########################
# Quit the Mac Application
sub quit {
    my ($self) = @_;
    AppleScript::quit_application($app_name);    
    AppleScript::wait_till_quit( $app_name );
}

sub activate { &AppleScript::activate_application($app_name); } 
sub launch   { &AppleScript::launch_application($app_name);  }


# Quit the preferences window.
sub quit_preferences {
    my ($self) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event("keystroke \"w\" using command down");
    $apple_script->run();
}


sub open_about_box   { &_launch_menu_item($mi_app_menu_about, $app_menu_main); } 
sub open_preferences { &_launch_menu_item($mi_app_menu_pref,  $app_menu_main); }

sub show_all {
  # &_launch_menu_item('Show All', 'McAfee Security');
}

sub hide_others { 
  # &_launch_menu_item('Show All', 'McAfee Security');
 }



sub _launch_menu_item {
    my ($menu_item, $menubar) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event("click menu item $menu_item of menu 1 of ".
                                      "menu bar item \"$menubar\" of menu bar 1 of ".
                                      "application process \"$app_name\"");
    $apple_script->run();
   
}

################# PREFERENCES TAB SELECTION FUNCTIONS #############################


sub select_general                { $_[0]->_select_preference_tab($p_tab_general_pref); } 
sub select_application_protection { $_[0]->_select_preference_tab($p_tab_appprot_pref); } 
sub select_antimalware            { $_[0]->_select_preference_tab($p_tab_am_pref); } 
sub select_firewall               { $_[0]->_select_preference_tab($p_tab_fw_pref); }

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


sub _select_preference_tab {
    my ($self, $path) = @_;
    
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->click($path, $app_name);
    $apple_script->end_system_event();
    
    $apple_script->run();
}


######################## Clicking sub-tabs under preferences ##########################
####################### SUB TABS in Preferences Window ... ###########

sub select_pref_ods {
    my ($self) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("set thevalue to value of pop up button 1 of tab group 1 of ".
                          "window \"$win_antimalware\" of application process \"$app_name\"");
    $apple_script->append("repeat while thevalue is not theName");
    $apple_script->append("set thevalue to value of pop up button1 of tab group 1 of ".
                          "window \"$win_antimalware\" of application process \"$app_name\"");
    $apple_script->append("end repeat");
    $apple_script->end_system_event();
    $apple_script->run();
}

sub select_pref_appprot_excl { $_[0]->_select_subtab_in_pref($p_excltab_appprot_pref); }
sub select_pref_appprot_rules {  $_[0]->_select_subtab_in_pref($p_ruletab_appprot_pref); } 
sub select_pref_antimalware_oas { $_[0]->_select_subtab_in_pref($p_oastab_am_pref); }
sub select_pref_antimalware_ods { $_[0]->_select_subtab_in_pref($p_odstab_am_pref); }
sub select_pref_antimalware_excl { $_[0]->_select_subtab_in_pref($p_excltab_am_pref); }
sub select_pref_firewall_rules { $_[0]->_select_subtab_in_pref($p_ruletab_fw_pref); }
sub select_pref_firewall_trusted { $_[0]->_select_subtab_in_pref($p_trustedtab_fw_pref); }


sub _select_subtab_in_pref {
    my ($self, $path ) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->click($path, $app_name);
    $apple_script->end_system_event();
    $apple_script->run();
}


############################# ACTIONS INSIDE THE PREFERENCES TABS ##########################
sub clean_appprot_rules {
    my ($self) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->try();
    $apple_script->append("tell text field 1 of row 1 of table 1 of scroll area 1 of tab group 1 of ".
                          "window \"Application Protection\" of application process $app_name");
    $apple_script->append("set {xPosition, yPosition} to position");
    $apple_script->append("set {xSize, ySize} to size");
    $apple_script->append("end tell");
#   -- modify offsets if hot spot is not centered:
    $apple_script->append("click at {xPosition + (xSize div 2), yPosition + (ySize div 2)}");
    $apple_script->end_try();
    $apple_script->append("repeat while button 2 of tab group 1 of window 1 of ".
                      "application process $app_name is enabled");
    $apple_script->click( $p_minusbtn_appprot_pref, $app_name);                  
    $apple_script->append("end repeat");
    $apple_script->end_system_event();
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
    $apple_script->click($p_btn_plus_appprot_pref, $app_name);
    $apple_script->wait_till_enabled($p_btn_cancel_add_rule_appprot, $app_name);
    $apple_script->click($p_btn_appname_add_rule_appprot, $app_name);
    $apple_script->keystroke('g',['command down', 'shift down' ] );
    $apple_script->keystroke($application);
    $apple_script->click($p_btn_go_finder_add_rule_appprot, $app_name);
    $apple_script->wait_till_enabled( $p_btn_ok_finder_add_rule_appprot, $app_name);
    $apple_script->click($p_btn_ok_add_rule_appprot , $app_name);
    $apple_script->wait_till_enabled( $p_btn_ok2_add_rule_appprot, $app_name);
    $apple_script->delay(1);
# TODO: Currently selection of kind of n/w access is not working ...     
#    $apple_script->click($p_pbtn_rest_add_rule_appprot, $app_name);
#    $apple_script->delay(1);
#    $apple_script->click( "menu item \"$action\" of $p_pbtn_rest_add_rule_appprot" , $app_name);
#    $apple_script->delay(1);
    $apple_script->click($p_btn_ok2_add_rule_appprot, $app_name);
    $apple_script->end_system_event();
    $apple_script->run();
}


############### ADD FIREWALL RULE #######################
sub add_firewall_rule {
    my ($self, $rh_rule) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
        $apple_script->click( $p_btn_plus_firewall_pref, $app_name);
        $apple_script->wait_till_enabled( $p_btn_ok_add_firewall_rule, $app_name);
        $apple_script->keystroke( $rh_rule->{'Rule'} );
        
        $apple_script->click( $p_pbtn_action_add_firewall_rule , $app_name);
    $apple_script->click( "menu item \"". $rh_rule->{'Action'} . "\" of menu 1 of $p_pbtn_action_add_firewall_rule" ,
                          $app_name);
    $apple_script->delay(1);
    
    $apple_script->click( $p_pbtn_prot_add_firewall_rule, $app_name );
    $apple_script->click( "menu item \"". $rh_rule->{'Protocol'} . "\" of menu 1 of $p_pbtn_prot_add_firewall_rule", 
                          $app_name);
    $apple_script->delay(1);

    $apple_script->click( $p_pbtn_dir_add_firewall_rule, $app_name);
    $apple_script->click( "menu item \"". $rh_rule->{'Direction'} ."\" of menu 1 of $p_pbtn_dir_add_firewall_rule", $app_name);
    $apple_script->delay(1);

    $apple_script->click( $p_pbtn_if_add_firewall_rule, $app_name);
    $apple_script->click( "menu item \"". $rh_rule->{'Interface'} ."\" of menu 1 of $p_pbtn_if_add_firewall_rule", $app_name );
    $apple_script->delay(1);

    $apple_script->click( $p_pbtn_src_add_firewall_rule, $app_name);
    $apple_script->click( "menu item \"". $rh_rule->{'Source'}. "\" of menu 1 of $p_pbtn_src_add_firewall_rule", $app_name);
    $apple_script->delay(1);
    $apple_script->keystroke( $rh_rule->{'Source_IP'} ) if $rh_rule->{'Source'} eq 'Others';
    
    $apple_script->click( $p_pbtn_dst_add_firewall_rule, $app_name);
    $apple_script->click( "menu item \"". $rh_rule->{'Destination'}. "\" of menu 1 of $p_pbtn_dst_add_firewall_rule", $app_name);
    $apple_script->delay(1);
    $apple_script->keystroke ( $rh_rule->{'Destination_IP'}) if( $rh_rule->{'Destination'} eq 'Others' );


    if($rh_rule->{'Protocol'} ne 'ICMP') {
        $apple_script->select( $p_txt_dst_port_add_firewall_rule, $app_name);
        $apple_script->delay(1);
        $apple_script->set_value( $p_txt_dst_port_add_firewall_rule, $rh_rule->{'Destination_port'}, $app_name);
        $apple_script->delay(1);
        $apple_script->set_value( $p_txt_src_port_add_firewall_rule, $rh_rule->{'Source_port'}, $app_name);
        $apple_script->delay(1);
    }
    $apple_script->click( $p_btn_ok_add_firewall_rule, $app_name);
    $apple_script->end_system_event();
    $apple_script->run();

}

######################## Preferences Window functions ####################
sub pref_firewall_select_custom {
    my ($self) = @_;
    &AppleScript::activate_application($app_name);

    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->click($p_custom_btn_fw_pref, $app_name);
    $apple_script->end_system_event();
    $apple_script->run();
}


#############################   ACTION ON CONSOLE UI ##################################

sub start_update { $_[0]->_click_update($btn_start_update); }
sub stop_update { $_[0]->_click_update($btn_start_scan); } 

sub _click_update {
    my ($self, $path) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->click($path, $app_name);
    $apple_script->end_system_event();
    $apple_script->run();
}



sub _click_scan {

    my ($self, $path) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->click($path, $app_name);
    $apple_script->end_system_event();
    $apple_script->run();
}


sub start_scan { $_[0]->_click_scan( $p_start_scanbtn ) ; }
sub stop_scan { $_[0]->_click_update( $p_stop_nowbtn); }

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
    my ($self, $row ) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->select("row $row of ".$p_left_menu, $app_name);
    $apple_script->end_system_event();
    $apple_script->run();
}

sub _wait_till_active {
    my ($self, $btn_active) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->wait_till_enabled( "button \"$btn_active\" of $p_left_menu2", $app_name);
    $apple_script->end_system_event();
    $apple_script->run();

}


sub pref_enable_admin {
    my ($self) = @_;
    my $apple_script = AppleScript->new();
    return unless ($ENV{'USER'} eq 'root');

    $apple_script->start_system_event();
    $apple_script->click($p_btn_lock_pref, $app_name);
    $apple_script->end_system_event();
    $apple_script->run();

}


sub _select_path_in_finder {
    my ($self, $path) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->keystroke('g', [ 'command down', 'shift down' ] );
    $apple_script->keystroke($path);
    $apple_script->click($p_btn_go_finder, $app_name);
    $apple_script->click($p_btn_open_finder, $app_name);
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


1;
