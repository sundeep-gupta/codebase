# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::NetworkOperation;
use strict;
use Const;
use Testcase;
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
    my ($self) = @_;
    my $protocol = $self->{'config'}->{'protocol'}; 
    my $host     = $self->{'config'}->{'server'};
    $self->{$protocol} = $FALSE;
    if ( $protocol eq 'telnet') {
        my $hostname=$self->{'config'}->{"server"};
        my $username=$self->{'config'}->{"user"};
        my $password=$self->{'config'}->{"password"};
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
        } else {
            my @lines = $t_obj->cmd("hostname");
            if ($lines[0] =~ /$hostname/) {
                $self->{'log'}->info("Telnet to $hostname successful.\n");
                $self->{$protocol} = $TRUE;
            }
        }
    } elsif ($protocol eq 'icmp') {
        my $ping = Net::Ping->new("icmp");
        if $ping->ping($host){
         $self->{'log'}->info("$host is alive") ;
         $self->{$protocol} = $TRUE
        };
        $ping->close();
    } 
}

sub verify {
    my ($self) = @_;
    my $protocol = $self->{'config'}->{'protocol'};
    
    $self->{'result'}->{'NetworkOperation'} = $FAIL;
    $self->{'result'}->{'NetworkOperation'} = $PASS
        if $self->{$protocol} and $self->{$protocol} == $TRUE;
}
sub clean {
 
}
