#-------------------------------------------------------------------------------------------------------------------
# Perl Source File --ProcessInfo.pl
#
# AUTHOR: Shailendra Mahapatra
#
# DATE  :20-Jan-2009
#
# PURPOSE:Get the memory and CPU footprint of all running  processes
#-------------------------------------------------------------------------------------------------------------------
use strict;
use warnings;
use Win32::Process::Info;
use FindBin qw($RealBin);
use lib "../../Lib";
use VSO;
use Log;
use McPerfmon;
use Carp qw(confess);

my $oLog=new Log("../Logs/$0.log",{overwrite=>1,verbose=>5});
my $oPI = Win32::Process::Info->new ("","NT");
my $oProcInfo;
my @Pids;
my @McProcessList;
my @List;
my $Runfor=4200;
my $ProcessListFile="$RealBin/ProcessList.txt";

__VERIFY(-f $ProcessListFile);
__VERIFY(open(PL,"$ProcessListFile"));
foreach(<PL>){
    
    chomp $_;
    push @McProcessList,$_;
}
@List=@McProcessList;
#Add counters for each of the  process in @McProcessList
foreach(@McProcessList){

    next if (!defined $_ || $_ eq " ");
    $oLog->Info(1,"Adding Counters for Process $_");
    my ($ProcName)=$_=~m/(.*)\.exe/i;
    $oLog->Info(1,"Adding Counters for Process $ProcName");
    my $McPerfobj=new McPerfmon({LogFile=>"C:\\Perflogs\\$ProcName"."Logs.csv",LogFormat=>"csv",SampleInterval=>60,Template=>"Counters.lst",Name=>$ProcName});
    __VERIFY($McPerfobj!=0);

    #First Delete the counter and then add.
    $McPerfobj->DeleteCounter();
    __VERIFY($McPerfobj->AddCounter() != 0);

    #Start the Counter.
    __VERIFY($McPerfobj->StartCounter() != 0);

}
VSO::Counter($Runfor);
foreach(@List){

    my ($ProcName)=$_=~m/(.*)\.exe/i;
    $oLog->Info(1,"Stopping Counters for Process $ProcName");
    my $McPerfobj=new McPerfmon({Name=>$ProcName});
    $McPerfobj->StopCounter();
}

sub __VERIFY{

    my $strStatus=shift;
    my ($strPackage,$strScript,$strLine)=caller();
    if(!$strStatus){

        $oLog->Error(1,"Check failed at script : $strScript Line Num: $strLine");
        confess "Runtime check failed at line $strLine";
    }
    else{

        $oLog->Info(1,"Check passed at script : $strScript Line Num: $strLine");
    }

}
