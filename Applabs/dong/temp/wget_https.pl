#!/tools/bin/perl
use Test::More tests => 2; # the number of tests
use Getopt::Std;

use vars qw( $opt_u);
getopt ("u") ;
my $host ;
if ( $opt_u ) {
  $host = $opt_u ;
}
elsif ($ENV{'PARAM'} ){
  do $ENV{'PARAM'} ;
  print "just done \n" ;
}
elsif ($ENV{'HOST'} ){
  $host = $ENV{'HOST'} ;
}

die "\nPlease provide ip address: wget.pl -u <ip address> \nor run script from /tools/bin/run./pl \n\n" 
  unless ($host ) ;
chomp ($host ) ;

my $http_url= "https://" . $host ."/" ;



print "URL:$url\n";
ok( run_wget(  $http_url, "1k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "2k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "3k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "4k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "5k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "6k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "7k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "8k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "9k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "10k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "100k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "200k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "250k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "500k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "7500k.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "1M.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "2M.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "3M.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "4M.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "5M.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "10M.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "20M.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "30M.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "50M.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "100M.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "200M.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;
ok( run_wget(  $http_url, "400M.file") =~ /response\.\.\.\W+200\W+OK/gms   , 'wget: test file ') ;



sub run_wget
  {
  my $url = shift ;
  my $file = shift ;
  $url .= "/$file" ;
  #print "URL($url)\n";
  $wget = `wget $url 2>&1`;
  open (PIPE, "cmd 2>&1 |");
  #print "wget($wget) \n" ;
  return $wget ;
}
