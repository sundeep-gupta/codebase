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
use Win32::AbsPath qw(RelativeToAbsolute);
use Time::HiRes qw(time);

chdir $Bin;
my $Conf=new Config::INI::Simple;
my $UserConf=new Config::INI::Simple;
my $Log=new Logger;
my $RetCode;
my $AbsPath=RelativeToAbsolute($Bin);
my $Config=new Config::INI::Simple;
my $SystemUptime;
my $ShutdownTime;
my $Rpt=new Config::INI::Simple;
my $Iteration;

chdir $AbsPath;

mkpath "$Bin/../Logs";
open(LOG,">> $Bin/../Logs/Main.log");
$|=1;

*STDERR=*LOG;

$Conf->read("$Bin/Main.ini");
$UserConf->read("$Bin/../User Scenarios/UserScenariosConfig.ini");

GetOptions('/','setup' => \&Setup,
                      '/','startup' => \&Startup,
                      '/','restart' => \&Restart);

while($Conf->{Config}->{"Product Scenarios"}==1 || $Conf->{Config}->{"User Scenarios"}==1){


    if($UserConf->{Filter}->{Running}==1){

        eval{

            system("perl","$Bin/../User Scenarios/Filtering/Filters.pl");
            exit(0);
        };
    }

    if($Conf->{Config}->{"Product Scenarios"}==1){

        $Config->read("$Bin/../Product Scenarios/ProductScenariosConfig.ini");
        if(!-e "$Bin/../Product Scenarios/logs/Report.ini"){

            open(INI,"> $Bin/../Product Scenarios/logs/Report.ini");
            close INI;
        }
        $Rpt->read("$Bin/../Product Scenarios/logs/Report.ini");

        $Iteration=$Config->{Settings}->{IterationCounter};
        $Iteration++;

        if($Conf->{Config}->{Restarted}==1){

            print "****  $Iteration ***** \n";
            $Rpt->{"Iteration_".$Iteration}->{Restart_StartTime}=$ShutdownTime;
            $Rpt->{"Iteration_".$Iteration}->{Restart_EndTime}=$SystemUptime;
            $Rpt->{"Iteration_".$Iteration}->{Restart_TimeTaken}=$SystemUptime-$ShutdownTime;
            $Rpt->write("$Bin/../Product Scenarios/logs/Report.ini");
        }

        $Log->Message(2,*LOG,"Starting Product Scenarios...");
        eval{

            $RetCode=system("perl","$Bin/../Product Scenarios/ProductScenarios.pl") or croak "Cannot run script ProductScenarios.pl";
            $RetCode=$RetCode>>8;
        };
        if($RetCode > 0){

            $Log->Error(2,*LOG,"Execution of  ProductScenarios.pl failed with error code: $RetCode");
        }
        else{

            $Log->Message(2,*LOG,"Execution of $Bin/../Product Scenarios/ProductScenarios.pl completed");
        }
    }


    if($Conf->{Config}->{"User Scenarios"}==1){

        $Config->read("$Bin/../User Scenarios/UserScenariosConfig.ini");
        if(!-e "$Bin/../User Scenarios/logs/Report.ini"){

            open(INI,"> $Bin/../User Scenarios/logs/Report.ini");
            close INI;
        }
        $Rpt->read("$Bin/../User Scenarios/logs/Report.ini");
        $Iteration=$Config->{Settings}->{IterationCounter};
        $Iteration++;

        if($Conf->{Config}->{Restarted}==1){

            $Rpt->{"Iteration_".$Iteration}->{Restart_StartTime}=$ShutdownTime;
            $Rpt->{"Iteration_".$Iteration}->{Restart_EndTime}=$SystemUptime;
            $Rpt->{"Iteration_".$Iteration}->{Restart_TimeTaken}=$SystemUptime-$ShutdownTime;
            $Rpt->write("$Bin/../User Scenarios/logs/Report.ini");
        }

        $Log->Message(2,*LOG,"Starting User Scenarios...");
        eval{

            $RetCode=system("perl","$Bin/../User Scenarios/UserScenarios.pl") or croak "Cannot run script UserScenarios.pl";
            $RetCode=$RetCode>>8;
        };
        if($RetCode > 0){

            $Log->Error(2,*LOG,"Execution of  UserScenarios.pl returned with error code: $RetCode");
            Restart() if ($RetCode==2);
        }
        else{

            $Log->Message(2,*LOG,"Execution of $Bin/../User Scenarios/UserScenarios.pl completed");
        }
    }

    #Read the Configuration again as it changes after the scenarios run.
    $Conf->read("$Bin/Main.ini");

    #Restart the machine if the option is selected.
    Restart() if($Conf->{Config}->{Restart}==1);
}
system("perl","$Bin/CreateReport.pl");

#Delete the startup key
VSO::DelRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\Main.pl');




##########################################################################
# The setup method. This method conatins tasks that have to be done before the run starts.
##########################################################################
sub Setup{

    $Log->Message(2,*LOG,"Running Setup...");
    #Adding Main.pl to startup
    VSO::SetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run',"Main.pl","C:\\perl\\bin\\perl.exe $AbsPath\\Main.pl /startup");
    Restart() if($Conf->{Config}->{Restart}==1);
}

##########################################################################
# This method is called every time the system restarts to calculate the time taken.
##########################################################################
sub Startup{

    my $CPUUsage=VSO::GetCPUUsage();
    my $Confirm=0;
    my $ConfirmThreshold=10;

    $Log->Message(2,*LOG,"Running Method Startup to wait for System to stabilize..");
    $ShutdownTime=$Conf->{RestartTime}->{ShutdownAt};

    #--------------------------------------------------------
	# System is considered stable when the CPU usage falls
	# to less than 10% for 10 secs
    #--------------------------------------------------------


	while($Confirm < $ConfirmThreshold)
    {
        $CPUUsage=VSO::GetCPUUsage();
        if($CPUUsage < 10.000)
        {
            if($Confirm == 0)
          {
            $SystemUptime=time;
          }
            $Confirm++;
        }
        else
        {
            $Confirm=0;
        }

        print "Current CPU Usage : $CPUUsage ($Confirm of $ConfirmThreshold)\n";
    }
    $Conf->{RestartTime}->{RestartedAt}=$SystemUptime;
    $Conf->{RestartTime}->{TimeTaken}=$SystemUptime-$ShutdownTime;
    $Conf->{Config}->{Restarted}=1;
    $Conf->write("$Bin/Main.ini");
}

######################################################################
# This method is called when a system restart is required.
######################################################################
sub Restart{

    #*******************************************
    # Code added for Monitoring McAfee Process On Startup
    #*******************************************
    if($Conf->{Config}->{"Product Scenarios"}==1){

        
    }
    #*******************************************

    #add ten seconds as the machine will restart after 10 secs.
    $Conf->{RestartTime}->{ShutdownAt}=time + 10;
    $Conf->write("$Bin/Main.ini");
    eval{

        $Log->Message(2,*LOG,"Restarting the Machine....");
        system("shutdown.exe",'-r','-t','10','-f','-c','The tests will run after the system restarts....');
    };
    exit;
}


exit $RetCode;
