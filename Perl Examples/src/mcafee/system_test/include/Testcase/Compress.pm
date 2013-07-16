package Testcase::Compress;
use strict;
use MSMConst;

our @ISA = ('Testcase');
sub new {
    my ($package, $rh_config, $log, $msm) = @_;
    my $self = Testcase->new($rh_config, $log, $msm);
    bless $self, $package;
    return $self;
}

sub init {
	my ($self) = @_;
	unlink $self->{'config'}->{'target'} if -e $self->{'config'}->{'target'};
}


sub execute {
	my ($self) = @_;
	my $target = $self->{'config'}->{'target'};
	my $source = $self->{'config'}->{'source'};
	$source = "$DATA_DIR/$source";
	system("tar -cf $target $source");
}

sub clean {
    my ($self) = @_;
    unlink $self->{'config'}->{'target'};
}

1;
