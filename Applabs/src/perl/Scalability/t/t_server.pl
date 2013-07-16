 use XMLRPC::Transport::HTTP;
use WANScaler::Scalability::Library;
WANScaler::Scalability::Library::test();
use WANScaler::Test;
WANScaler::Test::test();
my $daemon = XMLRPC::Transport::HTTP::Daemon -> new ( LocalPort => 7000)    							   -> dispatch_to('WANScaler::Test');
print "Contact to XMLRPC server at ", $daemon->url, "\n";
$daemon->handle;