# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::RebootTime;
use strict;
use Const;
use Testcase;

our @ISA = ('Testcase');
sub new {
	my ($package, $rh_param) = @_;
	my $self = Testcase->new($rh_param);
	bless $self, $package;
	return $self;
}

sub init {
    my ($self) = @_;
    # Check if autologin is enabled or not ...	
}

sub clean {
    my ($self) = @_;
    my $time  = time();
    &System::get_object_reference()->execute_cmd("echo $time > .prev_run_time");
}

sub execute {
    my ($self)     = @_;
    return unless (-e ".prev_run_time" );
    my $result_log = $self->{'result_log'};
    open(my $fh, ".prev_run_time");
    my $prev_run_time = <$fh>; chomp $prev_run_time;
    close $fh;
    $self->{'start_time'} = [$prev_run_time];
    $self->{'end_time'}   = &System::get_object_reference()->wait_till_cpu_idle();
    $self->{'result'} = {'RebootTime' => $PASS };
} 

1;
