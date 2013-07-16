package Resource::OpenPorts;
use strict;
use System;
use Log::Result;
#############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################

sub new {
    my ($package, $logfile) = @_;
	my $self = {};
	$self->{'result_file'} = Log::Result->new($logfile);
    bless $self, $package;
	return $self;
}
sub get {
    my ($self)  = @_;
	my $fh_results = $self->{'result_file'};
    my $system     = &System::get_object_reference();
    my $rh_data    = $system->open_ports(); 
    $fh_results->append($rh_data);
    return $rh_data;
}


1;
