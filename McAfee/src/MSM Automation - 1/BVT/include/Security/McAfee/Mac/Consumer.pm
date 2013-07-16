# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Security::McAfee::Mac::Consumer;
use strict;
use AppleScript;
use Security::McAfee::Mac;
use Security::McAfee::Mac::Const;
use Security::McAfee::Mac::Consumer::Config;
use Security::McAfee::Mac::Consumer::GUI;
use Const;
use System;

our @ISA = qw(Security::McAfee::Mac);

# TODO: Remove this and should work.
my $app_name = 'McAfee Internet Security';
my $p_btn_insert = '';
my $aw_app = 'ActivationWizard';
my $p_btn_cancel = '';
my $p_btn_activate = '';
my $p_link_forgot = '';

sub new {
    my ($package) = @_;
    my $self      = Security::McAfee::Mac->new();
    bless $self, $package;
    $self->_load_config($Security::McAfee::Mac::Consumer::config);
 #   $self->_load_test_tools() if $self->is_installed() and not $self->is_fm_installed('QATT') ;
    return $self;
}

sub is_auto_update_completed {
    my ($self) = @_;
    return 1; # Add check to findif auto update is done or not.
}

sub silent_install {
    my ($self, $build) = @_;
	$self->{'install_check'} = {};
    unless ($build and -e $build) {
        # Log the message here.
		$self->{'log'}->error("Invalid argument to silent_install");
        return;
    }
    # If asked to verify instrumentation then run a thread to check it
    require threads;
    my $th  = threads->create('wait_for_instru', $self);
    my $out = &System::get_object_reference()->installer( { 'package' => $build, 
						'target' => '/Applications'} );
    if( ( $out =~ /installer: The upgrade was successful/s ) or
        ( $out =~ /installer: The install was successful/s   )  ) {
	    $self->{'install_check'}->{'install'} =  $PASS;
    }   
    
	# Wait till activation wizard comes.
	sleep 5; 
	$self->{'install_check'}->{'activation_wizard_launch'} = $FAIL;
	if ( $self->is_aw_launched() ) {
	    print "DEBUG: AW is launched\n";
    	$self->{'install_check'}->{'activation_wizard_launch'} = $PASS ;
		# Quit activation Wizard window 
		$self->quit_aw();
	} 

    # Wait till we quit instru checker
    $th->join();
	$self->{'install_check'}->{'instrumentation_during_install'} = $PASS;
	if( -e $TMP_DIR.'/instru.xml' ) {
		$self->{'install_check'}->{'instrumentation_during_install'} = $PASS;
	}

    $self->{'install_check'}->{'firewall_default_pref'} = $FAIL;
    if ( $self->check_fw_default_pref()) {
         $self->{'install_check'}->{'firewall_default_pref'} = $PASS;
    }
    
    $self->{'install_check'}->{'appprot_default_pref'} = $FAIL;
    if ( $self->check_ap_default_pref()) {
        $self->{'install_check'}->{'appprot_default_pref'} = $PASS;
    }
    
    $self->{'install_check'}->{'antimalware_default_pref'} = $FAIL;
    if ( $self->check_am_default_pref() ) {
        $self->{'install_check'}->{'antimalware_default_pref'} = $PASS;
    }
	# TODO: Check if SA is installed ?
    return ;
}   



sub wait_for_instru {
    my ($self) = @_;
    # Wait till instru file is not found.
    while ( not -e $self->{'instru_file'} ) {};
    # Once found start copying it 
    while ( -e $self->{'instru_file'} ) { 
        &System::get_object_reference()->copy( { 'source' => $self->{'instru_file'}, 
              					 'target' => $TMP_DIR."/instru.xml"
						} );
    }
}

###############################################################################################################
# Description : Uninstall McAfee Security
###############################################################################################################
sub silent_uninstall {
    return unless -e $_[0]->{'uninstaller'};
    &System::get_object_reference()->execute_cmd($_[0]->{'uninstaller'} . " all > /dev/null 2>&1");
} 



sub perform_ods_scan {
    my ($self, $path) = @_;
    if ( $self->{'gui_mode'} ) {
	print "Using GUI MODE\n";
            $self->select_custom_scan();
            $self->add_file_to_scan($path);
            $self->start_scan();
            $self->wait_for_scan_complete();
    } else {
        $self->{'log'}->info("Runnning ODS with full scan");
        # Run Full ODS Scan for Consumer, as we do not have any other way to run custom scan
        &System::get_object_reference()->execute_cmd("sudo /usr/local/McAfee/AntiMalware/VShieldTaskManager 4 >> /dev/null 2>&1");
    }
}

sub manual_update {
    my ($self) = @_;
    &System::get_object_reference()->execute_cmd('/usr/local/McAfee/fmp/bin/UpdateHelper update 2>&1');
    # Add code to check if update happened or not
    sleep 60; # For now sleeping for one min.
    return 1;
}


sub get_build_url { 
    my ($self,$rh_option) = @_;
	my $build = $rh_option->{'build'};
	my $name = $rh_option->{'name'};
	my $server = $rh_option->{'url'};
	my $lang   = $rh_option->{'lang'};
	my $version = $rh_option->{'version'};
	my $type   = $rh_option->{'type'};
    unless ( $name and $server ) {
		$self->{'log'}->error("Invalid arguments to get_build_url");
		return '';
	}
	my $build_url = $server."/".$build."/".$name;
	$build_url .= "-$version" if $version;
	$build_url .= "-$build" if $build;
	$build_url .= "-$lang" if $lang;
	$build_url .= "-$type" if $type;
	$build_url .= ".dmg";
	return $build_url;
 }


################################### ACTIVATION WIZARD API ###########################

sub is_aw_launched {
    my ($self) = @_;
	# TODO: For now checking only process. We may need to check window also.
	return &System::get_object_reference()->query_process( $self->{'aw_process'} );
}
sub quit_aw {
    &AppleScript::quit_application("ActivationWizard");
}
sub launch_aw {
	my ($self) = @_;
	&System::get_object_reference()->execute_cmd("open ". $self->{'aw_app'} );
	$self->{'log'}->info("Launched ActivationWizard! Sleeping for 5 Sec !");
	return $self->is_aw_launched();
}
sub click_activate {
	my ($self) = @_;

	# TODO: Check if Console is launchd or not.
	
	# Assuming it is launched we try clicking on it. 

	my $apple_script = AppleScript->new();
	$apple_script->start_system_event();
	$apple_script->click( $p_btn_activate, $app_name );
	$apple_script->end_system_event();
}

sub get_aw_forgot_url {
	my $apple_script = AppleScript->new();
	$apple_script->start_system_event();
	$apple_script->click( $p_link_forgot, $aw_app );
	$apple_script->end_system_event();
	
}

sub click_aw_cancel {
	my $apple_script = AppleScript->new();
	$apple_script->start_system_event();
	$apple_script->click( $p_btn_cancel, $aw_app);
	$apple_script->end_system_event();

}

sub aw_activate {

}

sub aw_get_error_msg {

}

sub is_activation_successful {

}



1;
