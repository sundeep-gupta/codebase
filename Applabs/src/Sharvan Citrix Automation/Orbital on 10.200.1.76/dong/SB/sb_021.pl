#!/tools/bin/perl

=head NAME
sb_021.pl

=head1 DESCRIPTION

Test case = SB_4.3.8.3
With compression active, verify that the pipe is filled with one accelerated session 
of highly non-compressible data (100X ratio).

=head2 Test Category
Softboost

=head1 ENVIRONMENT
* 2 Orbs with softboost and compression enabled.
* Either reboot the tested Orb, or manually clear out the comp statistic.
* Lincence limit = 50 Mbsec.
* DR = 1.5Mbsec, 100RTT and 0% DROP


=head1 APPLICATIONS
=cut

=head1 Authors

Dong Duong 
04/01/05
=cut 


#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;


my $testcase = "sb_021";
getopt ("d, s") ;
if (  ! $opt_s  ) {
  print "Usage: $testcase  -d <DR> -s <ip address>  \n" ;
  exit 1 ;
}
my $dr = "20.20.20.1" ;   #default delay router if not provided.

if ($opt_d) {
  $dr = $opt_d; 
  chomp ($dr)}

my $host = $opt_s;
chomp ($host );
my $duration = 100;
my $wait_time = 120;
my $log_result = 0;
my $OUTPUT = "STDOUT";
my $expected_rate = 150; # 1.5BW * 100x = 150 Mbits/sec
my $log_file = ".\/logs\/"."$testcase".".log";

is (run_comp ($host, "-t $duration"),1,"SB & Compression: One session of highly compressible data") ;

sub run_comp
{
    my $host = shift ;
    my $args = shift ;
    if ($log_result) {
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
    }  
# Change the DR BW to 1.5 Mbps
   config_DR ($dr, 1500);
 
# start passing highly compressible data
    print "the LOG file is $log_file \n";
    my $invoke = "/usr/local/bin/iperf -c $host $args > $log_file &" ;
    print $OUTPUT "Invoke: $invoke \n";
    my $result = `$invoke` | tail -1 ;
    sleep $wait_time;   #wait for the test result.
    kill_all_iperf();
    sleep 10;
    print $OUTPUT "test result ..\n$result \n";
    my @rates = split(/\s+/, $result);
    print $OUTPUT "The expected rate: $expected_rate Mbits\/sec\n";
    print $OUTPUT "The actual rate  : $rates[6] $rates[7]\n";
    if ( ($rates[6] >= $expected_rate) && ($rates[7] eq "Mbits\/sec" )) 
    {
      return 1 ;
      } else {
      return  0 ;
    }
}

sub config_DR
#first input is the DR IP. The second is bw in Mbps
{
  print $OUTPUT "Configure the DR: $_[0]\n";
  my $set_bw = "ssh $_[0] \".\/set_bw.sh 30.30.20.0 $_[1] 200\"";
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
