#!/tools/bin/perl

=head NAME
7800_performance.pl

=head1 DESCRIPTION

=head2 Test Category
Performance

=head1 ENVIRONMENT

=head1 APPLICATIONS
=cut
=head1 bugs
=cut

=head1 Authors
Dong (27/01/06)
modify the original IPEF performance to test DBC backward compatibility
(only MBC is covered here)

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


my $testcase="7800_performance";
my $duration = 60;                 #w/o compression, each case runs 60 sec. With compression, each case runs 120sec 
my $ratio = 0.90;                  #expect thrput without compression
my @bw_list = (0.5, 1.5, 15, 45);
my @sess_list = (1, 100, 500);           
my $log_dir = '/var/tmp/';
my $maxbw_bps = 150000000;          #the remOrb must have this value before testing.
my $maxbw = 150;                    #150 Mbps (OC1, as proposed by Avnish).
my $highly_compressible = 1;                 #the default is to Iperf a highly compressible data (no -f option)
my $file = '/tools/files/big_compfile' ;#provide enough data for big pipe. This is the srt1400.xtx
my $orbital = 'Orb-7800';

#Delay Router global setting
my $dr = '20.20.20.1';
my $cnistnet = 0;            #default is TC (pod4). Change this opt to 1 if use CNISTNET
my $rtt = 100;                      #default is 100 ms. Input overide.
my $loss = 0;
my $dr_dest = '0.0.0.0';           


#Require @least 3 inputs: the locOrb, remOrb and the ISTAT Server.
# -r: remote Orb
# -o: local Orb
# -s: remote server
# -m (opt): mail the result
# -c (opt): compression ON
# -b (opt): Softboost
# -d (opt): Dong's delay router IP (CNISTNET). The default is Pod4 (TC)
# -f (opt): Run Iperf from a 3x-compressible file
#-----------------------------------------------------------------

getopt ("o,r,s,c,m,b,f,l,d") ;

if (  ! $opt_s || ! $opt_o || !$opt_r) {
  print "Usage: $testcase -o <locOrb> -r <remOrb> -s <Iperf Server> |-c <1> |-m <1> |-b <1> | -f <1> |-l<rtt> |-d <dong's DR IP>  \n" ;
  exit 1 ;
}
my $comp = 0;                #default is no compression
if ($opt_c) { $comp = $opt_c; chomp ($comp) };
if ($comp) { 
   $ratio = 2.5;
   }        

if ($opt_f) {
   $highly_compressible = 0;      
#   chomp($highly_compressible);
   $duration = 120;          #Need to run Iperf long enough when "-F" is used   
   $comp = 1;               #compression is automatically ON when 3X_compressible is ON
   }
 
my $send_mail = 0;                #default is not sending email
if ($opt_m) { $send_mail = $opt_m; chomp ($send_mail) };


my $host = $opt_s; chomp ($host );

my $locOrb = $opt_o; chomp ($locOrb);       #setup the Orb for XMLRPC
my $locOrb_url = "http://$locOrb:2050/RPC2";
my $locOrb_rpc = Orbital::Rpc->new($locOrb_url);

my $remOrb = $opt_r; chomp ($remOrb);       #setup the Orb for XMLRPC
my $remOrb_url = "http://$remOrb:2050/RPC2";
my $remOrb_rpc = Orbital::Rpc->new($remOrb_url);

my $softboost= 0;           #set to HB as default
if ($opt_b) {$softboost=$opt_b; chomp($softboost);$ratio = 0.85;}  #SB=1 & HB=0

if ($opt_l) { $rtt = $opt_l; chomp ($rtt) }

if ($opt_d) {
   $dr = $opt_d; chomp($dr);
   $cnistnet = 1;        
   }

my $sleep_time = $duration + 10; #Tune this value, for test with large number of sessions.

my $tm=localtime;
$tm = sprintf("%02d%02d%04d", $tm->mday,($tm->mon)+1, $tm->year+1900);

my $release =  &orb_version($locOrb_rpc);

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
   printf STAT "\n%-30s",'     TESTBED CONFIGURATION';
   print STAT "\n",'-' x30;
   printf STAT "\n%-15s\n",'Delay Router:',"\n";
   printf STAT "%5s%-7s%-6.2f\n",'     ', 'RTT:', $rtt;
   printf STAT "%5s%-7s%-6.2f\n\n",'     ', 'LOSS:', $loss;
   printf STAT "%-10s%-10s\n",'Orbital:', $orbital,"\n";
   print STAT '*' x30,"\n\n";

   print STAT '-' x125;
   printf STAT "\n%26s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s\n",'0.5Mb','0.5Mb','0.5Mb','1.5Mb','1.5Mb','1.5Mb','15Mb','15Mb','15Mb','45Mb','45Mb','45Mb';
   print STAT '-' x125;
   printf STAT "\n%8s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s%9s\n",'Date','Release','1sess','100sess','500sess','1sess','100sess','500sess','1sess','100sess','500sess','1sess','100sess','500sess';
   print STAT '-' x125, "\n";
}
#stamp the date & release to the log file
printf STAT "\n%8s%9s", $tm, $release;



#FOR DBC ONLY
#Turn off DBC on the branch ORB, which is the remOrb in this setup

   print "Set DBC OFF on the Branch Office .. ", $remOrb_rpc->set_parameter('Dbc.Enable', '0'), "\n";

#Continue as normal setup
if ($comp) {
   print "Set Compression On... ", $remOrb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n"
   } else {
   print "Set Compression Off... ", $remOrb_rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
   }

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

   } else {         #these two should have the upper limit (50Mbps). The locOrb will dictate the sending rate
        print LOG "Set the remOrb SendRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
        print LOG "Set the remOrb RecvRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowRecvRate', $maxbw_bps);
        if ( ($locOrb_rpc->get_parameter('UI.Softboost')) == 1) { $locOrb_rpc->set_parameter('UI.Softboost', '0' )}
        if ( ($remOrb_rpc->get_parameter('UI.Softboost')) == 1) { $remOrb_rpc->set_parameter('UI.Softboost', '0' )}
        if ($cnistnet) {
            
            config_CNISTNET ($dr, $dr_dest, $maxbw, $rtt, $loss);
           } else {
                config_TC ($dr, $maxbw, $rtt, $loss);
                }
        }



foreach $bw (@bw_list) {
   $expected_rate = ($bw * $ratio);
   my $bw_bps = $bw * 1000000;        #bit/sec required for Orb send-rate setting
   
   #set the tested orb to the tested BW
   print LOG "Set SendRate...\n", $locOrb_rpc->set_parameter('SlowSendRate', $bw_bps);
   print LOG "Set RecvRate...\n", $locOrb_rpc->set_parameter('SlowRecvRate', $bw_bps);

   if ($softboost)   {            #if SB then configure the DR for the tested BW
      print LOG "\nSet locOrb To SoftBoost: ", $locOrb_rpc->set_parameter('UI.Softboost', $softboost);
      print LOG "\nSet remOrb To SoftBoost: ", $remOrb_rpc->set_parameter('UI.Softboost', $softboost);

      if ($cnistnet) {
         config_CNISTNET ($dr, $dr_dest, $bw, $rtt, $loss);
         } else {
              config_TC ($dr, $bw, $rtt, $loss);
              }
      }
   sleep 5;		#Give enough time for CNISTNET to initialize?

   foreach $sess (@sess_list) {
      if ($comp) {
         print "Reset Compression Memory of the remOrb... ", $remOrb_rpc->send_command('CompressionHistory memory'), "\n"
         }

      if (!$highly_compressible) {      #the case of 3X-compressible
         if ($sess == 1) {                 	#handle this case separately
            is (run_iperf_file ($host, $bw, $duration, $file), 1, "Performance: $sess session over $bw Mbps") ;
            sleep 5;
            print LOG "------------------------------------\n\n";
            } else {                #if number of tested sessions are more than 1
                is (run_iperfs_file ($host, $bw, $sess,  $duration, $file), 1, "Performance: $sess sessions over  $bw Mbps") ;
                sleep 5;
                print LOG "------------------------------------\n\n";
                }      
         } else {			#this is the case of highly_comp
              if ($sess == 1) {                 	#handle this case separately
                 is (run_iperf ($host, $bw, $duration), 1, "Performance: $sess session over $bw Mbps") ;
                 sleep 5;
                 print LOG "------------------------------------\n\n";
                 } else {                #if number of tested sessions are more than 1
                      is (run_iperfs ($host, $bw, $sess,  $duration), 1, "Performance: $sess sessions over  $bw Mbps") ;
                      sleep 5;
                      print LOG "------------------------------------\n\n";
                      }      #fi
            } #if highly_compressible
      }         #foreach sess
}#foreach BW
    
if ($softboost) {
   if (!$highly_compressible) {        #case of 3X-compression
      printf STAT "%4s%-12s\n\n",'    ', 'SB/3X_COMP';
      } elsif ($comp) {
           printf STAT "%4s%-12s\n\n", '    ','SB/HIGH_COMP';
           } else {
                printf STAT "%4s%-12s\n\n", '    ','SB/NO_COMP';
                }
   } else {
        if (!$highly_compressible) {
           printf STAT "%4s%-12s\n\n", '    ','HB/3X_COMP';
           } elsif ($comp) {
                printf STAT "%4s%-12s\n\n", '    ','HB/HIGH_COMP';
                } else {
                     printf STAT "%4s%-12s\n\n", '    ','HB/NO_COMP';
                     }
        }#if softboost

#Reset Orb to the defaul 
   print LOG "\nSet locOrb To HB ", $locOrb_rpc->set_parameter('UI.Softboost', '0');
   print LOG "\nSet remOrb To HB ", $remOrb_rpc->set_parameter('UI.Softboost', '0');
   print LOG "Set the locOrb SendRate To $maxbw_bps \n", $locOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
   print LOG "Set the locOrb RecvRate To $maxbw_bps \n", $locOrb_rpc->set_parameter('SlowRecvRate', $maxbw_bps);
   print LOG "Set the remOrb SendRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
   print LOG "Set the remOrb RecvRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowRecvRate', $maxbw_bps);

   if ($cnistnet) {
      clear_CNISTNET ($dr);	#clear all static entries 
      config_CNISTNET ($dr, $dr_dest, $maxbw, $rtt, $loss);
      } else {
           config_TC ($dr, $maxbw, $rtt, $loss);
           }

#Test Completed. Send the result out.
if ($send_mail) {
   print `mail \-s \"$orbital: Performance Test Results $release\" engineering\@orbitaldata.com \< $stat_file`;
#    print `mail \-s \"$orbital: Performance Test Results\" dong\@orbitaldata.com \< $stat_file`;
   }

#********************************************************
sub run_iperf
{
    my $host = shift ;
    my $bw = shift;
    my $duration = shift ;
    my $pass="FAIL";
    my $number = '0.00';       #Print this value when test fails to collect results
    my $unit= 'Kbits/sec';
    my @rate="";
 
#Start Performance test
    my $test = "/usr/local/bin/iperf -c $host -t $duration";
    print LOG "Invoke: $test \n";
    my $result = `$test | tail -1`;
    sleep 5;
 
#Verify the results ..
   if ($result) {
      print LOG "/nThe Result is succesfully collected \n";
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
sub run_iperfs
{
    my $host = shift ;
    my $bw = shift;
    my $sess = shift;
    my $duration = shift ;
    my $pass = FAIL;
    my $number = '0.00';
    my $unit= 'Kbits/sec';
    my @rate;
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


#********************************************************
# run_iperf_file (host, bw, duration, file)
#********************************************************
sub run_iperf_file
{
    my $host = shift ;
    my $bw = shift;
    my $duration = shift ;
    my $file = shift;
    my $pass="FAIL";
    my $number = '0.00';
    my $unit= 'Kbits/sec';
    my @rate;

#Start Performance test
    my $test = "/usr/local/bin/iperf -c $host -t $duration -F $file";
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
# run_iperfs_file (host, bw, sess, duration,file)
#************************************************************************
sub run_iperfs_file
{
    my $host = shift ;
    my $bw = shift;
    my $sess = shift;
    my $duration = shift ;
    my $file = shift;
    my $pass = FAIL;
    my $number = '0.00';
    my $unit= 'Kbits/sec';
    my @rate;
    my $temp_log= "$log_dir"."$testcase"."_temp.log";

#Try this.. "iperf_c.sh <host> <sessions> <duration>
    my $test = "/tools/tests/regression/iperf_cf.sh $host $sess $duration $file > $temp_log &";
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
sub clear_CNISTNET
#Statically clear all entries of the DR in Dong's testbed
#only IP address of the DR is required
{
  print LOG "Clear CNISTNET DR: $_[0]\n";
  my $clear = "ssh $_[0] \"\/root\/hb_config\" ";
  $clear = `$clear`;
}

#*************************************************************************
sub config_CNISTNET
#Need 4 inputs: <DR IP> <REM-NETWORK> <BW Mbps> <RTT> <LOSS>
{
  print LOG "Configure CNISTNET DR: $_[0]\n";
  my $bw_Kbps = $_[2] * 1000;
  my $set_dr = "ssh $_[0] \"\/root\/set_bw.sh $_[1] $bw_Kbps $_[3] $_[4]\" ";
#  my $set_dr = "ssh $_[0] \"\/root\/set_bw.sh $_[1] $_[2] $_[3] $_[4]\" ";
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
  my $set_dr = "ssh $_[0] \"\/tools\/tests\/test_common\/neset.sh \-bw $bw \-rtt $_[2] \-loss $_[3] \" ";
#  my $set_dr = "ssh $_[0] \"\/tools\/tests\/test_common\/neset.sh \-bw $bw \-rtt $_[2] \-loss $_[3] \-qlp 1500 \" ";
  $set_dr = `$set_dr`;
}


=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
