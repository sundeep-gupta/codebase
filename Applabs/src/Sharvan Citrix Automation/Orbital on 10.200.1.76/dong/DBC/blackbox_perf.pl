#!/tools/bin/perl

=head NAME
blackbox_perf

=head1 Authors
1/20/06 (dong)
This script measure the performance of DBC, MBC compared to NONE from
a blackbox perspective. No compressionhist reset of any kind is executed.
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


my $testcase="blackbox_perf";

my $file_dir = '/dbc1/comp_files/';        #default directory to be copied
my $user = "dbc1";
my $passwd = "dbc1";
my $comp_method = "None";            #default is  None
#----------------------------------------------------
#use the /dbc directory for files with diff data types
#my $file_dir = '/dbc/';        
#my $user = "dbc";
#my $passwd = "dbc";
#----------------------------------------------------
my $log_dir = '/var/tmp/';
my $session = 1;
my $maxbw_bps = 100000000;
my $maxbw_Mbps = 100;
my $maxLAN_Mbps = 600;

#Delay Router Config
my $dr = "20.20.20.1";           #default Delay Router 
my $cnistnet = 1;
my $dr_dest='0.0.0.0';
my $maxdr_bw = 100000;
my $rtt = 100;
my $loss = 0;

#Defaults
my $file_list ;  
my $softboost= 1;		#default is SB
my $send_mail = 0;              #default is not sending email

#Require @least 3 inputs:
# -o locOrb
# -r remOrb
# -s Iperf Server
#Optional inputs
# -b softboost <1>; default is HB
# -m sendmail out <1>
# -x directory of the files; default is /dbc1/ 
# -c default = DBCl; 0 = None; 1 = MBC
#------------------------

getopt ("o,r,s,b,m, n,c") ;

if (  ! $opt_r || ! $opt_o || !$opt_s) {
  print "Usage: $testcase -r <remOrb> -o <locOrb> -s <Server>| -m <1> -b <1> -c<1/2> -n <numsess>   \n" ;
  exit 1 ;
  }

my $server = $opt_s; chomp ($server);

my $locOrb = $opt_o; chomp ($locOrb);       #setup the Orb for XMLRPC
my $locOrb_url = "http://$locOrb:2050/RPC2";
my $locOrb_rpc = Orbital::Rpc->new($locOrb_url);

my $remOrb = $opt_r; chomp ($remOrb);       #setup the Orb for XMLRPC
my $remOrb_url = "http://$remOrb:2050/RPC2";
my $remOrb_rpc = Orbital::Rpc->new($remOrb_url);

if ($opt_n) {$session=$opt_n; chomp($session)}
if ($opt_b) {$softboost=$opt_b; chomp($softboost)}  #SB=1 & HB=0
if ($opt_m) { $send_mail = $opt_m; chomp ($send_mail) };
if ($opt_c == 1)  {
   $comp_method = "MBC";
   } elsif ($opt_c == 2) {
       $comp_method = "DBC";
      }
print "The Tested Compression Method is $comp_method \n";
 

my $tm=localtime;
$tm = sprintf("%04d%02d%02d%02d%02d", $tm->year+1900, ($tm->mon)+1, $tm->mday,$tm->hour,$tm->min);
my $release =  &orb_version($locOrb_rpc);

#create the individual log file
my $log_file = "$log_dir"."$testcase"."_$release"."_$tm".".log";
print "this is the log file: $log_file \n";
open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
print LOG "\nOrbital $locOrb is running ...", &orb_version($locOrb_rpc), "\n";
print LOG "\nOrbital $remOrb is running ...", &orb_version($remOrb_rpc), "\n";



#CONFIGURE THE TESTBED ...
#Configure the data-center Orb
print LOG "Turn ON MBC for the remOrb... ", $remOrb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n";
sleep 2;
print LOG "Turn ON DBC for the remOrb... ", $remOrb_rpc->set_parameter('Dbc.Enable', '1'), "\n";
sleep 2;

#Configure the remote Orb
#The ideal setup is 
# DBC - DBC for DBC test
# DBC - 6500 for MBC test
# DBC - 5500 for None test
#-----------------------
if ($comp_method eq "NONE") {
   print LOG "The Tested Compression is NONE \n";
   print LOG "Turn OFF MBC for the locOrb... ", $locOrb_rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
   print LOG "Turn OFF DBC for the locOrb... ", $locOrb_rpc->set_parameter('Dbc.Enable', '0'), "\n";
   } elsif ($comp_method eq "MBC") {
       print LOG "Turn ON MBC for the locOrb... ", $locOrb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n";
       print LOG "Turn OFF DBC for the locOrb... ", $locOrb_rpc->set_parameter('Dbc.Enable', '0'), "\n";
       } elsif ($comp_method eq "DBC") {
           print LOG "Turn ON MBC for the locOrb... ", $locOrb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n";
           print LOG "Turn ON DBC for the locOrb... ", $locOrb_rpc->set_parameter('Dbc.Enable', '1'), "\n";
           }
sleep 2;

#Set both Orbs to the maximum rate (150Mbps)
   print LOG "Set the locOrb SendRate To $maxbw_bps \n", $locOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
   print LOG "Set the locOrb RecvRate To $maxbw_bps \n", $locOrb_rpc->set_parameter('SlowRecvRate', $maxbw_bps);
   print LOG "Set the remOrb SendRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
   print LOG "Set the remOrb RecvRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowRecvRate', $maxbw_bps);

#Configure DR
if ($cnistnet) {
   config_CNISTNET ($dr, $dr_dest, $maxbw_Mbps, $rtt, $loss);
   } else {
          config_TC ($dr, $maxbw_Mbps, $rtt, $loss);
          }

#Configure Orb to either SB or HB
       
   print LOG "\nSet locOrb SoftBoost to $softboost...\n: ", $locOrb_rpc->set_parameter('UI.Softboost', $softboost);
   print LOG "\nSet remOrb SoftBoost to $softboost...\n: ", $remOrb_rpc->set_parameter('UI.Softboost', $softboost);

#get the file list
$file_list = `ssh $server "ls $file_dir"`;
my @file_list = split (/\s+/, $file_list);
#print "THESE FILES WILL BE FTP_GET @file_list \n";


#Reset all history, regardless of the compression method
print "Reset Compression History of the LocOrb...\n ", $locOrb_rpc->send_command('CompressionHistory reset'), "\n";
print "Reset Compression History of the RemOrb...\n", $remOrb_rpc->send_command('CompressionHistory reset'), "\n";
sleep 2;
print LOG "\n\n";             #get rid of ":" at the beginning of the lines. suspect to be caused by the previous XMLRPC command

foreach $file (@file_list)    #the value is specified in Mbps
 {  
   my $file = "$file_dir"."$file";
   print LOG "LFTP-GET $file From Server $server \n";
   print "\nGet $file First Pass \n";
   is (get_lftp ($server, $file, $session,1), 1, "FIRST-PASS OF FILE $file FROM SERVER $server ") ;
  
   sleep 10; 	#break for 10 sec before the second pass
   print "\nGet $file Second Pass \n";
   is (get_lftp ($server, $file, $session,2), 1, "SECOND-PASS OF FILE $file FROM SERVER $server ") ;
   print LOG "\n****************************************************\n\n";
  }

    
#Get the results and put them in text report
lftp_report($log_file);

#Test Completed. Send the result out.
if ($send_mail) {
   print `mail \-s \"Compression Performance For Release  $release\" qa\@orbitaldata.com \< $stat_file`;
#    print `mail \-s \"Compression Performance For Release $release\" dong\@orbitaldata.com \< $stat_file`;
   }


#********************************************************  
# needs 2 inputs: server and the file
#-------------------------------------------------------
sub get_lftp
{
    my $server = shift ;
    my $file = shift;
    my $session=shift;
    my $pass = shift; 	#first or second pass
    my $cmd = `lftp $user\:$passwd\@$server -e 'pget -n $session $file -o \/dev\/null\; bye'`;
#    print LOG "LFTP-GET$pass $file From Server $server \n";
    print LOG "\nCOMPLETE-$pass $cmd \n";
}


#*************************************************************************
sub config_CNISTNET
#Need 4 inputs: <DR IP> <REM-NETWORK> <BW Mbps> <RTT> <LOSS>
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
#------------------------------------------------------------------------
sub config_TC
{
  my $bw = "$_[1]"."e6";
  print LOG "Configure TC DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \"\/tools\/tests\/test_common\/neset.sh \-bw $bw \-rtt $_[2] \-loss $_[3] \" ";
  $set_dr = `$set_dr`;
}

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

#-------------------------------------------------
#Extract the LFTP values from the log file and
#put them in a report text format
#
#Requires 1 entry: the log-file 
#------------------------------------------------
sub lftp_report
{
my $file = shift;
open (LOG,  "< $file") || die "Could not open the file $file \n";

#Create the Report file
my $report = "$log_dir"."$testcase"."_$release"."_$tm".".report";
open (STAT,  "> $report") || die "Faile to create file $report \n";

print STAT "-"  x80, "\n"; 
print STAT "\nCompression Method:	 $comp_method \n";
print STAT "\LFTP Server:	         $server \n";
printf STAT "%-40s%20s%20s\n", 'FILE NAMES', 'FIRST PASS', 'SECOND PASS';
print STAT "-"  x80, "\n"; 

my @line; my $value;
my $type;
my $req_next = 0;
while (<LOG>) {
#   print $_;
   if (! (/'*'/)) {           #skip comment lines
      @line = split(/\s+/);
      $type = shift(@line);
     if ($type eq 'LFTP-GET') {
         $result = shift(@line);	#The second item in the line
         printf STAT "%-40s",  $result;
         $req_next = 1;
         next;   
         } 
     if  (($type eq 'COMPLETE-1') && $req_next) {
         $result = pop(@line);
         if ($result) {
            printf STAT "%20s", $result;
            } else {
                 printf STAT "%20s", '0.00M/s';
                 }
         $req_next = 1;
         next;
         }
     if  (($type eq 'COMPLETE-2') && $req_next) {
         $result = pop(@line);
         if ($result) {
            printf STAT "%20s\n", $result;
            } else {
                 printf STAT "%20s\n", '(0.00M/s)';
                 }
         $req_next = 0;
         next;
         } 
     } #IF
   }   #while PARM

}

=head1 COPYRIGHT
Copyright (c) 2005, Author(s). All rights reserved.
This module is the property of Orbital Data Corporation.
It may not be used or modified by anyone without express permission
of Orbital Data Corporation.
=cut
