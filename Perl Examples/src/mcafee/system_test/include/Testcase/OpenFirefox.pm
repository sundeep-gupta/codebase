package Testcase::OpenFirefox;
use strict;
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
    &AppleScript::close_application('Firefox'); 
}

sub execute {
    my ($self) = @_;  
    my $start_time    = time();
    &AppleScript::launch_application('Firefox'); 
    &AppleScript::close_application('Firefox');
    $self->{'result_log'}->append({'OpenFirefox' => time() - $start_time} );
    return;    
}
1;
