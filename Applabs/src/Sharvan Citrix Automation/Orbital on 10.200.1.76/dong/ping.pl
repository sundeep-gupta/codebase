#!/tools/bin/perl 

=head NAME 

ping.pl


=head1 SYNOPSIS

If run from the command line:

ping.pl -s <ip_address>

=head1 DESCRIPTION

=cut


=head1 ARGUMENTS

=cut

use Test::More  tests => 1; # the number of tests
use Carp ;
#use strict ;
use Net::Ping ;
use Time::HiRes ;
use Getopt::Std ;
use vars qw( $opt_s);

getopt ("s") ;

my $host ;
if ( $opt_s ) {
  $host = $opt_s ;
}
#elsif ($ENV{'PARAM'} ){
#    $host =  $ENV{'PARAM'}->{'_test_ip'} ;
#}

elsif ($ENV{'HOST'} ){
  $host = $ENV{'HOST'} ;
}

die "\nNeed ip address: ping.pl -s <ip address> \n\n" 
  unless ($host ) ;
  
chomp ($host ) ;


is( run_ping( $host, "-w1 -c1 " ) , 1, "ping , 1 request : $host");

sub run_ping
  {
    my $host = shift ;
    my $option = shift ;
    my $invoke = "ping  $option $host" ;
    print "INVOKE:$invoke \n" ;
    my $out = (`$invoke |grep "received,"`) ;
    sleep 5 ;
    if (  ($out =~ /1 received/)  ) {
      return 1 ;
    } else { 
       print "FAIL TO $invoke\n $out\n";
       return 0 ; }
  }
