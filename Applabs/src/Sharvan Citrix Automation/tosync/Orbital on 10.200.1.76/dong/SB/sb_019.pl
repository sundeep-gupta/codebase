#!/tools/bin/perl

=head NAME
sb_019.pl

=head1 DESCRIPTION

Test case = SB_4.3.8.1
With compression active, verify that the pipe is filled with one accelerated session 
when transfering non-compressible data.

=head2 Test Category
Softboost

=head1 ENVIRONMENT
* 2 Orbs with softboost and compression enabled.
* Either reboot the tested Orb, or manually clear out the comp statistic.
* Lincence limit = 50 Mbsec.
* DR = 30Mbsec, 100RTT and 0% DROP


=head1 APPLICATIONS
=cut

=head1 Authors

Dong Duong 
04/01/05
=cut 


#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;


my $testcase = "sb_019";
getopt ("s") ;
if (  ! $opt_s  ) {
  print "Usage: $testcase  -s <ip address>  \n" ;
  exit 1 ;
}
my $host = $opt_s;
chomp ($host );
my $duration = 30;
my $wait_time = 10;
my $log_result = 0;
my $OUTPUT = "STDOUT";
my $expected_rate = 27; #in Mbits/sec

is (run_comp ($host, "-t $duration -X /tools/files/non_comp_files"),1,"SB & Compression: One non-compressible session") ;
#is (run_comp ($host, "-t $duration -P 20 -X /tools/files/non_comp_files") , 1, "SB & Compression: 20 non-compressible session") ;

sub run_comp
{
    my $host = shift ;
    my $args = shift ;
    if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
    }  
    my $invoke = "/usr/local/bin/iperf -c $host $args > $log_file &" ;
    print $OUTPUT "Invoke: $invoke \n";
    my $result = `$invoke | tail -1` ;
    sleep 10;   #wait for the test result.
    print $OUTPUT "test result ..\n$result \n";
    my @rates = split(/\s+/, $result);
    if ( ($rates[6] >= $expected_rate) && ($rates[7] eq "Mbits\/sec" )) 
    {
      print $OUTPUT "The expected rate: $expected_rate Mbits\/sec\n";
      print $OUTPUT "The actual rate  : $rates[6] $rates[7]\n";
      return 1 ;
      } else {
      print $OUTPUT "The expected rate: $expected_rate Mbits\/sec\n";
      print $OUTPUT "The actual rate  : $rates[6] $rates[7] \n";
      return  0 ;
    }
}


=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
