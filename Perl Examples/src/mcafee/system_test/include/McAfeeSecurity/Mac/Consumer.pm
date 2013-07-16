package McAfeeSecurity::Mac::Consumer;
use strict;
use AppleScript;
use McAfeeSecurity::Mac;
use McAfeeSecurity::Mac::Const;
use McAfeeSecurity::Mac::Const::Consumer;

our @ISA = qw(McAfeeSecurity::Mac);


sub new {
    my ($package) = @_;
    my $self      = McAfeeSecurity::Mac->new();
    $self->{'process'} = [ 'VShieldScanManager', 'fmpd', 'Menulet', 'appProtd', 'FWService', 'SiteAdvisorFM', 'McAfee Rep',
						   'VShieldService', 'Menulet','VShieldScanner', 'McAfee Security'];
	$self->{'screens'} = [2, 3, 4, 6, 7, 8, 9];		
	$self->{'product_paths'}    =  ['/usr/local/McAfee', 
				       			    '/Library/Application Support/McAfee', 
 			   '/Library/Frameworks/SACore.framework', '/Library/Frameworks/Scanbooster.framework',
  			   '/Library/Frameworks/AVEngine.framework','/Library/Frameworks/VirusScanPreferences.framework',
		   	   '/Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist',
		   '/Library/LaunchDaemons/com.mcafee.virusscan.fmpd.plist',
			   '/Applications/McAfee Security.app',      
		   '/Library/Application Support/Mozilla/Extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/{1650a312-02bc-40ee-977e-83f158701739}',
			   '/Library/Preferences/com.mcafee.ssm.antimalware.plist',
		   '/Library/Preferences/com.mcafee.ssm.appprotection.plist',
		   '/Library/Preferences/com.mcafee.ssm.firewall.plist',
 			'/etc/periodic/daily/555.siteadvisor','/Users/Shared/.McAfee',
		];					   
	$self->{'dat_paths'} = ['/usr/local/McAfee/AntiMalware/dats'];
    bless $self, $package;
}


sub silent_install {
    my ($self, $build) = @_;
print "Running for build $build\n";
    unless ($build and -e $build) {
        # Log the message here.
    }
    my $command = "installer -pkg '$build' -target /Applications";
    my $out     = `$command 2>&1`;
    # Quit activation Wizard window 
    &AppleScript::close_application("ActivationWizard");
print $out;
    if( ( $out =~ /installer: The upgrade was successful/s ) or
        ( $out =~ /installer: The install was successful/s   )  ) {
	return 1;
    }   
    return 0;
}   



sub select_custom_scan {
	my ($self) = @_;
	$self->_select_row(9);
	return;
    &AppleScript::activate_application($app_name);
    sleep 2;
	my $apple_script = AppleScript->new();
	$apple_script->start_system_event();
	$apple_script->append("select text field 1 of row 8 of outline 1 of scroll area 1 of splitter group 1 of window 1 ".
						  "of application process \"$app_name\"");

	$apple_script->keystroke("\"C\"");
	$apple_script->end_system_event();
	$apple_script->run();
}





sub run_custom_scan {
    my ($self, $ra_file) = @_;

    # Launch thee self
    $self->launch();
    
    $self->quit();

}

sub perform_ods_scan {
    my ($self, $path) = @_;
 
	$self->launch();
	$self->activate();
	$self->select_custom_scan();
	$self->add_file_to_scan($path);
	$self->start_scan();
	$self->wait_for_scan_complete();
	$self->quit();

}
sub add_file_to_scan {
    my ($self, $file_path) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
	$apple_script->append( "click pop up button 1 of scroll area 1 of group 1 of group 1 of splitter group 1 of window 1 of application process \"$app_name\"");
    $apple_script->keystroke("\"Choose\" & return");
    $apple_script->append("delay 1");   
	$apple_script->end_system_event();
    $apple_script->run();
	$self->_select_path_in_finder($file_path);
}

sub _click_scan {

    my ($self, $btn_name) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("click button \"$btn_name\" of group 2 of group 1 of splitter group 1 of window 1 of application process \"$app_name\"");
    $apple_script->end_system_event();
    $apple_script->run();

}
########################   PREFERENCES WINDOW ACTIONS - CONSUMER SPECIFIC ###############################

sub select_update {
    my ($self) = @_;
    $self->_select_preference_tab($btn_update);
}        

sub select_firewall {
    my ($self) = @_;
    $self->_select_preference_tab($btn_firewall);
}

################################ sub-tab actions on consumer specific preferences ########################

sub select_pref_update_repository {
    my ($self) = @_;
    $self->_select_subtab_in_pref($win_update, $btn_repository);

}


sub select_pref_update_proxy {
    my ($self) = @_;
    $self->_select_subtab_in_pref($win_update, $btn_proxy);

}

sub select_pref_update_schedule {
    my ($self) = @_;
    $self->_select_subtab_in_pref($win_update, $btn_schedule);
}


sub wait_for_scan_complete {
    my ($self) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("repeat while exists button \"$btn_stop_scan\" of group 2 of group 1 of splitter group 1 of window 1 of application process \"$app_name\"");
    $apple_script->append("delay 1");
    $apple_script->append("end repeat");
    $apple_script->end_system_event();
    $apple_script->run();
}





1;
