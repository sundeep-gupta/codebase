#!/tools/bin/perl
#Dong - 03/09/05
#This test verifies telnet, SSH and SCP between the two ORbs.
#Test Setup:
# Client--------Orb(inl)-----Orb(prox)-------Host
# Client IP = 20.20.20.56
# Host IP = 30.30.30.166
# Orb(inl) proxy = 30.30.30.56    20.20.2.56
# Orb(prox)proxy = 30.30.20.166   30.30.30.166
#                  30.30.30.56    20.20.3.56
# ex: ssh_proxy.pl -s 30.30.20.166 -c 30.30.20.56
# This script telnet from a client to a host (sever) & then SCP copy a file from
# the client to the server
############
use Test::More tests => 5;
use Getopt::Std;
use Net::Telnet ();
use strict;

use vars qw($opt_s $opt_c);
getopt ("sc");
my $server_url;
if ($opt_s) {
	$server_url = $opt_s;
}

my $client_url;
if ($opt_c) {
	$client_url = $opt_c;
}

print "$server_url\n";
print "$client_url\n";

my $username = "root";
my $passwd = "ARS!jr";

die "\nPlease provide ip addresses: ssh_proxy.pl -s <server ip> -c <client ip>\n\n"
	unless ($client_url);
chomp ($client_url);

ok(run_telnet( $username, $passwd, $server_url, $client_url, "1k.file") == '1');
ok(run_telnet( $username, $passwd, $server_url, $client_url, "2k.file") == '1');
ok(run_telnet( $username, $passwd, $server_url, $client_url, "3k.file") == '1');
ok(run_telnet( $username, $passwd, $server_url, $client_url, "4k.file") == '1');
ok(run_telnet( $username, $passwd, $server_url, $client_url, "5k.file") == '1');

sub run_telnet
{
	my $id = shift;
	my $pwd = shift;
	my $host = shift;
	my $client = shift;
	my $file = shift;
	
	my $t = new Net::Telnet (Timeout => 5,
				Errmode => 'return'); 
	$t->open($host);
	$t->login($id, $pwd);
#skip the "who" command for now
#	my @lines = $t->cmd("who");
#	print "@lines\n";
	my $temp_file = '/logs/tmp/' . $file ;
	print "temp_file($temp_file) \n";
	print "file($file) \n";
	if (-e $temp_file) {"rm -rf $file";print "remove old file"; };
	my @scp = $t->cmd("scp root\@$client\:\/tools\/files\/$file \/logs\/tmp\/");
	print "@scp\n";
#sleep 5;
#	my @login = $t->cmd("$pwd");
#	print "@login\n";
#sleep 5;
#        my $temp_file = '/logs/tmp/' . $file ;
#	print "temp_file($temp_file) \n" ;
	if (-e $temp_file) {$t->close; return 1;} else
	{
		$t->close;
		return 0;
	}
}

