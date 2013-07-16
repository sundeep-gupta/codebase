#!/tools/bin/perl
#**********************************************************************
#Only run on Orb7800 testbed
# Dong (1/31/06)
#do not re-initialyze the testbed.
#---------------------------------------------------------------------
use lib '/tools/lib/perl5/site_perl/5.8.4';
use lib '/tools/tests/regression';
use Test::More qw(no_plan); 
use Time::localtime;
use XMLRPC::Lite;
use Getopt::Std;
use Data::Dumper;
use orbital_rpc;

my $testcase = "7800_apache";
my $log_dir = "/var/tmp/";
my $softboost = 0;		#default is HB for now


my $binfile = "ab_binfile";        #change these file as needed.
my $compfile = "ab_compfile";
my $oneG_rand = "1GB-RANDOM-SCRIPT";
my $oneK = "1k_random";
my $fifteenK = "15K_random";

getopt ("s") ;
if ( !$opt_s ) {
  print "\nUsage: $testcase.pl  -s < HTTP Servers>  \n\n";
  exit 1;
}
my $host =  $opt_s ; chomp ($host) ;
my $host_url= "http://" . $host ."/" ;

my $send_mail = 0;	#don't send email result as default
if ($opt_m) { $send_mail = $opt_m; chomp ($send_mail) }
my $tm=localtime;
$tm = sprintf("%02d%02d%04d", $tm->mday,($tm->mon)+1, $tm->year+1900);



#if the HTTP server is not running, start it.
my $running = `ssh $host "ps -e |grep httpd" `;
if (! $running) {print `ssh $host \"\/etc\/\init.d\/httpd start\"`;}

my $log_file = "$log_dir"."$testcase"."_$rel"."_$tm".".log";
open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";

#print log header
printf LOG "\n%10s%10s\n%10s%10s\n%10s%10.0f\n",'Date:',$tm,'Release:',$rel,'SendRate:',$maxbw_bps;
print  LOG '*' x80, "\n\n";
print "URL:$host_url\n";


#---------BEgin AB with Compression ON -------
#start running AB using tar file
ok(ab_comp(1,1,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $binfile 1 request, 1 concurrent");
ok(ab_comp(100,100,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $binfile 100 requests, 100 concurrent");
ok(ab_comp(1000,500,$host_url,$binfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $binfile 1000 requests, 500 concurrent");
ok(ab_comp(1000,100,$host_url,$oneG_rand) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $oneG_rand 1000 requests, 100 concurrent");


#AB using compressible file
ok(ab_comp(1,1,$host_url,$compfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $compfile 1 request, 1 concurrent");
ok(ab_comp(100,100,$host_url,$compfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $compfile 100 requests, 100 concurrent");
ok(ab_comp(900,300,$host_url,$compfile) =~ /^Failed\W+requests:\W+0$/gxms,"AB COMPRESSION: $compfile 900 requests, 300 concurrent");


ok(ab_comp(100,1,$host_url, $oneK) =~ /^Failed\W+requests:\W+0$/gxms,"AB LATENCY  $oneK 100 requests, 1 concurrent");
ok(ab_comp(500,100,$host_url, $oneK) =~ /^Failed\W+requests:\W+0$/gxms,"AB LATENCY  $oneK 500 requests, 100 concurrent");

ok(ab_comp(100,1,$host_url, $fifteenK) =~ /^Failed\W+requests:\W+0$/gxms,"AB LATENCY  $oneK 100 requests, 1 concurrent");
ok(ab_comp(500,100,$host_url, $fifteenK) =~ /^Failed\W+requests:\W+0$/gxms,"AB LATENCY  $oneK 500 requests, 100 concurrent");
#----------Complete AB latency ---------

if ($send_mail) {
   print `mail \-s \"ApacheBench Test Results of Release $rel\" dong\@orbitaldata.com  \< $log_file`;
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

  my $ab_lat_comp  = `/tools/bin/ab -d -S -n $connections -c $concurrent $url`  ;
  print LOG  "AB LATENCY COMPRESS TEST RESULT:\n$ab_lat_comp \n";
  print LOG  "------------------------------ \n\n";
  return $ab_lat_comp ;
}
