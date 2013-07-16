package Test::Stress;
##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################
use strict;
use threads;
use Test;

our @ISA = qw (Test);

use Const;
use Log;
use Resource::CPUMemory;
use Resource::VMStat;
use Resource::Df;
use Resource::OpenPorts;
use Security;

sub new {
    my $package  = shift @_;
	my $self = Test->new($_[0]);
	bless $self, $package;
        $self->_set_log();

	$self->{'testcases'}         = $self->_create_testcases($self->{'config'});;
    $self->{ 'threads' }         = { };
	$self->{'capture_frequency'} = $self->{'config'}->get_config('capture_frequency') || 60;
	$self->{'delay_time'}        = $self->{'config'}->get_config('delay_time') || 120;
	$self->{'resource_logs'}     = $self->_get_resource_logs();

#	$self->add_firewall_rules(); 
#	$self->add_appprot_rules(); 
	return $self;
}
sub run {
    my $self = $_[0];
my $log = $self->{'log'};
    my @threads = ();
    $self->{'config'}->print_configuration($log);

    $self->{'threads'}->{'oas'}    = threads->create('run_oas_clean', $self);
    $self->{'threads'}->{'ods'}    = threads->create('run_ods_clean', $self);
    $self->{'threads'}->{'test_cases'} = threads->create('run_test_cases', $self);
    $self->{'threads'}->{'stress'}  = threads->create('run_stress_util', $self) 
                                                        if $self->{'config'}->get_config('run_stress');
    $self->{'threads'}->{'capture'} = threads->create('Test::capture_metrics', $self);    


    # This might not be working with XMLRPC Model.
    $self->{'threads'}->{'oas'}  ->join();
    $self->{'threads'}->{'ods'}  ->join();
    $self->{'threads'}->{'test_cases'}->join();
    $self->{'threads'}->{'capture'}->join();
    $self->{'threads'}->{'stress'}->join() if $self->{'config'}->get_config('run_stress');

}

sub run_oas_clean { 
    my ($self) = @_;
    my $log = $self->{'log'};
    while ( 1) {
        my $data = &_get_data();
        unlink $TMP_DIR."/oasfile.txt" if -e $TMP_DIR."/oasfile.txt";
        open ( my $fh, ">". $TMP_DIR."/oasfile.txt");
        print $fh $data;
        close $fh;
        sleep $self->{'delay_time'};
   }
}
sub _get_data {
    
    return 'ZQZXJVBVT' if ( int rand (10) == 0 );
    return 'Simple plain text';
}



sub run_stress_util {
    my ($self) = @_;
    my $s_log = "$LOG_DIR/stress_util_".$self->{'timestamp'}.".log";
    my $command = "$LIB_DIR/stress --vm 1 --vm-bytes 10M --cpu 6 > $s_log 2>&1";
    while(1) {
        $self->{'log'}->info("Running stress tool : $command");
        $self->{'system'}->execute_cmd($command);
        $self->{'log'}->info("Stress tool leeping for ". $self->{'config'}->get_config("stress_delay")." seconds");
        sleep $self->{'config'}->get_config("stress_delay");
    }
}
sub run_ods_clean {
    my ($self) = @_;
    my $log = $self->{'log'};
    my $ra_tc_obj = $self->{'testcases'};
    while ( 1) {
         $log->info("Starting ODS Scan");
        $self->{'product'}->perform_ods_scan( $DATA_DIR."/ODSMixed");
        sleep $self->{'config'}->get_config('delay_between_ods');
    }
  
}

sub run_test_cases {
    my $self = $_[0];
    my $product = $self->{'product'};
    my $sleep_time = $self->{'delay_time'};
    my $product_name = $self->{'config'}->get_config('product_name');
    # log file and McAfee Security application must be available.

    my $ra_tc_obj = $self->{'testcases'};
   $product->launch() if $product_name eq $MAC_CONSUMER or $product_name eq $MAC_ENTERPRISE; 
    while (1) {

        if ($product_name eq $MAC_CONSUMER or $product_name eq $MAC_ENTERPRISE) {
            $product->activate();
            $product->change_screen();
            sleep 10;
        }

        $self->{'sleeping_state'} = 0;
        foreach my $tc_obj (@$ra_tc_obj) {
	    my $tc_name = $tc_obj->{'config'}->{'name'};
            next if ( $tc_name eq 'OASClean' or $tc_name eq 'OASMixed'  
                    or $tc_name eq 'ODSClean' or $tc_name eq 'ODSMixed');
            $self->run_testcase($tc_obj);
        }

        $self->{'log'}->info("Sleeping zzzzzzz for $sleep_time");
        $self->{'sleeping_state'} = 1;
        sleep $sleep_time;
        
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
                'Leaks'     => "$LOG_DIR/leaks_$timestamp.log",
	};
}

sub stop {
	my ($self) = @_;
	foreach my $key (%{$self->{'threads'}}) {
		$self->{'threads'}->{$key}->kill();
	}
}

1;


