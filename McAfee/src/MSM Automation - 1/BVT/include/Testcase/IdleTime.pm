# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::IdleTime;
use strict;
use Testcase;
use Resource::CPUMemory;
use Const;
use System;

our @ISA = ('Testcase');
sub new {
    my ($package, $rh_param) = @_;
    my $self = Testcase->new($rh_param);
    bless $self, $package;
    return $self;
}


sub execute {
    my ($self)     = @_;
    my $sleep_time = $self->{'config'}->{'sleep_time'};
    my $iterations = 5;
    my $rh_stats   = {};
    my $cpu_memory = Resource::CPUMemory->new("$LOG_DIR/cpu_memory_idle_time.log", 
                                                $self->{'product'}->{'process'});
    for(my $i = 0; $i < $iterations; $i++) {
        &System::get_object_reference()->wait_till_cpu_idle();
        $cpu_memory->get();
        sleep $sleep_time; 
    }
    $self->{'result'} = {'IdleTime' => $PASS };
} 

1;
