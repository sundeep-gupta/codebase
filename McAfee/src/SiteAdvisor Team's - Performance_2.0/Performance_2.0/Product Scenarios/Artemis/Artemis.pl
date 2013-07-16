use strict;
use FindBin qw($RealBin);
use lib "$RealBin/../../Lib";
use Log;
use VSO;
use File::Basename;
use Win32;
#use Time::HiRes qw(time usleep);

my $ExecutingFile=fileparse($0);
my $VerboseLevel=5;
#my $StartTime=0;
#my $EndTime=0;

if(-f "$RealBin/log.ini"){

    my $Ini=new Config::INI::Simple;
    $Ini->read("Log.ini");
    $VerboseLevel=$Ini->{'Log'}->{'Verbose'};
    undef $Ini;
}
my $oLog=new Log("../Logs/$ExecutingFile.log",{overwrite=>0,verbose=>$VerboseLevel});

$oLog->Info(2,"Registering McTest.dll");
eval{
    Win32::RegisterServer("$RealBin/mctest.dll");
};
__VERIFY($@ eq "");

$oLog->Info(2,"Enabling Artemis");
VSO::SetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\VirusScan\Artemis','ArtemisEnabled',1,'REG_DWORD');
$oLog->Info(2,"Enabled Artemis");

eval{

  #$StartTime=time;
  $oLog->Info(2,"Calling Scan.vbs...");
  $oLog->Info(2,"Starting System Scan");
  system("cscript","$RealBin\\Scan.vbs","//Nologo",1);
  #$EndTime=time;
};




#----------------------------------------------------------------------------------
#The VERIFY method
#----------------------------------------------------------------------------------
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
