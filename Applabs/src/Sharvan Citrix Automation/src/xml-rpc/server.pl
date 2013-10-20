use XMLRPC::Transport::HTTP;
use strict;
my $daemon = XMLRPC::Transport::HTTP::Daemon
  -> new (LocalPort => 1580)
  -> dispatch_to('validator1')
;
print "Contact to XMLRPC server at ", $daemon->url, "\n";
$daemon->handle;




#use XMLRPC::Transport::HTTP;

# my $server = XMLRPC::Transport::HTTP::CGI
#    -> dispatch_to('test')
#    -> handle
#  ;

#  sub test { 
#	my @greetings = ("hello","Kumar");
#	return \@greetings;
#}

