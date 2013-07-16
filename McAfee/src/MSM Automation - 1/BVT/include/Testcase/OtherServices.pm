# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::OtherServices;
use File::Find;
use Const;
use strict;
use System;
use Testcase;

our @ISA = ('Testcase');

sub new {
	my ($package, $rh_param) = @_;
	my $self = Testcase->new($rh_param);
	bless $self, $package;
	return $self;
}

sub verify {
    my ( $self) = @_;
    my $ra_services = $self->{'config'}->{'services'};
    unless ( $ra_services ) 
    {
        $self->{'log'}->warning("No services set");
    }
   
    my $status = $PASS; 
    foreach my $service_name ( @$ra_services) 
    {
        if ( $self->{'product'}->is_service_running($service_name) )
        {
            $self->{'log'}->warning("Service is running");
            $self->{'log'}->warning($service_name);
        }
        else
        {
            $self->{'log'}->warning("Service not running");
            $self->{'log'}->warning($service_name);
            $status = $FAIL;
        }
    }		
    $self->{'result'} = {'OtherServices' => $status };
}

 
1;     
