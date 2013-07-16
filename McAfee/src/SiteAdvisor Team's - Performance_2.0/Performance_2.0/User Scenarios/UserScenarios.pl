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
my $CurrentIteration;
my $Iterations;
my $Log=new Logger();
my $MainConfig=new Config::INI::Simple;
my $RetCode;
my $SleepTime;


chdir $Bin;
mkpath "$Bin/Logs";

open(LOG,">> $Bin/Logs/UserScenarios.log");
open(RPT,">> $Bin/Logs/Report.Ini"),close RPT if (!-f  "$Bin/Logs/Report.Ini");
$|=1;

$Log->Message(3,*LOG,"Executing UserScenarios.pl");
$Conf->read("$Bin/UserScenariosConfig.ini") or die;
$CurrentIteration=$Conf->{Settings}->{IterationCounter};
$Iterations=$Conf->{Settings}->{Iterations};
print "Iteration Counter : $CurrentIteration Total : $Iterations\n";
$SleepTime=$Conf->{Settings}->{SleepTime};
if(!defined $SleepTime){

	$SleepTime=180;
}
else{

	$SleepTime=$SleepTime*60;
}

if($CurrentIteration < $Iterations){

    $CurrentIteration++;
    $Log->Message(3,*LOG,"Running Iteration ".$CurrentIteration);


    ###################################################
    #Run the FileCopying test case
    ###################################################
    if($Conf->{FileCopy}->{Run}==1){


        print "\n";
        $Log->Message(2,*LOG,"*************************************");
        $Log->Message(2,*LOG,"*** Executing File Copying Test ***");
        $Log->Message(2,*LOG,"*************************************");
        print "\n";
        eval{

            system("perl","$Bin/FileCopy/FileCopy.pl");
        };
        if($? || $@){

            $Log->Message(2,*LOG,"FileCopy.pl failed with Error Code ". $? >> 8);
        }
        VSO::Counter($SleepTime);
    }
    else{

        $Log->Message(3,*LOG,"Skipping FileCopy..");
    }

    ###################################################
    #Run the Applications test case
    ###################################################
    if($Conf->{Applications}->{Run}==1){


        print "\n";
        $Log->Message(2,*LOG,"*************************************");
        $Log->Message(2,*LOG,"****   Executing Apps Test        ****");
        $Log->Message(2,*LOG,"*************************************");
        print "\n";
        eval{

            system("perl","$Bin/Apps/OpenApps.pl");
        };
        if($? || $@){

            $Log->Message(2,*LOG,"OpenApps.pl failed with Error Code ". $? >> 8);
        }
        VSO::Counter($SleepTime);
    }
    else{

        $Log->Message(3,*LOG,"Skipping OpenApps..");
    }

    ###################################################
    #Run the IE:about blank test case
    ###################################################
    if($Conf->{IEblank}->{Run}==1){

        print "\n";
        $Log->Message(2,*LOG,"*************************************");
        $Log->Message(2,*LOG,"*** Executing about:blank tes t  ***");
        $Log->Message(2,*LOG,"*************************************");
        print "\n";
        eval{

            system("perl","$Bin/IE/IENavigate.pl","/desc","IEblank");
        };
        if($? || $@){

            $Log->Message(2,*LOG,"IENavigate.pl failed with Error Code ". $? >> 8);
        }
        VSO::Counter($SleepTime);

    }
    else{

        $Log->Message(3,*LOG,"Skipping IE:about blank..");
    }

    ###################################################
    #run the Homepage test case
    ###################################################
    if($Conf->{IEHomepage}->{Run}==1){

        print "\n";
        $Log->Message(2,*LOG,"*************************************");
        $Log->Message(2,*LOG,"**** Executing Homepage test  ****");
        $Log->Message(2,*LOG,"*************************************");
        print "\n";
        eval{

            system("perl","$Bin/Homepage/Homepage.pl");
        };
        if($? || $@){

            $Log->Message(2,*LOG,"Homepage.pl failed with Error Code ". $? >> 8);
        }
        VSO::Counter($SleepTime);

    }
    else{

        $Log->Message(3,*LOG,"Skipping Homepage test..");
    }

    ###################################################
    #run the RGY test cases
    ###################################################
    if($Conf->{RGY}->{Run}==1){

        print "\n";
        $Log->Message(2,*LOG,"***************************************************");
        $Log->Message(2,*LOG,"*Executing Red/Green/Yellow web sites test **");
        $Log->Message(2,*LOG,"***************************************************");
        print "\n";
        eval{

            system("perl","$Bin/RGY/RGY.pl");
        };
        if($? || $@){

            $Log->Message(2,*LOG,"RGY.pl failed with Error Code ". $? >> 8);
        }
        VSO::Counter($SleepTime);

    }
    else{

        $Log->Message(3,*LOG,"Skipping RGY test..");
    }

    ###################################################
    # Run the Filtering tests
    ###################################################
    if($Conf->{Filter}->{Run}==1){

        print "\n";
        $Log->Message(2,*LOG,"*************************************");
        $Log->Message(2,*LOG,"**** Executing Filtering tests   ****");
        $Log->Message(2,*LOG,"*************************************");
        print "\n";
        eval{

            $Conf=undef;
            $RetCode=system("perl","$Bin/Filtering/Filters.pl");
            $RetCode=$RetCode >> 8;
        };
        if($? || $@){

            $Log->Message(2,*LOG,"Filters.pl returned with Error Code $RetCode");
            exit(2) if($RetCode ==2); #error code for restarting..
        }
        #VSO::Counter($SleepTime);

    }
    else{

        $Log->Message(3,*LOG,"Skipping Filtering tests..");
    }

    ###################################################
    # Run Firefox tests
    ###################################################
    if($Conf->{Firefox}->{Run}==1){

        print "\n";
        $Log->Message(2,*LOG,"*************************************");
        $Log->Message(2,*LOG,"**** Executing Firefox tests   ****");
        $Log->Message(2,*LOG,"*************************************");
        print "\n";
        eval{

            $RetCode=system("perl","$Bin/Firefox/OpenFireFox.pl");
            $RetCode=$RetCode >> 8;
        };
        if($? || $@){

            $Log->Message(2,*LOG,"OpenFireFox.pl returned with Error Code $RetCode");
        }
        #VSO::Counter($SleepTime);
    }
    else{

        $Log->Message(3,*LOG,"Skipping Filtering tests..");
    }

    $Conf->read("$Bin/UserScenariosConfig.ini");
    $Conf->{Settings}->{IterationCounter}++;
    $Conf->write("$Bin/UserScenariosConfig.ini");

    if($Conf->{Settings}->{IterationCounter}==$Iterations){

        $MainConfig->read("$Bin/../Common/Main.ini");
        $MainConfig->{Config}->{"User Scenarios"}=0;
        $MainConfig->write("$Bin/../Common/Main.ini");
    }

}
else{

    $MainConfig->read("$Bin/../Common/Main.ini");
    $MainConfig->{Config}->{"User Scenarios"}=0;
    $MainConfig->write("$Bin/../Common/Main.ini");
}
