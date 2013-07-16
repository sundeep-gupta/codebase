package Testcase::LaunchConsole;
use strict;
use MSMConst;
use Testcase;

our @ISA = ('Testcase');
sub new {
	my ($package, $rh_config, $log, $msm, $result_log) = @_;
	my $self = Testcase->new($rh_config, $log, $msm);
    $self->{'result_log'} = $result_log if $result_log;
	bless $self, $package;
	return $self;
}

sub init {
	my ($self) = @_;
    &AppleScript::close_application('McAfee Security');   
}

sub clean {
    my ($self) = @_;
    &AppleScript::close_application('McAfee Security');   
}

sub execute {
    my ($self) = @_;
    my $start_time    = time();
    &AppleScript::launch_application('McAfee Security'); 
    $self->{'result_log'}->append( {'LaunchConsole' => time() - $start_time} )
		if $self->{'result_log'};
    
}
1;
