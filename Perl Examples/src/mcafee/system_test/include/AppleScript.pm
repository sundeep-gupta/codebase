##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2009, McAfee Limited. All rights reserved.
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
	my $self = { 'script' => "",
			   };
	bless $self, $package;
	return $self;
}

sub quit_application {
	my ($self, $app_name) = @_;
	$app_name = "\"$app_name\"" unless $app_name =~ /^"/;
	$self->{'script'} = "quit application $app_name\n";
	$self->run();
}


sub run {
	my ($self) = @_;
        return unless $self->{'script'};
	&Mac::AppleScript::RunAppleScript($self->{'script'});
}

sub append {
	my ($self, $line) = @_;
	return unless $line;
	$self->{'script'} .= $line."\n";
	return;
}

sub get_script {
	my ($self) = @_;
	return $self->{'script'};
}

sub start_system_event {
    my ($self, $action) = @_;
    my $msg = "tell application \"System Events\"";
    $msg .= " to $action" if $action;
    $self->append($msg);
}

sub end_system_event {
    my ($self) = @_;
    $self->append("end tell");
}

sub keystroke {
    my ($self, $keys) = @_;
    return unless $keys;
    $self->append("keystroke $keys")

}
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
# Description : quit the application.
# Parameters  : $app_name = application to be quit.
# Return      : NONE
#######################################################################
sub close_application {
    my $app_name = $_[0];
    my $applescript = "tell application \"$app_name\" to quit\n";
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
    sleep $delay if $delay;
    &close_application ($app_name);
}




sub screenshot {
    my ($self, $filename) = @_;
    my $apple_script = "tell application \"System Events\" to do shell script \"screencapture $filename\"\n";
    Mac::AppleScript::RunAppleScript($apple_script);
}


#######################################################################
#                     PRIVATE METHODS
#######################################################################

1;
