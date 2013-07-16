# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::FWDenyAccess;
use Testcase;
use File::Find;
use Const;
use strict;
use Time::HiRes qw/gettimeofday/;
use Net::Telnet;

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

    my $hostname=$self->{'config'}->{"fwtest_mc"};
    my $username=$self->{'config'}->{"fwtest_mc_userid"};
    my $password=$self->{'config'}->{"fwtest_mc_password"};
    $self->{'log'}->info("Trying to Telnet $hostname $username $password...\n");
    $self->{'telnet_result'} = $FAIL;
    my $t_obj;
    eval {
        $t_obj = new Net::Telnet (Timeout => 10,
             Prompt => '/[\$%#>] $/');
             $t_obj->open("$hostname");
             $t_obj->login($username, $password);
    };
    if ($@) {
         $self->{'log'}->info("Telnet to $hostname failed. \n");
         $self->{'telnet_result'} = $FAIL;
    } else {
        my @lines = $t_obj->cmd("hostname");
        if ($lines[0] =~ /$hostname/) {
            $self->{'log'}->info("Telnet to $hostname successful.\n");
            $self->{'telnet_result'} = $PASS;
        }
    }
    $self->{'end_time'} = [ gettimeofday() ];
    $self->{'result'}   = { 'FWDenyAccess' => $PASS };
    $self->{'result'}   = { 'FWDenyAccess' => $FAIL } if ($self->{'telnet_result'} eq $FAIL); 
}

sub init {
    my ($self)     = @_;
    return 1;
}

sub verify {
    my ($self, $file_to_verify) = @_;
    my $rh_config = $self->{'config'};
    $self->{'log'}->info("Verifying the Firewall Test for Telnet");
    my $product  = $self->{'product'};
    my $fw_rule = $product->get_fw_rules();
    unless ( $self->{'product'}->is_service_running('FWService'))
    {
        $self->{'result'}->{ 'FWDenyAccess'} = $FAIL;
        return;
    }    
    if ($fw_rule =~ /deny/ && $self->{'telnet_result'} eq $FAIL) {
        $self->{'result'}->{'FWDenyAccess'} = $PASS;
    } elsif ($fw_rule =~ /allow/ && $self->{'telnet_result'} eq $PASS) {
        $self->{'result'}->{'FWDenyAccess'} = $PASS;
    } else { 
    	$self->{'result'}->{'FWDenyAccess'} = $FAIL; 
    }    
}    

sub clean {
    my ($self) = @_;
    $self->{'product'}->delete_fw_rules();
    return 1;
}
 
1;     
