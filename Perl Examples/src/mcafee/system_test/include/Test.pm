##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2009, McAfee Limited. All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################

package Test;

use strict;
use Util;
use Log;
use Result;
use MSMConst;
use MSMConfig;
use Time::Local;
use AppleScript;
use threads;

sub new {
	my ($package, $config) = @_;

	my $self = {
			     'timestamp'         => time(),	
                 'config'            => $config,
				 };

	bless $self, $package;
	return $self;
}

sub _create_testcases {
	my ($self ) = @_;
	my $t_config = $self->{'config'};
	my $log      = $self->{'log'};
	my $msm      = $self->{'msm'};

	my $rh_tc_configs = $t_config->get_testcases();
	my $rh_tc = {};
	foreach my $key (keys %$rh_tc_configs) {
		my $config   = $rh_tc_configs->{$key};
		my $res_file = "$LOG_DIR/${key}_".$self->{'timestamp'}.".log";
		my $module   = 'Testcase::'.$key;
		require "$INC_DIR/Testcase/$key.pm";
		my $tc = ${module}->new($config, $log, $msm, Result->new($res_file) );
		$rh_tc->{$key} = $tc;
	}
	return $rh_tc;
}


sub add_firewall_rules {
	my ($self) = @_;

	my $msc = $self->{'msm'};
	
	$msc->launch();
	$msc->activate();
	$msc->open_preferences();
	$msc->select_firewall(); 
	$msc->pref_enable_admin();
        sleep 30;
	$msc->pref_firewall_select_custom();
	my $ra_firewall_rules = $self->{'config'}->get_config('firewall_rules');
    foreach my $rule (@$ra_firewall_rules) {							
		$msc->add_firewall_rule($rule);
	}
	$msc->quit_preferences();
	$msc->quit();
}

sub add_appprot_rules {
	my ($self) = @_;
	my $msm = $self->{'msm'};
	$msm->launch();
	$msm->activate();
	$msm->open_preferences();
	$msm->select_application_protection();
	$msm->pref_enable_admin();
	sleep 20; 
	my $ra_app_rules = $self->{'config'}->get_config('appprot_rules');
#	$msm->clean_appprot_rules(); return;
	foreach my $rule ( @$ra_app_rules) {
		$msm->add_appprot_rule($rule);
	}

	$self->{'msm'}->quit_preferences();
	$msm->quit();
}


sub run_testcase {
	my ($self, $tc_name) = @_;
	my $rh_testcases = $self->{'testcases'};
	my $log          = $self->{'log'};
	return unless $rh_testcases->{$tc_name};

	$log->info("Initializing test case : $tc_name");
	$rh_testcases->{$tc_name}->init();
	$log->info("Executing test case : $tc_name");
	$rh_testcases->{$tc_name}->execute();
	$log->info("Cleaning test case : $tc_name");
	$rh_testcases->{$tc_name}->clean();

}


sub capture_metrics {
    my $self       = $_[0];
    my $sleep_time = $self->{'capture_frequency'};
    my $log        = $self->{'log'};
	my $msm        = $self->{'msm'};
    my $cpu        = Resource::CPUMemory->new($self->{'resource_logs'}->{'CPUMemory'},$self->{'msm'}->get_product_process() );
    my $page_fault = Resource::VMStat->new($self->{'resource_logs'}->{'VMStat'});
    my $open_port  = Resource::OpenPorts->new($self->{'resource_logs'}->{'OpenPorts'});
    my $disk       = Resource::Df->new($self->{'resource_logs'}->{'Df'});

    while (1) {
		$log->info("Statistics captured") unless $self->{'sleeping_state'};
		$cpu->get(); 
		$page_fault->get();
		$open_port->get();
		$disk->get();
		sleep $sleep_time;
    }
}

1;

