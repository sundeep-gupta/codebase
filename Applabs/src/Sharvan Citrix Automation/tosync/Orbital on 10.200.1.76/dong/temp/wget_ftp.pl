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

my $ftp_url= "ftp://" . $host ."/" ;



print "URL:$url\n";
ok( run_wget(  $ftp_url, "1k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "2k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "3k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "4k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "5k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "6k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "7k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "8k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "9k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "10k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "100k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "200k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "250k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "500k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "750k.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;

ok( run_wget(  $ftp_url, "1M.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "2M.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "3M.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "4M.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "5M.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "10M.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "20M.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "30M.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "50M.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "100M.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "200M.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;
ok( run_wget(  $ftp_url, "400M.file") =~ /RETR\W+1k\.file\W+\.\.\.\W+done/gms   , 'wget: test file ') ;

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
