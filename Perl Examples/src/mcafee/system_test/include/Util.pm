package Util;
##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2009, McAfee Limited. All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091116 : Created
##############################################################

use strict;
use MSMConst;
use File::Basename;


###############################################################################################################
# Description : Run system reboot command and wait for 100 seconds so that it does not return 
###############################################################################################################
sub reboot {
    system("reboot");
    sleep(100);
}

###############################################################################################################
# Description : Run the defaults command to add the given path to the list of login items of the user.
# INPUT       : file with absolute path which needs to be added to the login items.
# RETURN      : NONE
###############################################################################################################
sub add_login_item {
    return unless $_[0];
	my @out = `defaults read loginwindow | grep $_[0]`;
	chomp @out; 
	return unless scalar @out;
	system('defaults write loginwindow AutoLaunchedApplicationDictionary -array-add \'<dict><key>Hide</key><false/><key>Path</key><string>'.$_[0].'</string></dict>\'');

}

sub enable_auto_login {
	my @out = `defaults read /library/preferences/com.apple.loginwindow autoLoginUser`;
	chomp @out;
	return if $out[0] eq 'root';
	`defaults write /library/preferences/com.apple.loginwindow autoLoginUser root`;
}

###############################################################################################################
# Description : Check if the current user is root or not
##############################################################################################################
sub is_root {
    return ( $< == 0 );
}


###############################################################################################################
# Description : Clears the McAfee Security log. 
#               Also capture the virtual and real memory used by the list of process (McAfee Security product)
# INPUT       : NONE
# RETURN      : A hash reference containing the memory and cpu stats
###############################################################################################################
sub clear_scan_log {
    return unless -e '/usr/local/McAfee';
    open(my $fh, "> $MSM_SECURITY_LOG");
    close $fh;
}

sub save_syslogs {
    my $time = time();
    mkdir "$LOG_DIR/$time";
    `mv $SYSTEM_LOG $KERNEL_LOG $MSM_LOG $MSM_DEBUG_LOG $LOG_DIR/$time > /dev/null 2>&1`;
}


###############################################   cleanLogs   #################################################################
# Author : Pavan 
# Description : This method is to clean/backup the Logs like system.log, VirusScan.log, VirusScanDebug.log and install.log. In
# 		case the backup to be archived use backupCrashes method. i.e call backup method with 1 and the backup location as 
#		arguments. Mehtod call: backupCrashes(1,$location)
# Arguments : This method takes three arguments
#	arg1 : To clean/backup a specific log file.
#	arg2 : 0 - to remove the content from Log
#	     : 1 - to backup the log
#	arg3 : Only used for backup purpose. This is the path of the backup location.
###############################################################################################################################
sub clean_logs	{
    my ($product) = @_;
    
    my $ra_log_paths = $product->get_log_paths();
    foreach my $log (@$ra_log_paths) {
        open(my $lh, "> ".$log); close($lh);
    }
}



sub backup_logs {

    my ($product, $backup_dir) = @_;
    my $ra_log_paths = $product->get_log_paths();
    mkdir $backup_dir unless -e $backup_dir;
    foreach my $log (@$ra_log_paths) {
        &File::Copy::copy($log, "$backup_dir/". basename($log) );
    }

}





1;
