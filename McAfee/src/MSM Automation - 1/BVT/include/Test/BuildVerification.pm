# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Test::BuildVerification;
# 
our @ISA = qw (Test);
use strict;
use Test;
use Conf;
use Log;
use Security;
use System;
use Const;
use Log::Result::BuildBot;

sub new {
    my $package  = shift @_;
    my $self    = Test->new(@_);
    bless $self, $package;
    $self->_set_log();
    $self->{'testcases'} = $self->_create_testcases();
    return $self;
}

sub run {
    my $self      = $_[0];
    my $product   = $self->{'product'};
    my $system    = $self->{'system'};
    my $prod_name = $self->{'config'}->get_config('product_name');
   
    # TODO: Remove crashes and logs
    #$product->clear_logs();
    $product->clear_crashes() if $product->check_crashes();
    
    my $ra_tc_obj       = $self->{'testcases'};
    my $rh_final_result = {};
    my $rh_test_result = {};
    my $tc_name = {};

    foreach my $tc_obj ( @$ra_tc_obj ) {
	
        $tc_name = $tc_obj->{'config'}->{'name'};

	my $log = Log->new( "$LOG_DIR/".$tc_name."_test.log" );
	$tc_obj->{'log'} = $log;
	$tc_obj->{'product'}->{'log'} = $log;

	$self->{'log'} = $log;
	$self->{'product'}->{'log'} = $log;

    	$log->info("Starting test with following configuration");
    	$self->{'config'}->print_configuration($log);

        next if ($tc_obj->{'config'}->{'needs_module'} and ! $product->is_fm_installed($tc_obj->{'config'}->{'needs_module'}));

        # Set the product preference if asked to do so
        if ( $tc_obj->{'config'}->{'product_pref'} ) {
            $log->info('Setting product preferences');
            $product->set_product_pref($tc_obj->{'config'}->{'product_pref'} ); 

        }
        
        # Run the testcase 
        $self->run_testcase( $tc_obj );

        # Get the result of the test case
        my $rh_result = $tc_obj->get_result();
        foreach my $key ( keys %$rh_result ) {
            my $value = $rh_result->{$key};
            if( $key eq $tc_name) {
                $key = $tc_obj->{'config'}->{'tc_desc'};
		$rh_test_result = $value;
            } else {
                $key = $tc_name. " ". $key. " check";
            }
            $rh_final_result->{$key} = $value;
        }
        # Reset the preferences to defaults
        $product->reset_to_defaults();
        if ( $product->check_crashes() )
	{
		# If crash occured for the testcase, mark the result as FAIL...
		$rh_test_result = $FAIL;
        	$product->backup_crashes($LOG_DIR . '/'. $tc_name . '/')  if $product->check_crashes();
	}
    }
    
    # TODO : Backup the logs
    # $product->backup_logs($LOG_DIR);
    # $product->backup_crashes($LOG_DIR . ) if $product->check_crashes();
    
    # Now write the results in the log file with format as expected by Buildbot
    my $result = Log::Result::BuildBot->new( "$LOG_DIR/".$tc_name."_result.log" );
    $result->write( $rh_final_result) ;

    if($rh_test_result eq $PASS)
    {
	return 0;
    }
    else
    {
	return 1;
    }
    
#    $log->info("Rebooting the machine");
#    $system->reboot();
}

    

1;

