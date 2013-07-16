use Net::SSH::Perl;

my $ssh = Net::SSH::Perl->new("172.16.6.153", 'debug' => '1');
$ssh->login("root", "password");


