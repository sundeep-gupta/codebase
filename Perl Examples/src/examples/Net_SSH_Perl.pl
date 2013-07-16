use strict;
use Net::SSH::Perl;
my $host = 'sta00578.us.oracle.com';
my $user = 'skgupta';
my $pass = 'ARS!jr12';
my $cmd = 'ls -l';
    my $ssh = Net::SSH::Perl->new($host);
    $ssh->login($user, $pass);
    my($stdout, $stderr, $exit) = $ssh->cmd($cmd);
