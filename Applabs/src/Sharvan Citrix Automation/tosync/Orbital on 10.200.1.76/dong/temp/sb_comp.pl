#!/tools/bin/perl

=head NAME
sb_comp.pl

=head1 DESCRIPTION
Verify SB interoperability with Compression using various data types
View will be use to classify if a session is compressed or not
Iperf will select the data types to be compressed

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
=cut
=head1 bugs
If the test failed without the log_file recorded, there is a high chance
that the iperf server crashed.
=cut

=head1 Authors

Dong Duong 
3/17/2005

=cut 

###########################################################################
#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;

#Don't need inputs for now
#getopt ("s,e") ;
#if (  !$opt_s && !$opt_e && !$opt_l && !$opt_r  ) {
#  print "Usage: system_reliability.pl -l <loc Orb> -r <rem Orb> -s <rem host> -e <non_acc host> \n" ;
#  exit 1 ;
#}
my $host1 = 30.30.20.166;
my $host2 = 30.30.20.165;
my $host3 = 30.30.20.167;
my $host4 = 30.30.30.166;
my $testcase="sb_comp";
my $duration = 72000;     #24 hrs test = 86400.
my $sess = 20;       #for non-compression or non-compressible data
my $comp_sess = 5;
my $wait_time = $duration + 50; #Tune this value, for test with large number of sessions.
my $run_time = 200;     # 3 hrs = 10800
my $interval = 20; 
my $expected_rate = 27; #in Mbits/sec
my $log_result = 0;
my $OUTPUT = "STDOUT";

is (run_comp(),1,"System Reliability") ;

sub run_comp
{
    my $log_file= ".\/logs\/"."$testcase".".log";
    my $tcp_log = ".\/logs\/"."$testcase"."_tcp.log";
    my $udp_log = ".\/logs\/"."$testcase"."_udp.log";
    my $non_comp_log = ".\/logs\/"."$testcase"."_non_comp.log";

#If log the result, then open the log file
    if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG"
     }

while ($duration - $run_time) {
# Bring up acc-TCP test    
    my $iperf_tcp = "/usr/local/bin/iperf -c $host -t $run_time -P $comp_sess -F ./data/2.6x > $tcp_log &";
    print $OUTPUT "INVOKE: $iperf_tcp \n";
    my $tcp_result = `$iperf_tcp`;
    print $OUTPUT "Sleep $interval seconds\n";
    sleep $interval;

# Bring up UDP test
    $udp_host =~ s/20/30/;  #use the non-proxy IP for UDP test
    my $iperf_udp = "/usr/local/bin/iperf -c $host4 -u -t $run_time -P $sessions -l 500 -w 500 > $udp_log &";
    print $OUTPUT "INVOKE: $iperf_udp \n";
    my $udp_result = `$iperf_udp`;
   print $OUTPUT "SLEEP $interval \n";
   sleep $interval;
#Bring up non-compressible data sess
    my $iperf_non_comp = "/usr/local/bin/iperf -c $host2 -t $run_time -P $sessions -F ./data/big.tar > $non_comp_log &";
    print $OUTPUT "INVOKE: $iperf_non_comp \n";
    my $non_comp_result = `$iperf_non_comp`;
    print $OUTPUT "Sleep $interval seconds\n";
    sleep $interval;
# while duration is not met
    print $OUTPUT "Sleep during Runtime $run_time \n";
    sleep $run_time;
    $duration = $duration - $run_time;
    print $OUTPUT "Time Left  `$duration / 60` minutes \n";
} end of while
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
#    {print "I=$i $tcp_result[$i]\n"; }   

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
     if ($total_rate >=  $expected_rate)
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
