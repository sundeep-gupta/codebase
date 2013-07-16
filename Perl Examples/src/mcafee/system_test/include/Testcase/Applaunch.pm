package Testcase::Applaunch;
use strict;
use Testcase;
use AppleScript;

our @ISA = ('Testcase');
sub new {
    my ($package, $rh_config, $log, $msm, $result_log) = @_;
    my $self              = Testcase->new($rh_config, $log, $msm);
    $self->{'result_log'} = $result_log if $result_log;
    bless $self, $package;
    return $self;
}
sub execute {
    my ($self)       = @_;
    my $ra_applications = $self->{'config'}->{'applications'};
    my $result_log       = $self->{'result_log'};
    my $total_time   = 0; 
    my $rh_apptime   = {};
    foreach my $app_name (@$ra_applications) {
        my $stime = time();
	&AppleScript::launch_close_application($app_name);
        my $time     = time() - $stime;
        $total_time += $time;
	$rh_apptime->{$app_name} = $time;
    }
    $result_log->append( { 'Applaunch' => $total_time } ) if $result_log;    
}

1;
