package Testcase::IdleTime;
use strict;
use Testcase;
use Resource::CPUMemory;
our @ISA = ('Testcase');
sub new {
    my ($package, $rh_config, $log, $msm, $result_log) = @_;
    my $self = Testcase->new($rh_config, $log, $msm);
    bless $self, $package;
    $self->{'result_log'} = $result_log if $result_log;
    return $self;
}


sub execute {
    my ($self) = @_;
    my $sleep_time = $self->{'config'}->{'sleep_time'};
    my $iterations = 15;
    my $rh_stats   = {};
    my $cpu_memory = Resource::CPUMemory->new();
    for(my $i = 0; $i < $iterations; $i++){
        sleep $sleep_time;       
        my $rh_stats   = $cpu_memory->get();
        $self->{'result_log'}->append( $rh_stats) if $self->{'result_log'};
    }
 
} 

1;
