#!/tools/bin/perl  
use lib '/tools/lib/perl5/site_perl/5.8.4';
use lib '/tools/tests/regression';
use Time::localtime;
use Carp;
#use strict;
use Getopt::Std ;
use XMLRPC::Lite;
use orbital_rpc;

my $testcase = 'reboot_system';
my $log_dir = '/var/tmp/';
my $time_to_reboot = 300;

getopt ("o") ;
if (  ! $opt_o ) {
  print "Usage: $testcase -o <locOrb>   \n" ;
  exit 1 ;
}
my $locOrb=$opt_o; chomp($locOrb);

my $tm =localtime;
#$tm = sprintf("%02d%02d%04d", $tm->mday,($tm->mon)+1, $tm->year+1900);
$tm = sprintf("%04d%02d%02d:%02d:%02d", $tm->year+1900, ($tm->mon)+1, $tm->mday, $tm->hour, $tm->min);

my $locOrb_url = "http://$locOrb:2050/RPC2";
my $log_file = "$log_dir"."$testcase"."_$tm".".log";
my $LOG ;
open ($LOG, ">$log_file") || die "Could not open the file $log_file \n";

#Start the test ...Reboot 100 times    
my $i = 1;
while ($i < 100) {
   print "\nTESTING\n";
   my $locOrb_rpc = Orbital::Rpc->new($locOrb_url);
   sleep 10;
   print "\nOrbital $locOrb is running ...", &orb_version($locOrb_rpc), "\n";
   print $LOG "\nOrbital $locOrb is running ...", &orb_version($locOrb_rpc), "\n";
   my $tm =localtime;
   $tm = sprintf("%04d%02d%02d:%02d:%02d", $tm->year+1900, ($tm->mon)+1, $tm->mday, $tm->hour, $tm->min);

   print "\nTime ...$tm\n";
   print $LOG "\nReboot the locOrb $locOrb ...", $locOrb_rpc->send_command('reboot'); 
   print "Rebooting the Orbital $locOrb ...\n";
   sleep $time_to_reboot;
   print "\nTimeup ...Reconnect to the Orb \n";
   print $LOG "\nOrbital $locOrb sucessfully rebooted the $i times \n";
   print  "\nOrbital $locOrb sucessfully rebooted the $i times \n";
   $i++
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
 

