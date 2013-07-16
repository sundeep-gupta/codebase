package Testcase::InstallMSM;
use strict;
use MSMConst;
use AppleScript;
use Testcase;

our @ISA = ('Testcase');
sub new {
	my ($package, $rh_config, $log, $msm, $result_log) = @_;
	my $self = Testcase->new($rh_config, $log, $msm);
	bless $self, $package;
    $self->{'result_log'} = $result_log if $result_log;
	return $self;
}

sub init {
    my ($self) = @_;
    my $log = $self->{'log'} ;
    $log->info("Check and remove prev versions") if $log;
    &uninstall_msmc (); 
}

sub execute {
    my ($self) = @_;
    my $run = $_[0];
    my $build_file = $self->{'config'}->{'build_file'};
    my $result_log = $self->{'result_log'};
    my $time = 0;

    if ($self->{'config'}->{'capture_cpu_memory'} ) {
	my $thr_install = threads->create('_install', $self);
	$time = &_capture_cpu_metric_on_thread($self, $thr_install);
    } else {
         my $time     = $self->_install(); 
	 $result_log->append( { "InstallMSM" => $time });
    }
}
 
###############################################################################################################
# Description : Install McAfee Security product with the given build.
# INPUT       : NONE
# RETURN      : A hash reference containing the memory and cpu stats
###############################################################################################################

sub _install {
    my ($self) = @_;
    my $build_file = $self->{'config'}->{'build_file'};
    my $msm = $self->{'msm'};
    my $start_time = time();
    my $log        = $self->{'log'};
    my $status = $msm->silent_install("$BUILD_DIR/MSM/$build_file");
    return time() - $start_time if $status;
   
    $log->info("Installation failed") if $log;
    return 0;
} 

sub _capture_cpu_metric_on_thread {
    my ($self, $thread) = @_;
    my $ra_resource_stats = [];
    my $sleep_time        = $self->{'config'}->{'capture_frequency'};
    my $log               = $self->{'log'};
    my $cpu_memory        = Resource::CPUMemory->new();
    my $result_log        = $self->{'result_log'};

    while($thread->is_running()) {
        $log->info("Capturing CPU Metrics") if $log;
	sleep $sleep_time;
	push @$ra_resource_stats, $cpu_memory->get();
    }
    $log->info("Waiting the thread to join") if $log;
    my $time = $thread->join();
    $log->info("Install thread joined") if $log;

    my $rh_resource_stats = &Result::average_result($ra_resource_stats);
    $rh_resource_stats->{'InstallMSM'} = $time;
    $result_log->append( $rh_resource_stats ) if $result_log;
}



###############################################################################################################
# Description : Uninstall McAfee Security
###############################################################################################################
sub uninstall_msmc {
 `/usr/local/McAfee/uninstallMSC  all > /dev/null 2>&1` if ( -e "/usr/local/McAfee/" );
} 





1;
