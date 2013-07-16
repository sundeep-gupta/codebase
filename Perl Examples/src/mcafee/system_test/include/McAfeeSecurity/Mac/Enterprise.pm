package McAfeeSecurity::Mac::Enterprise;

use strict;
use AppleScript;
use McAfeeSecurity::Mac;
use McAfeeSecurity::Mac::Const;
use McAfeeSecurity::Mac::Const::Enterprise;

our @ISA = qw(McAfeeSecurity::Mac);

sub new {
    my ($package) = @_;
    my $self = McAfeeSecurity::Mac->new();
    $self->{'process'} = [ 'VShieldScanManager', 'fmpd', 'Menulet', 'appProtd', 'FWService', 'cma', 'McAfee Rep',
						   'VShieldService', 'Menulet','VShieldScanner', 'McAfee Security'];
	$self->{'screens'} = [2, 3, 4, 6, 7];
	$self->{'product_paths'}    =  ['/usr/local/McAfee', 
				       			    '/Library/Application Support/McAfee', 
 			   '/Library/Frameworks/Scanbooster.framework',
  			   '/Library/Frameworks/AVEngine.framework','/Library/Frameworks/VirusScanPreferences.framework',
		   	   '/Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist',
		   '/Library/LaunchDaemons/com.mcafee.virusscan.fmpd.plist',
			   '/Applications/McAfee Security.app',      
			   '/Library/Preferences/com.mcafee.ssm.antimalware.plist',
		   '/Library/Preferences/com.mcafee.ssm.appprotection.plist',
		   '/Library/Preferences/com.mcafee.ssm.firewall.plist',
		];
	$self->{'dat_paths'} = ['/usr/local/McAfee/AntiMalware/dats'];;
    bless $self, $package;
}


sub silent_install {
    my ($self, $build) = @_;
    unless ($build and -e $build) {
		return 0;
    }
    my $command = "installer -pkg $build -target /Applications";
    my $out     = `$command 2>&1`;
    if( ( $out =~ /installer: The upgrade was successful/s ) or
        ( $out =~ /installer: The install was successful/s   )  ) {
       return 1;
    }   
    return 0;
}

########################### ODS Tasks ###########################
sub add_ods_task {
    my ($self, $task_name) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->append("activate application \"$app_name\"");
    $apple_script->start_system_event();
    $apple_script->append( "click button \"$btn_plus\" of group 1 of window 1 of application process \"$app_name\"");
    $apple_script->append( "repeat while button \"$btn_cancel\" of sheet 1 of window 1 of application process \"$app_name\" is not enabled");
    $apple_script->append("end repeat");
    $apple_script->keystroke("\"$task_name\"");
    $apple_script->append( "repeat while button \"$btn_create\" of sheet 1 of window 1 of application process \"$app_name\" is not enabled");
    $apple_script->append( "end repeat");
    $apple_script->append( "click button \"$btn_create\" of sheet 1 of window 1 of application process \"$app_name\"");
    $apple_script->end_system_event();
    $apple_script->run();

}

sub remove_ods_task {
    my ($self, $task_name) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("repeat while button 2 of group 1 of window 1 of application process \"$app_name\" is not enabled");
    $apple_script->append("select row 8 of outline 1 of scroll area 1 of splitter group 1 of window 1 of application process \"$app_name\"");
    $apple_script->append("click button 2 of group 1 of window 1 of application process \"$app_name\"");
    $apple_script->append("end repeat");
    $apple_script->end_system_event();
    $apple_script->run();
}

sub perform_ods_scan {
    my ($self, $path) = @_;
 
	$self->launch();
	$self->activate();
	$self->add_ods_task('ODS');
	$self->add_file_to_scan($path);
	$self->start_scan();
	$self->wait_for_scan_complete();
	$self->remove_ods_task('ODS');
	$self->quit();

}

sub remove_all_ods_tasks {
    my ($self, $path) = @_;
 
$self->launch();
$self->activate();
$self->remove_ods_task();
$self->quit();

}


sub add_file_to_scan {
    my ($self, $file_path) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("click pop up button 1 of scroll area 1 of group 2 of group 1 of splitter group 1 of window 1 of application process \"$app_name\"");
    $apple_script->keystroke("\"Choose\" & return");
    $apple_script->append("delay 1");
    $apple_script->end_system_event();
    $apple_script->run();
	$self->_select_path_in_finder($file_path);
}

sub wait_for_scan_complete {
    my ($self) = @_;
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("repeat while exists button \"$btn_stop_scan\" of group 3 of group 1 of splitter group 1 of window 1 of application process \"$app_name\"");
    $apple_script->append("delay 1");
    $apple_script->append("end repeat");
    $apple_script->end_system_event();
    $apple_script->run();
}
1;
