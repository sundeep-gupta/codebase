use XMLRPC::Lite;
use Data::Dumper;
use Frontier::Client;

$ip = "10.201.201.92";
send_command("http://".$ip.":2050/RPC2",'CompressionHistory reset');

sub send_command() {
	my $url = shift;
	my $param = shift;

	my $Response = XMLRPC::Lite->proxy($url)
			->call('Command', $param)
			->result;
}