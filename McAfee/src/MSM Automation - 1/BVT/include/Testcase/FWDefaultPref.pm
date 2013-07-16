# Copyright (c) 2010, McAfee Inc.  All rights reserved.
package Testcase::FWDefaultPref;
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
    $self->{'start_time'} = [ gettimeofday() ];

    $self->{'end_time'} = [ gettimeofday() ];
    $self->{'result'}   = { 'FWDefaultPref' => $PASS };
}


sub verify {
    my ($self, $file_to_verify) = @_;
    my $product  = $self->{'product'};
    my $allow_rule = `cat /usr/local/McAfee/Firewall/var/MscRules | grep -i "5002"`; 
    my @trusted_groups = $product->get_trusted_groups();
    unless ( $self->{'product'}->is_service_running('FWService'))
    {
        $self->{'result'}->{ 'FWDefaultPref'} = $FAIL;
        return;
    }    
    print $allow_rule,"\n\n", @trusted_groups;
    if ((($allow_rule) ne "" && scalar(@trusted_groups) == 1))   {
        $self->{'result'}->{'FWDefaultPref'} = $PASS;
    } else { 
    	$self->{'result'}->{'FWDefaultPref'} = $FAIL; 
    }
 
}    
sub clean {
    my ($self) = @_;
    return 1;
}
1; 
