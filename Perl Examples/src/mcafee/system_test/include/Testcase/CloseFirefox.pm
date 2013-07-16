package Testcase::CloseFirefox;
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

sub execute {
    my ($self) = @_;
    &AppleScript::close_application('Firefox');   
    &AppleScript::launch_application('Firefox'); 
    sleep 3;
    my $start_time    = time();
    &AppleScript::close_application('Firefox');
    $self->{'result_log'}->append( {'CloseFirefox' => time() - $start_time })
		if $self->{'result_log'};
}    

1;
