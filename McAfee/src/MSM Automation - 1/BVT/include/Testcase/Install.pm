package Testcase::Install;
################################################################################
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
#
# Author: SGupta6
# 
################################################################################
=head1
=cut

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
    $self->_set_data_dir();
    return $self;
}

sub init {
    my ($self)  = @_;
    my $log     = $self->{'log'} ;
    my $product = $self->{'product'};
    my $system  = &System::get_object_reference();
    my $data_dir = $self->get_data_dir();
    
    $log->info("Check and remove prev versions of same product!");
    $product->silent_uninstall();
    
    my $build_url = $self->{'config'}->{'build_url'};
    
    $log->info("Downloading build : $build_url") ;
    my $build_dmg = $system->build_download( {'source' => $build_url,
       'target' => $data_dir,
    });
    
    # If build_dmg does not exist. Installation Failure
    unless ( $build_dmg and -e $build_dmg) {
       $log->error("No Build found for installation!");
       $self->{'result'}->{'Install'} = $FAIL;
    }
    
    # Mount the given dmg and return the path of the mounted pkg
    $self->{'config'}->{'build_file'} = $system->mount_dmg( $build_dmg );                                                               
}

sub clean {
    my ($self) = @_;
    my $build_file = $self->{'config'}->{'build_file'};
    require File::Basename;
    my $basename   =  &File::Basename::basename($build_file);
    $basename =~ s/mpkg$/dmg/;
    my $system = &System::get_object_reference();
    $system->execute_cmd( "hdiutil eject '/Volumes/$basename'");
    my $data_dir = $self->get_data_dir();
    # Remove the file
    unlink $data_dir.'/'.$basename;
	
}
sub execute {
    my ($self) = @_;
    if ($self->{'config'}->{'capture_cpu_memory'} ) {
	my $thr_install = threads->create('_install', $self);
	    &_capture_cpu_metric_on_thread($self, $thr_install);
    } else {
        $self->_install(); 
    }
}
 
###############################################################################################################
# Description : Install McAfee Security product with the given build.
# INPUT       : NONE
# RETURN      : A hash reference containing the memory and cpu stats
###############################################################################################################

sub _install {
    my ($self)     = @_;
    my $product    = $self->{'product'};
    my $log        = $self->{'log'};
    $self->{'start_time'} = [ gettimeofday() ];
    $product->silent_install($self->{'config'}->{'build_file'});
    $self->{'end_time'}  = [ gettimeofday() ];   
    if ($product->{'install_check'}->{'install'} eq $PASS) {
        $log->info("Installation Passed");
        $self->{'result'} = {'Install' => $PASS };
        
        # If verify is there, we'll wait till services are started.
        if( $self->{'config'}->{'verify'} ) {
            $log->info("Waiting for Scanners to start-up");
            while ( not $product->is_service_running() ) {
                 sleep 1;
            }
            $log->info("Services running now. Proceeding with verification");
        }

    } else  {
        $log->info("Installation Failed");
        $self->{'result'} = { 'Install' => $FAIL };
    }
} 

sub verify {
    my ($self) = @_;
    my $rh_verify = $self->{'config'}->{'verify'};
    my $rh_install_check = $self->{'product'}->get_install_check();
    
    if ( $rh_install_check ) {
        while (my ($key, $value) = each %$rh_install_check) {
            $self->{'result'}->{$key} = $value;
        }
    }
    
    # Verify each sub-verifications
    foreach my $key ( keys %{$self->{'config'}->{'verify'}} ) {
        my $m = "v_$key";
        $self->$m();
    }
}

sub _capture_cpu_metric_on_thread {
    my ($self, $thread)   = @_;
    my $ra_resource_stats = [];
    my $sleep_time        = $self->{'config'}->{'capture_frequency'};
    my $log               = $self->{'log'};
    my $result_log        = $self->{'result_log'};

    while($thread->is_running()) {
        $log->info("Capturing CPU Metrics") ;
        my $cpu_memory = Resource::CPUMemory->new("$LOG_DIR/cpu_memory_install.log",
                                                  $self->{'product'}->get_product_process());
	$cpu_memory->get();
	sleep $sleep_time;
    }
    $log->info("Waiting the thread to join") ;
    my $time = $thread->join();
    $log->info("Install thread joined") ;
}

sub v_services {
    my ($self) = @_;
    
    if ( $self->{'product'}->is_all_service_running() ) {
        $self->{'result'}->{'services'} = $PASS;
    } else {
        $self->{'result'}->{'services'} = $FAIL;
    };
}

sub v_auto_update {
    my ($self) = @_;
    if ( $self->{'product'}->is_auto_update_completed() ) {
        $self->{'result'}->{'auto_update'} = $PASS;
    } else {
        $self->{'result'}->{'auto_update'} = $FAIL;
    }
}

# NOTE: Only for Mac Consumer. 
#       Never try with other products unless you want to burn your hands :-)
sub v_activation_wizard {
     my ($self) = @_;
     return unless  ref $self->{'product'} eq $MAC_CONSUMER;
     $self->{'result'}->{'activation_wizard'} = $self->{'product'}->is_activation_wizard_launched() ;
}

1;
