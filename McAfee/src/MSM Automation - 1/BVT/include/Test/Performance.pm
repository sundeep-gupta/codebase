# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Test::Performance;

our @ISA = qw (Test);
use strict;
use threads;
use Test;
use Const;
use Log;
use Log::Result::Performance;

use Resource::CPUMemory;
use Resource::VMStat;
use Resource::Df;
use Resource::OpenPorts;
use TestState;
use System;

sub new {

    my $package  = shift @_;
    my $self = Test->new(@_);
    bless $self, $package;
    $self->{'test_state'}      = $self->{'config'}->get_test_state();
    $self->{'timestamp'}       = $self->{'test_state'}->{'timestamp'};
    $self->_set_log();
    
    $self->{'reboot_required'} = $self->{'config'}->get_config('reboot_required');
    if( $self->{'config'}->get_config('product_install_check') and ! $self->{'product'}->is_installed() ) {
        $self->{'log'}->error("Cannot run test as product is not installed");
        die "Cannot run test as product is not installed\n";
    }
    $self->{'testcases'}       = $self->_create_testcases();
    return $self;
}


sub run {
    my $self = $_[0];
    my @threads = ();
    my $log     = $self->{'log'};
    my $product = $self->{'product'};
    my $system  = $self->{'system'};
    my $prod_name = $self->{'config'}->get_config('product_name');
    my $ra_tc_obj = $self->{'testcases'};
    unless (-e $self->{'test_state'}->{'test_state_file'} ) {
        $self->{'config'}->print_configuration($log);
    }
    my $test_state = $self->{'test_state'};
    while ( not $test_state->all_runs_completed() ) {
        my $tc_idx = $test_state->get_next_testcase();
        my $tc_obj = $ra_tc_obj->[$tc_idx];
        my $tc_name = $tc_obj->{'config'}->{'name'};
        if( $tc_name ne 'Install' and ( $prod_name ne $MAC_NORTON11 )) {
            # Wait till the service is not started
            $log->info("Waiting till services of product are up"); 
          #  while ( not $product->is_service_running()) {}
            $log->info("Waiting till CPU idle");
#            $system->wait_till_cpu_idle();
        }

        $self->run_testcase($tc_obj);
        $test_state->increment($tc_idx);
        unless ($test_state->runnable($tc_idx )) {
            if ( $self->{'testcases'}->[$tc_idx]->{'config'}->{'result_log'} ) {
                $log->info("Calculating average values for $tc_name");
                $self->{'testcases'}->{$tc_idx}->{'config'}->{'result_log'}->compute_average();
            }
            $test_state->set_results_computed($tc_idx);
        }
        &System::get_object_reference()->reboot() if $self->{'reboot_required'};
    }
}

sub run_testcase {
    my ($self, $tc_obj) = @_;
    my $log          = $self->{'log'};
    return unless $tc_obj;
    my $tc_name = $tc_obj->{'config'}->{'name'};
    for(my $run = 1; $run <= $tc_obj->{'config'}->{'runs_per_iteration'} ; $run++ ) {
        $tc_obj->{'product'}        = $self->{'product'};

        $log->info("Initializing test case $run  : $tc_name");
        $tc_obj->init();
        $log->info("Executing test case : $tc_name");
        $tc_obj->execute();
        $log->info("Cleaning test case : $tc_name");
        $tc_obj->clean();
        
        my $time = $tc_obj->get_execution_time();
        my $result_filename = "$LOG_DIR/performance_result_".$self->{'timestamp'}.".log";
        my $result_log = Log::Result::Performance->new ( $result_filename );
        $result_log->write({ $tc_obj->{'config'}->{'tc_desc'}." run $run" => $time } );
        print "Time taken = $time\n";
    }
}

sub _get_resource_logs {
    my ($self) = @_;
    my $timestamp = $self->{'timestamp'};
    return {
        'CPUMemory' => "$LOG_DIR/cpu_memory_$timestamp.log",
        'VMStat'    => "$LOG_DIR/vmstat_$timestamp.log",
        'OpenPorts' => "$LOG_DIR/ports_$timestamp.log",
        'Df'        => "$LOG_DIR/disk_$timestamp.log",
    };
}

1;

