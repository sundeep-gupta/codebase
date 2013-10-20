#!/tools/bin/perl
=head NAME
sb_002.pl

=head1 DESCRIPTION

Use 2 pairs of Iperf client/server to generate a total of 40 accelerated sessions. 
One pair can be used if the bottleneck is not on the client/server.
Verify:
* the pipe is filled up to the license limit.

=head2 Test Category

* DR = 30Mbsec, 100RTT and 0% DROP

=head1 APPLICATIONS
run: sb_002.pl -s <acc_host_1> -e <acc_host_2>

=cut

=head1 bugs
If the test failed without the log_file recorded, there is a high chance
that the iperf server crashed.
=cut

=head1 Authors

Dong Duong 
3/29/2005

=cut 

###########################################################################
#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;



getopt ("s, e") ;
if (  ! $opt_s || !$opt_e ) {
  print "Usage: testcase_number -s < acc-server_1> -e <acc-sever_2>  \n" ;
  exit 1 ;
}
my $host_1 = $opt_s;
chomp ($host_1 );
my $host_2 = $opt_e;
chomp ($host_2);
my $testcase="sb_002";
my $duration =200;              
my $sessions = 20;               #20 accelerated per pair.
my $sleep_time = $duration + 30; #Before extracting the results.
my $expected_rate = 25; #in Mbits/sec
my $log_result = 1;
my $OUTPUT = "STDOUT";

is (run_iperf_pair ($host_1, $host_2, "-t $duration -P $sessions ") , 1, "Softboost: License Limitation ") ;

sub run_iperf_pair
{
    my $host_1 = shift ;
    my $host_2 = shift; 
    my $args = shift ;
    my $acc1_log = ".\/logs\/"."$testcase"."_acc1.log";
    my $acc2_log = ".\/logs\/"."$testcase"."_acc2.log";
    my $log_file= ".\/logs\/"."$testcase".".log";
   
    if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
     }



#Start the 1st 20 accelerated sessions to the 1st server
    my $acc1_tcp = "/usr/local/bin/iperf -c $host_1 $args > $tcp_log &";
    print $OUTPUT "INVOKE: $acc1_tcp \n";
    my $acc1_result = `$acc1_tcp`;
    
#Start another 20 acc sessions to the 2nd server.
    my $acc2_tcp = "/usr/local/bin/iperf -c $host_2 $arg > $acc2_log &";
    print $OUTPUT "INVOKE: $acc2_tcp \n";
    my $acc2_result = `$acc2_tcp`;

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

#Collect non acc TCP test results (excluded)
   $excluded_result = `cat $excluded_log | grep SUM`;
   print $OUTPUT "Total $sessions non acc TCP BW comsumption: \n $excluded_result \n";
   my @excluded_result = split(/\s+/, $excluded_result);

#Compute the total throughputs
   my $counter=5;   
   if ($tcp_result[0] eq "") {$counter++}
   my $next_slot = $counter + 1;
   my $total_rate = $tcp_result[$counter] + $excluded_result[$counter] ;

   if (($tcp_result[$next_slot] eq "Mbits\/sec") && ($excluded_result[$next_slot] eq "Mbits\/sec"))
   {
     print $OUTPUT " MY ACC TCP IS: $tcp_result[$counter] \n";
     print $OUTPUT " MY EXCLUDED TCP IS: $excluded_result[$counter] \n";
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
