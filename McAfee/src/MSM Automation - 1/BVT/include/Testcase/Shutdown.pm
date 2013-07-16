# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::Shutdown;
use strict;
use Const;
use AppleScript;
use Testcase;
use System;

our @ISA = ('Testcase');
sub new {
	my ($package, $rh_param) = @_;
	my $self = Testcase->new($rh_param);
	bless $self, $package;
	return $self;
}

sub clean {
    my ($self) = @_;

    my $date = &System::get_object_reference()->execute_cmd("date \"+%H:%M:%S\""); chomp $date;
    if($date =~ /(\d\d):(\d\d):(\d\d)/) {
	$date = $1 * 3600 + $2 * 60 + $3;
        &System::get_object_reference()->execute_cmd("echo $date > .prev_run_time");
        &System::get_object_reference()->shutdown(); 
    }

}
sub execute {
    my ($self)   = @_;
    return unless (-e ".prev_run_time" );
    my $result_log = $self->{'result_log'};
    open(my $fh, ".rev_run_time");
    my $prev_run_time = <$fh>; chomp $prev_run_time;
    close $fh;
    my $first_log_msg = &System::get_object_reference()->execute_cmd("grep $FIRST_LOG_MESSAGE $KERNEL_LOG | tail -1");
    chomp $first_log_msg;
    my $first_msg_time = $self->_get_log_time($first_log_msg);
    
    my $login_start_msg = &System::get_object_reference()->execute_cmd("grep $LOGIN_START $SYSTEM_LOG | tail -1");
    chomp $login_start_msg;
    my $login_start_time = $self->_get_log_time($login_start_msg);

    my $login_end_msg = &System::get_object_reference()->execute_cmd("grep $LOGIN_END $SYSTEM_LOG | tail -1");
    chomp $login_end_msg;
    my $login_end_time = $self->_get_log_time($login_end_msg);

    my $user_process_msg = &System::get_object_reference()->execute_cmd("grep $USER_PROCESS $SYSTEM_LOG | tail -1");
    chomp $user_process_msg;
    my $user_process_time = $self->_get_log_time($user_process_msg);
    
    $result_log->append ( {
			   'LoginTime' =>  $user_process_time - $login_end_time,

		     	   'StartTime' => $login_start_time  - $first_msg_time,

		 	   'ShutdownTime' => $prev_run_time  - $last_msg_time ,
			}) if $result_log;
 
} 

1;
