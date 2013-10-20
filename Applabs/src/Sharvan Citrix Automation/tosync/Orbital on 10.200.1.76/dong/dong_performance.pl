#!/tools/bin/perl

=head NAME
performance.pl

=head1 DESCRIPTION
1. Config the tested Orb to HB with a specified BW value.
2. Run perform test up to 300 sessions
This is for Lyon release.

=head2 Test Category
Performance

=head1 ENVIRONMENT


=head1 APPLICATIONS
=cut
=head1 bugs
=cut

=head1 Authors
Dong Duong 
This version is for Dong's testbed only
=cut 

#use lib '/tools/lib/perl5/site_perl/5.8.4';
use FindBin;
use lib $FindBin::Bin;
use Test::More  qw(no_plan); 
use Time::localtime;  
use Carp ;
use Getopt::Std ;
use XMLRPC::Lite;
use Data::Dumper;
use orbital_rpc;


my $testcase="dong_performance";
my $duration = 60;

#Require @least 2 inputs: the tested ORB and the IPERF Server.
getopt ("d,r,o,s,c") ;

if (  ! $opt_s || ! $opt_o) {
  print "Usage: $testcase -d <dr> -r <rtt> -o <OrbIP> -s <Iperf Server> -c <1/0>  \n" ;
  exit 1 ;
}
my $comp = 0;                #default is no compression
if ($opt_c) { $comp = $opt_c; chomp ($comp) };
my @bw_list = (0.5, 1.5, 15, 45);  
my @sess_list = (1, 100, 500);                 #This list is proposed by Daniel 
my $host = $opt_s;
chomp ($host );
my $orb = $opt_o; chomp ($orb);       #setup the Orb for XMLRPC
my $url = "http://$orb:2050/RPC2";
my $rpc = Orbital::Rpc->new($url);
my $version = $rpc->get_system_variable("Version");
my $bw = 45;                      #Mbps.
my $rtt = 100;
if ($opt_r) { $rtt = $opt_r; chomp ($rtt) }
my $dr = "20.20.20.1";           #default Delay Router 
if ($opt_d)
  { $dr = $opt_d;
    chomp ($dr)
  }
my $sess =1;
my $expected_rate;
my $sleep_time = $duration + 50; #Tune this value, for test with large number of sessions.
my $tm=localtime;
$tm = sprintf("%02d%02d%04d", $tm->mday,($tm->mon)+1, $tm->year+1900);


#set result expectation
my $perc = 0.90;                  #expect thrput without compression
if ($comp) { $perc = 2.5 }        #set to 2.5x for now

#create the individual log file
my $log_file = "\/root\/TestResult\/"."NonComp_"."$testcase"."_$tm".".log";
if ($comp) { $log_file = "\/root\/TestResult\/"."Comp_"."$testcase"."_$tm".".log";}
print "this is the log file: $log_file \n";
open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";

#The stat file retains all the performance test results. Data is appent to the file.
my $stat_file = "\/root\/TestResult\/"."$testcase"."_stats".".log"; #contains perf results of all individual test.
if (-e $stat_file) {
   open (STAT,  ">> $stat_file") || die "Could not open the file $stat_file \n";
   } else {                       #file is not there
   open (STAT,  "> $stat_file") || die "Could not open the file $stat_file \n";
#Create the file header
   print STAT '-' x125;
   printf STAT "\n%26s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s\n",'0.5Mb','0.5Mb','0.5Mb','1.5Mb','1.5Mb','1.5Mb','15Mb','15Mb','15Mb','45Mb','45Mb','45Mb';
   print STAT '-' x125;
   printf STAT "\n%8s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s\n",'Date','Release','1sess','100sess','500sess','1sess','100sess','500sess','1sess','100sess','500sess','1sess','100sess','500sess';
   print STAT '-' x125, "\n";
}

@version = split(/\s+/, $version);
my $i =0;
my $release="";                         #The short form 
while ($version[$i]) {
  if ($version[$i++] eq "Release" ){     #$i now at the version number
     $release = "$version[$i++]"."-";        #$i now pointing at "Build"
     my $subver =  int ($version[++$i]) ;
#     print "Version sub:  $subver \n";
     $release = "$release"."$subver"; }
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

#Start the test ...
#Configure the DR only once    
    my $bw_Kb = $bw * 1000;
    sleep 5;
#stamp the date & release to the log file
printf STAT "\n%8s%9s", $tm, $release;

foreach $bw (@bw_list) {
   $expected_rate = ($bw * $perc);
   my $bw_bs = $bw * 1000000;        #bit/sec required for Orb send-rate setting
   print LOG "Set SendRate To: ", $rpc->set_parameter('SlowSendRate', $bw_bs);
   sleep 5;
   if ($bw_bs == $rpc->get_parameter('SlowSendRate')) {
          print LOG "The SendRate was sucessfully set: $bw_bs \n";
       } else {
          print LOG "The SendRate is not properly set to $bw_bs \n";
          print $OURPUT "The current SendRate is: ", $rpc->get_parameter('SlowSendRate'), "\n";
          exit; }
   
   foreach $sess (@sess_list) {
      if ($comp) {
         print "Reset Compression History ", $rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
         print "...", $rpc->set_parameter('Compression.EnableCompression', '1'), "\n"}
      if ($sess == 1) {                 	#handle this case separately
         is (run_perf ($host, $bw, $duration), 1, "Performance: One session over $bw Mbps") ;
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
  printf STAT "%8s\n\n", 'COMP';              #new line for each test
  } else {
    printf STAT "%8s\n\n", 'NO-COMP';}              #new line for each test
    
#Test Completed. Send the result out.
  print `mail \-s \"Orb6500 - Performance Test Results\" dong\@orbitaldata.com \< $stat_file`;

#********************************************************  
sub run_perf
{
    my $host = shift ;
    my $bw = shift;
    my $duration = shift ;
    my $pass="FAIL";
    my $number = '0.00';
    my $unit = 'Kbits/sec';
    my @rate;
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
   if ($result) {
      @rate = split(/\s+/, $result);
      $unit = pop(@rate);
      $number = pop(@rate);
      }
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
    my $number = '0.00';
    my $unit = 'Kbits/sec';
    my @rate;
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
   if ($result) {
      @rate = split(/\s+/, $result);
      $unit = pop(@rate);
      $number = pop(@rate);
      }
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
sub config_DR
#Need 4 inputs: <DR IP> <REM-NETWORK> <BW> <RTT> <LOSS>
{
  print LOG "Configure the DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \".\/set_bw.sh $_[1] $_[2] $_[3] $_[4]\" ";
  $set_dr = `$set_dr`;
  print LOG "Below is the DR configuration: \n $set_dr \n";
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
   print LOG "Active IPERF PID: @iperf_pid \n";
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


=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
