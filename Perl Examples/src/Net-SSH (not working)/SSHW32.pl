use Net::SSH::Perl;
$host = "172.16.6.6";
$user = "Administrator";
$pass = "@lt12345";
$cmd = "notepad.exe";
my $ssh = Net::SSH::Perl->new($host);
$ssh->login($user, $pass);
my($stdout, $stderr, $exit) = $ssh->cmd($cmd);
# 1.Math::Pari
# 2. Crypt::DH