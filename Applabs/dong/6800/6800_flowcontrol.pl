#!/tools/bin/perl

=head NAME
6800_flowcontrol.pl

=head1 Authors
For Orb6800 testbed only
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


my $testcase="6800_flowcontrol";
my $dr = '20.20.20.1';
my $duration = 60;
my $sleep_time = $duration + 10; #Tune this value, for test with large number of sessions.
my $ratio = 0.90;                  
my @rtt_list = (0, 100, 200, 300);
my @sess_list = (1, 100, 500);           
my $log_dir = '/var/tmp/';
my $maxbw_bps = 500000000;          #the remOrb must have this value before testing.
my $maxbw = 500;                      #700 Mbps.
my $rtt = 100;                      #default rtt ms
my $loss = 0;
my $dr_dest = '0.0.0.0';
my  $expected_rate = 200;           #Don't know the upper limit yet. the contrain could be client

#Require @least 3 inputs: the locOrb, remOrb and the ISTAT Server.
getopt ("r,o,s,c,m,b,d") ;

if (  ! $opt_s || ! $opt_o || !$opt_r) {
  print "Usage: $testcase -o <locOrb> -r <remOrb> -s <Iperf Server> |-c <1> |-m <1> |-b <1>|-d <DR-IP>   \n" ;
  exit 1 ;
}
my $comp = 0;                #default is no compression
if ($opt_c) { $comp = $opt_c; chomp ($comp) };

my $send_mail = 0;                #default is not sending email
if ($opt_m) { $send_mail = $opt_m; chomp ($send_mail) };

if ($comp) { $ratio = 2.5 }        #set to 2.5x for now

my $host = $opt_s; chomp ($host );

if ($opt_d) {$dr = $opt_d; chomp ($dr)};

my $locOrb = $opt_o; chomp ($locOrb);       #setup the Orb for XMLRPC
my $locOrb_url = "http://$locOrb:2050/RPC2";
my $locOrb_rpc = Orbital::Rpc->new($locOrb_url);
my $version = $locOrb_rpc->get_system_variable("Version");

my $remOrb = $opt_r; chomp ($remOrb);       #setup the Orb for XMLRPC
my $remOrb_url = "http://$remOrb:2050/RPC2";
my $remOrb_rpc = Orbital::Rpc->new($remOrb_url);

my $softboost= 0;           #set to HB as default
if ($opt_b) {$softboost=$opt_b; chomp($softboost)}  #SB=1 & HB=0



my $tm=localtime;
$tm = sprintf("%02d%02d%04d", $tm->mday,($tm->mon)+1, $tm->year+1900);

my $release = &orb_version($locOrb_rpc); 


#create the individual log file
my $log_file = "$log_dir"."NonComp_"."$testcase"."_$release"."_$tm".".log";
if ($comp) { $log_file = "$log_dir"."Comp_"."$testcase"."_$release"."_$tm".".log";}
print "this is the log file: $log_file \n";
open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
print LOG "\nOrbital $locOrb is running ...", &orb_version($locOrb_rpc), "\n";
print LOG "\nOrbital $remOrb is running ...", &orb_version($remOrb_rpc), "\n";

#The stat file retains all the performance test results. Data is appent to the file.
my $stat_file = "$log_dir"."$testcase"."_stats".".log"; #contains perf results of all individual test.
if (-e $stat_file) {
   open (STAT,  ">> $stat_file") || die "Could not open the file $stat_file \n";
   } else {                       #file is not there
   open (STAT,  "> $stat_file") || die "Could not open the file $stat_file \n";

#Create the file header
   print STAT "\n",'*' x30;
   print STAT "\nDELAY ROUTER'S LOSS:  $loss %\n";
   print STAT '*' x30,"\n\n";

   print STAT '-' x125;
   printf STAT "\n%26s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s\n",'0 RTT','0 RTT','0 RTT','100 RTT','100 RTT','100 RTT','200 RTT','200 RTT','200 RTT','300 RTT','300 RTT','300 RTT';
   print STAT '-' x125;
   printf STAT "\n%8s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s\n",'Date','Release','1sess','100sess','500sess','1sess','100sess','500sess','1sess','100sess','500sess','1sess','100sess','500sess';
   print STAT '-' x125, "\n";
}

#stamp the date & release to the log file
printf STAT "\n%8s%9s", $tm, $release;

# By default, this test is w/o compression.
# print "\nThe Current Compression Status: ", $locOrb_rpc->get_parameter('Compression.EnableCompression'),"\n";
if ($comp) {
   print "Set Compression On... ", $locOrb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n"
   } else {
   print "Set Compression Off... ", $locOrb_rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
   }
# print "\nThe Tested Compression Setting: ", $locOrb_rpc->get_parameter('Compression.EnableCompression'),"\n";

#Initialize the test bed

print LOG "Set the locOrb SendRate To $maxbw_bps \n", $locOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
print LOG "Set the locOrb RecvRate To $maxbw_bps \n", $locOrb_rpc->set_parameter('SlowRecvRate', $maxbw_bps);
print LOG "Set the remOrb SendRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
print LOG "Set the remOrb RecvRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowRecvRate', $maxbw_bps);
config_CNISTNET ($dr, $dr_dest, $maxbw, $rtt, $loss);

if ($softboost)   {        
   print LOG "\nSet locOrb To SoftBoost: ", $locOrb_rpc->set_parameter('UI.Softboost', $softboost);
   print LOG "\nSet remOrb To SoftBoost: ", $remOrb_rpc->set_parameter('UI.Softboost', $softboost);
   } else {        
        $locOrb_rpc->set_parameter('UI.Softboost', '0' );
        $remOrb_rpc->set_parameter('UI.Softboost', '0' );
        }


foreach $rtt (@rtt_list) {
   config_CNISTNET ($dr, $dr_dest, $maxbw, $rtt, $loss);

   foreach $sess (@sess_list) {
      if ($comp) {
         print "Reset Compression History of the locOrb... ", $locOrb_rpc->send_command('CompressionHistory reset'), "\n";
         }
      if ($sess == 1) {                 	#handle this case separately
         is (run_perf ($host, $maxbw, $duration), 1, "Performance: $sess session over $maxbw Mbps & $rtt rtt") ;
         sleep 5;
         print LOG "------------------------------------\n\n";
         } else {                #if number of tested sessions are more than 1
          is (run_perfs ($host, $maxbw, $duration, $sess), 1, "Performance: $sess sessions over  $maxbw Mbps & $rtt rtt") ;
          sleep 5;
          print LOG "------------------------------------\n\n";
          }      #fi
   }
}
    
if ($softboost) {
   if ($comp) {
      printf STAT "%14s\n\n", 'SB&COMP';
      } else {
           printf STAT "%14s\n\n", 'SB&NO_COMP';
           }
   } else {
        if ($comp) {
           printf STAT "%14s\n\n", 'HB&COMP';
           } else {
                printf STAT "%14s\n\n", 'HB&NO_COMP';
                }
        }

#Reset Orb to the defaul 
   print LOG "\nSet locOrb To HB ", $locOrb_rpc->set_parameter('UI.Softboost', '0');
   print LOG "\nSet remOrb To HB ", $remOrb_rpc->set_parameter('UI.Softboost', '0');
   print LOG "Set the locOrb SendRate To $maxbw_bps \n", $locOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
   print LOG "Set the locOrb RecvRate To $maxbw_bps \n", $locOrb_rpc->set_parameter('SlowRecvRate', $maxbw_bps);
   print LOG "Set the remOrb SendRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
   print LOG "Set the remOrb RecvRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowRecvRate', $maxbw_bps);
   config_CNISTNET ($dr, $dr_dest, $maxbw, 100, 0);

#Test Completed. Send the result out.
if ($send_mail) {
#   print `mail \-s \"Release $release: 500Mbps Performance\" engineering\@orbitaldata.com \< $stat_file`;
    print `mail \-s \"Orb-6800 Release $release: 500Mbps Performance\" dong\@orbitaldata.com \< $stat_file`;
   }


#********************************************************
sub run_perf
{
    my $host = shift ;
    my $bw = shift;
    my $duration = shift ;
    my $pass="FAIL";

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
    my $temp_log= "$log_dir"."$testcase"."_temp.log";
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

#----------------------------------------------------
# Find the running Orb version
# input: $locOrb_rpc or $remOrb_rpc
#----------------------------------------------------
sub orb_version
{
    my $orb_rpc = shift;
    my $ver = $orb_rpc->get_system_variable("Version");
    my @ver = split(/\s+/, $ver);
    my $i = 0; my $rel ="";
    while ($ver[$i]) {
       if ($ver[$i++] eq "Release") {
          $rel = "$ver[$i++]"."-";
          my $subver = int ($ver[++$i]);
          $rel = "$rel"."$subver";
        }
    }
    return $rel;
}
                                                                                                                            

#*************************************************************************
sub config_CNISTNET
#Need 4 inputs: <DR IP> <REM-NETWORK> <BW> <RTT> <LOSS>
{
  print LOG "Configure CNISTNET DR: $_[0]\n";
  my $bw_Kbps = $_[2] * 1000;
  my $set_dr = "ssh $_[0] \"\/root\/set_bw.sh $_[1] $bw_Kbps $_[3] $_[4]\" ";
#  print "\nTESTING..Show DR config \n", $set_dr;
  $set_dr = `$set_dr`;
  print LOG "Below is the CNISTNET DR configuration: \n $set_dr \n";
}
                                                                                                                             
                                                                                                                             
                                                                                                                             
                                                                                                                             
#************************************************************************
# This is for the Meshed Testbed DR
# /tools/test/test_common/neset.sh  -bw 100e6 -rtt 100 -loss 1
#Need 3 inputs: <DR IP> <BW> <RTT> <LOSS>
# Set qlp for 1500 as default (queue len in packets)
#------------------------------------------------------------------------
sub config_TC
{
  my $bw = "$_[1]"."e6";
  print LOG "Configure TC DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \"\/tools\/tests\/test_common\/neset.sh \-bw $bw \-rtt $_[2] \-loss $_[3] \-qlp 1500 \" ";
  $set_dr = `$set_dr`;
}


=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
