# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::AppProtDefaultPref;
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
    $self->{'result'}   = { 'AppProtDefaultPref' => $PASS };
}

sub init {
    my ($self)     = @_;
    return 1;

}

sub verify {
    my ($self, $file_to_verify) = @_;
    my $product  = $self->{'product'};
    my $app_preferences = $product->get_app_preferences();
    my $app_exclusions = $product->get_app_exclusions();
    unless ( $self->{'product'}->is_service_running('appProtd'))
    {
        $self->{'result'}->{ 'AppProtDefaultPref'} = $FAIL;
        return;
    }
    if (($app_preferences =~ /AllowAppleSignedBinaries\: Yes/ 
             && $app_preferences =~ /UnknownAppAction\: 1/ && $app_exclusions =~ /Num Exclusions  are 0/))   {
        $self->{'result'}->{'AppProtDefaultPref'} = $PASS;
    } else { 
    	$self->{'result'}->{'AppProtDefaultPref'} = $FAIL; 
    }
 
}    
sub clean {
    my ($self) = @_;
    return 1;
}
 
1;     
