use strict;
use warnings;
use Net::SSH::W32Perl;

&windows();

sub windows ()
{
my ($user,$pass,$host,$cmd) = ("060416",'\@lt12345,"172.16.6.12","dir c:\\");
my $ssh = Net::SSH::W32Perl->new($host,debug => 1);
$ssh->login($user, $pass);
my($stdout, $stderr, $exit) = $ssh->cmd("cmd /c \"$cmd\"");
print "Standard out: $stdout\nStandard Error: $stderr\nExit code: $exit\n";
}