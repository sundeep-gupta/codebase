package Conf;
##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# UID     YYMMDD : Comment
# -------------------------
# sgupta6 091116 : Created
##############################################################
use Const;
use strict;

sub new {
	my ($package) = @_;
	my $self = {};
	bless $self, $package;
	return $self;
}

#sub routine to fetch variable values from config file
sub get_config {
    my($self, $param) = @_;
    my $config = $self->{'config'};
    return $config->{$param};
}

sub get_testcases {
    my ($self) = @_;
    my $ra_testcase = $self->{'config'}->{'test_case_list'};
    my $ra_exec_tc = [];
    foreach my $rh_tc ( @$ra_testcase ) {
        if ( $rh_tc->{'execute'} ) {
            push @$ra_exec_tc, $rh_tc;
        }
    }
    return $ra_exec_tc;
}


sub print_configuration {
    my ($self, $log) = @_;
    my $rh_config = $self->{'config'};
    foreach my $key ( keys %$rh_config ) {
        $log->info ( "$key -> ". $rh_config->{$key} ) unless ref $rh_config->{$key};
    }
}
1;
