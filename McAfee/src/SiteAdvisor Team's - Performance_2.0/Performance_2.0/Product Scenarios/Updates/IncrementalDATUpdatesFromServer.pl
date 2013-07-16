use strict;
use warnings;
use FindBin qw($RealBin);
use lib "$RealBin/../../Lib";
use Log;
use McPerfmon;
use Getopt::Long;
use VSO;
use Win32::TieRegistry;

my $VerboseLevel=5;
my $SrcDir="$RealBin/Dats";
my $oMcPerf;
my $McUpdatePath=$Registry->{'HKEY_LOCAL_MACHINE\SOFTWARE\McAfee.com\Agent\Install Dir'};
my $McInsupdPath=$Registry->{'HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\VirusScan\InstallSettings\Install Dir'};
my $Counter=0;
my $McInsupdRan=0;
my ($ExecutingFile)=$0=~m/.*[\/|\\](.*)$/;

chdir $RealBin;
select(STDOUT);
$|=1;

if(-f "$RealBin/log.ini"){

    my $Ini=new Config::INI::Simple;
    $Ini->read("Log.ini");
    $VerboseLevel=$Ini->{'Log'}->{'Verbose'};
    undef $Ini;
}
my $oLog=new Log("../Logs/$ExecutingFile.log",{overwrite=>0,verbose=>$VerboseLevel});

GetOptions("/","/src:s" => \$SrcDir);
$oLog->Info(2,"DAT directory set as $SrcDir");
$oLog->Info(2,"Checking if  any DAT folder exists in the current folder");
if(-d "$SrcDir"){

    $oLog->Info(2,"DAT folder found");
    $oLog->Info(2,"Updating with these DATs before running update.");
    $oLog->Info(2,"McInsupdPath Path $McInsupdPath");
    __VERIFY(system("$McInsupdPath\\Mcinsupd.exe","$SrcDir","-upd_appinfo")==0);
    __VERIFY($@ eq "");
}
else{

    $oLog->Info(2,"No DAT folder found");
}
$oLog->Info(2,"Adding Perfmon Counters");
$oMcPerf=new McPerfmon({LogFile=>"C:\\Perflogs\\McInsupd"."Logs.csv",LogFormat=>"csv",SampleInterval=>1,Template=>".\\Counters.lst",Name=>"mcinsupd"});
__VERIFY($oMcPerf!=0);
#$oMcPerf->DeleteCounter();
$oMcPerf->AddCounter();

$oLog->Info(2,"Starting Perfmon Counters");
__VERIFY($oMcPerf->StartCounter() != 0);

$oLog->Info(2,"Starting Updates");
eval{

    $oLog->Info(2,"McUpdate Path $McUpdatePath");
    __VERIFY(system("$McUpdatePath\\Mcupdate.exe","/scheduled") >> 8 ==1);
    
};
__VERIFY($@ eq "");
$McInsupdRan=VSO::GetPID("mcinsupd.exe");
print "\n";
while($McInsupdRan eq "" && $Counter < 300){
	
	print "McInsupd.exe is not running yet. Will time out in ".(300-$Counter)." Secs   \r";
	sleep 2;
	$Counter=$Counter + 2;
	$McInsupdRan=VSO::GetPID("mcinsupd.exe");
}
$oLog->Info(2,"After timeout value of McInsupdRan is $McInsupdRan");
print "\n";
if($McInsupdRan > 0){
	
		while(VSO::GetPID("mcinsupd.exe") > 0){
		
			print "McInsup.exe is still running\r";
			$oLog->Info(2,"McInsupd.exe is still running");
			sleep 2;
	}
}
else{
	$oLog->Error(2,"McInsupd.exe did not run at all");
}

$oLog->Info(2,"McInsupd.exe has exited");
__VERIFY($oMcPerf->StopCounter() != 0);
#__VERIFY($oMcPerf->DeleteCounter() != 0);

sub __VERIFY{

    my $strStatus=shift;
    my ($strPackage,$strScript,$strLine)=caller();
    if(!$strStatus){

        $oLog->Error(1,"Check failed at script : $strScript Line Num: $strLine");
        exit(1);
    }
    else{

        $oLog->Info(1,"Check passed at script : $strScript Line Num: $strLine");
    }

}
