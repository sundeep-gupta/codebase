package Testcase::AppProt;
use strict;
our @ISA = ('Testcase');
use Testcase;
use Stress::Util;

sub new {
    my ($package, $rh_config, $log, $msm, $result_log) = @_;
    my $self              = Testcase->new($rh_config, $log, $msm);
	$self->{'result_log'} = $result_log ;
    bless $self, $package;
    return $self;

}

sub execute {
	my ($self) = @_;
	
	&Stress::Util::open_url_in_safari("http://www.google.co.in");
	&Stress::Util::open_itunes(100);
	&Stress::Util::open_url_in_firefox("http://www.gmail.com/");
	&Stress::Util::open_ichat();

}

1;
