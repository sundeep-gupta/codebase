#!/tools/bin/perl

=head NAME
sb_020.pl

=head1 DESCRIPTION
Verify that 3x compressed files can sucessfully pass through SB with Compression. 
The Iperf running through accelerated TCP will have a 2.6x ratios.
All other non-acc TCP sess can have any data form.
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
04/01/2005

=cut 

###########################################################################
#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;


my $testcase="system_reliability";
getopt ("s") ;
if (  !$opt_s  ) {
  print "Usage: $testcase  -s <rem host> \n" ;
  exit 1 ;
}
my $host = $opt_s;
chomp ($host );
my $duration = 50;     
my $sessions = 20;       #20 accelerated 
my $wait_time = $duration + 50; #Tune this value, for test with large number of sessions.
my $expected_rate = 27 * 2; #Mbits/sec The bw*2 (ratios)
my $log_result = 0;
my $OUTPUT = "STDOUT";
my $log_file= ".\/logs\/"."$testcase".".log";

is (run_comp($host, "-t $duration -P $sessions -X /tools/files/comp_files"),1,"SB & Compression: Transfer 2.x files") ;

sub run_comp
{
    my $host = shift;
    my $args = shift;
#If log the result, then open the log file
    if ($log_result) {
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG"
     }

    my $iperf_tcp = "/usr/local/bin/iperf -c $host $args  > $OUTPUT &";
    print $OUTPUT "INVOKE: $iperf_tcp \n";
    my $tcp_result = `$iperf_tcp`;
    print $OUTPUT "Sleep $interval seconds\n";
    sleep $wait_time;

#Kill Iperf processes
   my $string ="ps -e | grep iperf | tail -1 ";
   while (`$string`)
   {
   kill_iperf();
   sleep 5;
   }

#Collect TCP test results
   $tcp_result = `cat $tcp_log | grep SUM`;
   print $OUTPUT "The total throughput of $session with 2.x compress ratios: \n $tcp_result \n";
   my @tcp_result = split(/\s+/, $tcp_result);


#Compute the total throughputs
   my $counter=5; #the default result output by IPERF is in slot 5.  
   if ($tcp_result[0] eq "") {$counter++}
   my $next_slot = $counter + 1;

   print $OUTPUT "The expected throughput: $expected_rate Mbits/sec\n";
   print $OUTPUT "The actual throughput: $total_rate Mbits/sec\n";
   if (($tcp_result[$next_slot] eq "Mbits\/sec") && ($tcp_result[$counter] >= $expected_rate))
   {
       return 1 ;
   } else { return  0 ; }
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
