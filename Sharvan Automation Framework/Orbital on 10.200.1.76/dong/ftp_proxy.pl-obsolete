#!/tools/bin/perl
#FTP GET a file from a ftp-server
use Test::More tests => 1; # Number of tests
use Getopt::Std;
use Net::FTP;
use strict ;
use warnings ;

use vars qw( $opt_s );
getopt ("s");
my $host;
if ( $opt_s ) {
	$host = $opt_s;
}

die "\nPlease provide ip address: ftp_proxy.pl -s <ip address> \n\n"
	unless ( $host );
chomp ( $host );

ok(run_ftp( $host, "10k.file") == '1');

sub run_ftp
{
	my $ftp_ser = shift;
	my $file = shift;
	print "URL($ftp_ser)\n";	
        my $temp_file = '/logs/tmp/' . $file;
  print "tempfile $temp_file \n";
        if (-e $temp_file) {`rm -rf $temp_file`; print "remove old file"; };
	my $ftp = Net::FTP->new("$ftp_ser", Debug => 2);
#	$ftp->pasv();
#	$ftp->login("anonymous",'anonymous@orbitaldata.com');
# vsftpd does not allow anonymous to look into /tools/files.
# Use a local username to get by this issue
	$ftp->login("test","test");
#	$ftp->cwd("/");
        $ftp->ls("/tools/files");
	if ($ftp->get("\/tools\/files\/$file \/logs\/tmp\/$file") ) { $ftp->quit(); return 1; } else 
	{
		$ftp->quit();
		return 0;
	}
}
