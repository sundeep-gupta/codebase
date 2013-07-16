# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Security::McAfee::Mac::Consumer;

sub select_custom_scan {
    my ($self) = @_;
    if( $self->{'old_build'}) {
	$self->_select_row(9);
    } else {
        $self->_select_row(8);
    }
}


sub add_file_to_scan {
    my ($self, $file_path) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->click( $p_pbtn_choose_custom_scan, $app_name);
    $apple_script->keystroke("\"Choose\" & return");
    $apple_script->delay(1);
    $apple_script->end_system_event();
    $apple_script->run();
    $self->_select_path_in_finder($file_path);
}

sub stop_scan { $_[0]->_click_scan($btn_stop_now); }

sub _click_scan {
    my ($self, $path) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->click($path, $app_name);
    $apple_script->end_system_event();
    $apple_script->run();

}
########################   PREFERENCES WINDOW ACTIONS - CONSUMER SPECIFIC ###############################

sub select_update   { $_[0]->_select_preference_tab($btn_update); }

################################ sub-tab actions on consumer specific preferences ########################

sub select_pref_update_repository { $_[0]->_select_subtab_in_pref($win_update, $btn_repository); }
sub select_pref_update_proxy { $_[0]->_select_subtab_in_pref($win_update, $btn_proxy); }
sub select_pref_update_schedule { $_[0]->_select_subtab_in_pref($win_update, $btn_schedule); }    


sub wait_for_scan_complete {
    my ($self) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    unless ( $self->{'old_build'}) {
        $apple_script->append("repeat while exists button \"$btn_stop_scan\" of group 2 of group 2 of window 1 of application process \"$app_name\"");
    } else {
        $apple_script->append("repeat while exists button \"Stop Scan\"  of group 2 of group 1 of splitter group 1 of window of application process \"$app_name\"");
    }
    $apple_script->delay(1);
    $apple_script->append("end repeat");
    $apple_script->end_system_event();
    $apple_script->run();
}


sub remove_ods_task {}
sub remove_all_ods_tasks {}




1;
