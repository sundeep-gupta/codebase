# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::ConsoleAppLaunch;
use strict;
use Testcase;
use AppleScript;
use Time::HiRes qw(gettimeofday);
use Const;

our @ISA = ('Testcase');
sub new {
    my ($package, $rh_param) = @_;
    my $self  = Testcase->new($rh_param);
    bless $self, $package;
    $self->{'result'} = {};
    return $self;
}
sub init {

    my ($self) = @_;
    my $ra_applications = $self->{'config'}->{'applications'};
    foreach my $app_name ( @$ra_applications) {
        &AppleScript::quit_application($app_name);
        &AppleScript::wait_till_quit($app_name);
    }
}

sub clean {
    my ($self) = @_;
    my $ra_applications = $self->{'config'}->{'applications'};
    my $product = $self->{'product'};
    foreach my $app_name ( @$ra_applications) {
        &AppleScript::quit_application($app_name);
        &AppleScript::wait_till_quit($app_name);
    }
}
sub execute {
    my ($self) = @_;
    my $log = $self->{'log'};
    my $ra_applications   = $self->{'config'}->{'applications'};
    my $delay = $self->{'config'}->{'delay'} || 5;
    $self->{'start_time'} = [gettimeofday()];
    foreach my $app_name (@$ra_applications) {
        $self->{'log'}->info("Launching $app_name");
        &AppleScript::launch_application($app_name);
        &AppleScript::activate_application($app_name);
        sleep $delay if $delay;
        $self->set_application_launched($app_name, $self->check_application_launched($app_name));
	&AppleScript::quit_application($app_name, $delay);
    }
    $self->{'end_time'} = [ gettimeofday() ];
    $self->{'result'}->{ 'ConsoleAppLaunch'} = $PASS ;
}

sub verify {
	my ($self) = @_;
	
	my $log = $self->{'log'};
	my $product = $self->{'product'};
	my $ra_applications = $self->{'config'}->{'applications'};
	$self->{'result'}->{'ConsoleAppLaunch'} = $PASS;

	foreach my $app_name ( @$ra_applications) {
		$self->{'result'}->{'ConsoleAppLaunch'} = $FAIL unless $self->is_application_launched($app_name) ;
		next;
	}
}

sub check_application_launched {
    my ($self, $app_name) = @_;
    return $TRUE if &System::get_object_reference()->query_process($app_name);
    return $FALSE;
}

sub set_application_launched {
   my ($self, $app_name, $status) = @_;
   $self->{'launched'} = {} unless( $self->{'launched'}) ;
   $self->{'launched'}->{$app_name} = $status;
}

sub is_application_launched {
  my ($self, $app_name) = @_;
  return $self->{'launched'}->{$app_name};
}

1;
