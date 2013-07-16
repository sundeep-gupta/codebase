#-------------------------------------------------------------------------------------------------------------------
# Perl Source File --McProcessInfoStartup.pl
#
# AUTHOR: Shailendra Mahapatra
#
# Creation DATE  :30-Jan-2009
#
# PURPOSE:Get the memory and CPU footprint of all running McAfee processes at startup
#-------------------------------------------------------------------------------------------------------------------
use strict;
use warnings;
use Win32::Process::Info;
use FindBin qw($RealBin);
use lib "../../Lib";
use VSO;
use Log;
use McPerfmon;
use Win32::TieRegistry;
use Getopt::Long;
use Cwd 'abs_path';
use Win32;
use Config::INI::Simple;


my $oPI = Win32::Process::Info->new ("","NT");
my $oProcInfo;
my @Pids;
my @McProcessList;
my $Startup=0;
my $Restart=0;
my $Runfor=3600;
my $VerboseLevel=1;

if(-f "$RealBin/log.ini"){

    my $Ini=new Config::INI::Simple;
    $Ini->read("Log.ini");
    $VerboseLevel=$Ini->{'Log'}->{'Verbose'};
    undef $Ini;
}
my $oLog=new Log("../Logs/$0.log",{overwrite=>0,verbose=>$VerboseLevel});

GetOptions("/","startup" => \$Startup,
           "/","restart" => \$Restart,
           "/","runfor:i" => \$Runfor);

if(!$Startup && !$Restart){

    $oLog->Error(1,"Please specify either the restart or startup switch");
    Help();
    exit(1);
}

#Check if the ProcessInfo object gets created.
__VERIFY(defined $oPI);

@Pids=$oPI->ListPids();
foreach(@Pids){

    my $strProcessName;
    my $strExecutablePath;

    ($oProcInfo)=$oPI->GetProcInfo($_);
    $strProcessName=$oProcInfo->{"Name"}|| "NULL";
    $strExecutablePath=$oProcInfo->{"ExecutablePath"}|| "NULL";
    $oLog->Info(2,"Checking if Process $strProcessName belongs to McAfee");
    $oLog->Info(2,"Executable path is $strExecutablePath");

    #Check that the process path has mcafee in the path.
    if($strExecutablePath=~m/MCAFEE/gi){

        $oLog->Info(2,"**** $strExecutablePath belongs to McAfee ****");
        my ($ProcName)=$strProcessName=~m/(.*)\.exe/i;
        push @McProcessList,$ProcName;
    }
}



#Add counters for each of the mcAfee process in @McProcessList
foreach(@McProcessList){

    next if (!defined $_ || $_ eq " ");
    $oLog->Info(1,"Adding Counters for McAfee Process $_");
    my $ProcName=$_;
    $oLog->Info(1,"Adding Counters for McAfee Process $ProcName");
    my $McPerfobj=new McPerfmon({LogFile=>"C:\\Perflogs\\$ProcName"."Logs.csv",LogFormat=>"csv",SampleInterval=>1,Template=>"McCounters.lst",Name=>$ProcName});
    __VERIFY($McPerfobj!=0);

    if (!$Startup){

        $oLog->Info(2,"Startup is set to false");
        #First Delete the counter and then add.
        $McPerfobj->DeleteCounter();
        __VERIFY($McPerfobj->AddCounter() != 0);
    }
    else{

        $oLog->Info(2,"Startup is set to true");
        #Start the Counter.
        __VERIFY($McPerfobj->StartCounter() != 0) if ($Startup);
    }

}

if($Restart){

    $oLog->Info(2,"Setting the startup registry key");
    $Registry->{'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\McProcessStartup'}
="C:\\perl\\bin\\perl.exe ".abs_path($0)." /startup";

    Win32::InitiateSystemShutdown("","When I restart i'll start all the counters for you..!!!",20,1,1);
}

if($Startup){

    VSO::Counter($Runfor);
    foreach(@McProcessList){

        my $McPerfobj=new McPerfmon({LogFile=>"",LogFormat=>"",SampleInterval=>"",Template=>"",Name=>$_});
        $oLog->Info(1,"Stopping Counters for $_");
        $McPerfobj->StopCounter();
        $oLog->Info(1,"Deleting Counters for $_");
        $McPerfobj->DeleteCounter();
    }
}


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


sub Help{

    print qq{

        usage:

        ---------------------------------------------------------------------

        /restart => Use this to Add counters and restart the machine.
        /startup => Use this to start counters when the system starts up. Cannot be used before using /restart

        ---------------------------------------------------------------------
    };
}
