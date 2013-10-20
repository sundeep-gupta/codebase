#!/tools/bin/perl

=head NAME
beta_performance.pl

=head1 Authors
Dong Duong (6/13/05) 
This version is for Beta criteria regression.
Must be executed on 6500 Orb testbed
=cut 

use FindBin;
use lib $FindBin::Bin;
use Test::More  qw(no_plan); 
use Time::localtime;  
use Carp ;
use Getopt::Std ;
use XMLRPC::Lite;
use Data::Dumper;
use orbital_rpc;


my $testcase="beta_performance";
my $duration = 120;
my $comp_file = '/tools/files/linux.tar';    #this file is used for compression test

#Require @least 2 inputs: the tested ORB and the IPERF Server.
getopt ("d,r,o,s,c") ;

if (  ! $opt_s || ! $opt_o) {
   print "Usage: $testcase -d <dr> -r <rtt> -o <OrbIP> -s <Iperf Server> -c <1/0>  \n" ;
   exit 1 ;
   }

my $comp = 0;                #default is no compression
if ($opt_c) { $comp = $opt_c; chomp ($comp) };
my @bw_list = (0.5, 1.5, 15, 45);  
my @sess_list = (1, 10, 100, 200);          
my $host = $opt_s; chomp ($host );
my $orb = $opt_o; chomp ($orb);       #setup the Orb for XMLRPC
my $url = "http://$orb:2050/RPC2";
my $rpc = Orbital::Rpc->new($url);
my $version = $rpc->get_system_variable("Version");
my $bw = 45;                      #Default BW for the Orb Mbps.

my $rtt = 100;                    #default RTT
if ($opt_r) { $rtt = $opt_r; chomp ($rtt) }
my $dr = "20.20.20.1";           #default Delay Router 
my $dr_dest = '0.0.0.0';
my $dr_bw = 100000;             #default BR's BW 100000 Kbps
if ($opt_d) {
   $dr = $opt_d;
   chomp ($dr)
   }
my $sess =1;
my $expected_rate;
my $sleep_time = $duration + 50; #Tune this value, for test with large number of sessions.
my $tm=localtime;
$tm = sprintf("%02d%02d%04d", $tm->mday,($tm->mon)+1, $tm->year+1900);

my $OUTPUT = "STDOUT";

#set result expectation
my $perc = 0.90;                  #expect thrput without compression
if ($comp) { $perc = 2.5 }        #expect at least 2.5x compression ratio using a linux tar file

#create the individual log file
my $log_file = "\/logs\/TestResult\/"."NonComp_"."$testcase"."_$tm".".log";
if ($comp) { $log_file = "\/logs\/TestResult\/"."Comp_"."$testcase"."_$tm".".log";}
#print "this is the log file: $log_file \n";
open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
$OUTPUT = "LOG";

#result PASS/FAIL file
my $result_file = "\/logs\/TestResult\/"."$testcase"."_result"."_$tm".".log"; #contains perf results of all individual test.
   open (RESU,  "> $result_file") || die "Could not open the file $result_file \n";

#The stat file retains all the performance test results. Data is appent to the file.
my $stat_file = "\/logs\/TestResult\/"."$testcase"."_stats".".log"; #contains perf results of all individual test.
if (-e $stat_file) {
   open (PERF,  ">> $stat_file") || die "Could not open the file $stat_file \n";
   } else {                       #file is not there
       open (PERF,  "> $stat_file") || die "Could not open the file $stat_file \n";
       #Create the file header
       print PERF '-' x160;
       printf PERF "\n%52s%36s%36s%36s\n",'[BW=0.5Mb RTT=100ms LOSS=0.01%]','[BW=1.5Mb RTT=200ms LOSS=0.01%]','[BW=15Mb RTT=100ms LOSS=0.01%]','[BW=45Mb RTT=45ms LOSS=0.01%]'; 
       print PERF '-' x160;
       printf PERF "\n%8s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s\n",'Date','Release','1sess','10sess','100sess','300sess','1sess','10sess','100sess','300sess','1sess','10sess','100sess','300sess','1sess','10sess','100sess','300sess';
      print PERF '-' x160, "\n";
      }
my $STAT = "PERF";

@version = split(/\s+/, $version);
my $i =0;
my $release="";                         #The short form 
while ($version[$i]) {
   if ($version[$i++] eq "Release" ){     #$i now at the version number
      $release = "$version[$i++]"."-";        #$i now pointing at "Build"
      my $subver =  int ($version[++$i]) ;
      # print "Version sub:  $subver \n";
      $release = "$release"."$subver"; 
      }
  }
printf "THE TESTED VERSION: %8s \n", $release;     

# By default, this test is w/o compression.
print "\nThe Current Compression Status: ", $rpc->get_parameter('Compression.EnableCompression'),"\n";

if ($comp) {
   print "Set Compression On... ", $rpc->set_parameter('Compression.EnableCompression', '1'), "\n"
   } else {
       print "Set Compression Off... ", $rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
       }

print "\nThe Tested Compression Setting: ", $rpc->get_parameter('Compression.EnableCompression'),"\n";

#stamp the date & release to the log file
printf $STAT "\n%8s%9s", $tm, $release;

#Stamp time & release to the result file
printf RESU "\n%15s%15s\n%15s%15s\n%15s%25s\n",'Date:',$tm,'Release:',$release,'File Tested:', $comp_file;
print  RESU '-' x80, "\n\n";

#Start the test ....
foreach $bw (@bw_list) {
   $expected_rate = ($bw * $perc);
   my $bw_bs = $bw * 1000000;        #bit/sec required for Orb send-rate setting
   print $OUTPUT "Set SendRate To: ", $rpc->set_parameter('SlowSendRate', $bw_bs);
   sleep 5;
   if ($bw_bs == $rpc->get_parameter('SlowSendRate')) {
      print $OUTPUT "The SendRate was sucessfully set: $bw_bs \n";
      } else {
          print $OUTPUT "The SendRate is not properly set to $bw_bs \n";
          print $OURPUT "The current SendRate is: ", $rpc->get_parameter('SlowSendRate'), "\n";
          exit; 
          }

#------------------------------------------------------------------------------   
#This is the DR configurations proposed by Marketing
# FORMAT: config_CNISTNET ($nistnet_dr, $dr_dest, $dr_bw, $dr_rtt, $dr_loss);
#     0.5Kbps	100ms	0.01%
#     1.5Mbps	200ms	0.01%
#     15Mbps	100ms	0.01%
#     45Mbps	 45ms	0.01%
#------------------------------------------------------------------------------
   if ($bw == 0.5) {
      # RTT = 100 & LOSS = 0.01%
      config_CNISTNET ($dr, $dr_dest, $dr_bw, '100', '0.01');
      } elsif ($bw == 1.5) {
           # RTT = 200 & LOSS = 0.01%
           config_CNISTNET ($dr, $dr_dest, $dr_bw, '200', '0.01');
           } elsif ($bw == 15) {
               # RTT = 100 & LOSS = 0.01%
               config_CNISTNET ($dr, $dr_dest, $dr_bw, '100', '0.01');
               } elsif ($bw == 45) {
                   # RTT = 45 & LOSS = 0.01%
                   config_CNISTNET ($dr, $dr_dest, $dr_bw, '45', '0.01');
                   }
#--------------------------------------------------------------------------------
   foreach $sess (@sess_list) {
      if ($comp) {
         $rpc->send_command("CompressionHistory reset");
         #print "...", $rpc->set_parameter('Compression.EnableCompression', '1'), "\n"
         }

      if ($sess == 1) {                 	#handle this case separately

#         is (run_perf ($host, $bw, $duration), 1, "Performance: One session over $bw Mbps") ;
         if (run_perf ($host, $bw, $duration)) {	#if test passes
            print RESU "\nTest Case: Compression of $sess  session over $bw Mbps - PASS!!!\n"
            } else { 
                print RESU "\nTest Case: Compression of $sess  session over $bw Mbps - FAIL!!!\n"
                }
     
         sleep 5;
         print RESU "------------------------------------\n\n";
         } else {                #if number of tested sessions are more than 1
              #is (run_perfs ($host, $bw, $duration, $sess), 1, "Performance: $sess sessions over  $bw Mbps") ;
     
              if (run_perfs ($host, $bw, $duration, $sess)) {	#if test passes
                 print RESU "\nTest Case: Compression of $sess sessions over $bw Mbps - PASS!!!\n"
                 } else { 
                      print RESU "\nTest Case: Compression of $sess sessions over $bw Mbps - FAIL!!!\n"
                      }
              sleep 5;
              print RESU "------------------------------------\n\n";
              }      #fi
   }  #inner foreach
}     #outer foreach

if ($comp) {
   printf $STAT "%8s\n\n", 'COMP';              #new line for each test
   } else {
       printf $STAT "%8s\n\n", 'NO-COMP';
       }              #new line for each test

#Reset the DR back to its default
config_CNISTNET ($dr, $dr_dest, $dr_bw, '100', '0.01');

#Test Completed. Send the result out.
  print `mail \-s \"Beta Criteria: Performance Test Statistics\" dong\@orbitaldata.com \< $stat_file`;
  print `mail \-s \"Beta Criteria: Performance Test Results\" dong\@orbitaldata.com \< $result_file`;

#********************************************************  
sub run_perf
{
    my $host = shift ;
    my $bw = shift;
    my $duration = shift ;
    my $pass="FAIL";

#Start Performance test using the ab_compfile (3X ratio)
    my $iperf_test = "/usr/local/bin/iperf -c $host -t $duration -F $comp_file";
    print $OUTPUT "Invoke: $iperf_test \n";
    my $result = `$iperf_test | tail -1`;
    sleep 5;

#Verify the results ..
   my @rate = split(/\s+/, $result);
 
   print $OUTPUT "Performance Test of $sess over $bw\n";
   print $OUTPUT "The expected flow1 rate: $expected_rate Mbits/sec\n";
   print $OUTPUT "The actual flow1 rate  : $rate[6] $rate[7]\n";
   if ( ($rate[6] >= $expected_rate) && ($rate[7] eq "Mbits/sec" )) {
      print $OUTPUT "Throughput is in the expected range - PASS! \n";
      $pass = PASS;
      printf $STAT "%9.2f", $rate[6];
      return 1;
      } elsif ($rate[7] eq "Mbits/sec") {
           print $OUTPUT "Throughput is NOT in the expected range - FAIL! \n";
           printf $STAT "%9.2f", ($rate[6]);
           return  0 ;
           } else {
                print $OUTPUT "Throughput is NOT in the expected range - FAIL! \n";
                printf $STAT "%9.2f", ($rate[6]/1000);
                return  0 ;
                }  #end of if (test result verification)
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
    my $temp_log= "\/logs\/TestResult\/"."$testcase"."_temp.log";
    my $iperf_test = "/tools/tests/dong/iperfc_comp.sh $host $sess $duration $comp_file > $temp_log &";
    
    print $OUTPUT "Invoke: $iperf_test \n";
    my $result = `$iperf_test`;

#Wait for the test to complete ...
   print $OUTPUT "SLEEP $sleep_time \n";
   sleep $sleep_time;

#Verify the results ..
   print $OUTPUT  `cat $temp_log`;
   $result = `cat $temp_log | grep SUM`;
   my $i = 1;
   while (! $result && ($i < 10)) {    #wait an extra (max)450 sec before failing
     print $OUTPUT "The Result is not ready...Sleep 50 Sec \n";
     sleep 50;
     $result = `cat $temp_log | grep SUM`;
     $i++;
     }                       #wait until the test is completed
      
   kill_iperf();
   sleep 10;
   my @rate = split(/\s+/, $result);
   my $counter=0;
   if ($rate[0] eq "") {$counter++}
   my $slot = 5 + $counter;
 
   print $OUTPUT "Performance Test of $sess over $bw\n";
   print $OUTPUT "The expected rate: $expected_rate Mbits/sec\n";
   print $OUTPUT "The actual rate  : $rate[$slot] $rate[$slot+1]\n";
   if ( ($rate[$slot] >= $expected_rate) && ($rate[$slot + 1] eq "Mbits/sec" )) {
      print $OUTPUT "Throughput is in the expected range - PASS! \n";
      my $pass = PASS;
      printf $STAT "%9.2f",$rate[$slot];
      return 1;
      } elsif ($rate[$slot + 1] eq "Mbits/sec") { 
          print $OUTPUT "Throughput is NOT in the expected range - FAIL! \n";
          printf $STAT "%9.2f",$rate[$slot];
          return  0 ; 
          } else {
              print $OUTPUT "Throughput is NOT in the expected range - FAIL! \n";
              printf $STAT "%9.2f", ($rate[$slot]/1000);
              return  0 ; 
              }
}
 
#*************************************************************************
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

#*************************************************************************
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
#*************************************************************************
sub config_CNISTNET
#Need 4 inputs: <DR IP> <REM-NETWORK> <BW> <RTT> <LOSS>
{
  print $OUTPUT "Configure CNISTNET DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \"\/root\/set_bw.sh $_[1] $_[2] $_[3] $_[4]\" ";
#  print "\nTESTING..Show DR config \n", $set_dr;
  $set_dr = `$set_dr`;
  print $OUTPUT "Below is the CNISTNET DR configuration: \n $set_dr \n";
}
                                                                                                                                                                                 
#************************************************************************
# This is for the Meshed Testbed DR
# /tools/test/test_common/neset.sh  -bw 100e6 -rtt 100 -loss 1
#Need 3 inputs: <DR IP> <BW> <RTT> <LOSS>
#------------------------------------------------------------------------
sub config_TC
{
  my $bw = "$_[1]"."e6";
  print $OUTPUT "Configure TC DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \"\/tools\/tests\/test_common\/neset.sh \-bw $bw \-rtt $_[2] \-loss $_[3] \" ";
  $set_dr = `$set_dr`;
}


=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
