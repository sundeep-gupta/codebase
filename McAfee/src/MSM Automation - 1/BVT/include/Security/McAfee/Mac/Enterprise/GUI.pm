# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Security::McAfee::Mac::Enterprise;

use AppleScript;

sub _gui_add_ods_task {
    my $apple_script = AppleScript->new();
    $apple_script->append("activate application \"$app_name\"");
    $apple_script->start_system_event();
    $apple_script->click($p_btn_plus_scheduled_task, $app_name);
    $apple_script->wait_till_enabled( $p_btn_cancel_add_ods_task, $app_name);
    $apple_script->keystroke($task_name);
    $apple_script->wait_till_enabled( $p_btn_create_add_ods_task, $app_name);
    $apple_script->click($p_btn_create_add_ods_task, $app_name);
    $apple_script->end_system_event();
    $apple_script->run();
}

sub _gui_remove_ods_task {
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("repeat while $p_btn_minus_add_ods_task of application process \"$app_name\" is not enabled");
    $apple_script->select($p_row_ods_task_table, $app_name);
    $apple_script->click($p_btn_minus_add_ods_task, $app_name);
    $apple_script->append("end repeat");
    $apple_script->end_system_event();
    $apple_script->run();
}

sub _gui_perform_ods_scan {
    my ($self, $path) = @_;
    $self->launch();
    $self->activate();
    $self->add_ods_task('ODS');
    $self->add_file_to_scan($path);
    $self->start_scan();
    $self->wait_for_scan_complete();
    $self->remove_ods_task('ODS');
    $self->quit();
}

sub _gui_add_file_to_scan {
    my ($self, $file_path) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->click($p_pbtn_choose_add_ods_task);
    $apple_script->keystroke("\"Choose\" & return");
    $apple_script->delay(1);
    $apple_script->end_system_event();
    $apple_script->run();
    $self->_select_path_in_finder($file_path);

}


sub wait_for_scan_complete {
    my ($self) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("repeat while exists button \"$btn_stop_scan\" of group 3 of group 1 of splitter group 1 of window 1 of application process \"$app_name\"");
    $apple_script->delay(1);
    $apple_script->append("end repeat");
    $apple_script->end_system_event();
    $apple_script->run();
}

1;
