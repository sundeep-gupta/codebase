package Testcase;


sub new {
    my ($package, $rh_config, $log, $msm) = @_;
    my $self = {'config'=> $rh_config, 'log' => $log, 'msm' => $msm };
    bless $self, $package;
    return $self;
}

sub execute {
	my ($self) = @_;

}

sub init {
	my ($self) = @_;

}

sub clean {
	my ($self) = @_;

}





1;
