#!/tools/bin/perl

=head NAME
sb_013.pl

=head1 DESCRIPTION

Test Case = SB_4.3.4.2
Verify that sessions within a flow have an equal shared of BW.
The Sessions of multiple (2) flows sucesfully transfer data.
All 2 pipes are filled during the test

=head2 Test Category
Softboost

=head1 ENVIRONMENT
* 2 Orbs with softboost configured.
* Lincence limit = 30 Mbsec.
* DR = 30Mbsec, 200RTT and 0% DROP (flow_1)
* DR = 15Mbps,  300RTT  (flow_1)


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
3/30/05
=cut 


#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;


my $testcase="sb_013";

getopt ("s, t") ;
if (  ! $opt_s || !$opt_t  ) {
  print "Usage: $testcase -s <host_1> -t <host_2>  \n" ;
  exit 1 ;
}
my $host = $opt_s;
chomp ($host );
my $host_2 = $opt_t;
chomp ($host_2 );
my $duration = 100;
my $sessions = 20;
my $sleep_time = $duration + 20; #Tune this value, for test with large number of sessions.
my $expected_flow1_rate = 25; #in Mbits/sec
my $expected_flow2_rate = 12; #in Mbits/sec
my $log_result = 0;
my $OUTPUT = "STDOUT";

is (run_iperf($host, $host_2, "-t $duration -P $sessions "), 1, "Softboost: BW Allocation of Accelerated Sessions for 2 flows") ;

sub run_iperf
{
    my $host = shift ;
    my $host_2 =  shift;
    my $args = shift ;
    my $log_file = ".\/logs\/"."$testcase".".log";
    my $flow1_log= ".\/logs\/"."$testcase"."_flow1.log";
    my $flow2_log= ".\/logs\/"."$testcase"."_flow2.log";
    if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  ">> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
     }
#Make sure the DR is configured for 2 flows.
#run script 2flows_diffBW.sh & make sure flow1=30Mbps and flow2=15Mbps
#can call ssh if not yet done so:
#  system(ssh $DR "2flows_diffBW.sh 30000 200 0");
#as the sample above, flow1 will have 30Mbps and 200RTT, flow2 will have 30/2 Mbps and 300RTT

#Start test on flow1
    my $flow1 = "/usr/local/bin/iperf -c $host $args > $flow1_log &";
    my $flow2 = "/usr/local/bin/iperf -c $host_2 $args > $flow2_log &";
    print $OUTPUT "Invoke: $flow1 \n";
    my $flow1_result = `$flow1`;
    print $OUTPUT "Invoke: $flow2 \n";    
    my $flow2_result = `$flow2`;

#Wait for the test to complete ...
   print $OUTPUT "SLEEP $sleep_time \n";
   sleep $sleep_time;
   kill_iperf();
   sleep 5;

#Verify the results ..
   $flow1_result = `cat $flow1_log | grep SUM`;
   $flow2_result = `cat $flow2_log | grep SUM`;
   my @flow1_rate = split(/\s+/, $flow1_result);
   my @flow2_rate = split(/\s+/, $flow2_result);
   my $counter=0;
   if ($flow1_rate[0] eq "") {$counter++}
   my $flow1_slot = 5 + $counter;
   $counter=0;
   if ($flow2_rate[0] eq "") {$counter++}
   my $flow2_slot = 5 + $counter;
 
   print $OUTPUT "The expected flow1 rate: $expected_flow1_rate Mbits/sec\n";
   print $OUTPUT "The actual flow1 rate  : $flow1_rate[$flow1_slot] $flow1_rate[$flow1_slot+1]\n";
   print $OUTPUT "The expected flow2 rate: $expected_flow2_rate Mbits/sec\n";
   print $OUTPUT "The actual flow2 rate  : $flow2_rate[$flow2_slot] $flow2_rate[$flow2_slot+1]\n";

   if ( ($flow1_rate[$flow1_slot] >= $expected_flow1_rate) && ($flow1_rate[$flow1_slot + 1] eq "Mbits/sec" )) {
      print $OUTPUT "Flow One Passes \n";
      if ( ($flow2_rate[$flow2_slot] >= $expected_flow2_rate) && ($flow2_rate[$flow2_slot + 1] eq "Mbits/sec" )) {
         print $OUTPUT "Flow Two Passes \n";
         return 1;}
    } else { return  0 ; }
}

sub kill_iperf
{
 my $string = `ps -e | grep iperf | tail -1 `;
 print $OUTPUT "This Iperf process is running $string \n";
 my @field = split(/\s+/,$string);
 my $counter=0;
 if ($field[0] eq "") {$counter++}
 if (( $string =~ /iperf/)) {
  if (`kill $field[$counter]`) {
           print $OUTPUT  "The Iperf deamon ID:$field[$counter] was not killed \n";
                 } else {
           print $OUTPUT "The Iperf deamon ID:$field[$counter] was killed \n";
                 }
#       return 1;
        }else {
        print $OUTPUT "Iperf service was not running\n";
#  return 0;
        }
}


=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
