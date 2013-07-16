use Data::Dumper;
use XMLRPC::Lite;
$response = get_service_class_by_name('Telnet');
print Dumper($response);

sub enable_flow_control {
    my $name = shift;
    my $service_class =get_service_class_by_name($name);
    print Dumper($service_class);
    my $class_id 	  = $service_class->{'ClassID'};

    my $param = {'ClassID' => $class_id,
    			 'Policy'  => {'FlowControl' => ($service_class->{'Policy'}->{'FlowControl'} == 0) ? 1:0,
                 			   'Compression' => $service_class->{'Policy'}->{'Compression'},
                  			   'CompressionType' => $service_class->{'Policy'}->{'CompressionType'},
                 			   'ServiceQueue' => $service_class->{'Policy'}->{'ServiceQueue'},
                 			  }
                };
    print Dumper($param);
    my $response = call('ServiceClassSetPolicy',$param);
    return $response;

}
sub get_service_class_by_name {
    my $name = shift;
    my $response = &get_all_service_class;

    foreach $service (@$response) {
		return $service if ($service->{'ClassName'} eq $name);
    }
    return 'Service not found';
}

sub get_all_service_class  {
	return  __get_service_class(0);
}

sub __get_service_class {
   my $class = shift;
   my $response = call('ServiceClassGet',{'ClassID' => $class});
   return $response;
}
sub call {
   my $method = shift;
   my $args = shift;
   my $response = XMLRPC::Lite->proxy('http://10.199.32.62:2050/RPC2')
              ->call($method, $args)
              ->result;
   return $response;

}