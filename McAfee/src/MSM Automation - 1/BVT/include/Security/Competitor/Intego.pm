# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Security::Competitor::Intego;

our @ISA = qw(Security::Competitor);
use strict;
use Security::Competitor;


sub new {
    my ($package) = @_;
    my $self = Security::Competitor->new();
    bless $self, $package;
    $self->{'process'} = ['virusbarriers', 'virusbarrierl', 'virusbarrierd', 'virusbarrierb',
                          'VirusBarrier XS','NetBarrier Daemon XS','IntegoStatusItemHelper',
                          'integod', ];
    $self->{'product_path'} = [ '/Applications/NetBarrier Monitor.app', '/Applications/NetBarrier X5.app',
			        '/Applications/VirusBarrier X5.app', '/Library/Application Support/Intego',
                                '/Library/StartupItems/NetBarrierKPI','/Library/Preferences/Intego',
                                '/Library/Intego','/Library/Frameworks/IntegoiCalFramework.framework',

                                '/Library/LaunchDaemons/com.intego.VirusBarrier.daemon.plist',
                                '/Library/LaunchDaemons/com.intego.VirusBarrier.logger.daemon.plist',
                                '/Library/LaunchDaemons/com.intego.VirusBarrier.scanner.daemon.plist',
                                '/Library/LaunchDaemons/com.intego.commonservices.daemon.plist',
                                '/Library/LaunchDaemons/com.intego.netbarrier.daemon.plist',
                                '/Library/LaunchDaemons/com.intego.task.manager.daemon.plist',
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
    use Data::Dumper; print Dumper($_[0]->{'product_path'} );
    return $_[0]->{'product_path'};
}

sub get_dat_paths { return []; }
# We don't know that dude :-) }

sub get_product_process {
    return $_[0]->{'config'}->{'process'};
}

sub is_service_running {
    my ($self) = @_;
    my $ra_samples = $system->get_task_list({'duration'=>1);
    my $rh_resource_stats = { };
    my $rh_processes = $rh_sample->[0]->{'processes'};
    my $instances = grep { $_ =~ /virusbarriers/ } keys %$rh_processes;
    return $instances == 3;
}

1;
