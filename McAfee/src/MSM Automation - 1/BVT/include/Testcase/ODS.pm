# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::ODS;
use strict;
use Const;
use Cwd;
use Testcase;
use Time::HiRes qw/gettimeofday/;


our @ISA = ('Testcase');
sub new {
    my ($package, $rh_param) = @_;
    my $self    = Testcase->new($rh_param);
    bless $self, $package;
    return $self;
}

sub init {
    my ($self) = @_;
    # $self->{'product'}->remove_all_ods_tasks() ;
    return 1;
}


sub clean {
    my ($self) = @_;
    my $data_dir = $DATA_DIR."/". $self->{'config'}->{'data_dir'};
    rmdir $data_dir if ( $data_dir and -e $data_dir ) ;
    $self->{'log'}->info("Removing the ODS task");
    # Copy the logs 
    # &Util::backup_logs();
    my $product      = $self->{'product'};   
    # $product->launch();
    # $product->activate();
    # $product->remove_ods_task(); 
    # $product->quit();  
}


sub _start_ods_scan {
    my ($self, $data_dir) = @_;
    my $log      = $self->{'log'};
    my $product = $self->{'product'};   
    # $product->launch();
    # $product->activate();
    $product->perform_ods_scan(&Cwd::abs_path($data_dir));
    # $product->quit();
   
}

