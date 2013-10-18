use XMLRPC::Lite;
  $x= XMLRPC::Lite
      -> proxy('http://ddds1s91:1580')
      -> call('validator1.test', {})
      -> result;
print @{$x};


#use XMLRPC::Lite;

#$x = XMLRPC::Lite
#  -> proxy('http://ddds1s91/http-path/xml-rpc-server.cgi')
#  -> call('test', {})
#  -> result;

#  print @{$x};