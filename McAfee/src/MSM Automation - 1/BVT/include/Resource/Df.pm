package Resource::Df;
use strict;

#############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################
use System;
use Log::Result;
sub new {
    my ($package, $logfile) = @_;
	my $self = {};
	$self->{'result_file'} = Log::Result->new($logfile);
    bless $self, $package;
	return $self;
}


sub get {
	my ($self) = @_;
    my $fh_results = $self->{'result_file'};
    my $system     = &System::get_object_reference();
    my $ra_data    = $system->disk_usage();
    foreach my $rh_df (@$ra_data) {
        $fh_results->append($rh_df);
    }
    return $ra_data;

}

1;
