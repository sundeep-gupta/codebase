package Test::Soak;
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
##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2009, McAfee Limited. All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################
our @ISA = qw (Test);

use Const;
use Log;
use Resource::CPUMemory;
use Resource::VMStat;
use Resource::Df;
use Resource::OpenPorts;
use Resource::Leaks;
use Security;

sub new {

    my $package  = shift @_;
    my $self = Test->new(@_);
    bless $self, $package;
    $self->_set_log();
    $self->{'testcases'}         = $self->_create_testcases();
    $self->{'threads'}           = {};
    $self->{'capture_frequency'} = $self->{'config'}->get_config('capture_frequency') || 0;
    $self->{'delay_time'}        = $self->{'config'}->get_config('delay_time') || 0;
    $self->{'resource_logs'}     = $self->_get_resource_logs();

#    $self->add_firewall_rules(); 
#    $self->add_appprot_rules();
    return $self;
}


sub run {
    my $self = $_[0];
    my @threads = ();	
    $self->{'threads'}->{'oas'}    = threads->create('run_oas_clean', $self);
    $self->{'threads'}->{'ods'}    = threads->create('run_ods_clean', $self);
    $self->{'threads'}->{'test_cases'} = threads->create('run_test_cases', $self);
    $self->{'threads'}->{'capture'} = threads->create('Test::capture_metrics', $self);    


    # This might not be working with XMLRPC Model.
    $self->{'threads'}->{'oas'}  ->join();
    $self->{'threads'}->{'ods'}  ->join();
    $self->{'threads'}->{'test_cases'}->join();
    $self->{'threads'}->{'capture'}->join();
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
sub run_ods_clean {
    my ($self) = @_;
    my $log = $self->{'log'};
    my $ra_tc_obj = $self->{'testcases'};
    while ( 1) {
        $self->{'product'}->perform_ods_scan( $DATA_DIR."/ODSMixed");
        sleep $self->{'config'}->get_config('delay_between_ods');
    }
  
}

sub run_test_cases {
    my $self         = $_[0];
    my $log          = $self->{'log'};
    my $product      = $self->{'product'};
    my $sleep_time   = $self->{'delay_time'};
    my $product_name = $self->{'config'}->get_config('product_name');
    
    # log file and McAfee Security application must be available.
    return unless $log and $product;

    my $ra_tc_obj = $self->{'testcases'};
    while (1) {
        $self->{'sleeping_state'} = 0;
        # Select a screen in the console UI randomly
        if ($product_name eq $MAC_CONSUMER or $product_name eq $MAC_ENTERPRISE) {
#            $self->run_oas_clean();
            $product->launch(); $product->activate();
            $product->change_screen();
            sleep 10;
            $product->activate();
       #     $product->open_about_box();
        }

        foreach my $tc_obj ( @$ra_tc_obj) {
            my $tc_name = $tc_obj->{'config'}->{'name'};
            $self->run_testcase($tc_obj);
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
