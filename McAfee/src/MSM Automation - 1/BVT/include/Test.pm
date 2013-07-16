##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################

package Test;
use strict;
use Log;
use Const;
use Security;
use System;
sub new {
    my ($package, $config) = @_;
    my $self = {
        'timestamp' => time(),	
        'config'    => $config,
        'product'   => &Security::get_product_object($config->get_config('product_name')),
        'system'    => &System::get_object_reference(),
        };
    bless $self, $package;
    return $self;
}

sub _set_log {
    my ($self)           = @_;
    my $package          = ref $self;
    $package             =~ s/^Test:://;
    $package             =~ s/::/_/g; 
    $package             = lc $package;
    $self->{'test_name'} = $package;
    $self->{'log'} = Log->new( "$LOG_DIR/". $self->{'test_name'}."_test.log" );
    $self->{'product'}->{'log'} = $self->{'log'};
}

sub _create_testcases {
    my ($self )  = @_;
    my $t_config = $self->{'config'};
    my $log      = $self->{'log'};
    my $product  = $self->{'product'};

    my $ra_testcase = $t_config->get_testcases();
    my $ra_tc_obj   = [];
    foreach my $rh_tc ( @$ra_testcase ) {
        my $tc_name  = $rh_tc->{'name'};
        my $res_file = "$LOG_DIR/${tc_name}_". $self->{'timestamp'} . ".log";
        my $module   = 'Testcase::'.$tc_name;
        require "$INC_DIR/Testcase/$tc_name.pm";
        my $tc = ${module}->new ( {'config' => $rh_tc,
                                'log' => $log,
                                'product' => $product,
                            } );
        push @$ra_tc_obj, $tc;                        
    }
    return $ra_tc_obj;
}


sub add_firewall_rules {
    my ($self)  = @_;
    my $product = $self->{'product'};
    $self->{'log'}->info("Adding firewall rules");
    $product->launch();
    $product->activate();
    $product->open_preferences(); sleep 4;
    $product->select_firewall(); 
    sleep 1;
    $product->pref_firewall_select_custom();
    my $ra_firewall_rules = $self->{'config'}->get_config('firewall_rules');
    foreach my $rule (@$ra_firewall_rules) {							
        $product->add_firewall_rule($rule);
    }
    $product->quit_preferences();
    $product->quit();
}

sub add_appprot_rules {
    my ($self) = @_;
    my $product = $self->{'product'};
    $product->launch();
    $product->activate();
    $product->open_preferences();
    $product->select_application_protection();
    sleep 10; 
    my $ra_app_rules = $self->{'config'}->get_config('appprot_rules');
#	$product->clean_appprot_rules(); return;
    foreach my $rule ( @$ra_app_rules) {
        $product->add_appprot_rule($rule);
    }

    $product->quit_preferences();
    $product->quit();
}


sub run_testcase {
    my ($self, $tc_obj) = @_;
    return unless $tc_obj;
    my $tc_name = $tc_obj->{'config'}->{'name'};
    my $log     = $self->{'log'};
    $log->info("Initializing test case : $tc_name");
    $tc_obj->init();
    
    $log->info("Executing test case : $tc_name");
    $log->info("Test description : ". $tc_obj->{'config'}->{'tc_desc'}) if $tc_obj->{'config'}->{'tc_desc'};

    $tc_obj->execute();
    
    if ( $tc_obj->{'config'}->{'verify'} ) {
        $log->info("Verifying test case : $tc_name");
        $tc_obj->verify();
    }

    $log->info("Cleaning test case : $tc_name");
    $tc_obj->clean();

    return $tc_obj->get_result();
}


sub capture_metrics {
    my $self       = $_[0];
    my $sleep_time = $self->{'capture_frequency'};
    my $log        = $self->{'log'};
    my $product    = $self->{'product'};
    my $cpu        = Resource::CPUMemory->new($self->{'resource_logs'}->{'CPUMemory'},
                                              $self->{'product'}->get_product_process() );
    my $page_fault = Resource::VMStat->new($self->{'resource_logs'}->{'VMStat'});
    my $open_port  = Resource::OpenPorts->new($self->{'resource_logs'}->{'OpenPorts'});
    my $disk       = Resource::Df->new($self->{'resource_logs'}->{'Df'});
    require Resource::Leaks;
    my $leaks      = Resource::Leaks->new($self->{'resource_logs'}->{'Leaks'});

    while (1) {
        $log->info("Statistics captured");
        $cpu->get(); 
        $page_fault->get();
        $open_port->get();
        $disk->get();
        $leaks->get( $self->{'product'}->get_pids() );
        sleep $sleep_time;
    }
}


sub get_execution_time {
    my ( $self ) = @_;

    return 0 unless $self->{'start_time'} and $self->{'end_time'};

    my $t_secs = $self->{'end_time'}->[0] - $self->{'start_time'}->[0];
    my $t_usec = $self->{'end_time'}->[1] - $self->{'start_time'}->[0];

    return sprintf "%.2f", ( $t_secs + ( $t_usec/1000000) );
}
1;


