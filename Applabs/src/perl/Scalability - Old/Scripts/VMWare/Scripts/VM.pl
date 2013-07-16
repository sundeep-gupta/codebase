use XMLRPC::Lite;
use Frontier::Client;
use Data::Dumper;
my $cnt = 60;
my $val = 0;
for (my $i =0;$i<$cnt;$i++) {
	my $Response = XMLRPC::Lite->proxy("http://172.32.2.62:2050/RPC2")
		->call('Get', {Class => "SYSTEM", Attribute => "VMConsumption"})
		->result;
#	print Dumper($Response);

	$val +=$Response->{'VMConsumption'};
	sleep 1;
}
print 'Average VMConsumption - '.($val/$cnt);

