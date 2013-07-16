use strict;
use warnings;
use FindBin qw($RealBin);
use lib "$RealBin/../../Lib";
use Log;
use VSO;
use Win32::TieRegistry;
use File::Basename;
use Win32::Process;
use Time::HiRes qw(time usleep);
use Config::INI::Simple;

my $VerboseLevel=5;
my $ExecutingFile=fileparse($0);
my $FireFoxVersion=$Registry->{'HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Mozilla Firefox\CurrentVersion'};
my $FireFoxPath=$Registry->{'HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Mozilla Firefox' ."\\$FireFoxVersion\\Main\\PathToExe"};
my $objFireFox;
my $CPUUsage;
my $Stable=1;
my $EndTime=0;
my $StartTime=0;
my $AppExeName=fileparse($FireFoxPath);
my $Conf=new Config::INI::Simple;
my $CurrentIteration;
my $Report=new Config::INI::Simple;

if(-f "$RealBin/log.ini"){

    my $Ini=new Config::INI::Simple;
    $Ini->read("Log.ini");
    $VerboseLevel=$Ini->{'Log'}->{'Verbose'};
    undef $Ini;
}
my $oLog=new Log("../Logs/$ExecutingFile.log",{overwrite=>0,verbose=>$VerboseLevel});

$Conf->read("$RealBin/../UserScenariosConfig.Ini");
$CurrentIteration=$Conf->{Settings}->{IterationCounter};
$CurrentIteration++;

$oLog->Info(2,"Firefox version installed is $FireFoxVersion");
$oLog->Info(1,"Path to Firefox exe $FireFoxPath");
if(-f $FireFoxPath){

	eval{

		$StartTime=time;
		Win32::Process::Create($objFireFox,$FireFoxPath,"",0,NORMAL_PRIORITY_CLASS,".");
	};
}

$CPUUsage=VSO::GetProcCPUUsage("$AppExeName");
while($Stable <= 5)
{
	print "$AppExeName CPU Usage : $CPUUsage ";
	if ($CPUUsage <= 2){
		if($Stable ==1){
			$EndTime=time;
		}
		print "($Stable of 5)\n";
		$Stable++;
	}
	else{
		$Stable=1;
		print "\n";
	}
	$CPUUsage=VSO::GetProcCPUUsage("$AppExeName");
}

$Report->read("$RealBin/../Logs/Report.ini");
$Report->{"Iteration_".$CurrentIteration}->{OpenFireFox_StartTime}=localtime($StartTime);
$Report->{"Iteration_".$CurrentIteration}->{OpenFireFox_EndTime}=localtime($EndTime);
$Report->{"Iteration_".$CurrentIteration}->{OpenFireFox_TimeTaken}=$EndTime-$StartTime;
$Report->write("$RealBin/../Logs/Report.ini");

system("$RealBin/Process.exe","-q","$AppExeName");
#sleep 2;
#KillProc("$AppExeName");
