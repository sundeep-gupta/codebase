!/tools/bin/perl

=head NAME
sb_performance.pl

=head1 DESCRIPTION

=head2 Test Category
Performance

=head1 ENVIRONMENT

=head1 APPLICATIONS
=cut
=head1 bugs
=cut

=head1 Authors
Dong Duong 
6/29/05
This version is for regression testbed only
=cut 

use lib '/tools/lib/perl5/site_perl/5.8.4';
use lib '/tools/tests/regression';
use Test::More  qw(no_plan); 
use Time::localtime;  
use Carp ;
use Getopt::Std ;
use XMLRPC::Lite;
use Data::Dumper;
use orbital_rpc;


my $testcase="sb_performance";
my $dr = '10.200.199.154';   #POD4
#my $dr = '20.20.20.1';
my $duration = 60;
my $ratio = 0.90;                  #expect thrput without compression

#Require @least 3 inputs: the locOrb, remOrb and the ISTAT Server.
getopt ("r,o,p,s,c,m,b") ;

if (  ! $opt_s || ! $opt_o || !$opt_p) {
  print "Usage: $testcase -o <locOrb> -p <remOrb> -s <Iperf Server> |-c <1> |-m <1> |-b <1> |-r<rtt>  \n" ;
  exit 1 ;
}
my $comp = 0;                #default is no compression
if ($opt_c) { $comp = $opt_c; chomp ($comp) };

my $send_mail = 0;                #default is not sending email
if ($opt_m) { $send_mail = $opt_m; chomp ($send_mail) };

if ($comp) { $ratio = 2.5 }        #set to 2.5x for now

my @bw_list = (1.5, 15, 45);  
my @sess_list = (1, 10, 100, 300);                 #This list is proposed by Daniel 

my $host = $opt_s; chomp ($host );

my $locOrb = $opt_o; chomp ($locOrb);       #setup the Orb for XMLRPC
my $locOrb_url = "http://$locOrb:2050/RPC2";
my $locOrb_rpc = Orbital::Rpc->new($locOrb_url);
my $version = $locOrb_rpc->get_system_variable("Version");

my $remOrb = $opt_r; chomp ($remOrb);       #setup the Orb for XMLRPC
my $remOrb_url = "http://$remOrb:2050/RPC2";
my $remOrb_rpc = Orbital::Rpc->new($remOrb_url);
my $maxbw_bps = 50000000;          #the remOrb must have this value before testing.
my $maxbw = 50;                      #Mbps.

my $softboost= 0;           #set to HB as default
if ($opt_b) {$softboost=$opt_b; chomp($softboost)}  #SB=1 & HB=0

my $rtt = 100;
if ($opt_r) { $rtt = $opt_r; chomp ($rtt) }

my $sess =1;
my $sleep_time = $duration + 10; #Tune this value, for test with large number of sessions.

my $tm=localtime;
$tm = sprintf("%02d%02d%04d", $tm->mday,($tm->mon)+1, $tm->year+1900);


#create the individual log file
my $log_file = "\/logs\/regression_results\/"."NonComp_"."$testcase"."_$tm".".log";
if ($comp) { $log_file = "\/logs\/regression_results\/"."Comp_"."$testcase"."_$tm".".log";}
print "this is the log file: $log_file \n";
open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";

#The stat file retains all the performance test results. Data is appent to the file.
my $stat_file = "\/logs\/regression_results\/"."$testcase"."_stats".".log"; #contains perf results of all individual test.
if (-e $stat_file) {
   open (STAT,  ">> $stat_file") || die "Could not open the file $stat_file \n";
   } else {                       #file is not there
        open (STAT,  "> $stat_file") || die "Could not open the file $stat_file \n";

        #Create the file header
        print STAT '-' x125;
        printf STAT "\n%26s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s\n",'1.5Mb','1.5Mb','1.5Mb','1.5Mb','15Mb','15Mb','15Mb','15Mb','45Mb','45Mb','45Mb','45Mb';
        print STAT '-' x125;
        printf STAT "\n%8s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s\n",'Date','Release','1sess','10sess','100sess','300sess','1sess','10sess','100sess','300sess','1sess','10sess','100sess','300sess';
        print STAT '-' x125, "\n";
        }

#Checking the tested Orb's version
@version = split(/\s+/, $version);
my $i =0;
my $release="";                         #The short form 
while ($version[$i]) {
  if ($version[$i++] eq "Release" ){     #$i now at the version number
     $release = "$version[$i++]"."-";        #$i now pointing at "Build"
     my $subver =  int ($version[++$i]) ;
#     print "Version sub:  $subver \n";
     $release = "$release"."$subver"; 
     }
  }
printf "THE TESTED VERSION: %8s \n", $release;     

# By default, this test is w/o compression.
print "\nThe Current Compression Status: ", $locOrb_rpc->get_parameter('Compression.EnableCompression'),"\n";
if ($comp) {
   print "Set Compression On... ", $locOrb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n"
   } else {
   print "Set Compression Off... ", $locOrb_rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
   }
print "\nThe Tested Compression Setting: ", $locOrb_rpc->get_parameter('Compression.EnableCompression'),"\n";

#Configure BW on the Orb & DR global
#if SB, both Orb will be set to 50Mbps and the DR will control the tested BW
#if HB, the remOrb & DR will be set to 50Mbps, and the sending Orb (locOrb) will control the tested BS
if ($softboost)   {        #if it's SB then configure the DR once before testing
   print LOG "\nSet locOrb To SoftBoost: ", $locOrb_rpc->set_parameter('UI.Softboost', $softboost);
   print LOG "\nSet remOrb To SoftBoost: ", $remOrb_rpc->set_parameter('UI.Softboost', $softboost);
   
   print LOG "Set the locOrb SendRate To $maxbw_bps \n", $locOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
   print LOG "Set the locOrb RecvRate To $maxbw_bps \n", $locOrb_rpc->set_parameter('SlowRecvRate', $maxbw_bps);
   print LOG "Set the remOrb SendRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
   print LOG "Set the remOrb RecvRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowRecvRate', $maxbw_bps);
                                                                                                                                                                      
   print LOG "\nThe locOrb BW-Management is now... ", $locOrb_rpc->get_parameter('UI.Softboost');
   print LOG "\nThe remOrb BW-Management is now... ", $remOrb_rpc->get_parameter('UI.Softboost',"\n");

   } else {         #these two should have the upper limit (50Mbps). The locOrb will dictate the sending rate
        config_CNISTNET ($dr, $dr_dest, ($maxbw * 1000), '100', '0.0');
#       config_TC ($dr, $maxbw, '100', '0.0');
        print LOG "Set the remOrb SendRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
        if ( ($locOrb_rpc->get_parameter('UI.Softboost')) == 1) { $locOrb_rpc->set_parameter('UI.Softboost', '0' )}
        if ( ($remOrb_rpc->get_parameter('UI.Softboost')) == 1) { $remOrb_rpc->set_parameter('UI.Softboost', '0' )}
        }


#stamp the date & release to the log file
printf STAT "\n%8s%9s", $tm, $release;

foreach $bw (@bw_list) {
   $expected_rate = ($bw * $ratio);
   my $bw_bps = $bw * 1000000;        #bit/sec required for Orb send-rate setting
   
   if ($softboost)   {            #if SB then configure the DR for the tested BW
      config_CNISTNET ($dr, $dr_dest, ($bw * 1000), '100', '0.0');
      #config_TC ($dr, $bw, '100', '0.0');
      } else {
          print LOG "Set SendRate...\n", $locOrb_rpc->set_parameter('SlowSendRate', $bw_bps);
          if ($bw_bps == $locOrb_rpc->get_parameter('SlowSendRate')) {
             print LOG "The SendRate was sucessfully set: $bw_bps \n";
             } else {
                 print LOG "The SendRate is not properly set to $bw_bps \n";
                 print LOG "The current SendRate is: ", $locOrb_rpc->get_parameter('SlowSendRate'), "\n";
                 exit;
                 }

          }

   foreach $sess (@sess_list) {
      if ($comp) {
         print "Reset Compression History ", $locOrb_rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
         print "...", $locOrb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n"
         }

      if ($sess == 1) {                 	#handle this case separately
         is (run_perf ($host, $bw, $duration), 1, "Performance: $sess session over $bw Mbps") ;
         sleep 5;
         print LOG "------------------------------------\n\n";
         } else {                #if number of tested sessions are more than 1
             is (run_perfs ($host, $bw, $duration, $sess), 1, "Performance: $sess sessions over  $bw Mbps") ;
             sleep 5;
             print LOG "------------------------------------\n\n";
             }      #fi
 
  }
}

if ($comp) {
   printf STAT "%8s\n\n", 'COMP';              #Stamp the result of either compress or non-compress
   } else {
       printf STAT "%8s\n\n", 'NO-COMP';
       }              
    
#Reset Orb to the defaul 
   print LOG "\nSet locOrb To HB ", $locOrb_rpc->set_parameter('UI.Softboost', '0');
   print LOG "\nSet remOrb To HB ", $remOrb_rpc->set_parameter('UI.Softboost', '0');
   config_TC ($dr, $maxbw, '100', '0.0');
#Test Completed. Send the result out.

if ($send_mail) {
#   print `mail \-s \"Performance Test Results $release\" engineering\@orbitaldata.com \< $stat_file`;
    print `mail \-s \"Performance Test Results\" dong\@orbitaldata.com \< $stat_file`;
   }


#********************************************************
sub run_perf
{
    my $host = shift ;
    my $bw = shift;
    my $duration = shift ;
    my $pass="FAIL";
# format: change_dr (<dr ip> <rem_net> <bw> <rtt> <drop>)
#    $bw_Kb = $bw * 1000;     #convert to Kbps
#    config_DR ($dr, $net1_add, $bw_Kb, $rtt, 0);
#    sleep 10;
#Start Performance test
    my $test = "/usr/local/bin/iperf -c $host -t $duration";
    print LOG "Invoke: $test \n";
    my $result = `$test | tail -1`;
    sleep 5;
 
#Verify the results ..
   my @rate = split(/\s+/, $result);
   my $unit = pop(@rate);
   my $number = pop(@rate);
   print LOG "Performance Test of $sess over $bw\n";
   print LOG "The expected rate: $expected_rate Mbits/sec\n";
   print LOG "The actual rate  : $number $unit \n";
   if ( ($number >= $expected_rate) && ($unit eq "Mbits/sec" )) {
      print LOG "Throughput is in the expected range - PASS! \n";
      $pass = PASS;
      printf STAT "%9.2f", $number;
      return 1;
      } elsif ($unit eq "Mbits/sec") {
           print LOG "Throughput is NOT in the expected range - FAIL! \n";
           printf STAT "%9.2f", ($number);
           return  0 ;
           } elsif ($unit eq "Kbits/sec") {
                $number = $number/1000;
                if ($number >= $expected_rate) {
                    print LOG "Throughput is in the expected range - PASS! \n";
                    printf STAT "%9.2f", $number;
                    $pass = PASS;
                    return 1;
                    } else {
                        print LOG "Throughput is NOT in the expected range - FAIL! \n";
                        printf STAT "%9.2f", $number;
                        return  0 ;
                        }
                }
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
    my $temp_log= "\/logs\/regression_results\/"."$testcase"."_temp.log";
#Try this.. "iperf_c.sh <host> <sessions> <duration>
    my $test = "/tools/tests/regression/iperf_c.sh $host $sess $duration > $temp_log &";
    print LOG "Invoke: $test \n";
    my $result = `$test`;
 
#Wait for the test to complete ...
   print LOG "SLEEP $sleep_time \n";
   sleep $sleep_time;
 
# Gather the  results ..
   print LOG  `cat $temp_log`;
   $result = `cat $temp_log | grep SUM`;
   my $i = 1;
   while (! $result && ($i < 10)) {    #wait an extra (max) 450 sec before failing
     print LOG "The Result is not ready...Sleep 50 Sec \n";
     sleep 50;
     $result = `cat $temp_log | grep SUM`;
     $i++;
     }                       #wait until the test is completed
       
   kill_iperf();
   sleep 10;
   my @rate = split(/\s+/, $result);
   my $unit = pop(@rate);
   my $number = pop(@rate);
   print LOG "Performance Test of $sess over $bw\n";
   print LOG "The expected rate: $expected_rate Mbits/sec\n";
   print LOG "The actual rate  : $number $unit \n";
   if ( ($number >= $expected_rate) && ($unit eq "Mbits/sec" )) {
      print LOG "Throughput is in the expected range - PASS! \n";
      $pass = PASS;
      printf STAT "%9.2f", $number;
      return 1;
      } elsif ($unit eq "Mbits/sec") {
           print LOG "Throughput is NOT in the expected range - FAIL! \n";
           printf STAT "%9.2f", ($number);
           return  0 ;
           } elsif ($unit eq "Kbits/sec") {
                $number = $number/1000;
                if ($number >= $expected_rate) {
                    print LOG "Throughput is in the expected range - PASS! \n";
                    printf STAT "%9.2f", $number;
                    $pass = PASS;
                    return 1;
                    } else {
                        print LOG "Throughput is NOT in the expected range - FAIL! \n";
                        printf STAT "%9.2f", $number;
                        return  0 ;
                        }
                 }
}
#*************************************************************************

sub kill_iperf
{
 my $string = `ps -e | grep iperf | tail -1 `;
 print LOG "This Iperf process is running $string \n";
 my @field = split(/\s+/,$string);
 my $counter=0;
 if ($field[0] eq "") {$counter++}
 if (( $string =~ /iperf/)) {
  if (`kill $field[$counter]`) {
           print LOG  "The Iperf deamon ID:$field[$counter] was not killed \n";
                 } else {
           print LOG "The Iperf deamon ID:$field[$counter] was killed \n";
                 }
        }else {
        print LOG "Iperf service was not running\n";
        }
} #end of kill_iperf

#*************************************************************************
sub kill_all_iperf
{
   my $find_pid ="ps -e | grep iperf ";
   @iperf_pid = `$find_pid`;
   print LOG "Active ISTAT PID: @iperf_pid \n";
   my $i=0;
   while ($iperf_pid[$i])
   {
     print LOG "Iperf Process: $iperf_pid[$i] \n";
     if ($iperf_pid[$i] =~ /iperf/){
     my @field = split(/\s+/, $iperf_pid[$i]);
     my $counter = 0;
     if ($field[0] eq "") {$counter++}  #skip the 1st member if blank
     if (`kill $field[$counter]`) {
           print LOG "The Iperf deamon ID:$field[$counter] was not killed \n\n";
                 } else {
           print LOG "The Iperf deamon ID:$field[$counter] was killed \n\n";
                 }
        }else {
        print LOG "Iperf service was not running\n";
        }
                                                                                                                              
     $i++;
     sleep 2;
   } #end while
} #end of kill_all_iperf

#*************************************************************************
sub config_CNISTNET
#Need 4 inputs: <DR IP> <REM-NETWORK> <BW> <RTT> <LOSS>
{
  print LOG "Configure CNISTNET DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \"\/root\/set_bw.sh $_[1] $_[2] $_[3] $_[4]\" ";
#  print "\nTESTING..Show DR config \n", $set_dr;
  $set_dr = `$set_dr`;
  print LOG "Below is the CNISTNET DR configuration: \n $set_dr \n";
}
                                                                                                                             
                                                                                                                             
                                                                                                                             
                                                                                                                             
#************************************************************************
# This is for the Meshed Testbed DR
# /tools/test/test_common/neset.sh  -bw 100e6 -rtt 100 -loss 1
#Need 3 inputs: <DR IP> <BW> <RTT> <LOSS>
#------------------------------------------------------------------------
sub config_TC
{
  my $bw = "$_[1]"."e6";
  print LOG "Configure TC DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \"\/tools\/tests\/test_common\/neset.sh \-bw $bw \-rtt $_[2] \-loss $_[3] \" ";
  $set_dr = `$set_dr`;
}


=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
