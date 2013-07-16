# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::Compress;
use strict;
use Const;
use System;
use Time::HiRes qw/gettimeofday/;

our @ISA = ('Testcase');
sub new {
    my ($package, $rh_param) = @_;
    my $self = Testcase->new($rh_param);
    bless $self, $package;
    return $self;
}

sub init {
    my ($self) = @_;
    unlink $self->{'config'}->{'target'} if -e $self->{'config'}->{'target'};
}


sub execute {
    my ($self) = @_;
    my $target = $self->{'config'}->{'target'};
    my $source = $self->{'config'}->{'source'};
    $source = "$DATA_DIR/$source";
    $self->{'start_time'} = [ gettimeofday() ];
    &System::get_object_reference()->create_tar( {'tar_file'=> $target, 'source' => $source } );
    $self->{'end_time'}  = [ gettimeofday() ];
    $self->{'result'}    = { 'Compress' => $PASS }
}

sub clean {
    my ($self) = @_;
    unlink $self->{'config'}->{'target'};
}

1;
