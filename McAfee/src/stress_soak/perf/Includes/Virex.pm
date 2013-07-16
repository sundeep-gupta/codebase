
package Includes::Virex;
require Exporter;

use Includes::Natural;
use Time::Local;

# Author: Harish Garg, Shreyas Rao, Sanjeev Gupta McAfee, Inc.
# 

our @ISA       = qw(Exporter);
our @EXPORT    = qw(StartODS ParseLogDetect ParseLogClean ParseLogDelete VirexlogCleanUp EnglogCleanUp CheckForEngineError GetLogID OpenFiles GetDatNo ParseLogExclude ParseLogeUpdate VirexRestart ParseLogDetectOAS ParseLogCleanOAS ParseLogDeleteOAS ConfigReaderValue Virexstop CalculateTimeTaken TouchFilesPSS ChangePlist VirexDaemonStatus Plister);    # Symbols to be exported by default
our $VERSION   = 1.00;         # Version number

#####################################
# Sub-routine to find out whether a sample scan results in a detection or not. expects path to the engine log and the sample path

# sub-routine for starting ods in 8.6
sub StartODS(){
	print "in\n";
        my($ScanPath, $VirexTaskdatabase, $TaskID) = @_;
        print $VirexTaskdatabase, "\n";

        chomp $ScanPath;
        chomp $VirexTaskdatabase;
        chomp $TaskID;
     
        system (`cp $VirexTaskdatabase /usr/local/vscanx/var/.`); 
        system (`rm /private/tmp/ScanFolder`); 
        system (`ln -s $ScanPath /private/tmp/ScanFolder`); 
        system (`/usr/local/vscanx/VShieldTaskManager $TaskID`); 
        print "Finished ODS Task...\n\n";
}


sub ParseLogDetect(){
	my($englogpath, $samplefilepath) = @_;
	system ("find $samplefilepath -type f > tmp.txt");
	open (SAMPLELISTING, "tmp.txt") ;
	my @files = <SAMPLELISTING>;
	close (SAMPLELISTING);
	 my %resulthash = ();
	foreach my $filepath (@files){
		chomp $filepath;
		if ($filepath =~ /.sit|.hqx/){
			$filepath = $filepath.'/';	
		}
		my $Result = '';
		open (TMP, "< $englogpath") || warn "Coudln't open engine log\n";
		while (my $line = <TMP>){
		chomp $line;
		$_ = $line;
		if (m`$filepath`)
			{
				if (m/found/ && m/virus/){
				$Result = "PASS";
				}
				else{
				$Result = "FAIL";	
				}	
				last;	
			}
			else
			{	
			$Result = "FAIL";
			
                        }
		        
		}
			if ($filepath =~ /DS_Store/){
			}
			else{
			$resulthash{ "$filepath" } = "$Result"; 
			}
			close(TMP);
	}
		
	return \%resulthash;	
`rm -f tmp.txt`;
}

# Sub-routine to find out whether a sample scan results in a cleaning or not. expects path to the engine log and the sample path

sub ParseLogClean(){
	my($englogpath, $samplefilepath) = @_;
	system ("find $samplefilepath -type f > tmp.txt");
	open (SAMPLELISTING, "tmp.txt") ;
	my @files = <SAMPLELISTING>;
	close (SAMPLELISTING);
	 my %resulthash = ();
	foreach my $filepath (@files){
		chomp $filepath;
		if ($filepath =~ /.sit|.hqx/){
			$filepath = $filepath.'/';	
		}
		
				
		my $Result = '';
		open (TMP, "< $englogpath") || warn "Coudln't open engine log\n";
		while (my $line = <TMP>){
		chomp $line;
			$_ = $line;
		if (m/$filepath/)
			{
				if (m/found/ && m/virus/ && m/repaired/ && m/is ok/){
				$Result = "PASS";
				}
				else{
				$Result = "FAIL";	
				}	
				last;	
			}

			else
			{	
			$Result = "FAIL";
			}
		   
		}
			if ($filepath =~ /DS_Store/){
			}
			else{
			$resulthash{ "$filepath" } = "$Result"; 
			}
			close(TMP);
	}
		
	return \%resulthash;	
`rm -f tmp.txt`;
}

# Sub-routine to find out whether a sample scan results in a deletion or not. expects path to the engine log and the sample path

sub ParseLogDelete(){
	my($masterpath, $samplepath) = @_;
	system ("find $masterpath -type f > tmp1.txt");
	system ("find $samplepath -type f > tmp2.txt");
	system ("echo 'test' >> tmp2.txt");
	open (MASTER, "tmp1.txt") ;
	my @masterfiles = <MASTER>;
	close (MASTER);
	 my %resulthash = ();
	foreach my $filepath (@masterfiles){
		chomp $filepath;
		$filepath=~s/$masterpath/$samplepath/;
		my $Result = '';
		open (TMP, "< tmp2.txt") || warn "Couldn't open engine log\n";
		while (my $line = <TMP>){
		chomp $line;
		$_ = $line;
		if (m/$filepath$/)
		{
			$Result = "FAIL";
			last;	
		}

		else
		{	
			$Result = "PASS";
		}
		   
		}
			if ($filepath =~ /DS_Store/){
			}
			else{
			$resulthash{ "$filepath" } = "$Result"; 
			}
			close(TMP);
	}
		
	return \%resulthash;	
`rm -f tmp1.txt`;
`rm -f tmp2.txt`;
}

# Cleans the /var/log/virex.log file

sub VirexlogCleanUp()
{
# print "\n Virex Log Cleanup \n";
 my ($englogpath) = @_;
 open (TMP, "< $englogpath") || warn "Coudln't open Virex log for cleaning\n";
 
#system (`cat /dev/null > $englogpath`);
 system (`sudo chmod 777 /var/log/virex.log`);
 system (`cat /dev/null > /var/log/virex.log`);
 system (`sudo chmod 644 /var/log/virex.log`);

#system ("sudo killall Virex");
# system ("sudo SystemStarter stop nwa");
 system ("sleep 2");

# print"New engine Log created\n";
# system ("touch $englogpath");

 close(TMP);
}

# Cleans the engine log file

sub EnglogCleanUp()
{
 print "\nEngine Log Cleanup \n";
 my ($englogpath) = @_;
 open (TMP, "< $englogpath") || warn "Coudln't open engine log for cleaning\n";
 system (`cat /dev/null > $englogpath`);
 system ("sleep 2");
 print"New engine Log created\n";
 system ("touch $englogpath");
 system ("chmod 777 $englogpath");
 close(TMP);
}

# Check for engine Initialization error

sub CheckForEngineError(){
		my($virexlogpath) = @_;
		open (TMP, "< $virexlogpath") || warn "Coudln't open virex log\n";
		while (my $line = <TMP>){
		chomp $line;
		$_ = $line;
		if (m/Initialization of virex engine failed/)
			{
			warn "Error: Initialization of virex engine failed: Stopping the script";	
			die();	
			}
		}
		close(TMP);
}		
	

# Expects the dat and gives back the logid

sub GetLogID(){
		my($datno) = @_;
		chomp $datno;
		if ($datno =~ /\d\d\d\d/){
		my $logidline = `grep -ae $datno\~\^\~ ../Includes/logid.txt`;
		chomp $logidline;
		if ($logidline =~ /(.*)\~\^\~(.*)/){
		return  $2;
		}
		}
		else{
			print "Error in getting the DAT no - cann't proceed.\n";
		exit;
		}
}

# Open Files one by one for on access scanner to catch. expects the sample path

sub OpenFiles(){
	my $count = 0;
	my $maxfile = 50;
	
	system ("find @_ -type f > text.txt");

	open (TMP, "text.txt") || warn "Coudln't open text.txt\n";
	while (my $line = <TMP>)
	{
		chomp $line;
		print "Touching File: $line:\n";
		if ($count == $maxfile)
		{
			print "$count files touched, sleeping for a sec...\n";
			sleep 1;
			$count = 0;
		}

		if (-e $line)
		{
			open (FILE, "$line") || warn "Couldn't open :$line: for writing $!: \n";
			close (FILE);
		}
		$count++;
	}
	close(TMP);	
	`rm -f text.txt`;
}

# Gets the dat no

sub GetDatNo(){
		my $datnoline = `/usr/local/vscanx/uvscan --version | grep 'Virus data file'`;
		chomp $datnoline;
		if ($datnoline =~ /Virus data file v(\d\d\d\d) created(.*)/){
			return  $1;
		}
}

#####################################
# Sub-routine to find out whether a file in an excluded folder is not scanned or not.This routine return FAIL if Infection is found and PASS if the file is not scanned

sub ParseLogExclude(){
	my($englogpath, $samplefilepath) = @_;
	system (`find '$samplefilepath' -type f > tmp.txt`);
	open (SAMPLELISTING, "tmp.txt") ;
	my @files = <SAMPLELISTING>;
	close (SAMPLELISTING);
	 my %resulthash = ();
	foreach my $filepath (@files){
		chomp $filepath;
		if ($filepath =~ /.sit|.hqx/){
			$filepath = $filepath.'/';	
		}
		my $Result = '';
		open (TMP, "< $englogpath") || warn "Coudln't open engine log\n";
		while (my $line = <TMP>){
		chomp $line;
		$_ = $line;
		if (m`$filepath`)
			{
				if (m/found/ && m/virus/){
				$Result = "FAIL";
				}
				else{
				$Result = "PASS";	
				}	
				last;	
			}
			else
			{	
			$Result = "PASS";
			}
		   
		}
			if ($filepath =~ /DS_Store/){
			}
			else{
			$resulthash{ "$filepath" } = "$Result"; 
			}
			close(TMP);
	}
		
	return \%resulthash;	
`rm -f tmp.txt`;
}

#***************************************************************************************************
# Sub-routine to find out wether the eUpdate has successfully happened.This sub-routine return PASS if the string sent to this subroutine is found in the Virex-log . It returns FAIL if the same is not found

sub ParseLogeUpdate()
  {
	 my($virexlogpath, $string) = @_;
         my $Result = '';
#		print("$string: ");
                open (TMP, "< $virexlogpath") || warn "Coudln't open virex log\n";
		while (my $line = <TMP>)
                {
		chomp $line;
		$_ = $line;
		
               		if (m/$string/)
                               {
               			$Result = "PASS";
				last;	
				}
				else
                                {
					$Result = "FAIL";	
				}	
			       
		}
		close(TMP);
	return $Result;	
}
#***************************************************************************************************
#sub routine to restart Virex
sub VirexRestart()

{
system (`sudo SystemStarter stop Virex`);
sleep 5;
system (`sudo SystemStarter start Virex`);
sleep 40;
system (`open /Applications/VirusScan.app/`);
sleep 5;
system (`Killall VirusScan`);
print("Virex components have been restarted\n");
}
#***************************************************************************************************
#sub routine to stop Virex
sub Virexstop()

{
system (`sudo SystemStarter stop Virex`);
sleep 40;
system (`open /Applications/VirusScan.app/`);
sleep 5;
system (`Killall VirusScan`);
print("Virex components have been stopped\n");
}
#***************************************************************************************************


#Sub routine to parse OAS LOGS
sub ParseLogDetectOAS()
{
 print("\Starting log parsing...\n");
	my($englogpath, $samplefilepath) = @_;
	system ("find $samplefilepath -type f > tmp.txt");
	open (SAMPLELISTING, "tmp.txt") ;
	my @files = <SAMPLELISTING>;
	close (SAMPLELISTING);
	 my %resulthash = ();
	foreach my $filepath (@files){
		chomp $filepath;
		if ($filepath =~ /.sit|.hqx/){
			$filepath = $filepath.'/';	
		}
		my $Result = '';
		open (TMP, "< $englogpath") || warn "Coudln't open engine log\n";
		while (my $line = <TMP>){
		chomp $line;
		$_ = $line;
		if (m`$filepath`)
			{       if (m/Found/ && /infection/){
				$Result = "PASS";
				}
				else{
				$Result = "FAIL";	
				}	
				last;	
			}
			else
			{	
			$Result = "FAIL";
			
                        }
		        
		}
			if ($filepath =~ /DS_Store/){
			}
			else{
			$resulthash{ "$filepath" } = "$Result"; 
			}
			close(TMP);
	}
		
	return \%resulthash;	
`rm -f tmp.txt`;
}

#***************************************************************************************************

#Sub routine to parse OAS LOGS
sub ParseLogCleanOAS()
{
	my($englogpath, $samplefilepath) = @_;
	system ("find $samplefilepath -type f > tmp.txt");
	open (SAMPLELISTING, "tmp.txt") ;
	my @files = <SAMPLELISTING>;
	close (SAMPLELISTING);
	 my %resulthash = ();
	foreach my $filepath (@files){
		chomp $filepath;
		if ($filepath =~ /.sit|.hqx/){
			$filepath = $filepath.'/';	
		}
		my $Result = '';
		open (TMP, "< $englogpath") || warn "Coudln't open engine log\n";
		while (my $line = <TMP>){
		chomp $line;
		$_ = $line;
		if (m`$filepath`)
			{      

if (m/found/ && m/virus/ && m/repaired/ && m/is ok/){


				$Result = "PASS";
				}
				else{
				$Result = "FAIL";	
				}	
				last;	
			}
			else
			{	
			$Result = "FAIL";
			
                        }
		        
		}
			if ($filepath =~ /DS_Store/){
			}
			else{
			$resulthash{ "$filepath" } = "$Result"; 
			}
			close(TMP);
	}
		
	return \%resulthash;	
`rm -f tmp.txt`;
}
#***************************************************************************************************

#Sub routine to parse OAS LOGS
sub ParseLogDeleteOAS()
{
	my($englogpath, $samplefilepath) = @_;
	system ("find $samplefilepath -type f > tmp.txt");
	open (SAMPLELISTING, "tmp.txt") ;
	my @files = <SAMPLELISTING>;
	close (SAMPLELISTING);
	 my %resulthash = ();
	foreach my $filepath (@files){
		chomp $filepath;
		if ($filepath =~ /.sit|.hqx/){
			$filepath = $filepath.'/';	
		}
		my $Result = '';
		open (TMP, "< $englogpath") || warn "Coudln't open engine log\n";
		while (my $line = <TMP>){
		chomp $line;
		$_ = $line;
		if (m`$filepath`)
			{       if (m/was/ && /cleaned/){
				$Result = "PASS";
				}
				else{
				$Result = "FAIL";	
				}	
				last;	
			}
			else
			{	
			$Result = "FAIL";
			
                        }
		        
		}
			if ($filepath =~ /DS_Store/){
			}
			else{
			$resulthash{ "$filepath" } = "$Result"; 
			}
			close(TMP);
	}
		
	return \%resulthash;	
`rm -f tmp.txt`;
}

#***************************************************************************************************

#***************************************************************************************************
#***************************************************************************************************
#sub routine to fetch variable values from config file
sub ConfigReaderValue()

{
my($configvalue) = @_;
my $sourceconfigfile = new Config::Natural '../Includes/PerfConfig.txt';
my $variablevalue = $sourceconfigfile->param($configvalue);
#print $variablevalue;
return $variablevalue;


}
#***************************************************************************************************
#***************************************************************************************************
#sub routine to calculate time taken for a scan

sub CalculateTimeTaken()

{
#$filename = "/var/log/virex.log";
my($filename) = @_;
$lastline = `tail -1 $filename`;
chomp $lastline;
$firstline= `head -1 $filename`;
chomp $firstline;
$i = 0; 
while ($i < 1) 
{ 
# Getting start time values from first line ( start time)
   chomp($firstline); 
   $_ = $firstline;                  # string is stored in special storage 
   @parts0 = split(/ /);        # field separator is any number of " " (space) 
                                # scalar string $- is splitted and becomes array 
#   print "$parts0[0] -- $parts0[1] -- $parts0[2]\n"; 
$x00=$parts0[0];
$x0= $parts0[1];
chomp($x00);
chomp($x0);
$_ = $x0;
@time1 = split(/:/);

my $time1hr = $time1[0];
my $time1min = $time1[1];
my $time1sec = $time1[2];

chomp $time1hr;
chomp $time1min;
chomp $time1sec;

#print "$time1hr:$time1min:$time1sec\n";

$_=$x00;
@date1 = split(/-/);

my $date1year = $date1[0];
my $date1month = $date1[1];
my $date1day = $date1[2];

#######
####### BandAid to remove some special character in beginning of $date1year
####### This seems to be occuring as that is the first character in the file.

#$date1year1 = reverse($date1year);
#print "\n$date1year1\n";
#chop $date1year1;
#chop $date1year1;
#chop $date1year1;
#$date1year = reverse($date1year1);
#chomp $date1year;
#print "\n$date1year\n";
#chomp $date1year;
#chomp $date1month;
#chomp $date1day;
#######
#######
#######uncomment the line below for testing and debugging

#print "$time1hr:$time1min:$time1sec -- $date1year-$date1month-$date1day\n";

#Getting stop time values from last line ( end time)
   chomp($lastline); 
   $_ = $lastline;                  # string is stored in special storage 
   @parts = split(/ /);        # field separator is any number of " " (space) 
                                # scalar string $- is splitted and becomes array 

$x1=$parts[0];
$x= $parts[1];
chomp($x1);
chomp($x);
$_ = $x;
@time2 = split(/:/);

my $time2hr = $time2[0];
my $time2min = $time2[1];
my $time2sec = $time2[2];

#print "$time2hr:$time2min:$time2sec\n";

$_=$x1;
@date2 = split(/-/);

my $date2year = $date2[0];
my $date2month = $date2[1];
my $date2day = $date2[2];
#####uncomment the line below for testing and debugging
#print "$time2hr:$time2min:$time2sec -- $date2year-$date2month-$date2day\n";
#######



#print "\nTIME1S=$time1sec\nTIME1M=$time1min\nTIME1H=$time1hr\nTIME1D=$date1day\nTIME1M=$date1month\nTIME1Y=$date1year-\n";
#print "\nTIME2S=$time2sec\nTIME2M=$time2min\nTIME2H=$time2hr\nTIME2D=$date2day\nTIME2M=$date2month\nTIME2Y=$date2year-\n\n";

###
###Making year constant as there is some problem with calculation with year value.It gives wrong result
###Replace "2006" with $date1year if you can fix it.

my $starttimesec = timelocal($time1sec,$time1min,$time1hr,$date1day,$date1month,2007);

my $endtimesec = timelocal($time2sec,$time2min,$time2hr,$date2day,$date2month,2007);

chomp $endtimesec;
chomp $starttimesec;
$diff = $endtimesec - $starttimesec;
chomp $diff;

#print $endtimesec, "\n";
#print $starttimesec, "\n";
#print "Time taken in seconds for this scan : $diff seconds \n";
#system(`echo "Time taken in seconds for this scan : $diff seconds" >> perfresult.txt`); 
return $diff;

#stop loop after one loop
$i = $i+1 ;
} 

}


#*******************************************************************************************
#*******************************************************************************************
# Open Files one by one for on access scanner to catch. expects the sample path

sub TouchFilesPSS(){
	my $count = 0;
	my $maxfile = 250;
my $date ;

$tmpfilepath ="/tmp/filelist.tmp";
$tmpfilepath1 ="/tmp/touch-list.tmp";

`sudo rm -f $tmpfilepath`;
`sudo rm -f $tmpfilepath1`;
	
	system ("find @_ -type f > $tmpfilepath");

	open (TMP, "$tmpfilepath") || warn "Coudln't open $tmpfilepath\n";
#*
$starttime = `date "+%Y-%m-%d %H:%M:%S "`;
chomp $starttime;
system (`echo "$starttime  :   This is when first file was touched. " >> $tmpfilepath1`);
	while (my $line = <TMP>)
	{
		chomp $line;




		if ($count == $maxfile)
		{
		##	print "$count files touched...";
		print "...";
			#sleep 0;
			$count = 0;
		}

		if (-e $line)
		{
			open (FILE, "$line") || warn "Couldn't open :$line: for writing $!: \n";
			close (FILE);
		}
		$count++;

	}
$endtime = `date "+%Y-%m-%d %H:%M:%S "`;
chomp $endtime;
$endstring = "$endtime  :   This is when last file was touched.";

chomp $endstring;

system (`echo "$endstring" >> $tmpfilepath1`);
	close(TMP);	
`rm -f text.txt`;
}
#close(TMP);

#*******************************************************************************************
#*******************************************************************************************
#changes a plist file and enables it for Virex

sub ChangePlist()
{

my($plist_filename) = @_;
chomp $plist_filename;
system("sudo cp ../Includes/plist/$plist_filename /Library/Preferences/com.Mcafee.VirusScan.plist");

# Restarting Virex processes so that prefs takes affect - needed for oas
#system("sudo killall -m VShield*");
#system("sudo SystemStarter stop Virex");
system("sudo launchctl stop com.mcafee.virusscan.ScanManager");

# sleeping for 5 mins because OAS scanner lots of time to come back
sleep 100;

}
#*******************************************************************************************
#*******************************************************************************************
#sub routine to get virex daemon status
sub VirexDaemonStatus()
{
system (`echo "~~~~~~~~~~~~~~~~..~~~~~~~~~~~~~~" >> VirexDaemonStatus.log`);
system("date >> VirexDaemonStatus.log");
system(" top -s 1 -l 1 | grep VS* >> VirexDaemonStatus.log");
system (`echo "~~~~~~~~~~~~~~~~..~~~~~~~~~~~~~~" >> DaemonStatus.log`);

}

#*******************************************************************************************
#*******************************************************************************************
sub Plister()
{

my($a, $b, $c, $d, $e, $f, $g, $h, $i) = @_;
print $a,$b,$c,$d,$e,$f,$g,$h,$i;
chomp $a;


if ("$a"  eq "EUPDATE")
{
system ("sudo ./plister set integer $b /Library/Preferences/com.mcafee.virex.prefs.plist /AutoUpdate");
system ("sudo ./plister set integer $c /Library/Preferences/com.mcafee.virex.prefs.plist /CustomServer");
system ("sudo ./plister set integer $d /Library/Preferences/com.mcafee.virex.prefs.plist /FTP_ServerURL");
system ("sudo ./plister set integer $e /Library/Preferences/com.mcafee.virex.prefs.plist /FTP_UserName");
system ("sudo ./plister set integer $f /Library/Preferences/com.mcafee.virex.prefs.plist /FTP_Password");
system ("sudo ./plister set integer $g /Library/Preferences/com.mcafee.virex.prefs.plist /FTP_Directory");
}



if ("$a"  eq "OAS")
{
system ("sudo ./plister set integer $b /Library/Preferences/com.mcafee.virex.prefs.plist /AutoDetectFore");
system ("sudo ./plister set integer $c /Library/Preferences/com.mcafee.virex.prefs.plist /OAS/CheckVirusLike");
system ("sudo ./plister set integer $d /Library/Preferences/com.mcafee.virex.prefs.plist /OAS/DeleteUponFailedAction");
system ("sudo ./plister set integer $e /Library/Preferences/com.mcafee.virex.prefs.plist /OAS/FindJokes");
system ("sudo ./plister set integer $f /Library/Preferences/com.mcafee.virex.prefs.plist /OAS/RemoveMacros");
system ("sudo ./plister set integer $g /Library/Preferences/com.mcafee.virex.prefs.plist /OAS/ScanArchives");
system ("sudo ./plister set integer $h /Library/Preferences/com.mcafee.virex.prefs.plist /OAS/ScanMailboxes");
system ("sudo ./plister set integer $i /Library/Preferences/com.mcafee.virex.prefs.plist /OAS/ScanNetworkVolumes");
}

if ($a eq "ODS")
{
system ("sudo ./plister set integer $b /Library/Preferences/com.mcafee.virex.prefs.plist /ODS/CheckVirusLike");
system ("sudo ./plister set integer $c /Library/Preferences/com.mcafee.virex.prefs.plist /ODS/DeleteUponFailedAction");
system ("sudo ./plister set integer $d /Library/Preferences/com.mcafee.virex.prefs.plist /ODS/FindJokes");
system ("sudo ./plister set integer $e /Library/Preferences/com.mcafee.virex.prefs.plist /ODS/RemoveMacros");
system ("sudo ./plister set integer $f /Library/Preferences/com.mcafee.virex.prefs.plist /ODS/ScanArchives");
system ("sudo ./plister set integer $g /Library/Preferences/com.mcafee.virex.prefs.plist /ODS/ScanMailboxes");
}

else 
{
print ("ERROR!!!!!!!!\n");
exit;
}

}



