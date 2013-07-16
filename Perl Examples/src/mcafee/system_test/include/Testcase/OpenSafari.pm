package Testcase::OpenSafari;
use strict;
use MSMConst;
use AppleScript;
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
    &AppleScript::close_application('Safari'); 	
}

sub clean {
    my ($self) = @_;
}

sub execute {
    my ($self) = @_;  
    my $start_time    = time();
    &AppleScript::launch_application('Safari'); 
    &AppleScript::close_application('Safari');
    $self->{'result_log'}->append({'OpenSafari' => time() - $start_time} );
    return;    
}
1;
