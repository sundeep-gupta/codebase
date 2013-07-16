use strict;
use warnings;
use FindBin qw($RealBin);
use lib "$RealBin/../../Lib";
use Log;
use McPerfmon;
use Getopt::Long;
use VSO;
use Win32::TieRegistry;
use File::Basename;
use Time::HiRes qw(time usleep);
use Config::INI::Simple;

my ($WinBin)=$RealBin;
$WinBin=~s/\//\\/g;

my $VerboseLevel=5;
my $SrcDir="$WinBin\\FromDat";
my $ToDat="$WinBin\\ToDat";
my $oMcPerf;
my $McUpdatePath=$Registry->{'HKEY_LOCAL_MACHINE\SOFTWARE\McAfee.com\Agent\Install Dir'};
my $McInsupdPath=$Registry->{'HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\VirusScan\InstallSettings\Install Dir'};
my $Counter=0;
my $McInsupdRan=0;
my $ExecutingFile=fileparse($0);
my $Loop=1;
my $Conf=new Config::INI::Simple;
my $CurrentIteration;
my $Report=new Config::INI::Simple;
my $StartTime=0;
my $EndTime=0;

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
$Conf->read("$RealBin/../ProductScenariosConfig.Ini");
$CurrentIteration=$Conf->{Settings}->{IterationCounter};
$CurrentIteration++;
GetOptions("/","src:s" => \$SrcDir,
			"/","dst:s" => \$ToDat,
			"/","loop:i", => \$Loop );


for(my $i=1;$i<=$Loop;$i++){

	$oLog->Info(2,"Starting Iteration : $i");
	$oLog->Info(2,"From DAT directory set as $SrcDir");
	$oLog->Info(2,"To DAT directory set as $ToDat");
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
	    exit(1);
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
		$StartTime=time;
	   __VERIFY(system("$McInsupdPath\\Mcinsupd.exe","$ToDat","-upd_appinfo")==0);
	   $EndTime=time;

	};
	__VERIFY($@ eq "");
	$oLog->Info(2,"McInsupd.exe has exited");
	__VERIFY($oMcPerf->StopCounter() != 0);
}
$Report->read("$RealBin/../Logs/Report.ini");
$Report->{"Iteration_".$CurrentIteration}->{IncmntlUpd_StartTime}=localtime($StartTime);
$Report->{"Iteration_".$CurrentIteration}->{IncmntlUpd_EndTime}=localtime($EndTime);
$Report->{"Iteration_".$CurrentIteration}->{IncmntlUpd_TimeTaken}=$EndTime-$StartTime;
$Report->write("$RealBin/../Logs/Report.ini");

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
