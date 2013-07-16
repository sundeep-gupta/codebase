# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::OASQuarantine;
use Testcase::OAS;
use File::Find;
use Const;
use strict;
use Time::HiRes qw/gettimeofday/;

our @ISA = ('Testcase::OAS');
sub new {

    my ($package, $rh_param) = @_;
    my $self = Testcase::OAS->new($rh_param) ;
    bless $self, $package;
    $self->{'data_dir'} = $self->get_data_dir();
    return $self;
}

sub execute {
    my ($self)     = @_;
    my $rh_config  = $self->{'config'};
    my $source_dir = $self->{'data_dir'};
    my $rh_result  = {};
    $self->{'start_time'} = [ gettimeofday() ];
    if ( $rh_config->{'write'} and $rh_config->{'write'}->{'file_count'} ) {
        $rh_result =  $self->_execute_write($rh_config->{'write'}->{'file_count'},
                              $source_dir );
    } 
    if ( $rh_config->{'read'} ) {
        $rh_result = $self->_execute_read( $source_dir) if -e $source_dir;
    }
    $self->{'end_time'} = [ gettimeofday() ];
    $self->{'result'}   = { 'OASQuarantine' => $PASS };

}

sub init {
    my ($self)     = @_;
    my $source_dir = $self->{'data_dir'};
    my $product    = $self->{'product'};
    my $system     = &System::get_object_reference();
    $product->delete_quarantine();
    $system->remove_dir($source_dir) unless $self->{'config'}->{'read'};
    $system->mkdir($source_dir)      unless $self->{'config'}->{'read'};
}

sub verify {
    my ($self) = @_;
    my $rh_config = $self->{'config'};
    my $source_dir = $self->{'data_dir'};

    $self->{'log'}->info("Verifying the OAS Scan");
    if ( $rh_config->{'write'} and $rh_config->{'write'}->{'file_count'} ) {
        $self->{'result'}->{'OASQuarantine'} = $self->_verify_write($rh_config->{'write'}->{'file_count'},
							 $source_dir);
    } 
    if ( $rh_config->{'read'} and -e $source_dir) {
        $self->{'result'}->{'OASQuarantine'} = $self->_verify_read( $source_dir) ;
    }

}    
 
1;     
