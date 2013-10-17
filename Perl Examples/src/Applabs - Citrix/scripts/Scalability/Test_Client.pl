 use XMLRPC::Transport::HTTP;
use WANScaler::Scalability::Library;
  my $daemon = XMLRPC::Transport::HTTP::Daemon->new ( LocalPort => 7050)
    -> dispatch_to('WANScaler::Scalability::Library');
  print "Contact to XMLRPC server at ", $daemon->url, "\n";
  $daemon->handle;