 use XMLRPC::Transport::HTTP;

  my $daemon = XMLRPC::Transport::HTTP::Daemon->new ( LocalPort => 7050)
    -> dispatch_to('Scalability');
  print "Contact to XMLRPC server at ", $daemon->url, "\n";
  $daemon->handle;

