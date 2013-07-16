use XMLRPC::Lite;
my $rpc = XMLRPC::Lite->proxy('http://localhost:7000/',timeout=>100);
    my $count = 0;
    my $result;
  syswrite(\*STDOUT,"Calling ".$method. "\n"),
   $response = $rpc->call('WANScaler.Test.test') if $rpc;
$response = $response->result();
#use Data::Dumper;
#print Dumper($rpc);
print $response;
print 'Done';
