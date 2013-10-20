#!/tools/bin/perl

=head NAME
perf_01.pl

=head1 DESCRIPTION
Verify performance of one accelerated sessions over 45Mbps BW.

=head2 Test Category
Performance

=head1 ENVIRONMENT
* 2 Orbs with softboost configured with at least 50Mbps license.
* DR = 450Mbsec, 200RTT and 0% DROP (flow_1)


=head1 APPLICATIONS
=cut
=head1 bugs
=cut

=head1 Authors
Dong Duong 
04/06/05
=cut 


#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;


my $testcase="perf_01";

getopt ("d, s") ;
if (  ! $opt_s ) {
  print "Usage: $testcase -d <dr> -s <Iperf Server>  \n" ;
  exit 1 ;
}
my $host = $opt_s;
chomp ($host );
my $dr = "20.20.20.1";           #default Delay Router 
my $net1_add = "30.30.20.0";     #flow1 net
my $net1_bw = 45;       #Mbps.
my $net1_rtt = 200;
if ($opt_d)
  { $dr = $opt_d;
    chomp ($dr)
  }
my $duration = 60;
my $sessions =1;
my $sleep_time = $duration + 20; #Tune this value, for test with large number of sessions.
my $expected_flow1_rate = $net1_bw * 0.95; #Should be in the range of 95%
my $log_result = 0;
my $OUTPUT = "STDOUT";

is (run_perf ($host, $net1_bw, "-t $duration -P $sessions"), 1, "Performance: One session over a $net1_bw Mbps") ;

#is (run_perfs ($host, $net1_bw, "-t $duration -P $sessions"), 1, "Performance: One session over a $net1_bw Mbps") ;

sub run_perf
{
    my $host = shift ;
    my $bw = shift;
    my $args = shift ;
    my $log_file = "..\/logs\/"."$testcase".".log";
    if ($log_result) {
       my $log_file = "..\/logs\/"."$testcase".".log";
       open (LOG,  ">> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
     }
# format: change_dr (<dr ip> <rem_net> <bw> <rtt> <drop>)
    $bw = $bw * 1000;
    config_DR ($dr, $net1_add, $bw, $net1_rtt, 0);

#Start Performance test
    my $flow1 = "/usr/local/bin/iperf -c $host $args";
    print $OUTPUT "Invoke: $flow1 \n";
    my $flow1_result = `$flow1 | tail -1`;
    sleep 5;

#Verify the results ..
   my @flow1_rate = split(/\s+/, $flow1_result);
   print "This is the logged result \n @flow1_rate \n";
   my $counter=0;
   if ($flow1_rate[0] eq "") {$counter++}
   my $flow1_slot = 5 + $counter;
 
   print $OUTPUT "The expected flow1 rate: $expected_flow1_rate Mbits/sec\n";
   print $OUTPUT "The actual flow1 rate  : $flow1_rate[$flow1_slot] $flow1_rate[$flow1_slot+1]\n";

   if ( ($flow1_rate[$flow1_slot] >= $expected_flow1_rate) && ($flow1_rate[$flow1_slot + 1] eq "Mbits/sec" )) {
      print $OUTPUT "Throughput is in the expected range - PASS! \n";
      return 1;
    } else { 
        print $OUTPUT "Throughput is NOT in the expected range - FAIL! \n";
        return  0 ; }
}

#This sub is for multiple sessions 
sub run_perfs
{
    my $host = shift ;
    my $bw = shift;
    my $args = shift ;
    my $log_file = "..\/logs\/"."$testcase".".log";
    my $flow1_log= "..\/logs\/"."$testcase"."_flow1.log";
    if ($log_result) {
       my $log_file = "..\/logs\/"."$testcase".".log";
       open (LOG,  ">> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
     }
# format: change_dr (<dr ip> <rem_net> <bw> <rtt> <drop>)
    $bw = $bw * 1000;
    config_DR ($dr, $net1_add, $bw, $net1_rtt, 0);

#Start Performance test
    my $flow1 = "/usr/local/bin/iperf -c $host $args > $flow1_log &";
    print $OUTPUT "Invoke: $flow1 \n";
    my $flow1_result = `$flow1`;

#Wait for the test to complete ...
   print $OUTPUT "SLEEP $sleep_time \n";
   sleep $sleep_time;
   kill_iperf();
   sleep 5;

#Verify the results ..
   $flow1_result = `cat $flow1_log | grep SUM`;
   my @flow1_rate = split(/\s+/, $flow1_result);
   print "this is the logged result \n @flow1_rate \n";
   my $counter=0;
   if ($flow1_rate[0] eq "") {$counter++}
   my $flow1_slot = 5 + $counter;
 
   print $OUTPUT "The expected flow1 rate: $expected_flow1_rate Mbits/sec\n";
   print $OUTPUT "The actual flow1 rate  : $flow1_rate[$flow1_slot] $flow1_rate[$flow1_slot+1]\n";

   if ( ($flow1_rate[$flow1_slot] >= $expected_flow1_rate) && ($flow1_rate[$flow1_slot + 1] eq "Mbits/sec" )) {
      print $OUTPUT "Throughput is in the expected range - PASS! \n";
      return 1;
    } else { 
        print $OUTPUT "Throughput is NOT in the expected range - FAIL! \n";
        return  0 ; }
}
sub config_DR
#Need 4 inputs: <DR IP> <REM-NETWORK> <BW> <RTT> <LOSS>
{
  print $OUTPUT "Configure the DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \".\/set_bw.sh $_[1] $_[2] $_[3] $_[4]\" ";
  $set_dr = `$set_dr`;
  print $OUTPUT "Below is the DR configuration: \n $set_dr \n";
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
        }else {
        print $OUTPUT "Iperf service was not running\n";
        }
} #end of kill_iperf

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


=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
