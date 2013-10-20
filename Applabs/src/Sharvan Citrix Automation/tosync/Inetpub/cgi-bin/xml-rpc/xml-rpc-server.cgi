use XMLRPC::Transport::HTTP;

  my $server = XMLRPC::Transport::HTTP::CGI
    -> dispatch_to('test')
    -> handle
  ;

  sub test { 
	my @greetings = ("hello","Kumar");
	return \@greetings;
}

