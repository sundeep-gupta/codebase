#!/tools/bin/perl 

=head NAME 

run_test.pl


=head1 SYNOPSIS

If run from the command line:

run_test.pl -s <ip_address>

=head1 DESCRIPTION

This is a simple smoke test for the Orbital Data accelration appliance.
The program is a wrapper for other tests, hence its a "suite".


=cut


=head1 ARGUMENTS

-s <server ip address>

=cut

use Test::More  tests => 8 ; # the number of tests
use Carp ;
use strict ;


use Getopt::Std ;
use vars qw( $opt_s);
getopt ("s") ;

my $host ;
if ( $opt_s ) {
  $host = $opt_s ;
}
#print "HOST $host";
die "\nNeed ip address: run_test.pl -s <ip address> \n" 
  unless ($host);
  chomp ($host ) ;

is( run_test( "/tools/tests/dong/ping.pl" , $host, ) , 1, "ping , 1 request : $host") ;
#is( run_test( "/tools/tests/dong/scp_test.pl" , $host, ) , 1, "SCP Test: $host") ;
is( run_test( "/tools/tests/dong/softboost_001.pl" , $host, ) , 1, "Softboost_1: $host") ;
is( run_test( "/tools/tests/dong/softboost_002.pl" , $host, ) , 1, "Softboost_2: $host") ;
is( run_test( "/tools/tests/dong/softboost_003.pl" , $host, ) , 1, "Softboost_3: $host") ;
is( run_test( "/tools/tests/dong/softboost_004.pl" , $host, ) , 1, "Softboost_4: $host") ;
is( run_test( "/tools/tests/dong/softboost_005.pl" , $host, ) , 1, "Softboost_5: $host") ;
is( run_test( "/tools/tests/dong/softboost_006.pl" , $host, ) , 1, "Softboost_6: $host") ;
is( run_test( "/tools/tests/dong/softboost_007.pl" , $host, ) , 1, "Softboost_7: $host") ;


sub run_test
  {
    my $test = shift ;
    my $host = shift ;
    my $next_host = $_[2];  #For the test cases with additional input.
    my $invoke = "/tools/bin/perl $test -s  $host" ;
    if ($next_host) {
        $invoke = "/tools/bin/perl $test -s  $host -e $next_host" ;}
#    my $log = "$test".".log";
#    print "The individual test results are in: \n $log\n\n";
    print "RUNNING:$invoke \n" ;
    sleep 2 ;
    my @result = `$invoke` ;
#    system "echo THE TEST RESULTS OF $test  > $log";
#    print "----------------------------\n"  >> $log;
#    print "\n @result\n\n " >> $log;
#    print "----------------------------\n" >> $log;
#The test results is stored in the format:
# 1..3
# ok 1 - desc
# ok 2 - desc
# not ok
#now sparse thru the results start from the second line
   my $result ="";
   my $i = 1;
   while ($result[$i]) {
     if (!($result[$i]=~ /not ok/)) {
        print "Sub-Result $result[$i++]";
     } else {
       print "Test Failed because of the sub-cases. \n";
       print "Sub-Result $result[$i++]\n";
       print "-----------------------------\n";
       return 0;
     }
   }  #while loop 
    print "-----------------------------\n";
    return 1 ;
 }



