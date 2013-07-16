package Security::McAfee::Mac;

##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091124 : Created
##############################################################
use strict;
use AppleScript;
use Security::McAfee::Mac::Const;
use Security::McAfee::Mac::Config;
use Security::McAfee::Mac::GUI;
use PListReader;
use File::Basename qw/basename/;
use File::Find;
use File::Copy;

sub new {
    my ($package) = @_;
    my $self = {};
    bless $self, $package;
    $self->_load_config($Security::McAfee::Mac::config);
    return $self;
}

sub _load_config {
    my ($self, $config) = @_;;
    foreach my $key (keys %$config ) {
        $self->{$key} = $config->{$key};
    }
}

sub get_install_check { return $_[0]->{'install_check'};}
######################## SELECT THE VARIOUS TEXTFILEDS on RIGHT ########################
sub get_product_process { return $_[0]->{'process'}; } 
sub get_product_paths { return $_[0]->{'product_paths'}; } 
sub get_dat_paths     { return $_[0]->{'dat_paths'}; } 

sub is_installed {
    my ($self) = @_;
    my $ra_prod_paths = $self->get_product_paths();
    foreach my $prod_path (@$ra_prod_paths) {
	unless (-e $prod_path) {
		$self->{'log'}->error("$prod_path not found during install check") if $self->{'log'};
		return 0;
	}
    }
    return 1;
}

sub is_fm_installed {
    my ($self, $fm_name) = @_;
    my $fm_path = $self->{'root_dir'}."/". $self->{'fmp_config_path'}."/$fm_name";
    return ( -e $fm_path and -e "$fm_path/FMConfig.xml");
}

######################## TO START / STOP / RESTART / CHECK Services ####################
sub is_service_running {
    my ($self,$service) = @_;
    $service ||= 'VShieldScanner';
    my $system = &System::get_object_reference();
    my $rh_ps = $system->get_all_process();
 	return ( grep  {$_ =~ /$service/} keys( %$rh_ps) );
}

sub is_all_service_running {
    my ($self) = @_;
    my $ra_services = $self->{'primary_services'};
    foreach my $service ( @$ra_services) {
        return $FALSE unless $self->is_service_running($service);
    }
    return $TRUE;
}


sub is_update_running { return $_[0]->is_service_running( $_[0]->{'update_service'} ); }
sub load_scanner      { &System::get_object_reference()->load_plist($_[0]->{'scanner_plist'}); } 
sub unload_scanner    { &System::get_object_reference()->unload_plist($_[0]->{'scanner_plist'}); }
sub fmp_start { &System::get_object_reference()->execute_cmd( $_[0]->{'root_dir'}."/".$_[0]->{'fmp_bin_path'}."/fmp start 2>&1"); }
sub fmp_stop  { &System::get_object_reference()->execute_cmd( $_[0]->{'root_dir'}."/".$_[0]->{'fmp_bin_path'}."/fmp stop  2>&1"); }
sub fmp_reload  { &System::get_object_reference()->execute_cmd( $_[0]->{'root_dir'}."/".$_[0]->{'fmp_bin_path'}."/fmp reload  2>&1"); }



sub delete_quarantine { 
    my ($self) = @_;
    $self->add_fm('qatt') unless $self->is_fm_installed('qatt');
    my $qatt_bin = $self->{'tools'}->{'qatt'}->{'bin'};
    while ( 1) {
        my $ra_qid = $self->_get_quarantine_ids();
        last if scalar @$ra_qid == 0;
        my $quids = join( ' ', @$ra_qid );
        &System::get_object_reference()->execute_cmd("sudo $qatt_bin 7 $quids");
        sleep 2;
    }
} 

sub _get_quarantine_ids {
    my ($self) = @_;
    my $qatt_bin = $self->{'tools'}->{'qatt'}->{'bin'};
    my @output = &System::get_object_reference()->execute_cmd("$qatt_bin 6");
    chomp @output;
    my $ra_ids = [];
    # assuming the file does not have space in between 
    foreach my $line ( @output ) {
        $line =~ s/\s+$//; $line =~ s/^\s+//; $line =~ s/\s+/ /;
        my $id =(split ( ' ', $line))[1]; 
        push @$ra_ids, $id if $id and $id =~ /^(\d+)$/;
    }
    return $ra_ids;
}



sub verify_oas {
    my ($self, $file_to_check) = @_;
    my $log = $self->{'log'};	
    my $result = 0;
    my $rh_oas_pref = $self->get_oas_pref();
    my $ra_excl = $rh_oas_pref->{'OAS_Exclusion_List'};
    # If in Excl List File must exist 
    if ( scalar @$ra_excl > 0 and 
         grep { $file_to_check =~ /^$_/; } @$ra_excl ) {
         $log->info("File in exclusion list!");
        return -e $file_to_check ;
    }


    # For Quarantine
    if ( $rh_oas_pref->{'OAS_AV_ScannerSecondaryAction'} eq 3 ) {
        # File must not be present and quarantine file must be there
        unless ( -e $file_to_check ) {
            $log->info("Secondary action - quarantine, $file_to_check not found!");
            
            File::Find::find( {'no_chdir' => 1, 
                               'wanted'  => sub { $result = 1 if $File::Find::name =~ /\.file$/; } }, 
                               '/Quarantine' );
           }
    } elsif ( $rh_oas_pref->{'OAS_AV_ScannerSecondaryAction'} eq 2 ) {
        # File must not be there and no quarantine
        unless ( -e $file_to_check ) {
            $log->info("Secondary action delete, $file_to_check not found !");
            File::Find::find( {'no_chdir' => 1, 
                               'wanted'  => sub { $result = 1 unless $File::Find::name =~ /\.file$/; } }, 
                               '/Quarantine' );
        }
    }
    # TODO: Check for other preference settings also 
    return $result;
}


sub verify_ods {
    my ($self, $file_to_check ) = @_;
    my $rh_ods_pref = $self->get_ods_pref();
    my $log = $self->{'log'};
    my $result      = 0;
    my $ra_excl = $rh_ods_pref->{'ODS_Exclusion_List'};
    # If in Excl List File must exist 
    if ( scalar @$ra_excl and grep { $file_to_check =~ /^$_/; } @$ra_excl ) {
        $log->info("Verify : File found in exclusion list");
        return -e $file_to_check;
    }
    
    # For Quarantine
    if ( $rh_ods_pref->{'ODS_AV_ScannerSecondaryAction'} eq 3 ) {
        # File must not be present and quarantine file must be there
        unless ( -e $file_to_check ) {
            $log->info("$file_to_check does not exist!");
            File::Find::find( {'no_chdir' => 1, 
                               'wanted'  => sub { $result = 1 if $File::Find::name =~ /\.file$/; } }, 
                               '/Quarantine' );
           }
    } elsif ( $rh_ods_pref->{'ODS_AV_ScannerSecondaryAction'} eq 2 ) {
        # File must not be there and no quarantine:1

        unless ( -e $file_to_check ) {
            $log->info("$file_to_check does not exist!");
            File::Find::find( {'no_chdir' => 1, 
                               'wanted'  => sub { $result = 1 unless $File::Find::name =~ /\.file$/; } }, 
                               '/Quarantine' );
        }
    }
    return $result;
    # TODO: Check for other preference settings also 
}




sub get_pids {
    my ($self) = @_;
    my $ra_process = $self->{'process'};
    my $rh_process = &System::get_object_reference()->get_process();
    # Get top command output
    my @pids = ();
    foreach my $line ( keys %$rh_process ) {
        my $proc = '';
        foreach my $process ( @$ra_process) {
            next unless $line =~ /$process/;
            $proc = $process;
        }
        next if $proc eq '';
        my $ra_pids = $rh_process->{$line};
        foreach my $pid ( @$ra_pids) {
            push @pids, { 'pid'=> $pid, 'name' => $proc};
        }
    }
    return \@pids; 
}

########################## METHODS RELATED TO TOOLS ###############################
sub set_product_pref {
    my ( $self, $rh_pref) = @_;
    unless ( $rh_pref ) {
		$self->{'log'}->warning("No preferences passed to set");
	}
	foreach my $tool ( keys %$rh_pref ) { 
	    # Check if the tool is existing 
		my $tool_bin = $self->{'tools'}->{$tool}->{'bin'};
		unless ($tool_bin and -e $tool_bin) {
			$self->{'log'}->error("There is no binary for $tool : $tool_bin!!");
			return;
		}
		# Check and install the tool
		unless ( $self->is_fm_installed($tool) ) { 
			$self->{'log'}->info("Installing the FM : $tool");
        	$self->add_fm($tool)
 		}
		# Run all the commands using the tool
		my $ra_cmd  = $rh_pref->{$tool};
		foreach my $cmd ( @$ra_cmd) {
                    print "$tool_bin $cmd\n";
                    $self->{'log'}->info("CMD: $tool_bin $cmd");
			&System::get_object_reference()->execute_cmd("$tool_bin $cmd >> /dev/null 2>&1");
                    sleep 10;
	            # TODO: Check if preference is set or not
                    # my $rh_pref = $self->_get_plist_keys('am_pref', [$key]);
		    # last if ( $rh_pref->{$key} eq $value);
		}
	}
}

sub reset_to_defaults {
    my ($self) = @_;
    $self->set_am_default();
    $self->set_fw_default();
    $self->set_ap_default();
}
sub set_ap_default {
	my ($self) = @_;
	return unless ($self->is_fm_installed("AppProtection"));
	# TODO : Set back to ap default settings
	$self->add_fm('aptt') if not $self->is_fm_installed('aptt');
	my $cmd = $self->{'tools'}->{'aptt'}->{'bin'} . ' 5 0 0 0 0 2>&1';
	&System::get_object_reference()->execute_cmd("sudo $cmd");
	sleep 2;
}
sub set_fw_default {
	my ($self) = @_;
	return unless ($self->is_fm_installed("Firewall"));
	$self->add_fm('fwtt') if not $self->is_fm_installed('fwtt');
	my $cmd = $self->{'tools'}->{'fwtt'}->{'bin'} . ' 5 0 0 0 0 2>&1';
	&System::get_object_reference()->execute_cmd("sudo $cmd");
	sleep 2;
}
sub set_am_default {
    my ( $self ) = @_;
    return unless ($self->is_fm_installed("VShieldService"));
    $self->add_fm('qatt' )if not $self->is_fm_installed('qatt');
    my $system = &System::get_object_reference();
    my $command = $self->{'tools'}->{'qatt'}->{'bin'} . ' 5 2>&1';
    $system->execute_cmd("sudo $command "); sleep 2;
}



sub _get_plist_keys {
    my ( $self, $plist, $ra_keys) = @_;
    $self->{'plist_'.$plist} = PListReader->new ( $self->{$plist});
    return $self->{'plist_'.$plist}->get_keys( $ra_keys );
}

sub get_dat_version { return $_[0]->_get_plist_keys( 'am_pref', [ 'Update_DATVersion' ] ); }
sub get_oas_pref    { 
    return $_[0]->_get_plist_keys( 'am_pref',
                                  [ 'OAS_AV_ScannerSecondaryAction','OAS_AV_ScannerPrimaryAction',   
                                    'OAS_Exclusion_List', 'OAS_ScanOnRead', 'OAS_ScanOnWrite', 
                                    'OAS_ScanArchive','OAS_ScanMail',   'OAS_ScanNetwork',  
                                    'OAS_Enable',
                                 ] );
} 
sub get_ods_pref { 
    return $_[0]->_get_plist_keys( 'am_pref', [ 'ODS_AV_ScannerSecondaryAction',
            'ODS_AV_PrimaryAction', 'ODS_Exclusion_List', 'ODS_ScanArchive', 'ODS_ScanMail',
    ] );
} 


sub _load_test_tools {
    my ($self ) = @_;
    my $dir = $self->{'tools_dir'};
    opendir ( my $dh, $dir );
    my @list = readdir($dh);
    closedir $dh;
    foreach my $fm ( @list) {
        next unless -e "$dir/$fm/FMConfig.xml" ;
        $self->add_fm( $fm );
    }
}


sub add_fm {
    my ($self, $tool) = @_;
#    return ; # For soak and stress no fm module addition
    my $fm_bin = $self->{'tools'}->{$tool}->{'bin'};
	unless ( $fm_bin and -e $fm_bin ) {
		$self->{'log'}->error("bin for FM, $tool, is not found!");
		return ;
	}
	my $fm_config = $self->{'tools'}->{$tool}->{'config'};
	my $fm_config_base =  &File::Basename::basename($fm_config);
	unless ($fm_config and -e $fm_config) {
		$self->{'log'}->error("config for FM, $tool, is not found!");
		return ;
	}

    my $system = &System::get_object_reference();
    my $install_dir = $self->{'root_dir'}."/".$self->{'fmp_config_path'}."/".$tool;
    
    if ( -e $install_dir ){
		$self->{'log'}->info("FM already installed. Uninstalling");
        $system->remove_dir( $install_dir);
    }
    
    $system->mkdir($install_dir);
	
    $system->copy( { 'source' => $fm_config,
                     'target' => $install_dir } );
    $system->chmod( { 'permission' => 0700,
			'path' => $install_dir."/".$fm_config_base } );

    $self->fmp_reload();
    sleep 10 ; # For fmp to come up
     # TODO :add check to see if your config is loaded or not.
}

sub get_fw_rules {
	my ($self) = @_;
	$self->add_fm('fwtt') unless $self->is_fm_installed('fwtt');
	my $system = &System::get_object_reference();
	my $out = $system->execute_cmd($self->{'tools'}->{'fwtt'}->{'bin'} . ' 1');
	return ($out);
}

### TODO : This is a temporary method for deletion of FW rules
### A more clinical method needs to be implemented.

sub get_fw_rule_ids {
     my ($self) = @_;
     $self->add_fm('fwtt') unless $self->is_fm_installed('fwtt');
     my $system = &System::get_object_reference();
     my $cmd = $self->{'tools'}->{'fwtt'}->{'bin'} . ' 1';
     my @arr = split('\n',$system->execute_cmd("$cmd"));
     my $flag = 0;
     my @fw_data;
     foreach (@arr) {
         if ($flag == 1) {
            push(@fw_data,$_);
            $flag = 0;
         }
         if ($_ =~ /FWBasicData/) {
             $flag = 1;
         }
         next;
     }
     my $fw_rules;
     foreach my $rule (@fw_data) {
         $rule =~ s/\[//;
         $rule =~ s/\]//;
         $rule =~ s/^\s+//;
         my @tmp = split('\s+',$rule);
         $fw_rules .= "$tmp[0] ";
     }
     return ($fw_rules);
}

sub delete_fw_rules {
    my ($self) = @_;
    my $fw_rule_ids = $self->get_fw_rule_ids();
    #my $cmd = $self->{'tools'}->{'fwtt'}->{'bin'} . " 4 $fw_rule_ids";
    #&System::get_object_reference()->execute_cmd("sudo $cmd");
    &System::get_object_reference()->execute_cmd("$self->{'tools'}->{'fwtt'}->{'bin'} 4 $fw_rule_ids > /dev/null") if ($fw_rule_ids);
}
### TODO : This is a temporary method for deletion trusted groups
### A more clinical method needs to be implemented.

sub get_trusted_groups {
    my ($self) = @_;
    my $system = &System::get_object_reference();
    my @fw_out = split('\n',$system->execute_cmd($self->{'tools'}->{'fwtt'}->{'bin'} . ' 8'));
    my @trusted_groups;
    foreach my $line (@fw_out) {
        if ($line =~ /\[/) {
            my @tmp = (split(']',$line));
            $tmp[0] =~ s/\]//;
            $tmp[0] =~ s/\[//;
            push(@trusted_groups, $tmp[0]);
        } else { next;}
    }
    return (@trusted_groups);
}
 
sub delete_trusted_list {
     my ($self) = @_;
     my @trusted_groups = $self->get_trusted_groups();
     foreach (@trusted_groups) {
          &System::get_object_reference()->execute_cmd($self->{'tools'}->{'fwtt'}->{'bin'} . " 12 $_ > /dev/null") if ($_ !~ /McAfee/);
     }
}

sub get_app_preferences {
     my ($self) = @_;
     return(&System::get_object_reference()->execute_cmd($self->{'tools'}->{'aptt'}->{'bin'} . ' 20004'));
}

sub get_app_exclusions {
     my ($self) = @_;
     return(&System::get_object_reference()->execute_cmd($self->{'tools'}->{'aptt'}->{'bin'} . ' 20006'));
}


###########################################################################
#               Application protection related methods
###########################################################################
sub get_excluded_app_names {
    my ($self) = @_;
    use Data::Dumper;
    print Dumper( $self->_get_plist_keys( 'ap_pref', [ 'Exclusions' ] ) ); 
    return $self->_get_plist_keys( 'ap_pref', [ 'Exclusions' ] );
}

sub is_appprot_enabled {
    my ($self) = @_;
    use Data::Dumper;
    print Dumper( $self->_get_plist_keys( 'ap_pref', [ 'EnableAppProtection' ] ) ); 
    return $self->_get_plist_keys( 'ap_pref', [ 'EnableAppProtection' ] );
}

sub get_other_app_pref {
    my ($self) = @_;
    use Data::Dumper;
    print Dumper( $self->_get_plist_keys( 'ap_pref', [ 'UnknownAppAction' ] ) ); 
    return $self->_get_plist_keys( 'ap_pref', [ 'UnknownAppAction' ] ); 
}

sub delete_app_rules {
    my ($self) = @_;
    my @app_rules = $self->get_app_rules();
    foreach (@app_rules) {
        chomp($_);
        $_ =~ s/AppGroup \=//;
        $_ =~ s/ExecAllowed \=//;
        $_ =~ s/Enabled \=//;
        $_ =~ s/NwAction \=//;
        $_ =~ s/yes/1/g;
        $_ =~ s/no/0/g;
        &System::get_object_reference()->execute_cmd($self->{'tools'}->{'aptt'}->{'bin'} . " 20001 $_");
    }
}

sub get_app_rules {
    my ($self) = @_;
    my $output = &System::get_object_reference()->execute_cmd($self->{'tools'}->{'aptt'}->{'bin'} . ' 20003');
    chomp($output);
    my @rules;
    my $rule;
    my @lines = split("\n",$output);
    my $rule_flag = 1;
    foreach $_ (@lines) {
        chomp($_);
        if ($_ =~ /AppGroup/) {
            $rule .= "$_ ";
            $rule_flag = 0;
        }
        if ($_ =~ /ExecAllowed/ && $rule_flag == 0) {
            $rule .= "$_ ";
            $rule_flag = 1;
            push (@rules, $rule);
        }
    }
    return(@rules);
}

################################################################################
#                  METHODS TO CLEAN / CHECK / BACKUP Logs and Crashes          #
################################################################################
sub get_log_paths { return $_[0]->{'logs'}; }
sub get_crash_paths { return $_[0]->{'crash'};}

# Clears all the logs and writes 0 byte file
sub clear_logs	{
    my ($product) = @_;
    my $ra_log_paths = $product->get_log_paths();
    foreach my $log (@$ra_log_paths) {
        open(my $lh, "> ".$log); close($lh);
    }
}

# Copies the logs into the given directory
sub backup_logs {
    my ($product, $backup_dir) = @_;
    my $ra_log_paths = $product->get_log_paths();
    mkdir $backup_dir unless -e $backup_dir;
    foreach my $log (@$ra_log_paths) {
        &File::Copy::copy($log, "$backup_dir/". basename($log) );
    }
}

# Copies the logs into the given directory
sub backup_crashes {
    my ($product, $backup_dir) = @_;
    mkdir $backup_dir unless -e $backup_dir;

    my $ra_crash_paths = $product->get_crash_paths(); 
    foreach my $crash_path (@$ra_crash_paths) {        
    	$product->{'log'}->info("Backing crash logs from $crash_path to $backup_dir");
    	my $cmd = 'sudo cp -LR '.  $crash_path . "\/*.crash ".$backup_dir;
    	&System::get_object_reference()->execute_cmd("$cmd"); 
    }
}

# Return TRUE if the crash is found. FALSE otherwise
sub check_crashes {
    my ($self) = @_;
    my $ra_crash_paths = $self->get_crash_paths();
    my $crash_found = $FALSE;

    foreach my $crash_path (@$ra_crash_paths ) {
        &File::Find::find({'no_chdir' => 1,
         'wanted' => sub {
              $crash_found = $TRUE if $File::Find::name =~ /\.crash$/;
         }
        },$crash_path) if -d $crash_path;
        last if $crash_found;
    }

    return $crash_found;
}

# Method to clean crash logs
# TODO: What if the crash is symlink. We need to fix that
sub clear_crashes {
    my ($self) = @_;
    my $ra_crash_paths = $self->get_crash_paths();
    
    foreach my $crash_path ( @$ra_crash_paths ) {
    	$self->{'log'}->info("Clearing crash logs from $crash_path ...\n");
    	my $cmd = 'sudo rm -f '.  $crash_path . "\/*.crash";
    	&System::get_object_reference()->execute_cmd("$cmd"); 
    }    
}


################################################################################

sub check_fw_default_pref {
    my ($self) = @_;
    $self->add_fm('fwtt') unless $self->is_fm_installed('fwtt');

    my $fw_rules = $self->get_fw_rules();
    my @trusted_groups = $self->get_trusted_groups();
    print $fw_rules,"\n\n";
    print @trusted_groups;
    if (($fw_rules =~ /isUnknownTrafficBlocked \: 0/ && scalar(@trusted_groups) == 1)) { return 1} else {return 0} ;
}

sub check_ap_default_pref {
    my ($self) = @_;
    my $rh_ap_pref = $self->_get_plist_keys( 'ap_pref', ['EnableAppProtection',
                                            'UnknownAppAction', 'AllowAppleSignedApps','Exclusions']);
    if ( $rh_ap_pref->{'UnknownAppAction'} == 1 and
         $rh_ap_pref->{'AllowAppleSignedApps'} == 1 and
         $rh_ap_pref->{'EnableAppProtection'} == 1 and
         scalar @ { $rh_ap_pref->{'Exclusions'} } == 0 and
         ( not -e '/usr/local/McAfee/AppProtection/var/profile.data' or
         -z '/usr/local/McAfee/AppProtection/var/profile.data') ){
          return 1;
         }
     return 0;
}

sub check_am_default_pref {
    my ($self) = @_;
    my $rh_pref = $self->_get_plist_keys( 'am_pref', ['Exclusion_Enable',
                                            'OAS_AV_ScannerPrimaryAction',
                                            'OAS_AV_ScannerSecondaryAction',
                                            'OAS_Spyware_ScannerPrimaryAction',
                                            'OAS_Spyware_ScannerSecondaryAction',
                                            'ODS_Spyware_ScannerPrimaryAction',
                                            'ODS_Spyware_ScannerSecondaryAction',
                                            'ODS_AV_ScannerPrimaryAction',
                                            'ODS_AV_ScannerSecondaryAction',

                                            'OAS_Enable',
                                            'OAS_EnableScanBooster',
                                            'ODS_ScanMail',
                                            'ODS_ScanArchive',
                                            'OAS_ScanMail',
                                            'OAS_ScanNetwork',
                                            'OAS_ScanArchive',
                                            'OAS_ScanOnRead',
                                            'OAS_ScanOnWrite',
                                            'OAS_ScanTimeout',
                                            'OAS_Exclusion_List',
                                            'ODS_Exclusion_List',
                                            ]);

    if (
         $rh_pref->{'Exclusion_Enable'} == 1 and
         $rh_pref->{'OAS_AV_ScannerPrimaryAction'} == 1 and
         $rh_pref->{'OAS_AV_ScannerSecondaryAction'} == 3 and
         $rh_pref->{'OAS_Spyware_ScannerPrimaryAction'} == 1 and
         $rh_pref->{'OAS_Spyware_ScannerSecondaryAction'} == 3 and

         $rh_pref->{'ODS_Spyware_ScannerPrimaryAction'} == 1 and
         $rh_pref->{'ODS_Spyware_ScannerSecondaryAction'} == 3 and
         $rh_pref->{'ODS_AV_ScannerPrimaryAction'} == 1 and
         $rh_pref->{'ODS_AV_ScannerSecondaryAction'} == 3 and

         $rh_pref->{'OAS_Enable'} == 1 and
         $rh_pref->{'OAS_EnableScanBooster'} == 1 and
         $rh_pref->{'ODS_ScanMail'} == 1 and
         $rh_pref->{'ODS_ScanArchive'} == 1 and
         not $rh_pref->{'OAS_ScanMail'} and
         not $rh_pref->{'OAS_ScanNetwork'} and
         not $rh_pref->{'OAS_ScanArchive'}  and

         not $rh_pref->{'OAS_ScanOnRead'} and
         $rh_pref->{'OAS_ScanOnWrite'} == 1 and

         $rh_pref->{'OAS_ScanTimeout'} == 45 and

         scalar @ { $rh_pref->{'OAS_Exclusion_List'} } == 0 and
         scalar @ { $rh_pref->{'ODS_Exclusion_List'} } == 0  ){
          return 1;
         }
     return 0;
}

1;
