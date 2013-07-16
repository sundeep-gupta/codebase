use strict;
use Getopt::Long;
use Config::INI::Simple;
use Win32::IEAutomation;
use FindBin qw($Bin);
use lib "$Bin/../../Lib";
use Logger;
use Time::HiRes qw(time usleep);
use File::DirWalk;

my $NavigateURL;
my $StartTime;
my $EndTime;
my $Log=new Logger();
my $Conf=new Config::INI::Simple;
my $Report=new Config::INI::Simple;
my $CurrentIteration;
my $IE;
my $TempLocation=$ENV{USERPROFILE}.'\Local settings\Temporary Internet Files';
my $Cookies=$ENV{USERPROFILE}.'\Cookies';
my $Desc;

#Open the log file for writing
open(LOG,">> $Bin/../Logs/UserScenarios.log") or warn;
$|=1;

#Get the command line params
GetOptions('/','url:s' => \$NavigateURL,
           '/','desc:s' => \$Desc);

$NavigateURL="about:blank" if(!defined $NavigateURL || $NavigateURL eq "");
$Conf->read("$Bin/../UserScenariosConfig.Ini") or die;
$CurrentIteration=$Conf->{Settings}->{IterationCounter};
$CurrentIteration++;

#Clear the Temporary internet files
$Log->Message(2,*LOG,"Clearing Temporary internet files..");
ClearDir($TempLocation);

#Clear Coookies
$Log->Message(2,*LOG,"Clearing Cookies..");
ClearDir($Cookies);

$Log->Message(2,*LOG,"Executing IENavigate.pl with url $NavigateURL...");
$Log->Message(3,*LOG,"URL passed as $NavigateURL");

# Creating new instance of Internet Explorer
$IE = Win32::IEAutomation->new( visible => 1, maximize => 0);

#Capture the start time
$StartTime=time;

# Site navigation
$IE->gotoURL($NavigateURL,0);

#wait for the page to load
$IE->WaitforDone();

#capture the end time
$EndTime=time;

$Report->read("$Bin/../Logs/Report.Ini");
if($NavigateURL=~m/about:blank/gi){

    $Report->{"Iteration_".$CurrentIteration}->{IECreate_StartTime}=localtime($StartTime);
    $Report->{"Iteration_".$CurrentIteration}->{IECreate_EndTime}=localtime($EndTime);
    $Report->{"Iteration_".$CurrentIteration}->{IECreate_TimeTaken}=$EndTime-$StartTime;

}
else{

    $Report->{"Iteration_".$CurrentIteration}->{"IENavigate$Desc"."_$NavigateURL"."_StartTime"}=localtime($StartTime);
    $Report->{"Iteration_".$CurrentIteration}->{"IENavigate$Desc"."_$NavigateURL"."_EndTime"}=localtime($EndTime);
    $Report->{"Iteration_".$CurrentIteration}->{"IENavigate$Desc"."_$NavigateURL"."_TimeTaken"}=$EndTime-$StartTime;
}
sleep 5;
$IE->closeIE();
$Report->write("$Bin/../Logs/Report.Ini");




##############################################################
# This method clears the Temp files and cookies.
##############################################################
sub ClearDir{

    my $Dir=shift;
    my $Dw=new File::DirWalk();

    $Dw->onFile(sub{
                                        my $File=shift;
                                        unlink $File;
                                        return File::DirWalk::SUCCESS;
                                    }
    );

    $Dw->onDirLeave(sub{
                                                my $Folder=shift;
                                                rmdir $Folder;
                                                return File::DirWalk::SUCCESS;
                                            }
    );

    $Dw->walk($Dir);

}
