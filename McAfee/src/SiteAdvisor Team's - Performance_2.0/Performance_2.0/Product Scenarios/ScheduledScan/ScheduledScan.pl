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
my $VSOInstallDir=VSO::GetInstallPath('vso');
my $StartTime=0;
my $EndTime=0;

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

eval{

  $oLog->Info(2,"starting Sceduled Scan");
  #$StartTime=time;
  system("$VSOInstallDir\\Mcods.exe","/startscheduledscan");
  sleep 5;
  while(VSO::GetProcCPUUsage('mcods.exe') > 0){

	 print "ODS is still running\r";
	 sleep 1;
  }
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
