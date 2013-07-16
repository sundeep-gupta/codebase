package Stress::Test;

use strict;
use threads;
use Test;

our @ISA = qw (Test);

use MSMConst;
use Log;
use Resource::CPUMemory;
use Resource::VMStat;
use Resource::Df;
use Resource::OpenPorts;
use McAfeeSecurity;

sub new {
    my $package  = shift @_;
	my $self = Test->new($_[0]);
	bless $self, $package;
	my $log_name = "$LOG_DIR/stress_".$self->{'timestamp'}.".log";
	$self->{ 'log'}              = Log->new($log_name);
	$self->{'msm'}               = &McAfeeSecurity::get_product_object($self->{'config'}->get_config("product_name"));
	$self->{'testcases'}         = $self->_create_testcases($self->{'config'});;
    $self->{ 'threads' }         = { };
	$self->{'capture_frequency'} = $self->{'config'}->get_config('capture_frequency') || 60;
	$self->{'delay_time'}        = $self->{'config'}->get_config('delay_time') || 120;
	$self->{'resource_logs'}     = $self->_get_resource_logs();
	$self->{'msm'}->{'log'}      = $self->{'log'}; 

	$self->add_firewall_rules(); 
	$self->add_appprot_rules(); 
	return $self;
}
sub run {
    my $self = $_[0];
    my @threads = ();
	$self->{'threads'}->{'stress'}  = threads->create('run_stress_util', $self) if $self->{'config'}->get_config('run_stress');
    $self->{'threads'}->{'oas'}    = threads->create('run_oas_clean', $self);
#	$self->{'threads'}->{'ods'}    = threads->create('run_ods_clean', $self);
    $self->{'threads'}->{'test_cases'}    = threads->create('run_test_cases', $self);
    $self->{'threads'}->{'capture'} = threads->create('Test::capture_metrics', $self);    


    # This might not be working with XMLRPC Model.
	$self->{'threads'}->{'stress'}->join() if $self->{'config'}->get_config('run_stress');
    $self->{'threads'}->{'oas'}  ->join();
#    $self->{'threads'}->{'ods'}  ->join();
    $self->{'threads'}->{'test_cases'}  ->join();
    $self->{'threads'}->{'capture'}->join();

}

sub run_stress_util {
	my ($self) = @_;
	my $s_log = "$LOG_DIR/stress_util_".$self->{'timestamp'}.".log";
	my $command = "$LIB_DIR/stress --vm 1 --vm-bytes 10M --cpu 6 > $s_log 2>&1";
	while(1) {
		$self->{'log'}->info("Running stress tool : $command");
		system($command);
		$self->{'log'}->info("Stress tool leeping for ". $self->{'config'}->get_config("stress_delay")." seconds");
		sleep $self->{'config'}->get_config("stress_delay");
	}
}

sub run_oas_mixed { while(1) { $_[0]->_run_scan('OASMixed', $_[0]->{'delay_time'}); sleep $_[0]->{'delay_time'}; } }
sub run_oas_clean { while (1) { $_[0]->_run_scan('OASClean', $_[0]->{'delay_time'}); sleep $_[0]->{'delay_time'}; } }
sub run_ods_mixed { $_[0]->_run_scan('ODSMixed', $_[0]->{'config'}->get_config('delay_between_ods') ); }
sub run_ods_clean { $_[0]->_run_scan('ODSClean', $_[0]->{'config'}->get_config('delay_between_ods') ); }


sub run_test_cases {
    my $self = $_[0];
    my $log = $self->{'log'};
    my $msm = $self->{'msm'};
    my $sleep_time = $self->{'delay_time'};
    my $product_name = $self->{'config'}->get_config('product_name');
    # log file and McAfee Security application must be available.
    return unless $log and $msm;

	my $rh_testcases = $self->{'testcases'};
	while (1) {

		if ($product_name eq $MAC_CONSUMER or $product_name eq $MAC_ENTERPRISE) {
			$self->run_ods_clean();

			$msm->launch(); $msm->activate();
			$msm->change_screen();
			sleep 10;
			$msm->open_about_box();
		}

		$self->{'sleeping_state'} = 0;
		foreach my $tc_name (keys %$rh_testcases) {
			next if ( $tc_name eq 'OASClean' or $tc_name eq 'OASMixed'  or $tc_name eq 'ODSClean' or $tc_name eq 'ODSMixed');
			$self->run_testcase($tc_name);
		}
		$log->info("Sleeping zzzzzzz for $sleep_time");
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
	};
}




sub _run_scan {
    my ($self, $tc_name, $delay) = @_;
	return unless ( $self->{'config'}->get_config('product_name') eq $MAC_CONSUMER or 
				    $self->{'config'}->get_config('product_name') eq $MAC_ENTERPRISE );
	my $log     = $self->{'log'};

#	while (1) {
		$log->info("Starting $tc_name");
		$self->run_testcase($tc_name);
		$log->info("Sleeping zzzzzzz for $delay");
#	}
}

sub get_config { return $_[0]->{'config'}; }

sub stop {
	my ($self) = @_;
	foreach my $key (%{$self->{'threads'}}) {
		$self->{'threads'}->{$key}->kill();
	}
}

1;


