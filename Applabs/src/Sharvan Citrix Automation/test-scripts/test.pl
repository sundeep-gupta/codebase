use XMLRPC::Lite;

#my $param = "CompressionClearTextBytes";
my $param = "CompressionCipherTextBytes";
my $response = XMLRPC::Lite->proxy("http://10.201.201.92:2050/RPC2")
	->call('Get', {Class => "SYSTEM", Attribute => $param})
	->result;
        
#my $res = XMLRPC::Lite->proxy("http://10.201.201.93:2050/RPC2")
#            ->call("ResetPerfCounters")
#            ->result;

if ( (element_exists(${$response}{$param})) && ( exists(${$response}{$param}{'Fault'})) ) {
      print "Fault returned by get_parameter\n";
      print %{$response} . "\n";
      exit;
}else {
	print $response->{$param}->{"Total"};
}


sub element_exists {
   my $potential_hash = shift;
   return (ref($potential_hash) eq "HASH");
}

