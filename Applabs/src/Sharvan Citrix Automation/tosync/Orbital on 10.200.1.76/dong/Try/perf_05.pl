#!/tools/bin/perl

=head NAME
perf_05.pl

=head1 DESCRIPTION
Verify performance of Sessions over a configured BW. 
This is for Lyon release.
=head2 Test Category
Performance

=head1 ENVIRONMENT
* 2 Orbs with softboost configured with at least 50Mbps license.
* DR = 45Mbsec, 200RTT and 0% DROP (flow_1)


=head1 APPLICATIONS
=cut
=head1 bugs
=cut

=head1 Authors
Dong Duong 
04/12/05
=cut 


use Test::More  qw(no_plan); 
#use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;


my $testcase="perf_05";

getopt ("d,r,s") ;
if (  ! $opt_s ) {
  print "Usage: $testcase -d <dr> -s <Iperf Server>  \n" ;
  exit 1 ;
}
#my @bw_list = (1.5, 3.0, 4.5, 6.0, 10, 12, 20, 30);   #SB has bug with bw higher than 20
my @bw_list = (1.5, 3.0, 4.5, 6.0, 10,12,20 );  
my @sess_list = (1, 10,20,50, 100,200, 300,400,500);                 #Modify this list if needed
my $host = $opt_s;
chomp ($host );
my $net1_add = "30.30.20.0";     #flow1 net
my $net2_add = "20.20.0.0";     #flow1 net
my $bw = 45;                      #Mbps.
my $net1_rtt = 100;
if ($opt_r) { $net1_rtt = $opt_r; chomp ($net1_rtt) }
my $dr = "20.20.20.1";           #default Delay Router 
if ($opt_d)
  { $dr = $opt_d;
    chomp ($dr)
  }
my $duration = 200;
my $sess =1;
my $perc = 0.93;                  #expect throughout percentage
my $expected_flow1_rate;
my $sleep_time = $duration + 50; #Tune this value, for test with large number of sessions.
my $OUTPUT = "STDOUT";
my $log_result = 1;        #saved output of the test?.
if ($log_result) {
   my $log_file = "..\/logs\/"."$testcase".".log";
   open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
   $OUTPUT = "LOG";
}
my $stat_result=1;
if ($stat_result) {
   my $stat_file = "..\/logs\/"."$testcase"."_stats.log"; #contains perf results of all individual test.
   open (PERF,  "> $stat_file") || die "Could not open the file $stat_file \n";
   $STAT = "PERF";
   print $STAT "\n";
   print $STAT `date`;
   print $STAT "-----------------------------------\n\n";
}

#Start the test ...
#Configure the DR only once    
    $bw_Kb = $bw * 1000;
    config_DR ($dr, $net1_add, $bw_Kb, $net1_rtt, 0);
    config_DR ($dr, $net2_add, $bw_Kb, $net1_rtt, 0);  #Reverse direction
foreach $sess (@sess_list) {
  print $STAT " ******* $sess Session(s) Test Result*******\n";
  print $STAT " Bandwidth      Send Rate         Result\n";
  $expected_flow1_rate = ($bw * $perc); 
  if ($sess == 1) {                 	#handle this case separately
      is (run_perf ($host, $bw, $duration), 1, "Performance: One session over $bw Mbps") ;
      sleep 10;
      print $OUTPUT "------------------------------------\n\n";
   } else {                #if number of tested sessions are more than 1
          is (run_perfs ($host, $bw, $duration, $sess), 1, "Performance: $sess sessions over  $bw Mbps") ;
          sleep 10;
          print $OUTPUT "------------------------------------\n\n";
   }      #fi
          print $STAT " ***************************************\n\n";
}
  
sub run_perf
{
    my $host = shift ;
    my $bw = shift;
    my $duration = shift ;
    my $pass="FAIL";
# format: change_dr (<dr ip> <rem_net> <bw> <rtt> <drop>)
#    $bw_Kb = $bw * 1000;     #convert to Kbps
#    config_DR ($dr, $net1_add, $bw_Kb, $net1_rtt, 0);
#    sleep 10;
#Start Performance test
    my $flow1 = "/usr/local/bin/iperf -c $host -t $duration";
    print $OUTPUT "Invoke: $flow1 \n";
    my $flow1_result = `$flow1 | tail -1`;
    sleep 5;

#Verify the results ..
   my @flow1_rate = split(/\s+/, $flow1_result);
#   print "This is the logged result \n @flow1_rate \n";
 
   print $OUTPUT "Performance Test of $sess over $bw\n";
   print $OUTPUT "The expected flow1 rate: $expected_flow1_rate Mbits/sec\n";
   print $OUTPUT "The actual flow1 rate  : $flow1_rate[6] $flow1_rate[7]\n";
   if ( ($flow1_rate[6] >= $expected_flow1_rate) && ($flow1_rate[7] eq "Mbits/sec" )) {
      print $OUTPUT "Throughput is in the expected range - PASS! \n";
      $pass = PASS;
      printf $STAT "%10.2f     %10.2f     %10s", $bw, $flow1_rate[6], $pass;
      print $STAT "\n";
      return 1;
      } else { 
        print $OUTPUT "Throughput is NOT in the expected range - FAIL! \n";
        printf $STAT "%10.2f     %10.2f     %10s", $bw, $flow1_rate[6], $pass;
        print $STAT "\n";
        return  0 ;
      }  #end of if (test result verification)
}

#*************************************************************************
#This sub is for multiple sessions 
sub run_perfs
{
    my $host = shift ;
    my $bw = shift;
    my $duration = shift ;
    my $sess = shift;
    my $pass = FAIL;
    my $log_file = "..\/logs\/"."$testcase".".log";
    my $flow1_log= "..\/logs\/"."$testcase"."_flow1.log";
    if ($log_result) {
       my $log_file = "..\/logs\/"."$testcase".".log";
       open (LOG,  ">> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
     }
    if ($sess > 300) {$sleep_time = $duration + 100}
# format: change_dr (<dr ip> <rem_net> <bw> <rtt> <drop>)
#    $bw_Kb = $bw * 1000;
#    config_DR ($dr, $net1_add, $bw_Kb, $net1_rtt, 0);

#Start Performance test
#    my $flow1 = "/usr/local/bin/iperf -c $host -t $duration -P $sess > $flow1_log &";
#-------This iperf could not sustain 300 sessions test ----
#Try this.. "iperf_c.sh <host> <sessions> <duration>
    my $flow1 = "/tools/tests/dong/iperf_c.sh $host $sess $duration > $flow1_log &";
    
    print $OUTPUT "Invoke: $flow1 \n";
    my $flow1_result = `$flow1`;

#Wait for the test to complete ...
   print $OUTPUT "SLEEP $sleep_time \n";
   sleep $sleep_time;
   kill_iperf();
   sleep 10;

#Verify the results ..
   print $OUTPUT  `cat $flow1_log`;
   $flow1_result = `cat $flow1_log | grep SUM`;
   my @flow1_rate = split(/\s+/, $flow1_result);
#   print "this is the logged result \n @flow1_rate \n";
   my $counter=0;
   if ($flow1_rate[0] eq "") {$counter++}
   my $flow1_slot = 5 + $counter;
 
   print $OUTPUT "Performance Test of $sess over $bw\n";
   print $OUTPUT "The expected flow1 rate: $expected_flow1_rate Mbits/sec\n";
   print $OUTPUT "The actual flow1 rate  : $flow1_rate[$flow1_slot] $flow1_rate[$flow1_slot+1]\n";
   if ( ($flow1_rate[$flow1_slot] >= $expected_flow1_rate) && ($flow1_rate[$flow1_slot + 1] eq "Mbits/sec" )) {
      print $OUTPUT "Throughput is in the expected range - PASS! \n";
      my $pass = PASS;
      printf $STAT "%10.2f     %10.2f     %10s", $bw, $flow1_rate[$flow1_slot], $pass;
      print $STAT "\n";
      return 1;
    } else { 
        print $OUTPUT "Throughput is NOT in the expected range - FAIL! \n";
        printf $STAT "%10.2f     %10.2f     %10s", $bw, $flow1_rate[6], $pass;
        print $STAT "\n";
        return  0 ; }
}
#*************************************************************************
sub config_DR
#Need 4 inputs: <DR IP> <REM-NETWORK> <BW> <RTT> <LOSS>
{
  print $OUTPUT "Configure the DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \".\/set_bw.sh $_[1] $_[2] $_[3] $_[4]\" ";
  $set_dr = `$set_dr`;
  print $OUTPUT "Below is the DR configuration: \n $set_dr \n";
}
 
#*************************************************************************
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

#*************************************************************************
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
