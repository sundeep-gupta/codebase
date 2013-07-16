use LWP;


my $url = 'http://192.168.1.251/index.php';


my $ua  = new LWP::UserAgent;
my $req = new HTTP::Request (GET => $url);
$ua->credentials($url,'', 'admin','orbital');
$req->authorization_basic ('admin', 'orbital');
my $request = $ua->request ($req);
print $request->code;
print $request->content;
die unless $request->code eq '200';
my $page = $request->content;
print $page;


