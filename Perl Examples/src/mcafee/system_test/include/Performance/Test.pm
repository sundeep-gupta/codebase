package Performance::Test;
# 
our @ISA = qw (Test);
use strict;
use threads;
use Test;
use MSMConst;
use Log;
use Resource::CPUMemory;
use Resource::VMStat;
use Resource::Df;
use Resource::OpenPorts;
use McAfeeSecurity;
use Performance::TestState;

sub new {

    my $package  = shift @_;
	my $self = Test->new(@_);
	bless $self, $package;
	$self->{'test_state'}      = $self->{'config'}->get_test_state();
    $self->{'timestamp'}       = $self->{'test_state'}->{'timestamp'};
    $self->{'reboot_required'} = $self->{'config'}->get_config('reboot_required');
	my $log_name               = "$LOG_DIR/performance_".$self->{'timestamp'}.".log";
    $self->{'log'}             = Log->new($log_name);
	$self->{'msm'}             = &McAfeeSecurity::get_product_object($self->{'config'}->get_config('product_name'));
	$self->{'msm'}->{'log'}    = $self->{'log'};
	$self->{'testcases'}       = $self->_create_testcases();
	return $self;
}


sub run {
    my $self = $_[0];
    my @threads = ();
    my $log     = $self->{'log'};
    my $test_state = $self->{'test_state'};
    while ( not $test_state->all_runs_completed() ) {
        my $tc_name = $test_state->get_next_testcase();
        $self->run_testcase($tc_name);
        $test_state->increment($tc_name);
		unless ($test_state->runnable($tc_name)) {
	  		$log->info("Calculating average values for $tc_name");
		    # TODO: Compute average result value given the result log :-)
		    $test_state->set_results_computed($tc_name);
		}
        &Util::reboot() if $self->{'reboot_required'};
    }
}

sub run_testcase {
	my ($self, $tc_name) = @_;
	my $rh_testcases = $self->{'testcases'};
	my $log          = $self->{'log'};
	return unless $rh_testcases->{$tc_name};
	for(my $run = 1; $run <= $rh_testcases->{$tc_name}->{'config'}->{'runs_per_iteration'} ; $run++ ) {
		my $result_filename = "$LOG_DIR/${tc_name}_".$self->{'timestamp'}."_${run}.log";
		$rh_testcases->{$tc_name}->{'result_log'} = Result->new($result_filename); 
        $rh_testcases->{$tc_name}->{'msm'}        = $self->{'msm'};
	
		$log->info("Initializing test case $run  : $tc_name");
		$rh_testcases->{$tc_name}->init();
		$log->info("Executing test case : $tc_name");
		$rh_testcases->{$tc_name}->execute();
		$log->info("Cleaning test case : $tc_name");
		$rh_testcases->{$tc_name}->clean();
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



sub get_config { return $_[0]->{'config'}; }

1;

