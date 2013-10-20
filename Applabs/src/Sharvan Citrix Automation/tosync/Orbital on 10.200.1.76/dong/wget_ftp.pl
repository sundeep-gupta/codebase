#!/tools/bin/perl
#Require FTP deamon as VSFTPD running on the remote host.
#WGET will login as "anonymous" /@wget as username and password
#The remore FTP home directory is /vatr/ftp. Copy the tested files into this\
#directory before running the test.
###########################################3
#use Test::More tests => 2; # the number of tests
use Test::More qw(no_plan);
use Getopt::Std;
use vars qw( $opt_u);
my $testcase = 'wget_ftp.pl';
getopt ("s, f") ;

my $host ;
if ( $opt_s ) { $host = $opt_s ; }

die "\n $testcase -s <Server ip> \n\n" unless ($host ) ;
chomp ($host ) ;

my $file='ab_compfile';
if ($opt_f) {($file = $opt_f); chomp($file)}
my $ftp_url= "ftp://" . $host ."/" ;



print "URL:$ftp_url\n";
ok( run_wget(  $ftp_url, $file) =~ /RETR\W+100M\W+\.\.\.\W+done/gms   , "wget: $file file ") ;

sub run_wget
  {
  my $url = shift ;
  my $file = shift ;
  $url .= "$file" ;
 print "URL($url)\n";
  $wget = `wget $url 2>&1`;
  open (PIPE, "cmd 2>&1 |");
  return $wget ;
}
