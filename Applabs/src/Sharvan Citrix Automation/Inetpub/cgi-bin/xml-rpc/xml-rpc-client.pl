use XMLRPC::Lite;

$x = XMLRPC::Lite
  -> proxy('http://ddds1s91/http-path/xml-rpc-server.cgi')
  -> call('test', {})
  -> result;

  print @{$x};