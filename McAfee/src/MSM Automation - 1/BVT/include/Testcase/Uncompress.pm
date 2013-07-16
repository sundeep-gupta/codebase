# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::Uncompress;
use strict;
use Testcase;
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

sub init { $_[0]->clean(); }
sub execute { 
    $_[0]->{'start_time'} = [ gettimeofday() ];
    &System::get_object_reference()->extract_tar("$DATA_DIR/".$_[0]->{'config'}->{'source'});
    $_[0]->{'end_time'}   = [ gettimeofday() ];
    $_[0]->{'result'  }   = { 'Uncompress' => $PASS };
} 
sub clean { 
	my ($self) = @_;
	rmdir $self->{'config'}->{'target'} if -e $self->{'config'}->{'target'}  ;
}


1;
