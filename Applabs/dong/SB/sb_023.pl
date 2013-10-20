#!/tools/bin/perl

=head NAME
sb_023.pl

=head1 DESCRIPTION

Test Case = SB_4.3.8.5
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


my $testcase="sb_023";

getopt ("d, s, t") ;
if (  ! $opt_s || !$opt_t  ) {
  print "Usage: $testcase -d <dr> -s <host_1> -t <host_2>  \n" ;
  exit 1 ;
}
my $host = $opt_s;
chomp ($host );
my $host_2 = $opt_t;
chomp ($host_2 );
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
my $duration = 500;
my $sessions = 50;
my $sleep_time = $duration + 20; #Tune this value, for test with large number of sessions.
my $expected_flow1_rate = 25; #The pipe is 30Mbps
my $expected_flow2_rate = 12; #The pipe is 15 Mbps
my $log_result = 0;
my $OUTPUT = "STDOUT";

is (run_comp($host, $host_2, "-t $duration -P $sessions -X /tools/files/comp_files "), 1, "SB & Compression: Multiple (2) flows") ;

sub run_comp
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
# format: change_dr (<dr ip> <rem_net> <bw> <rtt> <drop>)
    config_DR ($dr, $net1_add, $net1_bw, $net1_rtt, 0);
    print "Between DR config calls \n";
    config_DR ($dr, $net2_add, $net2_bw, $net2_rtt, 0);

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
