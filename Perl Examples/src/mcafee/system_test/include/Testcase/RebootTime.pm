package Testcase::RebootTime;
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
    # Check if autologin is enabled or not ...	
}

sub clean {
    my ($self) = @_;
    my $time  = time();
    `echo $time > .prev_run_time`;
}

sub execute {
    my ($self)     = @_;
    return unless (-e ".prev_run_time" );
    my $result_log = $self->{'result_log'};
    open(my $fh, ".prev_run_time");
    my $prev_run_time = <$fh>; chomp $prev_run_time;
    close $fh;
    my $idle_time  = $self->_wait_till_idle()     ;
    $result_log->append( { 'RebootTime' => $idle_time - $prev_run_time } ) if $result_log;
} 




sub _wait_till_idle {
    my ($self)         = @_;
    my $counter        = 0;
    my $first_idletime = 0;
    my $log = $self->{'log'};

    while( $counter < 10 ) {
        my $cpu = `sar -u 1 1 | sed -n '4p'`;
        my ($time,$user,$nice,$sys,$idle)=split(/[ ]+ /,$cpu);
        unless ($idle >= 90 ) {
	    $counter = 0; 
            next;
        }
        $counter++;
        $first_idletime = time() if $counter == 1;
        $log->info( "Time : ".$time."    CPU Usage is : ".(100-$idle)."%") if $log;
    } 
    return $first_idletime;
}

1;
