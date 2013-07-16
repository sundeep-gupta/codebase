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
use Getopt::Long;

my $oLog=new Log("../Logs/$0.log",{overwrite=>1,verbose=>5});
my $oPI = Win32::Process::Info->new ("","NT");
my $oProcInfo;
my @Pids;
my @McProcessList;
my $ProcessCount=0;
my $Counter=1;
my $SleepTime=3600;

GetOptions("/","loop:s"=> \$Counter,
           "/","sleep:i" => \$SleepTime,
           "/","help|?" => \&Help);
open(LOG,"> ../Logs/McProcCount.log") or die;


#Check if the ProcessInfo object gets created.
__VERIFY(defined $oPI);

for(my $i=1;$i<=$Counter;$i++){

    print "Iteration $i of $Counter\n";
    print LOG "Iteration $i of $Counter\n\n";
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
            print LOG $strProcessName."\n";
            push @McProcessList,$strProcessName;
        }
    }
    $ProcessCount=scalar @McProcessList;
    print LOG qq{

    "----------------------------------------------------------------"
    Total McAfee Process Running: $ProcessCount
    "----------------------------------------------------------------"
    };

    if($i < $Counter){

        print LOG "\n\n";
        VSO::Counter($SleepTime);
        undef @McProcessList;
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
        ----------------------------------------------------------------------------------
        /loop        The number of times the script should run. If not given 1 is assumed.
        /sleep       The number of seconds to sleep between iterations

        eg: McProcessCount.pl /loop 2 /sleep 3600
    };
    exit(1);
}
