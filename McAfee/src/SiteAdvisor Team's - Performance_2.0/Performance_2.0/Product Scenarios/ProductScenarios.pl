use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/../Lib";
use Logger;
use Getopt::Long;
use Config::INI::Simple;
use File::Path;
use Carp;
use VSO;
use Win32::Process;
use Time::HiRes qw(time);

my $Conf=new Config::INI::Simple;
my $Rpt=new Config::INI::Simple;
my $RunSystemScan=0;
my $Restart=0;
my $LaunchMcShell=0;
my $Iterations;
my $CurrentIteration;
my $Log=new Logger;
my $RetCode;
my $StartTime;
my $EndTime;
my $McShell;
my $McShellPID;
my $McShellCPUUsage;
my $Stable=0;
my $Config=new Config::INI::Simple;
my $SleepTime;

chdir $Bin;
mkpath "$Bin/Logs";

open(LOG,">> $Bin/Logs/ProductScenarios.log");
open(RPT,">> $Bin/Logs/Report.Ini"),close RPT if (!-f  "$Bin/Logs/Report.Ini");

$|=1;

$Conf->read("$Bin/ProductScenariosConfig.ini");
$Iterations=$Conf->{Settings}->{Iterations};
$CurrentIteration=$Conf->{Settings}->{IterationCounter};
$SleepTime=$Conf->{Settings}->{SleepTime};
if(!defined $SleepTime){

	$SleepTime=180;
}
else{

	$SleepTime=$SleepTime*60;
}

if($CurrentIteration < $Iterations){

    $CurrentIteration++;
    $Log->Message(3,*LOG,"Running Iteration ".($CurrentIteration));

    $RunSystemScan=$Conf->{"System Scan"}->{Run};
    if($RunSystemScan==1){

        eval{
            print "\n";
            $Log->Message(2,*LOG,"*************************************");
            $Log->Message(2,*LOG,"****** Starting System Scan  ******");
            $Log->Message(2,*LOG,"*************************************");
            print "\n";
            $StartTime=time;
            $RetCode=system("perl","System Scan/RunODS.pl");
            $EndTime=time;
        };
        if($@ || $RetCode){

            $Log->Error(2,*LOG,"System Scan Failed with Error Code $RetCode");
        }
        WriteINI($StartTime,$EndTime,"ODS");
        VSO::Counter($SleepTime);
    }
    else{

        $Log->Message(3,*LOG,"Skipping System Scan..");
    }

    if($Conf->{"RightClickScan"}->{Run}==1){

	eval{
	    print "\n";
	    $Log->Message(2,*LOG,"*************************************");
	    $Log->Message(2,*LOG,"****** Starting RightClickScan  ******");
	    $Log->Message(2,*LOG,"*************************************");
	    print "\n";
	    $StartTime=time;
	    $RetCode=system("perl","RightClickScan/RightClickScan.pl");
	    $EndTime=time;
	};
	if($@ || $RetCode){

	    $Log->Error(2,*LOG,"RightClickScan Failed with Error Code $RetCode");
	}
	WriteINI($StartTime,$EndTime,"RightClickScan");
	VSO::Counter($SleepTime);
    }
    else{

        $Log->Message(3,*LOG,"Skipping System Scan..");
    }
    
    if($Conf->{"ScheduledScan"}->{Run}==1){

	eval{
	    print "\n";
	    $Log->Message(2,*LOG,"*************************************");
	    $Log->Message(2,*LOG,"****** Starting ScheduledScan  ******");
	    $Log->Message(2,*LOG,"*************************************");
	    print "\n";
	    $StartTime=time;
	    $RetCode=system("perl","./ScheduledScan/ScheduledScan.pl");
	    $EndTime=time;
	};
	if($@ || $RetCode){

	    $Log->Error(2,*LOG,"ScheduledScan Failed with Error Code $RetCode");
	}
	WriteINI($StartTime,$EndTime,"ScheduledScan");
	VSO::Counter($SleepTime);
    }
    else{

        $Log->Message(3,*LOG,"Skipping ScheduledScan..");
    }

	if($Conf->{"ArtemisODS"}->{Run}==1){

	eval{
	    print "\n";
	    $Log->Message(2,*LOG,"**************************************************");
	    $Log->Message(2,*LOG,"****** Starting SystemScan with Artemis ON  ******");
	    $Log->Message(2,*LOG,"**************************************************");
	    print "\n";
	    $StartTime=time;
	    $RetCode=system("perl","./Artemis/Artemis.pl");
	    $EndTime=time;
	};
	if($@ || $RetCode){

	    $Log->Error(2,*LOG,"Artemis Scan failed with Error Code $RetCode");
	}
	WriteINI($StartTime,$EndTime,"ArtemisODS");
	VSO::Counter($SleepTime);
    }
    else{

        $Log->Message(3,*LOG,"Skipping Artemis ODS..");
    }

    #Launch McShell
    if ($Conf->{"McShell Startup"}->{Run}==1){

        print "\n";
        $Log->Message(2,*LOG,"*************************************");
        $Log->Message(2,*LOG,"*****   McShell Lauch Test     *****");
        $Log->Message(2,*LOG,"*************************************");
        print "\n";

        $LaunchMcShell=$Conf->{"McShell Startup"}->{Path};
        LaunchMcShell();
        VSO::Counter($SleepTime);
    }
    else{

        $Log->Message(3,*LOG,"Skipping McShell Launch..");
    }

    #Run Updates
    if($Conf->{Updates}->{Run}==1){

        print "\n";
        $Log->Message(2,*LOG,"*************************************");
        $Log->Message(2,*LOG,"********       Updates Test   ********");
        $Log->Message(2,*LOG,"*************************************");
        print "\n";
        eval{

            $RetCode=system("perl","Updates/Runupdates.pl");
            $RetCode=$RetCode >> 8;
        };
        if($@ || $RetCode){

            $Log->Error(2,*LOG,"Updates Failed with Error Code $RetCode");
        }
        else{

            $Log->Message(2,*LOG,"Updates Completed with Error Code $RetCode");
        }
        VSO::Counter($SleepTime);
    }
    else{

        $Log->Message(3,*LOG,"Skipping Updates..");
    }

    #Run EmailScan
    if($Conf->{"EmailScan"}->{Run}==1){

        print "\n";
        $Log->Message(2,*LOG,"*************************************");
        $Log->Message(2,*LOG,"********   Email Scan Test  ********");
        $Log->Message(2,*LOG,"*************************************");
        print "\n";
        eval{

            $RetCode=system("perl","EmailScan/RunEmailScan.pl");
            $RetCode=$RetCode >> 8;
        };
        if($@ || $RetCode){

            $Log->Error(2,*LOG,"EmailScan Failed with Error Code $RetCode");
        }
        else{

            $Log->Message(2,*LOG,"EmailScan Completed with Error Code $RetCode");
        }
        VSO::Counter($SleepTime);
    }
    else{

        $Log->Message(3,*LOG,"Skipping EmailScan..");
    }

    #Run IncrementalDATupdates
    if($Conf->{"IncrementalDATUpdates"}->{Run}==1){

    	print "\n";
        $Log->Message(2,*LOG,"*************************************");
        $Log->Message(2,*LOG,"********   Incremental DAT Updates Test  ********");
        $Log->Message(2,*LOG,"*************************************");
        print "\n";
        eval{

	    $RetCode=system("perl","./Updates/IncrementalDATUpdates.pl");
        };
        if($@ || $RetCode){

            $Log->Error(2,*LOG,"IncrementalDATUpdates Failed with Error Code $RetCode");
        }
        else{

            $Log->Message(2,*LOG,"IncrementalDATUpdates Completed with Error Code $RetCode");
        }
        VSO::Counter($SleepTime);
    }
    else{

        $Log->Message(3,*LOG,"Skipping Incremental DAT updates test.");
    }



    $Log->Message(2,*LOG,"Iterations $CurrentIteration of  $Iterations Completed");
    $Conf->{Settings}->{IterationCounter}++;
    $Conf->write("$Bin/ProductScenariosConfig.ini");

    if($Conf->{Settings}->{IterationCounter}==$Iterations){

        $Config->read("$Bin/../Common/Main.ini");
        $Config->{Config}->{"Product Scenarios"}=0;
        $Config->write("$Bin/../Common/Main.ini");
    }

}
else{

    $Config->read("$Bin/../Common/Main.ini");
    $Config->{Config}->{"Product Scenarios"}=0;
    $Config->write("$Bin/../Common/Main.ini");
}


##########################################################
#Method to launch McShell
##########################################################
sub LaunchMcShell{

    $Log->Message(2,*LOG,"Launching McShell...");
        eval{

            $StartTime=time;
            Win32::Process::Create($McShell,$LaunchMcShell,"",0,NORMAL_PRIORITY_CLASS,".");
        };
        $McShellPID=$McShell->GetProcessID();

        if($McShellPID != 0)
        {
            $McShellCPUUsage=VSO::GetProcCPUUsage("mcshell");
            while($Stable < 5)
            {
                print "McShell CPU Usage : $McShellCPUUsage ";
                if ($McShellCPUUsage == 0.000)
                {
                    if($Stable ==1)
                    {
                        $EndTime=time;
                    }
                    print "($Stable of 5)\n";
                    $Stable++;

                }
                else
                {
                    $Stable=1;
                    print "\n";
                }
                $McShellCPUUsage=VSO::GetProcCPUUsage("mcshell");
            }
        }
        WriteINI($StartTime,$EndTime,"McShellLaunch");
        sleep 2;
        KillProc("mcshell");
}
##########################################################
# This method writes the Report.ini file.
##########################################################
sub WriteINI{

    my $StartTime=shift;
    my $EndTime=shift;
    my $Desc=shift;
    $Rpt->read("$Bin/Logs/Report.Ini");
    $Rpt->{"Iteration_".$CurrentIteration}->{$Desc."_StartTime"}=localtime($StartTime);
    $Rpt->{"Iteration_".$CurrentIteration}->{$Desc."_EndTime"}=localtime($EndTime);
    $Rpt->{"Iteration_".$CurrentIteration}->{$Desc."_TimeTaken"}=$EndTime-$StartTime;
    $Rpt->write("$Bin/Logs/Report.Ini");
}
