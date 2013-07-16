#!/tools/bin/perl
#**********************************************************************
# Dong 5/5/05
# This test requires the HTTPD running on the server.  All the
# files being downloaded from the HTTPD must exist in the 
# /var/www/html directory. For convenience, just do a symbolic copy
#from the /tools/files directory )cp -s /tools/files/* /var/www/html
# ***check the /etc/httpd/logs for errors if appl
#***********************************************************************
# Dong 5/19/05
# add more test cases from Derrick's note
#*************************************************************************
#use Test::More tests => 2; # the number of tests
use lib '/tools/lib/perl5/site_perl/5.8.4';
use Test::More qw(no_plan); 
use Time::localtime;
use XMLRPC::Lite;
use Getopt::Std;
use Data::Dumper;
use orbital_rpc;

my $testcase = "dong_apache";
getopt ("s,o") ;
if ( !$opt_s || !$opt_o ) {
  print "\nUsage: $testcase.pl -o <Orb> -s  < HTTP Server ip address> \n\n";
  exit 1;
}
my $host =  $opt_s ; chomp ($host) ;
my $dong_DR = 20.20.20.1;       #default for Dong's HA testbed
my $dr = 10.200.199.154;       #default for POD4 testbed

#setup orbital parameters
my $orb = $opt_o; chomp ($orb);
my $orb_url = "http://$orb:2050/RPC2";
my $orb_rpc = Orbital::Rpc->new($orb_url);

my $host_url= "http://" . $host ."/" ;
my $tm=localtime;
$tm = sprintf("%02d%02d%04d", $tm->mday,($tm->mon)+1, $tm->year+1900);

my $binfile = "ab_noncomp";        #change these file as needed.
my $compfile = "ab_compfile";
my $oneK = "1k_random";
my $fifteenK = "15K_random";

#Find the Orb tested version
my $ver = $orb_rpc->get_system_variable("Version");
my @ver = split(/\s+/, $ver);
my $i = 0; my $rel ="";
while ($ver[$i]) {
   if ($ver[$i++] eq "Release") {
      $rel = "$ver[$i++]"."-";
      my $subver = int ($ver[++$i]);
      $rel = "$rel"."$subver";}
}

#Set the Orb send rate
print "Set SendRate To 45Mbps:", $orb_rpc->set_parameter("SlowSendRate", "45000000");
my $orb_sendrate = $orb_rpc->get_parameter('SlowSendRate');
print "\nOrb Tested Release: $rel \n";
print "Orb Send  Rate: $orb_sendrate \n";

#if the HTTP server is not running, start it.
my $running = `ssh $host "ps -e |grep httpd" `;
if (! $running) {print `ssh $host \"\/etc\/\init.d\/httpd start\"`;}

#Log file will be stored in /logs/tmp
   my $log_file = "\/logs\/regression_results\/"."$testcase"."_$tm"."_$rel".".log";
   open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
   $OUT = "LOG";

#print log header
printf $OUT "\n%10s%10s\n%10s%10s\n%10s%10.0f\n",'Date:',$tm,'Release:',$rel,'SendRate:',$orb_sendrate;
print  $OUT '*' x80, "\n\n";
print "URL:$host_url\n";

#---------Start AB with Compression OFF -------
  print "Turn Compression OFF ", $orb_rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
ok(ab(1,1,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB : $binfile 1 request, 1 concurrent");
ok(ab(10,10,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB : $binfile 10 requests, 10 concurrent");
ok(ab(100,100,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB : $binfile 100 requests, 100 concurrent");

#---------Start AB with Compression ON -------
#start running AB using tar file
ok(ab_comp(1,1,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $binfile 1 request, 1 concurrent");
ok(ab_comp(10,10,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $binfile 10 requests, 10 concurrent");
ok(ab_comp(100,100,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $binfile 100 requests, 100 concurrent");
ok(ab_comp(10000,500,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $binfile 10000 requests, 500 concurrent");

#AB using compressible file
ok(ab_comp(1,1,$host_url,$compfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $compfile 1 request, 1 concurrent");
ok(ab_comp(10,10,$host_url,$compfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $compfile 10 requests, 10 concurrent");
ok(ab_comp(100,100,$host_url,$compfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $compfile 100 requests, 100 concurrent");
ok(ab_comp(10000,700,$host_url,$compfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $compfile 10000 requests, 700 concurrent");
#--------Stop AB with Compression ---------



#------------Start AB latency-----------
# 100 request, one active sess at a time, 1000bytes file, no loss & no latency.
#AB latency with compression OFF
ok(ab_latency(100,1,$host_url, $oneK, 2.5) =~ /^Failed\W+requests:\W+0$/gxms,"AB LATENCY 2.5Mbps: $oneK 100 requests, 1 concurrent");
ok(ab_latency(100,1,$host_url, $oneK, 10) =~ /^Failed\W+requests:\W+0$/gxms,"AB LATENCY 10Mbps: $oneK 100 requests, 1 concurrent");

#AB latency with compression ON
#Set compression ON & reset its history. Another way is to send a console command reset_hist.  
#  print "Turn Compression On ", $orb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n";
#  print "Reset Compression History ", $orb_rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
#  print "... ", $orb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n";
ok(ab_latency_comp(100,1,$host_url, $oneK, 2.5) =~ /^Failed\W+requests:\W+0$/gxms,"AB LATENCY COMPRESSION 2.5Mbps: $oneK 100 requests, 1 concurrent");

#reset compression history
#  print "Reset Compression History ", $orb_rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
#  print "... ", $orb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n";
ok(ab_latency_comp(100,1,$host_url, $oneK, 10) =~ /^Failed\W+requests:\W+0$/gxms,"AB LATENCY COMPRESSION 10Mbps: $oneK 100 requests, 1 concurrent");
#----------Complete AB latency ---------

print `mail \-s \"DONG - ApacheBench Test Results of Release $rel\" dong\@orbitaldata.com \< $log_file`;


#*******************************************************************
sub ab
  {
  my $connections = shift ;
  my $concurrent = shift ;
  my $url = shift ;
  my $file = shift ;
  $url .= "/$file" ;
  
  my $ab  = `/tools/bin/ab -d -S -n $connections -c $concurrent $url`  ;
  print $OUT  "AB NON-COMPRESS TEST RESULT:\n$ab \n";
  print $OUT  "------------------------------ \n\n";
  return $ab ;
}

#*******************************************************************
#This sub is obsolete
#-------------------------------------------------------------------
sub ab_comp
  {
  my $connections = shift ;
  my $concurrent = shift ;
  my $url = shift ;
  my $file = shift ;
  $url .= "/$file" ;

#Set compression ON & reset its history. Another way is to send a console command reset_hist.  
  print "Turn Compression On ", $orb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n";
  print "Reset Compression History ", $orb_rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
  print "... ", $orb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n";

  my $ab_comp  = `/tools/bin/ab -d -S -n $connections -c $concurrent $url`  ;
  print $OUT  "AB COMPRESS TEST RESULT:\n$ab_comp \n";
  print $OUT  "------------------------------ \n\n";
  return $ab_comp ;
}
#*******************************************************************
sub ab_latency
  {
  my $connections = shift ;
  my $concurrent = shift ;
  my $url = shift ;
  my $file = shift ;
  my $bw_Mbps = shift;
  my $bw_bps = $bw_Mbps * 1000000;
  $url .= "/$file" ;

#The DR config can be setup before running this subroutine  
#POD4 testbed uses TC as delay router
#Dong's HA testbed uses CNISTNET
#-------------------------------------------------------
#Configure POD4 Delay Router for no loss & no latency
# format: config_TC <IP> <BW Mbps> <RTT> <LOSS>
#  config_TC $pod4_DR $bw_Mbps 0 0
#----------------------------------------------------------
#configure CNISTNET on Dong's HA testbed  
# format: config_CNISTNET (<dr ip> <rem_net> <bw> <rtt> <drop>)
#    $bw_Kbps = $bw_Mbps * 1000;     #convert to Kbps
#    config_CNISTNET ($dong_DR, $net1_add, $bw_Kbps, $net1_rtt, 0);
#    sleep 10;
#----------------------------------------------------------
  print "Turn Compression OFF ", $orb_rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
  print "Set The Tested BW: ", $orb_rpc->set_parameter('SlowSendRate',"$bw_bps");
  sleep 3;
  my $ab_lat  = `/tools/bin/ab -d -S -n $connections -c $concurrent $url`  ;
  print $OUT  "AB LATENCY NON-COMPRESS TEST RESULT:\n$ab_lat \n";
  print $OUT  "------------------------------ \n\n";
  return $ab_lat ;
}
#*******************************************************************
sub ab_latency_comp
  {
  my $connections = shift ;
  my $concurrent = shift ;
  my $url = shift ;
  my $file = shift ;
  my $bw_Mbps = shift;
  my $bw_bps = $bw_Mbps * 1000000;

  $url .= "/$file" ;

#The DR config can be setup before running this subroutine  
#POD4 testbed uses TC as delay router
#Dong's HA testbed uses CNISTNET
#-------------------------------------------------------
#Configure POD4 Delay Router for no loss & no latency
# format: config_TC <IP> <BW Mbps> <RTT> <LOSS>
#  config_TC $pod4_DR $bw_Mbps 0 0
#----------------------------------------------------------
#configure CNISTNET on Dong's HA testbed  
# format: config_CNISTNET (<dr ip> <rem_net> <bw> <rtt> <drop>)
#    $bw_Kbps = $bw_Mbps * 1000;     #convert to Kbps
#    config_CNISTNET ($dong_DR, $net1_add, $bw_Kbps, $net1_rtt, 0);
#    sleep 10;
#----------------------------------------------------------
  print "Turn Compression ON ", $orb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n";
  print "Set The Tested BW: ", $orb_rpc->set_parameter('SlowSendRate',"$bw_bps");
  my $ab_lat_comp  = `/tools/bin/ab -d -S -n $connections -c $concurrent $url`  ;
  print $OUT  "AB LATENCY COMPRESS TEST RESULT:\n$ab_lat_comp \n";
  print $OUT  "------------------------------ \n\n";
  return $ab_lat_comp ;
}
#*************************************************************************
sub config_CNISTNET
#Need 4 inputs: <DR IP> <REM-NETWORK> <BW> <RTT> <LOSS>
{
  print $OUT "Configure CNISTNET DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \".\/set_bw.sh $_[1] $_[2] $_[3] $_[4]\" ";
  $set_dr = `$set_dr`;
  print $OUT "Below is the CNISTNET DR configuration: \n $set_dr \n";
}

#************************************************************************
# This is for the Meshed Testbed DR
# /tools/test/test_common/neset.sh  -bw 100e6 -rtt 100 -loss 1
#Need 3 inputs: <DR IP> <BW> <RTT> <LOSS>
#------------------------------------------------------------------------
sub config_TC                                                                                                                      
{
  my $bw = "$_[1]"."e6";
  print $OUT "Configure TC DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \"\/tools\/tests\/test_common\/neset.sh \-bw $bw \-rtt $_[2] \-loss $_[3] \" ";
  $set_dr = `$set_dr`;
}

