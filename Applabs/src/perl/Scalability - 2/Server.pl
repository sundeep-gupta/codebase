  use XMLRPC::Transport::HTTP;
   syswrite \*STDOUT, "Contact to XMLRPC server at ";
   sleep(2);
  my $daemon = XMLRPC::Transport::HTTP::Daemon
    -> new (LocalPort => 80)
    -> dispatch_to('RPC')
  ;
  syswrite \*STDOUT, "Contact to XMLRPC server at ", $daemon->url, "\n";
  $daemon->handle;

  1;