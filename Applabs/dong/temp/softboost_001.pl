#!/tools/bin/perl

=head NAME
softboost_001.pl

=head1 DESCRIPTION
Verify that the pipe is filled with one accelerated session.

=head2 Test Category
Softboost

=head1 ENVIRONMENT
* 2 Orbs with softboost configured.
* Lincence limit = 30 Mbsec.
* DR = 30Mbsec, 100RTT and 0% DROP


=head1 APPLICATIONS
Iperf Usage: iperf [-s|-c host] [options]
       iperf [-h|--help] [-v|--version]
 
Client/Server:
  -f, --format    [kmKM]   format to report: Kbits, Mbits, KBytes, MBytes
  -i, --interval  #        seconds between periodic bandwidth reports
  -l, --len       #[KM]    length of buffer to read or write (default 8 KB)
  -m, --print_mss          print TCP maximum segment size (MTU - TCP/IP header)
  -p, --port      #        server port to listen on/connect to
  -u, --udp                use UDP rather than TCP
  -w, --window    #[KM]    TCP window size (socket buffer size)
  -B, --bind      <host>   bind to <host>, an interface or multicast address
  -C, --compatibility      for use with older versions does not sent extra msgs
  -M, --mss       #        set TCP maximum segment size (MTU - 40 bytes)
  -N, --nodelay            set TCP no delay, disabling Nagle's Algorithm
  -V, --IPv6Version        Set the domain to IPv6
 
Server specific:
  -s, --server             run in server mode
  -D, --daemon             run the server as a daemon
 
Client specific:
  -b, --bandwidth #[KM]    for UDP, bandwidth to send at in bits/sec
                           (default 1 Mbit/sec, implies -u)
  -c, --client    <host>   run in client mode, connecting to <host>
  -d, --dualtest           Do a bidirectional test simultaneously
  -n, --num       #[KM]    number of bytes to transmit (instead of -t)
  -r, --tradeoff           Do a bidirectional test individually
  -t, --time      #        time in seconds to transmit for (default 10 secs)
  -F, --fileinput <name>   input the data to be transmitted from a file
  -X, --dirinput <name>    input the data to be transmitted from a directory
  -I, --stdin              input the data to be transmitted from stdin
  -L, --listenport #       port to recieve bidirectional tests back on
  -P, --parallel  #        number of parallel client threads to run
  -T, --ttl       #        time-to-live, for multicast (default 1)
=cut

=head1 Authors

Dong Duong 

=cut 


#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;


getopt ("s") ;
if (  ! $opt_s  ) {
  print "Usage: testcase_number -s <ip address>  \n" ;
  exit 1 ;
}
my $host = $opt_s;
chomp ($host );
my $testcase = "softboost_001";
my $log_result = 0;
my $OUTPUT = "STDOUT";
my $expected_rate = 5; #in Mbits/sec
is (run_iperf($host, "-t 10 ") , 1, "Softboost: Throughput with one accelerated session ") ;

sub run_iperf
{
    my $host = shift ;
    my $args = shift ;
    if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
    }  
    my $invoke = "/usr/local/bin/iperf -c $host $args" ;
    my $result = `$invoke | tail -1` ;
    sleep 10;   #wait for the test result.
#the result should be the line with transfered rates
   print $OUTPUT "test result ..\n$result \n";
   my @rates = split(/\s+/, $result);
#   foreach my $i (0 .. 13)
#    {print "I=$i $rates[$i]\n"; }   
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
