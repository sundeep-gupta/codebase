#!/tools/bin/perl

=head NAME
sb_003.pl

=head1 DESCRIPTION

Test Case = SB_4.3.1.4
Verify that sessions within a flow have an equal shared of BW.
The Sessions of multiple (2) flows sucesfully transfer data.
All 2 pipes are filled during the test

=head2 Test Category
Softboost

=head1 ENVIRONMENT
* 2 Orbs with softboost configured.
* Lincence limit = 50 Mbsec.
* DR = 20Mbsec, 200RTT and 0% DROP (flow_1)
* DR = 15Mbps,  300RTT  (flow_2)


=head1 APPLICATIONS
=cut

=head1 bugs
If the test failed without the log_file recorded, there is a high chance
that the iperf server crashed.
=cut

=head1 Authors

Dong Duong 
3/30/05
=cut 


#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;


my $testcase="sb_003";

getopt ("d, s, t") ;
if (  ! $opt_s || ! $opt_t  ) {
  print "Usage: $testcase -d <DR> -s <host_1> -t <host_2>  \n" ;
  exit 1 ;
}
my $DR = "20.20.20.1";
if ( $opt_d ) { 
   $DR = $opt_d;
   chomp ($DR); } 
my $host = $opt_s;
chomp ($host );
my $host_2 = $opt_t;
chomp ($host_2 );
my $duration = 100;
my $sessions = 20;
my $sleep_time = $duration + 20; #Tune this value, for test with large number of sessions.
my $expected_flow1_rate = 16; #Pipe 1 is 20Mbits/sec
my $expected_flow2_rate = 12; #Pipe 2 is 15Mbits/sec
my $log_result = 0;
my $OUTPUT = "STDOUT";

is (run_iperf($host, $host_2, "-t $duration -P $sessions "), 1, "Softboost: Send rate is bounded by the total line BW") ;

sub run_iperf
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
#Configure the DR
#print $OUTPUT "The DR IP is: $DR \n";
config_DR ($DR);

#Start test on flow1 and flow2
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
      if ( ($flow2_rate[$flow2_slot] >= $expected_flow2_rate) && ($flow2_rate[$flow2_slot + 1] eq "Mbits/sec" )) {
        return 1 ;}
    } else { return  0 ; }
}
sub config_DR
{
  print $OUTPUT "Configure the DR: $_[0]\n";
  my $set_bw = "ssh $_[0] \".\/set_bw.sh 30.30.20.0 20000 200;.\/set_bw.sh 30.30.40.0 15000 300;.\/set_bw.sh 20.20.0.0 30000 200\"";
  $set_bw = `$set_bw`;
  print $OUTPUT "Below is the DR configuration: \n $set_bw \n";
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
#       return 1;
        }else {
        print $OUTPUT "Iperf service was not running\n";
#  return 0;
        }
}


=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
