package Testcase::Firewall;
use strict;
use MSMConst;
use Stress::Util;
use Testcase;

our @ISA = ('Testcase');

sub new {
    my ($package, $rh_config, $log , $msm, $result_log ) = @_;
    my $self = Testcase->new($rh_config, $log, $msm);
    bless $self, $package;
    $self->{'result_log'} = $result_log;
    return $self;

}

sub execute {
    my ($self)  = @_;
    my $ra_urls = $self->{'config'}->{'URLs'};
    my $ra_ping = $self->{'config'}->{'ping'};
    foreach my $url ( @$ra_urls) {
	&Stress::Util::open_url_in_firefox($url);
    }

    # run the ping commands
    foreach my $host (@$ra_ping) {
	system("ping -c 10 $host");
    }	
}
1;
