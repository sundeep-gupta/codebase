#!/tools/bin/perl
#Require HTTP deamon  on the remote host.
#
#The remote files are in /var/www/http. Copy the tested files 
#as sym-linked into this directory before running the test.
###########################################3
#use Test::More tests => 2; # the number of tests
use Test::More qw(no_plan);
use Getopt::Std;
use vars qw( $opt_u);
my $testcase = 'wget_http.pl';
getopt ("s") ;
my $host ;
if ( $opt_s ) { $host = $opt_s ; }

die "\n $testcase -s <ip address> \n\n" unless ($host ) ;
chomp ($host ) ;

my $http_url= "http://" . $host ."/" ;
my $comp_file = 'ab_compfile';
my $tar_file = 'ab_tarfile';


print "URL:$http_url\n";
ok( run_wget(  $http_url, $comp_file) =~ /response\.\.\.\W+200\W+OK/gms, "HTTP: $comp_file ") ;
ok( run_wget(  $http_url, $tar_file) =~ /response\.\.\.\W+200\W+OK/gms , "HTTP: $tar_file ") ;

sub run_wget
  {
  my $url = shift ;
  my $file = shift ;
  $url .= "$file" ;
 print "URL($url)\n";
  $wget = `wget $url -P /dev/null`;
#  $wget = `wget $url 2>&1`;
#  open (PIPE, "cmd 2>&1 |");
  return $wget ;
}
