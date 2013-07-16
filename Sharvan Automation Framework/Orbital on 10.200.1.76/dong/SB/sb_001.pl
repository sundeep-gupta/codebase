#!/tools/bin/perl

=head NAME
sb_001.pl

=head1 DESCRIPTION
Verify that the pipe is filled with one accelerated session.
Test case = SB_4.3.1.1

No Compression

=head2 Test Category
Softboost

=head1 ENVIRONMENT
* 2 Orbs with softboost configured.
* Lincence limit = 30 Mbsec.
* DR = 30Mbsec, 100RTT and 0% DROP

=cut

=head1 Authors

Dong Duong 

=cut 


use FindBin;
use lib $FindBin::Bin;
use Time::localtime;
use XMLRPC::Lite;
use Data::Dumper;
use orbital_rpc;
#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
#use Net::RawIP qw ( :pcap) ;

my $testcase = "sb_001";
my $log_result = 1;

getopt ("o, s, l, b") ;
if (  ! $opt_s || !$opt_o ) {
  print "Usage: testcase_number -s <ip address> -b <dr_bw/Kbits> -r <dr_rtt>  \n" ;
  exit 1 ;
}
my $host = $opt_s; chomp ($host );
my $orb = $opt_o; chomp ($orb);       #setup the Orb for XMLRPC
my $url = "http://$orb:2050/RPC2";
my $rpc = Orbital::Rpc->new($url);

my $dr = '20.20.20.1';  #need to modify this IP if not runnin on Dong's testbed
my $dr_bw = 45000; 	#default is 45Mbps
my $dr_rtt = 100; 	#default rtt
if ($opt_b) {$dr_bw = $opt_b; chomp($dr_bw)}
if ($opt_r) {$dr_rtt= $opt_r; chomp($dr_rtt)}

my $duration = 60;	#test runs for 60 seconds
my $tm=localtime;
$tm = sprintf("%02d%02d%04d", $tm->mday,($tm->mon)+1, $tm->year+1900);

my $OUTPUT = "STDOUT";
my $log_dir = '/logs/TestResult';
my $expected_rate = ($dr_bw/1000) * 0.9; #in Mbits/sec, assuming the criteria is 90% of the pipe.

if ($log_result) {
    my $log_file = "$log_dir\/"."$testcase".".log";
    open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
    $OUTPUT = "LOG";
    }  

#Turn OFF Compression
print $OUTPUT "Set Compression.EnableCompression To OFF\n ", $rpc->set_parameter('Compression.EnableCompression', '0');

is (run_iperf($host, $duration, $dr_bw, $dr_rtt) , 1, "Softboost: Throughput with one accelerated session over $dr_bw Kbit/sec ") ;

sub run_iperf
{
    my $host = shift ;
    my $duration = shift ;
    my $dr_bw = shift;
    my $dr_rtt = shift;
    my $dr_dest = '0.0.0.0';
    
#configure the DR to the tested BW. The LOSS should be 0
    config_CNISTNET ($dr, $dr_dest, $dr_bw, $dr_rtt, 0);
    
    my $iperf_test = "/usr/bin/iperf -c $host -t $duration" ;
    my $result = `$iperf_test | tail -1` ;
    sleep 10;   #wait for the test result.
#the result should be the line with transfered rates
   print $OUTPUT "test result ..\n$result \n";
   my @rates = split(/\s+/, $result);
#   foreach my $i (0 .. 13)
#    {print "I=$i $rates[$i]\n"; }   
    if ( ($rates[6] >= $expected_rate) && ($rates[7] eq "Mbits\/sec" )) 
    {
      print $OUTPUT "The expected rate: $expected_rate Mbits\/sec\n";
      print $OUTPUT "The actual rate  : $rates[6] $rates[7]\n";
      return 1 ;
      } else {
      print $OUTPUT "The expected rate: $expected_rate Mbits\/sec\n";
      print $OUTPUT "The actual rate  : $rates[6] $rates[7] \n";
      return  0 ;
    }
}

sub config_CNISTNET
#Need 4 inputs: <DR IP> <REM-NETWORK> <BW> <RTT> <LOSS>
{
  print $OUTPUT "Configure CNISTNET DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \"\/root\/set_bw.sh $_[1] $_[2] $_[3] $_[4]\" ";
#  print "\nTESTING..Show DR config \n", $set_dr;
  $set_dr = `$set_dr`;
  print $OUTPUT "Below is the CNISTNET DR configuration: \n $set_dr \n";
}


=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
