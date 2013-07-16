#-------------------------------------------------------------------------------------------------------------------
# Perl Source File --McProcessInfo.pl
#
# AUTHOR: Shailendra Mahapatra
#
# DATE  :20-Jan-2009
#
# PURPOSE:Get the memory and CPU footprint of all running McAfee processes
#-------------------------------------------------------------------------------------------------------------------
use strict;
use warnings;
use Win32::Process::Info;
use FindBin qw($RealBin);
use lib "../../Lib";
use VSO;
use Log;
use McPerfmon;

my $oLog=new Log("../Logs/$0.log",{overwrite=>1,verbose=>5});
my $oPI = Win32::Process::Info->new ("","NT");
my $oProcInfo;
my @Pids;
my @McProcessList;
my $Runfor=3600;

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
        push @McProcessList,$strProcessName;
    }
}



#Add counters for each of the mcAfee process in @McProcessList
foreach(@McProcessList){

    next if (!defined $_ || $_ eq " ");
    $oLog->Info(1,"Adding Counters for McAfee Process $_");
    my ($ProcName)=$_=~m/(.*)\.exe/i;
    $oLog->Info(1,"Adding Counters for McAfee Process $ProcName");
    my $McPerfobj=new McPerfmon({LogFile=>"C:\\Perflogs\\$ProcName"."Logs.csv",LogFormat=>"csv",SampleInterval=>1,Template=>"McCounters.lst",Name=>$ProcName});
    __VERIFY($McPerfobj!=0);

    #First Delete the counter and then add.
    $McPerfobj->DeleteCounter();
    __VERIFY($McPerfobj->AddCounter() != 0);

    #Start the Counter.
    __VERIFY($McPerfobj->StartCounter() != 0);

}
VSO::Counter($Runfor);
foreach(@McProcessList){

    my ($ProcName)=$_=~m/(.*)\.exe/i;
    $oLog->Info(1,"Stopping Counters for McAfee Process $ProcName");
    my $McPerfobj=new McPerfmon({Name=>$ProcName});
    $McPerfobj->StopCounter();
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
