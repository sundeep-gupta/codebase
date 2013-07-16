# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::FWTrustedList;
use Testcase;
use File::Find;
use Const;
use strict;
use Time::HiRes qw/gettimeofday/;
use Net::Ping;

our @ISA = ('Testcase');
sub new {

	my ($package, $rh_param) = @_;
	my $self = Testcase->new($rh_param) ;
	bless $self, $package;
	return $self;
}

sub execute {
    my ($self)     = @_;
    my $rh_config  = $self->{'config'};
    $self->{'start_time'} = [ gettimeofday() ];

    my $host=$self->{config}->{"fwtest_mc"};
    $self->{'log'}->info("Trying to ping $host ...");
    my $p = Net::Ping->new("icmp");;
    if ($p->ping($host)) {
    	$self->{'log'}->info("$host is alive.");
    	$self->{'trusted_list_result'} = $PASS;
    } else {
        $self->{'log'}->info("$host is not reacheable\n");
        $self->{'trusted_list_result'} = $FAIL;
    }
    $p->close();

    $self->{'end_time'} = [ gettimeofday() ];
    $self->{'result'}   = { 'FWTrustedList' => $PASS };
    $self->{'result'}   = { 'FWTrustedList' => $FAIL } if ($self->{'trusted_list_result'} eq $FAIL)
}

sub init {
    my ($self)     = @_;
    return 1;

}

sub verify {
    my ($self, $file_to_verify) = @_;
    my $rh_config = $self->{'config'};
    $self->{'log'}->info("Verifying the Firewall Test for Ping Packets");
    my $product  = $self->{'product'};
    my $fw_rule = $product->get_fw_rules();

    unless ( $self->{'product'}->is_service_running('FWService'))
    {
        $self->{'result'}->{ 'FWTrustedList'} = $FAIL;
        return;
    }    
    if ($product->get_fw_rules() =~ /deny/ && $self->{'trusted_list_result'} eq $PASS) {
        $self->{'result'}->{'FWTrustedList'} = $PASS;
    } else { 
    	$self->{'result'}->{'FWTrustedList'} = $FAIL; 
    }
 
}    
sub clean {
    my ($self) = @_;
    $self->{'product'}->delete_fw_rules();
    $self->{'product'}->delete_trusted_list();
    return 1;
}
 
1;     
