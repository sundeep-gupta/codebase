#!/tools/bin/perl
#FTP GET a file from a Windoes ftp-server
#Windows's FTP server needs to have the $file stored in 
# the \inetpub\ftproot directory

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

die "\nPlease provide ip address: ftp_winser.pl -s <ip address> \n\n"
	unless ( $host );
chomp ( $host );

ok(run_ftp( $host, "10M.file") == '1');

sub run_ftp
{
	my $ftp_ser = shift;
	my $file = shift;
	print "URL($ftp_ser)\n";	
        my $temp_file = '/logs/tmp/' . $file;
  print "tempfile $temp_file \n";
#        if (-e $temp_file) {`rm -rf $temp_file`; print "remove old file"; };
	my $ftp = Net::FTP->new("$ftp_ser", Debug => 1);
print "testing .../n";
	$ftp->login("ftp",'anonymous@orbitaldata.com');
	if ($ftp->get("$file \/logs\/tmp\/$file") ) { $ftp->quit(); return 1; } else 
	{
		$ftp->quit();
		return 0;
	}
}
