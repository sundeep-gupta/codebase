# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::AppProt;
use strict;
our @ISA = ('Testcase');
use Testcase;
use Const;
use Time::HiRes qw(gettimeofday);

sub new {
    my ($package, $rh_param) = @_;
    my $self = Testcase->new($rh_param);
    bless $self, $package;
    return $self;

}

sub execute {
    my ($self) = @_;
    $self->{'start_time'} = [gettimeofday];
    &open_url_in_safari("http://www.google.co.in");
    &open_itunes(100);
    &open_url_in_firefox("http://www.gmail.com/");
    &open_ichat();
    $self->{'end_time'} = [gettimeofday];
    $self->{'result'}   = {'AppProt' => $PASS };

}

sub open_url_in_safari {
	my ($url, $delay) = @_;
	$delay ||= 10;
	&AppleScript::launch_application("Safari");
	my $apple_script = AppleScript->new();
	$apple_script->append("tell application \"System Events\"");
	$apple_script->append("open location \"$url\"");
	$apple_script->append("delay $delay");
	$apple_script->append("end tell");
	$apple_script->run();
	&AppleScript::close_application("Safari");
}

sub open_url_in_firefox {
	my ($url, $delay) = @_;
	$delay ||=  10;
	&AppleScript::launch_application("Firefox");
	my $apple_script = AppleScript->new();
	$apple_script->append("tell application \"Firefox\"");
	$apple_script->append("activate");
	$apple_script->append("delay $delay");
	$apple_script->append("open location \"$url\"");
	$apple_script->append("delay $delay");
	$apple_script->append("end tell");
	$apple_script->run();
	&AppleScript::close_application("Firefox");
}

sub open_itunes {

	my ($delay) = @_;
	$delay ||= 10;
	&AppleScript::launch_application("iTunes");
	my $apple_script = AppleScript->new();
	$apple_script->append("tell application \"System Events\"");
	$apple_script->append("if (not (exists window \"iTunes\" of process \"iTunes\")) then");
	$apple_script->append("click menu item \"Quit iTunes\" of menu 1 of menu bar item \"iTunes\" of menu bar 1 ".
						  "of application process \"iTunes\"");
	$apple_script->append("end if");
	$apple_script->append("delay $delay");
	$apple_script->run();
	&AppleScript::close_application("iTunes");

}
sub open_ichat {
	&AppleScript::launch_application("iChat");
	my $apple_script = AppleScript->new();
	$apple_script->append("tell application \"System Events\"");
	$apple_script->append("click menu item \"Bonjour List\" of menu 1 of menu bar item \"Window\" of menu bar 1 ".
						  "of application process \"iChat\"");
	$apple_script->append("end tell");

	$apple_script->run();
	&AppleScript::close_application("iChat");
}



1;
