# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Security::McAfee::Mac::Enterprise;

use strict;
use AppleScript;
use System;
use Security::McAfee::Mac;
use Security::McAfee::Mac::Const;
use Security::McAfee::Mac::Enterprise::Const;
use Security::McAfee::Mac::Enterprise::Config;
use Security::McAfee::Mac::Enterprise::GUI;
use Const;

our @ISA = qw(Security::McAfee::Mac);

sub new {
    my ($package) = @_;
    my $self      = Security::McAfee::Mac->new();
    bless $self, $package;
    $self->_load_config($Security::McAfee::Mac::Enterprise::config);
    $self->{'gui_mode'} = 1; 
    return $self;
}

sub is_auto_update_completed {
    my ($self) = @_;
    my $old_dat = $self->get_dat_version();
return (1);
    # Wait if VShieldUpdate is already running
    while ($self->is_service_running("VShieldUpdate") == 1) {
        sleep 1;
    }

    my $new_dat = $self->get_dat_version();
    my $log = $self->{'product_log'}; 
    if ($new_dat > $old_dat) {
        return 1;
    } else {
        return 0;
    }

}



sub manual_update {
    my ($self) = @_;

    $self->add_fm({'qatt' } ) unless $self->is_fm_installed('qatt');

    &System::get_object_reference()->execute_cmd("$self->{'tools'}->{'qatt'}->{'bin'} 16 En 2>&1");
    sleep 30;

    # Add code to check if update happened or not.
    return 1;
}


sub silent_install {
    my ($self, $build) = @_;
    $self->{'install_check'} = {};
    unless ($build and -e $build) {
    # Log the message here.
        $self->{'log'}->error("Invalid argument to silent_install");
        return;
    }
    my $out = &System::get_object_reference()->installer( { 'package' => $build,
                                                'target' => '/Applications'} );
    if( ( $out =~ /installer: The upgrade was successful/s ) or
        ( $out =~ /installer: The install was successful/s   )  ) {
            $self->{'install_check'}->{'install'} =  $PASS;
    }

    if ( $self->is_fm_installed('Firewall') ) {
        $self->{'install_check'}->{'firewall_default_pref'} = $FAIL;
        if ( $self->check_fw_default_pref()) {
            $self->{'install_check'}->{'firewall_default_pref'} = $PASS;
        }
    }
    
    if ( $self->is_fm_installed('AppProtection') ) { 
        $self->{'install_check'}->{'appprot_default_pref'} = $FAIL;
        if ( $self->check_ap_default_pref()) {
            $self->{'install_check'}->{'appprot_default_pref'} = $PASS;
        }
    }

    if ( $self->is_fm_installed('VShieldService') ) {
        $self->{'install_check'}->{'antimalware_default_pref'} = $FAIL;
        if ( $self->check_am_default_pref() ) {
            $self->{'install_check'}->{'antimalware_default_pref'} = $PASS;
        }
    }
    return ;

}
###############################################################################################################
# Description : Uninstall McAfee Security
###############################################################################################################
sub silent_uninstall {
    my ($self) = @_;
    if ( -e $self->{'root_dir'} ) {
        &System::get_object_reference()->execute_cmd( $self->{'uninstaller'} );
    }
    if ( -e $self->{'cma_root_dir'} ) {
        &System::get_object_reference()->execute_cmd( $self->{'cma_uninstaller'} ); 
    }
} 

########################### ODS Tasks ###########################
sub add_ods_task {
    my ($self, $task_name) = @_;
    if( $self->{'gui_mode'} ) {
        require Security::McAfee::Mac::Enterprise::GUI;
        $self->_gui_add_ods_task();
    } else {
        # Add code to add ods task using command.
    }
}

sub remove_ods_task {
    my ($self, $task_name) = @_;
    if( $self->{'gui_mode'} ) {
        $self->_gui_remove_ods_task();
    } else {
        # Add Code to remove ods task using command.
    }
}

sub perform_ods_scan {
     my ($self, $path) = @_;
     $self->{'gui_mode'} = 0;
     if ($self->{'gui_mode'} ) {
        $self->_gui_perform_ods_scan($path);

    } else {
        # Write code to do ODS scan using command

        $self->{'log'}->info("ODS on $path");
        sleep 10;
        my $cmd = &Cwd::abs_path("$self->{'tools'}->{'qatt'}->{'bin'}");
        $cmd =  "$cmd 9 1000 Scan 0 0 $path";
        $self->{'log'}->info("Running command $cmd");
        my $ods_out = `sudo $cmd | grep -i "ODSNow command done"`;
	chomp($ods_out);	

	if( $ods_out eq "ODSNow command done" ) {
	  $self->{'result'}  = {'ODSMixed' => $PASS};
	} else {
	  $self->{'result'}  = {'ODSMixed' => $FAIL};
        }

        $self->{'log'}->info("$ods_out");
        sleep 10;
        &System::get_object_reference()->reload_service('/usr/local/McAfee/fmp/bin/fmp');
        sleep 10;
    }
}

sub remove_all_ods_tasks {
    my ($self, $path) = @_;
    if ( $self->{'gui_mode'} ) {
        $self->launch();
        $self->activate();
        $self->remove_ods_task();
        $self->quit();
    } else {
        
    }
}


sub add_file_to_scan {
    my ($self, $file_path) = @_;
    if( $self->{'gui_mode'} ) {
        $self->_gui_add_file_to_scan($file_path);
    }else {
        # Equivalent in cmd line
    }
}

sub is_service_running {
    my ($self,$service) = @_;
    $service ||= 'VShieldScanner';
    $self->{'log'}->info("Checking Service - $service \n");
    my $system = &System::get_object_reference();
    my $rh_ps = $system->get_all_process();
    #use Data::Dumper; print Dumper "%$rh_ps \n";
 	return ( grep  {$_ =~ /$service/} keys( %$rh_ps) );
}

sub is_all_service_running {
    my ($self) = @_;
    my $ra_services = $self->{'avas_services'};
    my @services = @$ra_services;
    if ( $self->is_fm_installed('Firewall') ) {
        $ra_services = $self->{'fw_services'};
        push(@services,$ra_services);
    } 
    if ( $self->is_fm_installed('AppProtection') ) {
        $ra_services = $self->{'apppro_services'};
        push(@services,$ra_services);
    }
    print "In Enterprise.pm  -- Services - @services \n";
    foreach my $service ( @services) {
        return $FALSE unless $self->is_service_running($service);
    }
    return $TRUE;
}

1;
