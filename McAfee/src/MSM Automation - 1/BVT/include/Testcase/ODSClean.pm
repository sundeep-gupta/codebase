# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::ODSClean;
use Testcase::ODS;
use Const;
use strict;
use Time::HiRes qw/gettimeofday/;
our @ISA = ('Testcase::ODS');
sub new {
    my ($package, $rh_param) = @_;
    my $self = Testcase::ODS->new($rh_param);
    bless $self, $package;
    return $self;
}

sub execute {
    my ($self)     = @_;
    my $data_dir   = $self->{'config'}->{'data_dir'};
    my $log        = $self->{'log'};
    my $result_log = $self->{'result_log'};
    $data_dir      = "$DATA_DIR/$data_dir";
    my $start_time = time();
    $log->info("Starting ODS Scan");
    $self->{'start_time'} = [gettimeofday() ];
    $self->_start_ods_scan($data_dir);
    $self->{'end_time'} = [gettimeofday() ];
    $log->info("ODS Scan completed");
    $self->{'result'}  = {'ODSClean' => $PASS};
}
