#!/tools/bin/perl

=head NAME
sb_024.pl

=head1 DESCRIPTION

Test Case = SB_4.3.8.6
Verify that compressed TCP, UDP, and WEB traffic can co-exist gracefully in
SB & Compression environment.

=head2 Test Category
Softboost

=head1 ENVIRONMENT
* 2 Orbs with softboost configured.
* Lincence limit = 30 Mbsec.
* DR = 30Mbsec, 200RTT and 0% DROP (flow_1)
* DR = 15Mbps,  300RTT  (flow_1)


=head1 APPLICATIONS
=cut
=head1 bugs
If the test failed without the log_file recorded, there is a high chance
that the iperf server crashed.
=cut

=head1 Authors

Dong Duong 
04/04/05
=cut 


#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;


my $testcase="sb_024";

getopt ("d, s,t, u, w") ;
if (  ! $opt_s || !$opt_t || !$opt_u ||!$opt_w  ) {
  print "Usage: $testcase -d <dr> -s <host> -t <host2> -u <UDP ser> -w <WEB ser>  \n" ;
  exit 1 ;
}
my $host = $opt_s;         	#Server for compressed data of flow1
chomp ($host );			
my $host_2 = $opt_t;
chomp ($host_2 );		#server for compressed data of flow2
my $udp_ser = $opt_u;       	#server to handle UDP traffic
chomp ($udp_ser );
my $web_ser = $opt_w;           #server to handle non-acc web traffic
chomp ($web_ser );
my $dr = "20.20.20.1";       #default Delay Router 
my $net1_add = "30.30.20.0";     #flow1 net
my $net2_add = "30.30.40.0";     #flow2 net
my $net1_bw = 30000;       #as defined in the test case.
my $net2_bw = 15000;
my $net1_rtt = 200;
my $net2_rtt = 300;
if ($opt_d)
  { $dr = $opt_d;
    chomp ($dr)
  }
my $duration = 100;
my $sessions = 20;
my $sleep_time = $duration + 20; #Tune this value, for test with large number of sessions.
my $expected_flow1_rate = 25; #The pipe is 30Mbps
my $expected_flow2_rate = 12; #The pipe is 15 Mbps
my $log_result = 0;
my $OUTPUT = "STDOUT";
is (run_comp("-t $duration -P $sessions "), 1, "SB & Compression: Co-existence of all traffic types") ;

sub run_comp
{
    my $args = shift ;
    my $log_file = ".\/logs\/"."$testcase".".log";
    my $host1_log= ".\/logs\/"."$testcase"."_host1.log";
    my $host2_log= ".\/logs\/"."$testcase"."_host2.log";
    my $web_log= ".\/logs\/"."$testcase"."_web.log";
    my $udp_log= ".\/logs\/"."$testcase"."_udp.log";
    if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  ">> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
     }
#Make sure the DR is configured for 2 flows.
# format: change_dr (<dr ip> <rem_net> <bw> <rtt> <drop>)
    config_DR ($dr, $net1_add, $net1_bw, $net1_rtt, 0);
    config_DR ($dr, $net2_add, $net2_bw, $net2_rtt, 0);

#Start test on flow1
    my $host1 = "/usr/local/bin/iperf -c $host $args > $host1_log &";
    print $OUTPUT "Invoke: $host1 \n";
    my $host1_result = `$host1`;
    sleep 10;
#start test on flow2
    my $host2 = "/usr/local/bin/iperf -c $host_2 $args > $host2_log &";
    print $OUTPUT "Invoke: $host2 \n";    
    my $host2_result = `$host2`;
    sleep 10;
# Bring up UDP test
    my $udp = "/usr/local/bin/iperf -c $udp_ser $args -u -l 500 -w 500 > $udp_log &";
    print $OUTPUT "INVOKE: $udp \n";
    my $udp_result = `$udp`;
    sleep 10;
#Bring up non-acc WEB TCP
    my $web_tcp = "/usr/local/bin/iperf -c $web_ser $args > $web_log &";
    print $OUTPUT "INVOKE: $web_tcp \n";
    my $web_result = `$web_tcp`;
    sleep 10;
#Wait for the test to complete ...
   print $OUTPUT "SLEEP $sleep_time \n";
   sleep $sleep_time;
   kill_all_iperf();
   sleep 5;

#Verify the results ..
#note that flow1=30Mbps shares host1, udp, and web traffic.
#	flow2=15Mbps only has host2 traffic
#---------------------   
   $host1_result = `cat $host1_log | grep SUM`;
   $host2_result = `cat $host2_log | grep SUM`;
   $web_result = `cat $web_log | grep SUM`;
   $udp_result = `cat $udp_log | grep SUM`;
   
   print $OUTPUT "Test Result for $host \n";
   $host1_result = find_throughput ($host1_result);
   print $OUTPUT "Test Result for $host_2 \n";
   $host2_result = find_throughput ($host2_result);
   print $OUTPUT "Test Result for $web_ser \n";
   $web_result = find_throughput ($web_result);
   print $OUTPUT "Test Result for $udp_ser \n";
   $udp_result = find_throughput ($udp_result);
   print $OUTPUT "\n-----------------------------\n";
   my $actual_flow1_rate = $host1_result + $web_result + $udp_result; 
   print $OUTPUT "The expected flow1 rate: $expected_flow1_rate Mbits/sec\n";
   print $OUTPUT "The actual flow1 rate  : $actual_flow1_rate \n";
   print $OUTPUT "The expected flow2 rate: $expected_flow2_rate Mbits/sec\n";
   print $OUTPUT "The actual flow2 rate  : $flow2_rate[$flow2_slot] $flow2_rate[$flow2_slot+1]\n";

   if ( $actual_flow1_rate  >= $expected_flow1_rate)  {
      print $OUTPUT "Flow One Passes \n";
      if ($host2_result >= $expected_flow2_rate) {
         print $OUTPUT "Flow Two Passes \n";
         return 1;}
    } else { return  0 ; }
}
 
sub config_DR
#Need 5 inputs: <DR IP> <REM-NETWORK> <BW> <RTT> <LOSS>
{
  print $OUTPUT "Configure the DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \".\/set_bw.sh $_[1] $_[2] $_[3] $_[4]\" ";
  $set_dr = `$set_dr`;
  print $OUTPUT "The tested DR configuration: \n $set_dr \n";
}
 
sub kill_all_iperf
{
   my $find_pid ="ps -e | grep iperf ";
   @iperf_pid = `$find_pid`;
   print $OUTPUT "Active IPERF PID: @iperf_pid \n";
   my $i=0;
   while ($iperf_pid[$i])
   {
     print $OUTPUT "Iperf Process: $iperf_pid[$i] \n";
     if ($iperf_pid[$i] =~ /iperf/){
     my @field = split(/\s+/, $iperf_pid[$i]);
     my $counter = 0;
     if ($field[0] eq "") {$counter++}  #skip the 1st member if blank
     if (`kill $field[$counter]`) {
           print $OUTPUT "The Iperf deamon ID:$field[$counter] was not killed \n\n";
                 } else {
           print $OUTPUT "The Iperf deamon ID:$field[$counter] was killed \n\n";
                 }
        }else {
        print $OUTPUT "Iperf service was not running\n";
        }
                                                                                                                              
     $i++;
     sleep 2;
   } #end while
} #end of kill_all_iperf

#find the SUM throughput of IPERF 
sub find_throughput
{
   my $line_in = shift;
   my @result = split(/\s+/, $line_in);
   my $counter=0;
   if ($result[0] eq "") {$counter++}
   my $slot = 5 + $counter;
   if ($result[$slot+1] eq "Mbits/sec")
     {
     print "The SUM result of \n $line_in \n";
     print "SUM = $result[$slot] \n";
     return $result[$slot];
     } else {
        print "The failed test result \n $line_in \n";
        return 0;
     }
} #end of find_throughput

=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
