package library;

use XMLRPC::Lite;
use LWP::Simple;
require Exporter;

our @ISA=qw(Exporter);
our @EXPORT=qw();
our @EXPORT_OK=qw();
our $VERSION=1.0;

sub config_orbitals {
	&set_parameter("10.1.1.4",'Compression.EnableCompression',1)
	&set_parameter("10.1.2.4",'Compression.EnableCompression',1)

	&set_parameter("10.1.1.4",'UI.Softboost',1);
	&set_parameter("10.1.2.4",'UI.Softboost',1);
}


sub set_parameter {
    chomp(my $ip = shift);
    chomp(my $param = shift);
    chomp(my $value = shift);

    my $url = "http://$ip:2050/RPC2";
    
	# Define our parameter names and values
    my $parameter_name = ($param) ? $param : "Parameter name not defined";
    my $parameter_value = (($value) || ($value == 0)) ? $value : "Parameter value not defined";

    print("Setting orbital [$ip] parameter: [$param] with value: [$value]\n");
    my $response =  XMLRPC::Lite
          ->proxy($url)
          ->call('Set', {Class => "PARAMETER", Attribute => $param, Value => eval($value) })
          ->result;

    if (defined(${$response}{'Fault'})) {
		print("${$response}{'Fault'}\n");
		print("Parameter couldn't be set");
		return 0;
    }
	else {
		print("Parameter set successfully\n");
		return 1;
	}		

}


1;

__END__
