# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Resource::CPUMemory;
use strict;
use Const;
use Log::Result::CPUMemory;
use System;
sub new {
    my ($package, $logfile, $ra_process) = @_;
    my $self = {};
    bless $self, $package;
    $self->{'resource_file'} = $logfile;
    $self->{'result_file'} = Log::Result::CPUMemory->new($logfile) if $logfile;
    $self->{'top_dump_file'} = "$LOG_DIR/top_command_dump.log";
    $self->{'process'}     = $ra_process;
    return $self;
}

sub get {
    my ($self) = @_;
    my $fh_results = $self->{'result_file'};
    my $ra_process = $self->{'process'};
    my $system     = &System::get_object_reference();
    my $ra_samples = $system->get_task_list();
    my $rh_resource_stats = { };
    foreach my $rh_sample ( @$ra_samples ) {
        my $rh_processes = $rh_sample->{'processes'};
        foreach my $process ( keys %$rh_processes ) {
            next unless grep { $_ =~ /$process/ or $process =~ /$_/; } @$ra_process;
            my $ra_instances = $rh_processes->{$process};
            for ( my $i = 0; $i < scalar @$ra_instances ; $i++ ) {
                my $rh_instance = $$ra_instances[$i];
                foreach my $key ( keys %$rh_instance ) {
                    $rh_resource_stats->{ "${process}_${i}_${key}" }   = $rh_instance->{$key};
                    if ( $rh_resource_stats->{"total_$key"} ) {
                        $rh_resource_stats->{ "total_$key"} += $rh_instance->{$key};
                    } else {
                        $rh_resource_stats->{ "total_$key" } = $rh_instance->{$key};
                    }
                }
            }
        }
    }
    $fh_results->append($rh_resource_stats) if $self->{'result_file'}; 
    return $rh_resource_stats;

}

1;
