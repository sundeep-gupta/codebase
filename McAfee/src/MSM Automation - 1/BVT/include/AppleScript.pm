##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################
package AppleScript;

use strict;
use Mac::AppleScript;

sub new {
    my ($package) = @_;
    my $self = { 'script' => "", };
    bless $self, $package;
    return $self;
}

#######################################################################
# Description : quit the application.
# Parameters  : $app_name = application to be quit.
# Return      : NONE
#######################################################################
sub close_application {
    my $app_name = $_[0];
    my $applescript = "tell application \"$app_name\" to quit\n";
    &Mac::AppleScript::RunAppleScript($applescript);
}
sub quit_application {
    my $app_name = $_[0];
    return unless $app_name;
    my $applescript = "tell application \"$app_name\" to quit\n";
    &Mac::AppleScript::RunAppleScript($applescript);
}


sub run {
	my ($self) = @_;
        return unless $self->{'script'};
        
	&Mac::AppleScript::RunAppleScript($self->{'script'}) ;
        if ($@) {
            print "Error in AppleScript: $@"; 
        }
}

sub append {
	my ($self, $line) = @_;
	return unless $line;
	$self->{'script'} .= $line."\n";
	return;
}
sub click {
    my ($self, $path, $app_name) = @_;
    return unless $path;
    $self->append("Click $path of application process \"$app_name\"");
}
sub set_value {
    my ($self, $path, $value, $app_name) = @_;
    $self->append("Set value of $path of application process \"$app_name\" to \"$value\" ");

}
sub select {
    my ($self, $path, $app_name) = @_;
    return unless $path;
    $self->append("select $path of application process \"$app_name\"");
}


sub start_system_event {
    my ($self, $action) = @_;
    my $msg = "tell application \"System Events\"";
    $msg .= " to $action" if $action;
    $self->append($msg);
}


sub keystroke {
    my ($self, $keys, $ra_options) = @_;
    return unless $keys;
    my $ks = "keystroke \"$keys\" ";
    if( $ra_options and scalar @$ra_options > 0 ) {
        $ks = $ks. " using { ". join (',' ,@$ra_options)." } ";
    }
    $self->append($ks);

}

sub wait_till_enabled {
   my ($self, $path, $app_name) = @_;
   return unless $path and $app_name;
   $self->append("repeat while $path of application process \"$app_name\" is not enabled");
   $self->append("end repeat");
}


sub delay {
    my ($self, $sec) = @_;
    return unless $sec;
    $self->append("delay $sec");
}

sub get_script { return $_[0]->{'script'}; }
sub end_system_event { $_[0]->append('end tell'); }
sub try     { $_[0]->append("try"); }
sub end_try { $_[0]->append("end try"); }

#######################################################################
#                    STATIC METHODS
#######################################################################

#######################################################################
# Description : launch given application
# Parameters  : $app_name - application name
# Return      : NONE
#######################################################################
sub launch_application {
    my $app_name = $_[0];
    my $applescript = "tell application \"$app_name\" to launch\n";
    &Mac::AppleScript::RunAppleScript($applescript);

}

sub activate_application {
    my $app_name = $_[0];
    my $applescript = "tell application \"$app_name\" to activate\n";
    &Mac::AppleScript::RunAppleScript($applescript);
}


#######################################################################
# Description : launch and close the given application.
# Parameters  : $app_name - application name.
# Return      : NONE
#######################################################################
sub launch_close_application {
    my ($app_name, $delay)  =  @_;
    return unless $app_name;
    &launch_application($app_name);
    &activate_application($app_name);
    sleep $delay if $delay;
    &quit_application($app_name);
    &wait_till_quit($app_name);
}


sub screenshot {
    my ($self, $filename) = @_;
    my $apple_script = "tell application \"System Events\" to do shell script \"screencapture $filename\"\n";
    Mac::AppleScript::RunAppleScript($apple_script);
}



sub wait_till_quit {
    my ($application) = @_;
    return unless $application;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("repeat 5 times ");
    $apple_script->append("set var_process to name of every process as list");
    $apple_script->append("if var_process contains \"$application\" then exit repeat");
    $apple_script->append("delay 1");
    $apple_script->append("end repeat");
    $apple_script->append("set var_process to name of every process as list");
    $apple_script->append("if var_process contains \"$application\" then do shell script \"killall '$application'\"");
    $apple_script->end_system_event();
    $apple_script->run();
}


#######################################################################
#                     PRIVATE METHODS
#######################################################################

1;
