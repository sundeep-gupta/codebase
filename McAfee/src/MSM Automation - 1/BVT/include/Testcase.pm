package Testcase;
##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################
use strict;
use Const;

sub new {
    my ($package, $rh_param) = @_;
    my $config   = $rh_param->{'config'};
    my $log      = $rh_param->{'log'};
    my $product  = $rh_param->{'product'};
    die ("FATAL ERROR: Missing parameter 'config' for testcase\n")  unless $config;
    die ("FATAL ERROR: Missing parameter 'log' for testcase\n")     unless $log;
    die ("FATAL ERROR: Missing parameter 'product' for testcase\n") unless $product;

    my $result_log = $rh_param->{'result_log'};
    my $self              = {};
    $self->{'config'}     = $config;
    $self->{'log'}        = $log;
    $self->{'product'}    = $product; 
    $self->{'result_log'} = $result_log if $result_log;
    bless $self, $package;
    return $self;
}

# Dummy methods for test cases
sub execute {}
sub init    {}
sub clean   {}
sub verify  {}
sub get_result { return $_[0]->{'result'}; }

sub get_execution_time {
    my ($self) = @_;
    return 0 unless $self->{'start_time'} and $self->{'end_time'};   

    return sprintf "%.2f" , ( $self->{'end_time'}->[0] - $self->{'start_time'}->[0] ) + 
              ( $self->{'end_time'}->[1] - $self->{'start_time'}->[1] )/1000000;
}

sub _set_data_dir {
     my ($self) = @_;
     
     # Config always takes preference
     if ($self->{'config'}->{'data_dir'}) {
      $self->{'data_dir'} = $DATA_DIR.'/'.$self->{'config'}->{'data_dir'};
      return;
     }
     my $package = ref $self;
     $package =~ s/^Testcase:://;
     
     # This is for multiple directory levels 
     $package =~ s/::/_/;
     $self->{'data_dir'} = $DATA_DIR.'/'.$package;
}

sub get_data_dir {
     my ($self) = @_;
     return $self->{'data_dir'} || $DATA_DIR.'/'.$self->{'config'}->{'data_dir'};
 
}
1;
