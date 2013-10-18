#!/tools/bin/perl

=head NAME
softboost_010.pl

=head1 DESCRIPTION
Verify the pipe is filled when there is more available line bw.

* The Pipe should be filled.
* The accelerated TCP should not crush UDP and vice versa.
* The accelerated bw should be increased when UDP traffic decreased.


=head2 Test Category
Softboost

=head1 ENVIRONMENT
* 2 Orbs with softboost configured.
* Lincence limit = 30 Mbsec.
* DR = 30Mbsec, 100RTT and 0% DROP
* The UDP server is statically set to 30.30.30.166, for now.
* The HOST needs to have iperf service running for TCP and
  UDP -l 500 -w 500

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
=head1 bugs
If the test failed without the log_file recorded, there is a high chance
that the iperf server crashed.
=cut

=head1 Authors

Dong Duong 
3/22/2005

=cut 

###########################################################################
#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;


getopt ("s") ;
if (  ! $opt_s  ) {
  print $OUTPUT "Usage: testcase_number -s <ip address>  \n" ;
  exit 1 ;
}
my $host = $opt_s;
chomp ($host );
my $testcase="softboost_010";
my $duration =240;                
my $sessions = 20;               #20 accelerated & 20 UDP sessions
my $sleep_time = $duration + 30; #Tune this value, for test with large number of sessions.
my $break_time = 65;   #stick to the test case
my $expected_rate = 27; #in Mbits/sec
my $log_result = 1;
my $OUTPUT = "STDOUT";

is (run_iperf($host, "-t $duration -P $sessions ") , 1, "Softboost: Fill up the pipe ") ;

#this sub invoke iperf TCP and iperf UDP
sub run_iperf
{
    my $host = shift ;
    my $udp_host = $host; 
    my $args = shift ;
    my $log_file= ".\/logs\/"."$testcase".".log";
    my $tcp_log = ".\/logs\/"."$testcase"."_tcp.log";
    my $udp_log = ".\/logs\/"."$testcase"."_udp.log";

    if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
     }


# iperf UDP with -l500 -w 500 will use up 512 bytes/sessions
# The iperf server must also be running with the same options.
    $udp_host =~ s/20/30/;  #use the non-proxy IP for UDP test
    my $iperf_udp = "/usr/local/bin/iperf -c $udp_host -t 60 -P 20 -u  > $udp_log &";
    print $OUTPUT "INVOKE: $iperf_udp \n";
    my $udp_result = `$iperf_udp`;
    sleep 10;  #Before starting accelerated TCP

#Start TCP accelerated test 
    my $iperf_tcp = "/usr/local/bin/iperf -c $host $args > $tcp_log &";
    print $OUTPUT "INVOKE TCP IPERF: $iperf_tcp \n";
    my $tcp_result = `$iperf_tcp`;

   print $OUTPUT "BREAK TIME $break_time \n";
   sleep $break_time;

#Start UDP test again
   print "---------------------------\n\n >> $udp_log"
   system  ("iperf -c $udp_host -t 60 -P 20 -u >> $udp_log &");

   my $string ="ps -e | grep iperf | tail -1 ";
   while (`$string`)
   {
   kill_iperf();
   sleep 5;
   }

#Collect TCP test results
   $tcp_result = `cat $tcp_log | grep SUM`;
   print $OUTPUT "Total $session TCP BW comsumption: \n $tcp_result \n";
   my @tcp_result = split(/\s+/, $tcp_result);

# Use this loop to make sure the result is in the intended slots
#   foreach my $i (0 .. 10)
#    {print $OUTPUT "I=$i $tcp_result[$i]\n"; }   

#Collect UDP test results
   $udp_result = `cat $udp_log | grep SUM`;
   print $OUTPUT "Total $sessions UDP BW comsumption: \n $udp_result \n";
   my @udp_result = split(/\s+/, $udp_result);

#Compute the total throughputs
   my $counter=5;   
   if ($tcp_result[0] eq "") {$counter++}
   my $next_slot = $counter + 1;
   my $total_rate = $tcp_result[$counter] + $udp_result[$counter] ;

   if (($tcp_result[$next_slot] eq "Mbits\/sec") && ($udp_result[$next_slot] eq "Mbits\/sec"))
   {
     print $OUTPUT " MY TCP IS: $tcp_result[$counter] \n";
     print $OUTPUT " MY UDP IS: $udp_result[$counter] \n";
     if ($total_rate >= $expected_rate)
     {
       print $OUTPUT "The expected throughput: $expected_rate Mbits/sec\n";
       print $OUTPUT "The total actual throughput: $total_rate Mbits/sec\n";
       return 1 ;
     } 
   } else 
      {
      print $OUTPUT "The pipe is not filled\n";
      print $OUTPUT "The total actual throughput: $total_rate Mbits/sec\n";
      return  0 ; 
      }
   }

sub kill_iperf
{
 $string = `ps -e | grep iperf | tail -1 `;
 if (( $string =~ /iperf/)) {
  my @field = split(/\s+/,$string);
  my $counter=0;
  if ($field[0] eq "") {$counter++}  #prevent the spaces at the beg of the list

  if (`kill $field[$counter]`) {
           print $OUTPUT "The Iperf deamon ID:$field[$counter] was not killed \n";
                 } else {
           print $OUTPUT "The Iperf deamon ID:$field[$counter] was killed \n";
                 }
#       return 1;
        }else {
        print $OUTPUT "Iperf service was not running\n";
#  return 0;
        }
} #end of main


=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
