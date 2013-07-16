package System;
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
use System::Darwin;
use File::Fetch;
use Const;
$System::system_instance = undef;
sub get_object_reference {
    my ($package) = @_;
	my $self = {};
    unless ($System::system_instance) {
        my $package = &_identify_operating_system();
        $System::system_instance = $package->new();
    }
    return $System::system_instance;
}

sub new {
    my ($package) = @_;
    my $self = {};
    bless $self, $package;
    return $self;
}
sub copy {
    my ($self, $rh_options) = @_;
    my $source = $rh_options->{'source'};
    my $target = $rh_options->{'target'};
    require File::Copy;
    &File::Copy::copy($source, $target);
}

sub mkdir {
    my ($self,$path) = @_;
    mkdir ($path);
}

sub remove_dir {
    my ($self,$path) = @_;
    require File::Path;
    # Commented this because this is changing the directory of the program.
    # Need to write a clean implementation
 #   &File::Path::rmtree ($path);
}

sub change_permission {
    my ($self,$rh_options) = @_;
    my $path = $rh_options->{'path'};
    my $permission = $rh_options->{'permission'};
    `chmod $permission $path`;
}

sub installer {
    my ($self, $rh_options) = @_;
}


sub _identify_operating_system {
        return "System::". ucfirst $^O;
}

sub get_hostname {
    my $host = `hostname`; chomp $host; return $host;
}

sub execute_cmd {
    my ($self, $cmd) = @_ ;
    return `$cmd`;

}

sub ping {
    my ($self, $host) = @_;
    system("ping -c 10 $host");

}

1;
