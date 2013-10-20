#!/tools/bin/perl

=head NAME
sb_010.pl

=head1 DESCRIPTION
With IP Exclusion list, verify that non-accelerated TCP can co-exist with acc TCP.
* Use Iperf to 2 separate servers, one accelerated &
* the other non-acc via the exclusion list.
* The Pipe should be filled.
* The accelerated TCP should not crush non-acc TCP and vice versa.

=head2 Test Category
Softboost

=head1 ENVIRONMENT
* 2 Orbs with softboost configured.
* Lincence limit = 35 Mbsec.
* DR = 30Mbsec, 100RTT and 0% DROP
* The server host must have iperf -s & iperf -s -p 5002

=head1 APPLICATIONS
run: sb_010.pl -s <acc_host> -e <non_acc_host>

=cut

=head1 bugs
If the test failed without the log_file recorded, there is a high chance
that the iperf server crashed.
=cut

=head1 Authors

Dong Duong 
3/15/2005

=cut 

###########################################################################
#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;



#"s" is the address of the accelerated server, as usual.
#"e" is the IP of the excluded IP host.
getopt ("s, e") ;
if (  ! $opt_s || !$opt_e ) {
  print "Usage: testcase_number -s < acc-server> -e <excluded-sever  \n" ;
  exit 1 ;
}
my $host = $opt_s;
chomp ($host );
my $excluded_host = $opt_e;
chomp ($excluded_host);
my $testcase="sb_010";
my $duration =150;              #min must be 50 => 30 sec for TCP
my $sessions = 20;               #20 accelerated & 20 UDP sessions
my $sleep_time = $duration + 80; #running 20 acc & 20 non-acc against a server, need 50 extra.
my $expected_rate = 27; #in Mbits/sec
my $log_result = 1;
my $OUTPUT = "STDOUT";

is (run_iperf($host, $excluded_host, "-t $duration -P $sessions ") , 1, "Softboost: Accelerated & Excluded TCP ") ;

sub run_iperf
{
    my $host = shift ;
    my $excluded_host = shift; 
    my $args = shift ;
    my $tcp_log = ".\/logs\/"."$testcase"."_tcp.log";
    my $excluded_log = ".\/logs\/"."$testcase"."_excluded.log";
    my $log_file= ".\/logs\/"."$testcase".".log";
   
    if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
     }


#Start Iperf for excluded sessions
    my $iperf_excluded = "/usr/local/bin/iperf -c $excluded_host $arg > $excluded_log &";
    print "INVOKE TCP IPERF: $iperf_excluded \n";
    my $excluded_result = `$iperf_excluded`;

#Start TCP accelerated sessions
    my $iperf_tcp = "/usr/local/bin/iperf -c $host $args > $tcp_log &";
    print "INVOKE TCP IPERF: $iperf_tcp \n";
    my $tcp_result = `$iperf_tcp`;

#need to kill the iperf client when running with more 
#than two sessions
   print "SLEEP $sleep_time \n";
   sleep $sleep_time;
   my $string ="ps -e | grep iperf | tail -1 ";
   while (`$string`)
   {
   kill_iperf();
   sleep 2;
   }

#Collect TCP test results
   $tcp_result = `cat $tcp_log | grep SUM`;
   print "Total $sessions TCP BW comsumption: \n $tcp_result \n";
   my @tcp_result = split(/\s+/, $tcp_result);

#Collect non acc TCP test results (excluded)
   $excluded_result = `cat $excluded_log | grep SUM`;
   print "Total $sessions non acc TCP BW comsumption: \n $excluded_result \n";
   my @excluded_result = split(/\s+/, $excluded_result);

#Compute the total throughputs
   my $counter=5;   
   if ($tcp_result[0] eq "") {$counter++}
   my $next_slot = $counter + 1;
   my $total_rate = $tcp_result[$counter] + $excluded_result[$counter] ;

   if (($tcp_result[$next_slot] eq "Mbits\/sec") && ($excluded_result[$next_slot] eq "Mbits\/sec"))
   {
     print " MY ACC TCP IS: $tcp_result[$counter] \n";
     print " MY EXCLUDED TCP IS: $excluded_result[$counter] \n";
     if ($total_rate >= $expected_rate)
     {
       print "The expected throughput: $expected_rate Mbits/sec\n";
       print "The total actual throughput: $total_rate Mbits/sec\n";
       return 1 ;
     } 
   } else 
      {
      print "The pipe is not filled\n";
      print "The total actual throughput: $total_rate Mbits/sec\n";
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
           print "The Iperf deamon ID:$field[$counter] was not killed \n";
                 } else {
           print "The Iperf deamon ID:$field[$counter] was killed \n";
                 }
#       return 1;
        }else {
        print "Iperf service was not running\n";
#  return 0;
        }
} #end of main


=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
