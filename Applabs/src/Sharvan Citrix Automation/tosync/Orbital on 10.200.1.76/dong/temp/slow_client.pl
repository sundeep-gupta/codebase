#!/tools/bin/perl
#Dong - modify from the FTP Bench test.
#This is the test case that cause the Orb to run out
#of packets 
#Should bring down the box within seconds
#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ; # the number of tests
use Carp ;
use Getopt::Std ;
use vars qw( $opt_s);

getopt ("s") ;

my $host ;
if ( $opt_s ) {
  $host = $opt_s ;
}
elsif ($ENV{'PARAM'} ){
  do $ENV{'PARAM'} ;
  print "just done \n" ;
}
elsif ($ENV{'HOST'} ){
  $host = $ENV{'HOST'} ;
}

die "\nNeed to provide ip address: slow_client.pl -s <ip address> \n\n" 
  unless ($host ) ;

chomp ($host ) ;

 is( ftp_bench($host , " -n15 -t200 -v -utest -ptest -f/tools/files/10M.file -c50" ) , 1, "ftp benchmark 15 users 10M file level 50 concurrency") ;


sub ftp_bench {
  my $host  = shift ;
  my $option = shift ;
  my $string = "/tools/bin/dkftpbench $option -h$host" ;
print "INVOKE:$string \n" ;
  my $result = `$string` ;
  if ( $result =~ /.*Test\W+over.*/gxsm ) {
    return 1 ;
  } else { return 0 ; }
}
