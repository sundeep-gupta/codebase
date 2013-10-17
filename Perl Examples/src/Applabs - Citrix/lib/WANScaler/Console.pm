package WANScaler::Console;
use Net::Telnet;

sub new {
	my $package = shift;
    my $options = shift;
    my $self = {};
    my $telnet = Net::Telnet->new(%$options);
    $self->{'TELNET'} = $telnet;
    bless $self,$package;
}
sub getlines {
	my $self = shift;
	return $self->{'TELNET'}->getlines();
}
1;