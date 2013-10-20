#!/tools/bin/perl
use Test::More tests => 27;
use Getopt::Std;
use strict;
use warnings;

use vars qw( $opt_s );
getopt ("s");
my $url;
if ( $opt_s ) {
        $url = $opt_s;
}

die "\nPlease provide ip address: scp_test.pl -s <ip address> \n\n"
        unless ( $url );
chomp ( $url );

ok(run_scp($url, "1k.file") == '1');
ok(run_scp($url, "2k.file") == '1');
ok(run_scp($url, "3k.file") == '1');
ok(run_scp($url, "4k.file") == '1');
ok(run_scp($url, "5k.file") == '1');
ok(run_scp($url, "6k.file") == '1');
ok(run_scp($url, "7k.file") == '1');
ok(run_scp($url, "8k.file") == '1');
ok(run_scp($url, "9k.file") == '1');
ok(run_scp($url, "10k.file") == '1');
ok(run_scp($url, "100k.file") == '1');
ok(run_scp($url, "200k.file") == '1');
ok(run_scp($url, "250k.file") == '1');
ok(run_scp($url, "500k.file") == '1');
ok(run_scp($url, "750k.file") == '1');
ok(run_scp($url, "1M.file") == '1');
ok(run_scp($url, "2M.file") == '1');
ok(run_scp($url, "3M.file") == '1');
ok(run_scp($url, "4M.file") == '1');
ok(run_scp($url, "5M.file") == '1');
ok(run_scp($url, "10M.file") == '1');
ok(run_scp($url, "20M.file") == '1');
ok(run_scp($url, "30M.file") == '1');
ok(run_scp($url, "50M.file") == '1');
ok(run_scp($url, "100M.file") == '1');
ok(run_scp($url, "200M.file") == '1');
ok(run_scp($url, "400M.file") == '1');

sub run_scp
{
	my $host = shift;
	my $file = shift;

#	my $ssh = `ssh root\$host`;
	my $scp = `scp root\@$host\:\/tools\/files\/\/$file \/logs\/tmp\/`;
	
	my $temp_file = '/logs/tmp/' . $file;
	
	if (-e $temp_file) {return 1;} else {return 0;}
}

