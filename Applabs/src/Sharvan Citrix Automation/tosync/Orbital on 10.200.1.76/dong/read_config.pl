#!/tools/bin/perl
use lib '/tools/lib/perl5/site_perl/5.8.4';
use lib '/tools/tests/regression';
use Test::More qw(no_plan); 
use Time::localtime;
use XMLRPC::Lite;
use Getopt::Std;
use Data::Dumper;
use orbital_rpc;

getopt ("f") ;
if ( !$opt_f) {
  print "\nUsage: $testcase.pl -f <config.txt> \n\n";
  exit 1;
}
my $config_file = $opt_f;

print "\nCONFIGURATION: $config_file\n";

#Get the testbed config ..
open (PARM,  "< $config_file") || die "Could not open the file $config_file \n";
my @line; my $value;
my $locOrb; my $remOrb; my $DR; my $locHost1; my $locHost2; my $locHost3; my $remHost1; my $remHost2; my $remHost3;

while (<PARM>) {
   if (! (/#/)) {           #skip comment lines
      @line = split(/\s+/);
      SWITCH:  {
         if (/locOrb/) {$locOrb = pop(@line);  last SWITCH}
         if (/remOrb/) {$remOrb = pop(@line); last SWITCH}
         if (/locHost1/) {$locHost1 = pop(@line); last SWITCH}
         if (/locHost2/) {$locHost2 = pop(@line); last SWITCH}
         if (/locHost3/) {$locHost3 = pop(@line); last SWITCH}
         if (/remHost1/) {$remHost1 = pop(@line); last SWITCH}
         if (/remHost2/) {$remHost2 = pop(@line); last SWITCH}
         if (/remHost3/) { $remHost3 = pop(@line); last SWITCH}
         if (/DR/) {$DR = pop(@line); last SWITCH}
         } #SWITCH
        
      } #IF
   }   #while PARM
     print "\nThe locOrb is:  $locOrb \n";
     print "\nThe remOrb is:  $locOrb \n";
     print "\nThe Delay Router is:  $DR \n";
     print "\nThe locHost1 is: $locHost1 \n";
     print "\nThe locHost2 is: $locHost2 \n";
     print "\nThe locHost3 is: $locHost3 \n";
     print "\nThe remHost1 is: $remHost1 \n";
     print "\nThe remHost2 is: $remHost2 \n";
     print "\nThe remHost3 is: $remHost3 \n";


#***********************************************************************
# format: ab (#connection, #concurrent, hostURL, file, compression (0/1)
#***********************************************************************
sub ab
{
  my $connections = shift ;
  my $concurrent = shift ;
  my $url = shift ;
  my $file = shift ;
  my $compression = shift;
  $url .= "/$file" ;
  
  my $ab  = `/tools/bin/ab -d -S -n $connections -c $concurrent $url`  ;
  if ($compression) {
     print LOG  "AB COMPRESSION TEST RESULT:\n$ab \n";
     print LOG  "------------------------------ \n\n";
     } else {
          print LOG  "AB TEST RESULT:\n$ab \n";
          print LOG  "------------------------------ \n\n";
          }
  return $ab ;
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

