#!/tools/bin/perl  
#load newly released patches on Dong's testbed
#------------------------------------------------------------
use lib '/tools/lib/perl5/site_perl/5.8.4';
use lib '/tools/tests/regression';
use Carp;
use Getopt::Std ;
#use strict;
use Time::localtime;
use XMLRPC::Lite;
use orbital_rpc;

my $testcase = 'loadpatch';

#define the loaded bracnh 
#my $branch = 'orbital-1.7.';		# 1.7 branch
#my $branch = 'orbital-0.0.0.*.complete.i686.bin';          # trunk
my $branch = 'orbital-3.0.0.*.complete.i686.bin';          # Nice
my $log_dir = '/var/tmp/';
my $patch_dir = '/orb_patches/';		#home of the patches

my %Orbs = (
#   prox1 => '10.200.38.61',
   prox2 => '10.200.38.62',
   prox3 => '10.200.38.63',
   prox7 => '10.200.38.67',

   );

#---------------------------
# loadpatch -v 
# -v: first 3 digits with no trailing dot (ex 0.0.0)
#--------------------------

getopt ("v");
my $version_digit;
if ($opt_v) {
   $version_digit = $opt_v;
   chomp ($version_digit);
   }

if ($version_digit) {
   print "\nINPUT VERSION: $version_digit \n";
   $branch = 'orbital-'."$version_digit".".*.complete.i686.bin";
   print "\nTHIS IS THE USER INPUT BRANCH: $branch \n";
   }
 
my $patch = &find_patch ($branch);        #find the latest patch. If there's no new patch, exit.
my $Orb;
foreach $Orb (sort keys %Orbs) {
   my $OrbIP = $Orbs{$Orb};
   print "\nORBIP is $OrbIP \n";
   my $Orb_url = "http://$OrbIP:2050/RPC2";
   my $Orb_rpc = Orbital::Rpc->new($Orb_url);
   print "\nUPLOADING PATCH to $OrbIP ...\n";
   my @load_result = &load_patch ($OrbIP, $patch) ;        
   my $load_result;
   if ($load_result =~ /^$OrbIP:\s+end/, @load_result) { 	#if loaded suc
      print  "\nSUCCESSFULLY LOADED ON $Orb: $OrbIP\n"
      } else { 
           print  "\nFAILED TO LOAD ON $Orb: $OrbIP\n"
           }
   
    #Reboot the Orb (6/27/05)
    print  "\nReboot the Orb $Orb: $OrbIP...", $Orb_rpc->send_command('reboot'); 
  }

    #Report the newly loaded patches
    print "\n WAIT 300 SECONDS FOR THE ORBS TO BOOT UP \n";
    sleep 300;
#Check if all of them are properly upgraded
foreach $Orb (sort keys %Orbs) {
   my $OrbIP = $Orbs{$Orb};
   my $Orb_url = "http://$OrbIP:2050/RPC2";
   my $Orb_rpc = Orbital::Rpc->new($Orb_url);
   print  "\nOrbital $Orb: $OrbIP is running ...", &orb_version($Orb_rpc), "\n";
   }


#-----------------------------------------------------
#This sub calls python's ui_ctrl.py to upgrade the Orb
#-----------------------------------------------------
sub load_patch
{
   my $orb = shift;
   my $patch = shift;
   $patch = "$patch_dir"."$patch";
   return `python \/tools\/tests\/ui_ctrl\/ui_ctrl.py -U $patch $orb`;
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

#---------------------------------------------------------
#Find the latest trunk patch from BOT=10.200.2.103/patches
# find_patch (tested branch)
#------------------------------------------
sub find_patch
{
  my $branch = shift;
  my $bot = '10.200.2.103';
#  my $res = `lftp -c 'open $bot/patches\; ls -rt | grep orbital-0.0 | tail -1\; bye'`;
#  print "PATCH BELONG TO $branch \n";
  my $res = `lftp -c 'open $bot/patches; ls -rt | grep '$branch' | tail -1; bye'`;
  my @res = split(/\s+/, $res);
  my $file_name = pop(@res);
#print  "TESTED PATCH IS: $file_name\n";
  print  "TESTED PATCH IS: $file_name\n";
  my $url = "ftp://"."$bot"."/patches/";
  my $download_result = &run_wget($url, $file_name, $patch_dir);
  if ($download_result =~ /Remote file no newer than local file/) {
     print  "NO BUILD TODAY\n"; exit 1;
     } else {
         print  "START REGRESSION ON $file_name \n"
     }
  return  $file_name;
}

#----------------------------------------------------
# Call WGET
#----------------------------------------------------
sub run_wget
{
  my $url = shift ;
  my $file = shift ;
  my $dest = shift;
  $url .= "$file" ;
  print  "URL($url)\n";
  # WGET -N (only if the file is newer) -P (dest directory)
  my $wget = `wget $url -N -P $dest 2>&1`;
  print  "$wget \n";
  return $wget ;
}

