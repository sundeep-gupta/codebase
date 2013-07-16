# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::Firewall;
use strict;
use Const;
use Testcase;
use Net::Ping;
use System;
use Time::HiRes qw/gettimeofday/;

our @ISA = ('Testcase');

sub new {
    my ($package, $rh_param) = @_;
    my $self = Testcase->new($rh_param);
    bless $self, $package;
    return $self;

}

sub execute {
    my ($self)  = @_;
    my $ra_ping = $self->{'config'}->{'ping'};
    
    # run the ping command
    foreach my $host (@$ra_ping) {
        my $ping = Net::Ping->new("icmp");
        $self->{'log'}->info("$host is alive") if $ping->ping($host);
        $ping->close();
    }	
}

1;
