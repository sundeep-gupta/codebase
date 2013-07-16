package WANScaler::XmlRpc::ServiceClassPolicy;
use WANScaler::XmlRpc;
use vars qw(@ISA);
our @ISA = qw(WANScaler::XmlRpc);

sub new {
	my $package = shift;
    my $self = WANScaler::XmlRpc->new(@_);
    bless $self,$package;
}

sub get_service_class_policy {
	my $self = shift;
    my $service_class = shift;

}

sub get_service_classes {
	my $param = {"ClassID" => 0};
	my $response = $self->get("ServiceClassGet",$param);
    return $response;
}