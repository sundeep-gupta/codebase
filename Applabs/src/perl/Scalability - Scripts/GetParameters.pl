use XMLRPC::Lite;

open(FH,'clients.txt');
@list = <FH>   ;
close(FH);

foreach $ip (@list) {
	syswrite(\*STDOUT,$ip);
	$response = XMLRPC::Lite->proxy("http://$ip:2050/RPC2")
    						->call('Get',{Class=>'PARAMETER',Attributes=>'System.VirtualClients'})
                            ->result;
	print $response;
}