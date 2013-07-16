package Log::Result::BuildBot;

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

use strict;
use Log;


sub new {
    my ($package, $filename) = @_;
    my $self = {'filename' => $filename,};
    bless $self, $package;
    return $self;
}

sub write {
    my ($self, $new_results) = @_;
    open ( my $fh, ">> ". $self->{'filename'} ) or die "Could not open file : $! : ". $self->{'filename'};
    while ( my ( $tc_name, $value) = each %$new_results) {
       syswrite( $fh, "===RESULT : $tc_name :    $value\n" );
    }
    close $fh;
}


1;
