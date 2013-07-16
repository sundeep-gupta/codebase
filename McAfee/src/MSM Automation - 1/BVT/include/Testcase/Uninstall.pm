# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::Uninstall;
use strict;
use Const;
use AppleScript;
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
    my $product = $self->{'product'};
    my $log     = $self->{'log'};
    unless ( $product->is_installed() ) {
        $self->{'result'} = {'Uninstall' => $FAIL };
        print "Product not installed\n";
        return;
    }
    $self->{'start_time'} = [ gettimeofday() ]; 
    $product->silent_uninstall();
    $self->{'end_time'} = [ gettimeofday() ];
    $self->{'result'}   = { 'Uninstall' => $PASS }
    
}
 
sub verify {
    my ($self) = @_;
    print "Verifying ... \n";
    my $log     = $self->{'log'};
    my $product = $self->{'product'};
    if ( -e $product->{'root_dir'} ) {
        $log->info("Product root dir exists. Uninstall failed");
        $self->{'result'}->{'Uninstall'} = $FAIL;
    }
}

1;
