package System::Darwin;
#############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################
use strict;
use System;
use Const;
use File::Fetch;
our @ISA = qw(System);

my $CMD_VMSTAT = 'vm_stat';
my $CMD_LSOF   = 'lsof -i -P | grep -i listen';
my $CMD_DF     = 'df -ahm';
my $CMD_TOP    = &_get_top_command();
my $SEP_TOP    = &_get_top_seperator();
my $CMD_LEAKS  = &_get_leaks_command();

sub new {
    my ($package) = @_;
    my $self = System->new();
    bless $self, $package;
    return $self;
}


sub installer {
    my ($self, $rh_options) = @_;
    my $build = $rh_options->{'package'} ;
    my $target = $rh_options->{'target'};
    my $command = "installer -pkg '$build' -target $target";
    my $out     = `$command 2>&1`;
}


sub shutdown {
    `halt`; sleep 100;
}

sub wait_till_cpu_idle {
    my ($self)    = @_;
    my $counter   = 0;
    my $idle_time = '';
    my $command = 'sar -u 1 ';
    while (1) {   
        my @output  = `$command`; chomp @output;
        foreach my $line (@output) {
	        next unless ($line =~ /^(\d\d):(\d\d):(\d\d)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)$/ );
            unless ($7 >= 60 ) {
			    $counter = 0;
				last;
			}
	        $idle_time = "$1:$2:$3"  unless $counter;
		    $counter++;
		    return $idle_time if $counter eq 5;
        } 
    }
}

sub reboot {
    `reboot`;
    sleep 10;
}

sub is_root {
    return ( $< == 0 );
}

sub is_system_admin {
    return ( $< == 0 );
}

sub vmstat {
    my @vm_stat = `$CMD_VMSTAT`;
    my $rh_data = {};
    foreach my $line (@vm_stat) {
        if( $line =~ /^"?(.*)"?:\s*(\d+)/ ) {
            $rh_data->{$1} = $2;
        }
    }
    return $rh_data;
}
sub leaks {
    my ( $self, $pid ) = @_;
    my @ra_leaks = `$CMD_LEAKS $pid 2>&1`;
    return \@ra_leaks;
}
sub open_ports {

    # We store 'command_output' in log file and also
    # count of open ports in another log file.
    my @ports_output = `$CMD_LSOF`;
    my $rh_data     = {};
    $rh_data->{'open_port_count'} = scalar @ports_output;
    $rh_data->{'command_output'}  = join('', @ports_output);
    return $rh_data;


}

sub open_files_on_process {
    my ($self, $process) = @_;
    my @output = `lsof -c $process`;
    return @output;
}

sub disk_usage {

    my @df_output = `$CMD_DF`;
    chomp @df_output;
    my $ra_df = [];
    
    foreach my $line (@df_output) {
        my $rh_df = {};
            if ($line =~ /^(.*?)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)%\s+(.+)$/) {
                my $file_system = $1; $file_system =~ s/\s+$//;
                $rh_df->{'Filesystem'} = $file_system;
                $rh_df->{'Blocks'}     = $2;
                $rh_df->{'Used'}       = $3;
                $rh_df->{'Available'}  = $4;
                $rh_df->{'Capacity'}   = $5;
                $rh_df->{'Mount'}      = $6;
                push @$ra_df, $rh_df;
            }; 
    }
    return $ra_df;
}

sub get_task_list {
    my ($self, $rh_options) = @_;
    my $duration = $rh_options->{'duration'} || 3;
    my $command = "$CMD_TOP -l $duration ";

    my @output = `$command`; chomp @output;

   my $raa_samples = &_get_samples( \@output );
   my $ra_parsed   = []; 
   foreach my $ra_sample ( @$raa_samples ) {
        push @$ra_parsed, &_parse_sample($ra_sample);
    }
    shift @$ra_parsed; # because first top sample does not have CPU usage
    return $ra_parsed;
}

sub _get_leaks_command {
    return 'leaks' if -e '/usr/bin/leaks';

    my $os_version = &get_os_version();
    if( $os_version eq '10.5') {
        return $LIB_DIR."/leaks_Leopard" if -e $LIB_DIR."/leaks_Leopard";
    }
    if ( $os_version eq '10.4') {
        return $LIB_DIR."/leaks_Tiger" if -e $LIB_DIR . "/leaks_Tiger";
    }
    return '';
}
sub _get_samples {
    my ($ra_output) = @_;
    
    my $raa_samples = [];
    my $ra_sample   = [];
    foreach my $line ( @$ra_output ) {
        if ( $line =~ /^Processes:/ ) {
            push @$raa_samples, $ra_sample if scalar @$ra_sample;
            $ra_sample = [];
        }
        push @$ra_sample, $line;
    }
    return $raa_samples;
}

sub _parse_sample {
    my ($ra_sample) = @_;
    my $tasks_started = 0;
    my $rh_parsed    = {};
    foreach my $line (@$ra_sample) {

        unless ( $tasks_started ) {

            if ($line =~ /COMMAND/ ) {
                $tasks_started = 1;
            }
            next;
        } 
        
        my ($cpu, $rsize, $rshrd, $vsize, $command ) = &_get_stats($line);
        unless ($command) {
            next;
        }
        if ( $rh_parsed->{'processes'}->{$command} ) {
            push @ { $rh_parsed->{'processes'}->{$command} } , 
                 { 'rsize' => $rsize, 'cpu' => $cpu, 'vsize' => $vsize, 'rshrd' => $rshrd };
        } else {
            $rh_parsed->{'processes'}->{$command} = [ { 
                                                        'rsize' => $rsize, 
                                                        'cpu'   => $cpu,
                                                        'vsize' => $vsize,
                                                        'rshrd' => $rshrd,
                                                        } ];
        }
    }
    return $rh_parsed;
}

sub _get_stats {
	my ($line) = @_;
    $line =~ s/\s+/ /g;
    my ($cpu, $rsize, $vsize, $rshrd, $command) = (split($SEP_TOP, $line) )[ 0,1,2,3,4];
    unless ($cpu and $rsize and $vsize and $rshrd and $command ) { return };
    $cpu =~ s/^\s*//; $rsize =~ s/^\s*//; $vsize =~ s/^\s*//; $rsize =~ s/^\s*//;
    $rsize = &_convert_to_bytes($rsize);
    $vsize = &_convert_to_bytes($vsize);
    $rshrd = &_convert_to_bytes($rshrd);
	return ($cpu, $rsize, $rshrd, $vsize, $command);

}

sub _convert_to_bytes {
	my ($metric)  = @_;
    if( $metric =~ /(\d+)(\w)[+|-]?/ ) {
	    $metric = $1;
		if ($2 eq 'K') {
			$metric *= 1024;
		} elsif ($2 eq 'M') {
			$metric *= 1024 * 1024;
		}
	} 
	return $metric;
}
sub get_os_version {
    my ($self);
    my $version = `defaults read /System/Library/CoreServices/SystemVersion ProductUserVisibleVersion`;
    chomp $version;
    return $version;
}
sub _get_top_command {
    my ($self) = @_;
    my $version = &get_os_version();
    chomp $version;
    if ($version =~ /^10.6/) {
        return 'top -stats cpu,rsize,vsize,rshrd,command ';
    } else {
   		return 'top -p \'$cccc:$jjjjjjjjjjjj:$llllllllllll:$iiiiiiiiiiii:^bbbbbbbbbbbbbbbbbbbb\'';
	}
}

sub _get_top_seperator {
    my ($self) = @_;
   my $version = &get_os_version();
   if ($version =~ /^10.6/) {
        return ' ';
   } else {
        return ':';
   }
}


########### AFP MOUNT - UNMOUNT 
sub mount_afp {
    my ($self, $options)  = @_;
    my $server   = $options->{'server'};
    my $user     = $options->{'user'};
    my $password = $options->{'password'};
    my $dir      = $options->{'server_dir'};
    my $target   = $options->{'mount'};
    mkdir($target);
    my $command = "mount -t afp afp://${user}:${password}\@${server}:/${dir} ${target}";
    return system($command);
}

sub unmount {
    my ($self, $target) = @_;
    return unless $target and -e $target;
    return system("umount $target");
}

sub scp {
    my ($self, $rh_option) = @_;
    my $source = $rh_option->{'source'};
    my $target = $rh_option->{'target'};
    system("scp $source $target");
}

sub load_plist {
    my ($self, $plist) = @_;
    return unless -e $plist;
    `launchctl load $plist`;
}

sub unload_plist {
    my ($self, $plist) = @_;
    return unless -e $plist;
    `launchctl unload $plist`;
}


sub create_tar {
    my ($self, $rh_options) = @_;
    my $target = $rh_options->{'tar_file'};
    my $source = $rh_options->{'source'};
    system("tar -cf $target $source");
}
sub extract_tar {
    my ($self, $source) = @_;
    system("tar -xf $source ");
}


sub start_service {
    my ($self, $path) = @_;
    `$path start`;
}

sub stop_service {
    my ($self, $path) = @_;
    `$path stop`;
}

sub reload_service {
    my ($self, $path) = @_;
    `$path reload`;
}

sub chmod {
    my ($self, $rh_param) = @_;
    my $perm = $rh_param->{'permission'};
    my $file = $rh_param->{'path'};
    chmod ($perm, $file);
}
sub build_download {                                                               
    my ($self,$rh_param) = @_;
    my $build_path = $rh_param->{'source'};
    my $target     = $rh_param->{'target'};
    $build_path =~ s/^\s+//;
    my $ff = File::Fetch->new(uri => "$build_path");
    my $where = $ff->fetch(to => "$target") or syswrite(\*STDERROR, $?); 
    require File::Basename;
    my ($basename, undef, $suffix) = &File::Basename::fileparse($build_path);
    return $target.'/'.$basename if -e $target.'/'.$basename;
}   
 
sub mount_dmg {    
    my ($self,$dmg_file) = @_;
    require File::Basename;
    my ($basename, undef, $suffix) = &File::Basename::fileparse($dmg_file);
    print $basename;

    system ("hdiutil attach '$dmg_file' -mountpoint '/Volumes/$basename' 2>&1"); 
    my $return = "/Volumes/$basename/$basename";
    $return =~ s/dmg$/mpkg/;
    return $return;
}

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

sub get_process { return $_[0]->get_all_process (); }
sub get_all_process {
    my ($self) = @_;

    my @output = `ps -ea -o 'pid' -o 'command'`;
    chomp @output;
    my $rh_process = {};
    foreach my $line ( @output) {
        next unless ( $line =~ /(\d+)\s+(.*)$/);
        if ( $rh_process->{$2} ) {
            push @{$rh_process->{$2}}, $1;
        } else {
            $rh_process->{$2} = [$1];
        }
    }
    return $rh_process;

}

# Checks if the process exist and return its PID(s)
# TODO : regex match.
sub query_process {
    my ($self, $proc) = @_;
    return unless $proc;
    my $rh_process = $self->get_all_process();
    my @pids = ();
    foreach my $process ( keys %$rh_process ) {
        if ( $process =~ /$proc/) {
            push @pids, @{$rh_process->{$process}};
        }
    }
    return @pids;
}
1;
