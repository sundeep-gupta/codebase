#!/tools/bin/perl

=head NAME
sb_014.pl

=head1 DESCRIPTION
Test Case = SB_4.3.5.x
Verify that the system with SB enabled can withstand 24 hrs of reliability test

=head2 Test Category
Softboost

=head1 ENVIRONMENT
* 2 Orbs with softboost configured.
* Lincence limit = 50 Mbsec.
* DR = 30Mbsec, 100RTT and 0% DROP
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
3/30/2005

=cut 

###########################################################################
#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;


my $testcase="sb_014";
getopt ("l, r, s,e") ;
if (  !$opt_s || !$opt_e || !$opt_l || !$opt_r || !$opt_t ) {
  print "Usage: $testcase -l <loc Orb> -r <rem Orb> -s <flow1> -t <flow2> -e <non_acc host> \n" ;
  exit 1 ;
}
my $loc_orb = $opt_l;
chomp ($loc_orb);
my $rem_orb = $opt_r;
chomp ($rem_orb );
my $flow1_host = $opt_s;
chomp ($flow1_host );
my $flow2_host = $opt_t;
chomp ($flow2_host );
my $nonacc_host = $opt_e;
chomp ($nonacc_host );
my $duration = 3600;     #24 hrs test = 86400.
my $sessions = 20;       #20 accelerated & 20 UDP sessions
my $wait_time = $duration + 50; #Tune this value, for test with large number of sessions.
my $run_time = 300;     # 3 hrs = 10800
my $interval = 20; 
my $expected_rate = 27; #in Mbits/sec
my $log_result = 0;
my $OUTPUT = "STDOUT";

is (run_rel($loc_orb, $rem_orb, $host),1,"Softboost: Reliability") ;

sub run_rel
{
    my $loc_orb = shift ;
    my $rem_orb = shift; 
    my $host = shift;
    my $udp_host = $host;
    my $log_file= ".\/logs\/"."$testcase".".log";
    my $flow1_log = ".\/logs\/"."$testcase"."_flow1.log";
    my $flow2_log = ".\/logs\/"."$testcase"."_flow2.log";
    my $udp_log = ".\/logs\/"."$testcase"."_udp.log";
    my $nonacc_log = ".\/logs\/"."$testcase"."_nonacc.log";
    my $loc_orb_log = ".\/logs\/"."$testcase"."_loc_orb.log";
    my $rem_orb_log = ".\/logs\/"."$testcase"."_rem_orb.log";

#If log the result, then open the log file
    if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG"
     }
#Check VMSTAT of the Orbs every 30 minutes for 48 hours
    
    my $chk_loc_orb = "ssh $loc_orb \"vmstat -n 1800 96 \" > $loc_orb_log &";
    my $chk_rem_orb = "ssh $rem_orb \"vmstat \-n 1800 96 \" > $rem_orb_log &";
    $chk_loc_orb = `$chk_loc_orb`; 
    $chk_rem_orb = `$chk_rem_orb`;

while ($duration - $run_time) {
    # Bring up acc-TCP test on flow1   
    my $flow1_tcp = "/usr/local/bin/iperf -c $flow1_host -t $run_time -P $sessions >> $flow1_log &";
    print $OUTPUT "INVOKE: $flow1_tcp \n";
    my $flow1_result = `$flow1_tcp`;
    print $OUTPUT "Sleep $interval seconds\n";
    sleep $interval;

    # Bring up acc-TCP test on flow2   
    my $flow2_tcp = "/usr/local/bin/iperf -c $flow2_host -t $run_time -P $sessions >> $flow2_log &";
    print $OUTPUT "INVOKE: $flow2_tcp \n";
    my $flow2_result = `$flow2_tcp`;
    print $OUTPUT "Sleep $interval seconds\n";
    sleep $interval;

    # Bring up UDP test
    $udp_host =~ s/20/30/;  #use the non-proxy IP for UDP test
    my $iperf_udp = "/usr/local/bin/iperf -c $udp_host -u -t $run_time -P $sessions -l 500 -w 500 >> $udp_log &";
    print $OUTPUT "INVOKE: $iperf_udp \n";
    my $udp_result = `$iperf_udp`;
    print $OUTPUT "SLEEP $interval \n";
    sleep $interval;

    #Bring up non-acc TCP
    my $nonacc_tcp = "/usr/local/bin/iperf -c $non_acc_host -t $run_time -P $sessions >> $nonacc_log &";
    print $OUTPUT "INVOKE: $nonacc_tcp \n";
    my $nonacc_result = `$nonacc_tcp`;
    print $OUTPUT "Sleep $interval seconds\n";
    sleep $interval;
 
   # while duration is not met
    print $OUTPUT "Sleep during Runtime $run_time \n";
    sleep $run_time;
    $duration = $duration - $run_time;
    print $OUTPUT "Time Left  $duration / 60 minutes \n";
}  #end of while

#get the last iperf PID in the list   
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


#Collect UDP test results
   $udp_result = `cat $udp_log | grep SUM`;
   print $OUTPUT "Total $sessions UDP BW comsumption: \n $udp_result \n";
   my @udp_result = split(/\s+/, $udp_result);

#Compute the total throughputs
#---------------------------------------------
#   my $counter=5;   
#   if ($tcp_result[0] eq "") {$counter++}
#   my $next_slot = $counter + 1;
#   my $total_rate = $tcp_result[$counter] + $udp_result[$counter] ;

#   if (($tcp_result[$next_slot] eq "Mbits\/sec") && ($udp_result[$next_slot] eq "Mbits\/sec"))
#   {
#     print $OUTPUT " MY TCP IS: $tcp_result[$counter] \n";
#     print $OUTPUT " MY UDP IS: $udp_result[$counter] \n";
#     if ($total_rate >=  $expected_rate)
#     {
#       print $OUTPUT "The expected throughput: $expected_rate Mbits/sec\n";
#       print $OUTPUT "The total actual throughput: $total_rate Mbits/sec\n";
#       return 1 ;
#     } 
#   } else 
#      {
#      print $OUTPUT "The pipe is not filled\n";
#      print $OUTPUT "The total actual throughput: $total_rate Mbits/sec\n";
#      return  0 ; 
#      }
#   }
#--------------------------------------------
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
