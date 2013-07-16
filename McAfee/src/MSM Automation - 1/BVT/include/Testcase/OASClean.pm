# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::OASClean;
use Testcase::OAS;
use Const;
use strict;
use Time::HiRes qw/gettimeofday/;
our @ISA = ('Testcase::OAS');
sub new {
	my ($package, $rh_param) = @_;
	my $self = Testcase::OAS->new($rh_param);
	bless $self, $package;
	return $self;
}

sub execute {
    my ($self)     = @_;
    my $source_dir = $self->{'config'}->{'data_dir'};
    $source_dir    = "$DATA_DIR/$source_dir";
    my $file_count = $self->{'config'}->{'file_count'} || 0;
    $self->{'start_time'} = [ gettimeofday() ];
    if ($self->{'config'}->{'write'} ) {
	$self->_execute_write($file_count, $source_dir);
    } 
    if ($self->{'config'}->{'read'} ) {
	$self->_execute_read($source_dir) if -e $source_dir;
    }
    $self->{'end_time'}  = [ gettimeofday() ];
    $self->{'result'  }  = { 'OASClean' => $PASS };

}

sub verify {

    my ($self, $file_to_check) = @_;

    if ( -e $file_to_check) {
        $self->{'result'}->{'OASClean'} = $PASS;
    } else {
        $self->{'result'}->{'OASClean'} = $FAIL;
    }

}
