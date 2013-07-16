#!/tools/bin/perl

=head NAME

=head1 DESCRIPTION

=head1 ENVIRONMENT

=head1 APPLICATIONS

=cut

=head1 bugs
If the test failed without the log_file recorded, there is a high chance
that the iperf server crashed.
=cut

=head1 Authors

Dong Duong 
3/24/2005

=cut 

###########################################################################
#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;


#"s" is the address of the remote server, as usual.
#"l" is the local server.
getopt ("s") ;

if (  ! $opt_s  ) {
  print "Usage: testcase_number -s < WINDOWS HOST>  \n" ;
  exit 1 ;
}

my $host = $opt_s;
chomp ($host );
my $testcase="run_WinIPERF";
my $duration =100;              
my $sessions = 20;               # number of sessions per direction
my $sleep_time = $duration + 50; #allow enough time to collect the test results.
my $expected_rate = 10; #in Mbits/sec
my $log_result = 1;
my $OUTPUT = "STDOUT";

is (run_SendReceive ($host, "-t $duration -P $sessions ") , 1, "Softboost: Run Iperf from Windows") ;

sub run_SendReceive
{
    my $host = shift ;
    my $args = shift ;
    my $send_log = ".\/logs\/"."$testcase"."_send.log";
#    my $receive_log = ".\/logs\/"."$testcase"."_receive.log";
#    my $log_file= ".\/logs\/"."$testcase".".log";
#    my @iperf_pid ="";
    if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
     }



#SSH to Windows and start Iperf test
    my $run_iperf = "ssh $host \"x:/\dong-suites/\iperf -c 30.30.20.165 -t 50 \" > $log_file &";
    print $OUTPUT "INVOKE: $run_iperf \n";
    my $send_result = `$send_tcp`;

#Start downstream test 
    my $receive_tcp = "ssh $host \"iperf -c $local_host $args \" > $receive_log &";
    print $OUTPUT "INVOKE: $receive_tcp \n";
    my $receive_result = `$receive_tcp`;

#clean up iperf processes
   print $OUTPUT "SLEEP $sleep_time \n";
   sleep $sleep_time;
#local processes
   my $find_pid ="ps -e | grep iperf ";
   @iperf_pid = `$find_pid`;
   print $OUTPUT "Local Iperf PID:   $find_pid \n";
   print $OUTPUT "@iperf_pid \n";
   my $i=0;
   while ($iperf_pid[$i])
   {
   print $OUTPUT "Iperf Process: $iperf_pid[$i] \n";
   kill_iperf($iperf_pid[$i]);
   $i++;
   sleep 2;
   }
#remote processes
   $find_pid ="ssh $host \"ps -e \" | grep iperf  ";
   @iperf_pid = `$find_pid`;
   print $OUTPUT "Remote Iperf PID:    $find_pid \n";
   print $OUTPUT "@iperf_pid \n";
   $i=0;
   while ($iperf_pid[$i])
   {
   print $OUTPUT "Iperf Process: $iperf_pid[$i] \n";
   rem_kill_iperf($host, $iperf_pid[$i]);
   $i++;
   sleep 2;
   }

#Collect sending TCP result
   $send_result = `cat $send_log | grep SUM`;
   print $OUTPUT "Sending Rate: \n $send_result \n";
   my @send_result = split(/\s+/, $send_result);

#Collect receiving TCP results
   $receive_result = `cat $receive_log | grep SUM`;
   print $OUTPUT "Receiving Rate: \n $receive_result \n";
   my @receive_result = split(/\s+/, $receive_result);

#Compute the total throughputs
   my $counter=5;   
   if ($send_result[0] eq "") {$counter++}
   my $next_slot = $counter + 1;
#   my $total_rate = $tcp_result[$counter] + $excluded_result[$counter] ;

   if (($send_result[$next_slot] eq "Mbits\/sec") && ($receive_result[$next_slot] eq "Mbits\/sec"))
   {
     print $OUTPUT "Sending Rate: $send_result[$counter] \n";
     print $OUTPUT "Receiving Rate: $receive_result[$counter] \n";
     if (($send_result[$counter] >= $expected_rate) && ($receive_result[$counter] >= $expected_rate))
     {
       return 1 ;
     } 
   } else 
      {
      print $OUTPUT "The pipe is not filled\n";
      return  0 ; 
      }
}

sub kill_iperf
{
 my $string = shift;
 if (( $string =~ /iperf/)) {
  my @field = split(/\s+/,$string);
  my $counter=0;
  if ($field[0] eq "") {$counter++}  #prevent the spaces at the beg of the list

  if (`kill $field[$counter]`) {
           print $OUTPUT "The Iperf deamon ID:$field[$counter] was not killed \n\n";
                 } else {
           print $OUTPUT "The Iperf deamon ID:$field[$counter] was killed \n\n";
                 }
        }else {
        print $OUTPUT "Iperf service was not running\n";
        }
}
#takes 2 inputs: host_ip and a string.
sub rem_kill_iperf
{
 my $host = shift;
 my $string = shift;
 if (( $string =~ /iperf/)) {
  my @field = split(/\s+/,$string);
  my $counter=0;
  if ($field[0] eq "") {$counter++}  #prevent the spaces at the beg of the list

  if (`ssh $host \"kill $field[$counter]\"`) {
           print $OUTPUT "The Iperf deamon ID:$field[$counter] was not killed \n\n";
                 } else {
           print $OUTPUT "The Iperf deamon ID:$field[$counter] was killed \n\n";
                 }
 }else {
    print $OUTPUT "Iperf service was not running\n";
 }
} #end of sub rem_kill_iperf



=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
