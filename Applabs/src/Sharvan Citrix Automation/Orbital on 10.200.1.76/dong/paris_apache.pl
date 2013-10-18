#!/tools/bin/perl
#**********************************************************************
# Dong 8/31/05
# modify the original apache for Paris, so it can take HB as well as SB
#---------------------------------------------------------------------
use lib '/tools/lib/perl5/site_perl/5.8.4';
use lib '/tools/tests/regression';
use Test::More qw(no_plan); 
use Time::localtime;
use XMLRPC::Lite;
use Getopt::Std;
use Data::Dumper;
use orbital_rpc;

my $testcase = "paris_apache";
my $log_dir = "/var/tmp/";
#my $log_dir = "\/logs\/regression_results\/";
my $maxbw_bps = 150000000;          #the remOrb must have this value before testing.
my $maxbw = 150;   
my $dr = '10.200.199.154';       #default for POD4 testbed
my $cnistnet = 0;            #default is TC (pod4). Change this opt to 1 if use CNISTNET
my $rtt = 100;                      #default is 100 ms. Input overide.
my $loss = 0;
my $dr_dest = '0.0.0.0';
my $softboost = 0;		#default is HB for now


#------------------------------------
# -o: locOrb
# -r: remOrb
# -s: remHost
# -b: SB (opt) . The default is HB
# -m: email result (opt). The default is not senfing
#-----------------------------------
getopt ("o,r,s,b,m") ;
if ( !$opt_s || !$opt_o || !$opt_r) {
  print "\nUsage: $testcase.pl -o <locOrb> -r <remOrb> -s < HTTP Servers> | -b <1> | -m <1> \n\n";
  exit 1;
}
my $host =  $opt_s ; chomp ($host) ;
my $host_url= "http://" . $host ."/" ;

my $send_mail = 0;	#don't send email result as default
if ($opt_m) { $send_mail = $opt_m; chomp ($send_mail) }

#setup orbital parameters
my $locOrb = $opt_o; chomp ($locOrb);       #setup the Orb for XMLRPC
my $locOrb_url = "http://$locOrb:2050/RPC2";
my $locOrb_rpc = Orbital::Rpc->new($locOrb_url);

my $remOrb = $opt_r; chomp ($remOrb);       #setup the Orb for XMLRPC
my $remOrb_url = "http://$remOrb:2050/RPC2";
my $remOrb_rpc = Orbital::Rpc->new($remOrb_url);

if ($opt_b) { $softboost = $opt_b; chomp ($softboost) }

my $tm=localtime;
$tm = sprintf("%02d%02d%04d", $tm->mday,($tm->mon)+1, $tm->year+1900);

my $binfile = "ab_binfile";        #change these file as needed.
my $compfile = "ab_compfile";
my $oneK = "1k_random";
my $fifteenK = "15K_random";

#Find the Orb tested version
my $ver = $locOrb_rpc->get_system_variable("Version");
my @ver = split(/\s+/, $ver);
my $i = 0; my $rel ="";
while ($ver[$i]) {
   if ($ver[$i++] eq "Release") {
      $rel = "$ver[$i++]"."-";
      my $subver = int ($ver[++$i]);
      $rel = "$rel"."$subver";}
}

#initialize the testbed
print LOG "Set the locOrb SendRate To $maxbw_bps \n", $locOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
print LOG "Set the locOrb RecvRate To $maxbw_bps \n", $locOrb_rpc->set_parameter('SlowRecvRate', $maxbw_bps);
print LOG "Set the remOrb SendRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowSendRate', $maxbw_bps);
print LOG "Set the remOrb RecvRate To $maxbw_bps \n", $remOrb_rpc->set_parameter('SlowRecvRate', $maxbw_bps);
if ($softboost)   {        #if it's SB then configure the DR once before testing
   print LOG "\nSet locOrb To SoftBoost: ", $locOrb_rpc->set_parameter('UI.Softboost', $softboost);
   print LOG "\nSet remOrb To SoftBoost: ", $remOrb_rpc->set_parameter('UI.Softboost', $softboost);
   } else {      
        $locOrb_rpc->set_parameter('UI.Softboost', '0' );
        $remOrb_rpc->set_parameter('UI.Softboost', '0' );
        }
#Not currently used
if ($cnistnet) {
   config_CNISTNET ($dr, $dr_dest, $maxbw, $rtt, $loss);
   } else {
        config_TC ($dr, $maxbw, $rtt, $loss);
        }


#if the HTTP server is not running, start it.
my $running = `ssh $host "ps -e |grep httpd" `;
if (! $running) {print `ssh $host \"\/etc\/\init.d\/httpd start\"`;}

   my $log_file = "$log_dir"."$testcase"."_$rel"."_$tm".".log";
   open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";

#print log header
printf LOG "\n%10s%10s\n%10s%10s\n%10s%10.0f\n",'Date:',$tm,'Release:',$rel,'SendRate:',$maxbw_bps;
print  LOG '*' x80, "\n\n";
print "URL:$host_url\n";

#---------Start AB with Compression OFF -------
print "Turn Compression OFF ", $locOrb_rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
#print "Reset Compression History of the locOrb... ", $locOrb_rpc->send_command('CompressionHistory reset'), "\n"
ok(ab(1,1,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB : $binfile 1 request, 1 concurrent");
ok(ab(10,10,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB : $binfile 10 requests, 10 concurrent");
ok(ab(100,100,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB : $binfile 100 requests, 100 concurrent");

#---------Start AB with Compression ON -------
#start running AB using tar file
ok(ab_comp(1,1,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $binfile 1 request, 1 concurrent");
ok(ab_comp(10,10,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $binfile 10 requests, 10 concurrent");
ok(ab_comp(100,100,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $binfile 100 requests, 100 concurrent");


#AB using compressible file
ok(ab_comp(1,1,$host_url,$compfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $compfile 1 request, 1 concurrent");
ok(ab_comp(10,10,$host_url,$compfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $compfile 10 requests, 10 concurrent");
ok(ab_comp(100,100,$host_url,$compfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $compfile 100 requests, 100 concurrent");

#--------Stop AB with Compression ---------



#------------Start AB latency-----------
# 100 request, one active sess at a time, 1000bytes file, no loss & no latency.
#AB latency with compression OFF
#set DR before testing AB Latency
config_TC ($dr, $maxbw, 0, 0);

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

#Change DR configuration back to its original configuration: 100RTT & 1% LOSS
config_TC ($dr, $maxbw, $rtt, $loss);

#This below line is not needed when bug "UI.HardboostSendRate" is fixed (0.0.0-135)
#Reset the Orb send rate
print "Reset SendRate To $maxbw_bps:", $locOrb_rpc->set_parameter('SlowSendRate',$maxbw_bps);

#----------Complete AB latency ---------

if ($send_mail) {
   print `mail \-s \"ApacheBench Test Results of Release $rel\" engineering\@orbitaldata.com  \< $log_file`;
#   print `mail \-s \"ApacheBench Test Results of Release $rel\" dong\@orbitaldata.com  \< $log_file`;
   }


#*******************************************************************
sub ab
{
  my $connections = shift ;
  my $concurrent = shift ;
  my $url = shift ;
  my $file = shift ;
  $url .= "/$file" ;
  
  my $ab  = `/tools/bin/ab -d -S -n $connections -c $concurrent $url`  ;
  print LOG  "AB NON-COMPRESS TEST RESULT:\n$ab \n";
  print LOG  "------------------------------ \n\n";
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
  print "Turn Compression On ", $locOrb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n";
  print "Reset Compression History of the locOrb... ", $locOrb_rpc->send_command('CompressionHistory reset'), "\n";

  my $ab_comp  = `/tools/bin/ab -d -S -n $connections -c $concurrent $url`  ;
  print LOG  "AB COMPRESS TEST RESULT:\n$ab_comp \n";
  print LOG  "------------------------------ \n\n";
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

  print "Turn Compression OFF ", $locOrb_rpc->set_parameter('Compression.EnableCompression', '0'), "\n";
  print LOG "Set The Tested BW to $bw_Mbps Mbps\n", $locOrb_rpc->set_parameter('SlowSendRate', "$bw_bps");
  sleep 3;
  my $ab_lat  = `/tools/bin/ab -d -S -n $connections -c $concurrent $url`  ;
  print LOG  "AB LATENCY NON-COMPRESS TEST RESULT:\n$ab_lat \n";
  print LOG  "------------------------------ \n\n";
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

  print "Turn Compression ON ", $locOrb_rpc->set_parameter('Compression.EnableCompression', '1'), "\n";
  print  LOG "Set The Tested BW to $bw_Mbps Mbps \n", $locOrb_rpc->set_parameter('SlowSendRate', "$bw_bps");
  my $ab_lat_comp  = `/tools/bin/ab -d -S -n $connections -c $concurrent $url`  ;
  print LOG  "AB LATENCY COMPRESS TEST RESULT:\n$ab_lat_comp \n";
  print LOG  "------------------------------ \n\n";
  return $ab_lat_comp ;
}

#*************************************************************************
sub config_CNISTNET
#Need 4 inputs: <DR IP> <REM-NETWORK> <BW Mbps> <RTT> <LOSS>
{
  print LOG "Configure CNISTNET DR: $_[0]\n";
  my $bw_Kbps = $_[2] * 1000;
  my $set_dr = "ssh $_[0] \".\/set_bw.sh $_[1] $bw_Kbps $_[3] $_[4]\" ";
  $set_dr = `$set_dr`;
  print LOG "Below is the CNISTNET DR configuration: \n $set_dr \n";
}

#************************************************************************
# This is for the Meshed Testbed DR
# /tools/test/test_common/neset.sh  -bw 100e6 -rtt 100 -loss 1
#Need 3 inputs: <DR IP> <BW Mbps> <RTT> <LOSS>
#------------------------------------------------------------------------
sub config_TC                                                                                                                      
{
  my $bw = "$_[1]"."e6";
  print LOG "Configure TC DR: $_[0]\n";
  my $set_dr = "ssh $_[0] \"\/tools\/tests\/test_common\/neset.sh \-bw $bw \-rtt $_[2] \-loss $_[3] \" ";
  print LOG "\nConfigure DR ...\n", `$set_dr`;
}

