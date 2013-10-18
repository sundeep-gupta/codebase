#!/tools/bin/perl

=head NAME
softboost_005.pl

=head1 DESCRIPTION
Verify that accelerated and non-accelerated TCP can co-exist gracefully

* The Pipe should be filled.
* The accelerated TCP should not crush non-acc TCP and vice versa.

=head2 Test Category
Softboost

=head1 ENVIRONMENT
* 2 Orbs with softboost configured.
* Lincence limit = 30 Mbsec.
* DR = 30Mbsec, 100RTT and 0% DROP

=head1 APPLICATIONS
1. ex: if $host=30.30.20.166
    then   $non_acc_host = 30.30.30.166
2. The $host must have:
   iperf -s & iperf -s -p 5002 (running)

=cut

=head1 Authors

Dong Duong 
3/14/2005

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
my $testcase="softboost_005";
my $duration =150;              #min must be 50 => 30 sec for TCP
my $sessions = 20;               #20 accelerated & 20 UDP sessions
my $sleep_time = $duration + 50; # running 20 acc & 20 non-acc against a server, need 50 extra.
my $expected_rate = 25; #in Mbits/sec
my $log_result = 1;
my $OUTPUT = "STDOUT";

is (run_iperf($host, "-t $duration -P $sessions ") , 1, "Softboost: Throughput with $sessions accelerated session ") ;

#this sub invoke iperf TCP and iperf UDP
sub run_iperf
{
    my $host = shift ;
    my $non_acc_host = $host; 
    my $args = shift ;
    my $log_file= ".\/logs\/"."$testcase".".log";
    my $tcp_log = ".\/logs\/"."$testcase"."_tcp.log";
    my $non_acc_log = ".\/logs\/"."$testcase"."_non_acc.log";
    if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
     }

#Since Iperf with multiple sessions needs ctl<c> to terminate,
#it has to be running in the background and output to the
#log file name testcase.log

#Start TCP accelerated sessions
    my $iperf_tcp = "/usr/local/bin/iperf -c $host $args > $tcp_log &";
    print $OUTPUT "INVOKE TCP IPERF: $iperf_tcp \n";
    my $tcp_result = `$iperf_tcp`;
#    print $OUTPUT "Sleep 20 seconds before starting non-acc TCP sessions\n";
    sleep 5;

    $non_acc_host =~ s/20/30/;  #use the non-proxy IP 
    my $iperf_non_acc = "/usr/local/bin/iperf -c $non_acc_host $args -p 5002  > $non_acc_log &";
    print $OUTPUT "INVOKE TCP IPERF: $iperf_non_acc \n";
    my $non_acc_result = `$iperf_non_acc`;

#need to kill the iperf client when running with more 
#than two sessions
   print $OUTPUT "SLEEP $sleep_time \n";
   sleep $sleep_time;
   my $string ="ps -e | grep iperf | tail -1 ";
   while (`$string`)
   {
   kill_iperf();
   sleep 2;
   }

#Collect TCP test results
   $tcp_result = `cat $tcp_log | grep SUM`;
   print $OUTPUT "Total $sessions TCP BW comsumption: \n $tcp_result \n";
   my @tcp_result = split(/\s+/, $tcp_result);

#Collect non acc TCP test results
   $non_acc_result = `cat $non_acc_log | grep SUM`;
   print $OUTPUT "Total $sessions non acc TCP BW comsumption: \n $non_acc_result \n";
   my @non_acc_result = split(/\s+/, $non_acc_result);

#Compute the total throughputs
   my $counter=5;   
   if ($tcp_result[0] eq "") {$counter++}
   my $next_slot = $counter + 1;
   my $total_rate = $tcp_result[$counter] + $non_acc_result[$counter] ;

   if (($tcp_result[$next_slot] eq "Mbits\/sec") && ($non_acc_result[$next_slot] eq "Mbits\/sec"))
   {
     print $OUTPUT " MY ACC TCP IS: $tcp_result[$counter] \n";
     print $OUTPUT " MY NON ACC TCP IS: $non_acc_result[$counter] \n";
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
