# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Security::Competitor::Norton;

our @ISA = qw(Security::Competitor);
use strict;
use Security::Competitor;
#use Security::Competitor::Const::Intego;


sub new {
    my ($package) = @_;
    my $self = Security::Competitor->new();
    bless $self, $package;
    $self->{'process'} = ['SymSchedulerDaemon', 'SymUIAgent', 'SymSharedSettingsd',
'SymSecondaryLaunch', 'SymSchedulerDaemon',
'SymDaemon', 'SymAVScanDaemon',
'NortonAutoProtect', 'Norton AntiVirus', 'NortonMissedTasks'];
                        
                       
    $self->{'product_path'} = [ '/Applications/Symantec Solutions',
                                '/Library/Application Support/Norton Solutions Support', '/Library/Application Support/Symantec','/Library/Contextual Menu Items/NAVCMPlugIn.plugin','/Library/Documentation/Help/Norton Help Scripts',

'/Library/LaunchDaemons/com.symantec.MissedTasks.plist',
'/Library/LaunchDaemons/com.symantec.avscandaemon.plist',
'/Library/LaunchDaemons/com.symantec.diskMountNotify.plist',
'//Library/LaunchDaemons/com.symantec.navapd.plist',
'/Library/LaunchDaemons/com.symantec.navapdaemon.plist',
'/Library/LaunchDaemons/com.symantec.symSchedDaemon.plist',
'/Library/LaunchDaemons/com.symantec.symdaemon.plist',
'/Library/LaunchDaemons/com.symantec.uiagent.plist',
'/Library/PreferencePanes/SymantecQuickMenu.prefPane',
'/Library/PrivateFrameworks/SymAVScan.framework',
'/Library/PrivateFrameworks/SymAppKitAdditions.framework',
'/Library/PrivateFrameworks/SymBase.framework',
'/Library/PrivateFrameworks/SymDaemon.framework',
'/Library/PrivateFrameworks/SymIPS.framework',
'/Library/PrivateFrameworks/SymIR.framework',
'/Library/PrivateFrameworks/SymInternetSecurity.framework',
'/Library/PrivateFrameworks/SymNetworking.framework',
'/Library/PrivateFrameworks/SymScheduler.framework',
'/Library/PrivateFrameworks/SymSharedSettings.framework',
'/Library/PrivateFrameworks/SymSystem.framework',
'/Library/PrivateFrameworks/SymUIAgent.framework',
'/Library/PrivateFrameworks/SymUIAgentUI.framework',
'/Library/Symantec',
 '/Library/Widgets/Symantec Alerts.wdgt',
'/System/Library/Extensions/SymIPS.kext',
'/System/Library/Extensions/SymInternetSecurity.kext',
'/etc/Symantec.conf',
'/etc/mach_init.d/SymSharedSettings.plist',
'/usr/bin/navx',

                             ];

    return $self;
}

#sub launch {
#    my ($self) = @_;
#    my $apple_script = AppleScript->new();
#    AppleScript::launch_application($app_name);
#}


sub perform_ods_scan {
    my ($self, $path) = @_;
    # TODO: Implemtation here
}

sub get_product_paths {
    return $_[0]->{'product_path'};
}

sub get_dat_paths { return []; }
# We don't know that dude :-) }

sub get_product_process {
    return $_[0]->{'config'}->{'process'};
}
1;
