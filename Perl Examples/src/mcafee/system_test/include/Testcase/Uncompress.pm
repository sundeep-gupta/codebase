package Testcase::Uncompress;
use strict;
use Testcase;
our @ISA = ('Testcase');
sub new {
	my ($package, $rh_config, $log, $msm) = @_;
	my $self = Testcase->new($rh_config, $log, $msm);
	bless $self, $package;
	return $self;
}

sub init {
	my ($self) = @_;

	# Do product specific checks here...

	# Test data checks.
	rmdir $self->{'config'}->{'target'} if -e $self->{'config'}->{'target'};
}


sub execute {
	my ($self) = @_;
	my $source = $self->{'config'}->{'source'};
	system("tar -xf $source ");

}

sub clean {
	my ($self) = @_;
	rmdir $self->{'config'}->{'target'} if -e $self->{'config'}->{'target'}  ;
}


1;
