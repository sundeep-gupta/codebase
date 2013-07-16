use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/../../Lib";
use Logger;
use Getopt::Long;
use Config::INI::Simple;
use Time::HiRes qw(time usleep);
use File::Path;
use VSO;
use File::Copy;


my $Conf=Config::INI::Simple->new();
my $Log=new Logger();
my $Source;
my $Destination;
my $StartTime;
my $EndTime;
my $Report=Config::INI::Simple->new();
my $Iteration;

mkpath "$Bin/../Logs";

#Open the log file for writing
open(LOG,">> $Bin/../Logs/UserScenarios.log") or warn;
$|=1;
$Log->Message(2,*LOG,"Executing FileCopy.pl...");

$Conf->read("$Bin/../UserScenariosConfig.Ini") or die;
$Source=$Conf->{FileCopy}->{Source};
$Destination=$Conf->{FileCopy}->{Destination};
$Iteration=$Conf->{Settings}->{IterationCounter};
$Iteration++;

$Log->Message(2,*LOG,"Source : $Source");
$Log->Message(2,*LOG,"Destination : $Destination");

#Exit if the source folder does not exist.
$Log->Error(2,*LOG,"Source Folder does not exist"),exit(1) if(!-d $Source);

#Delete the destination if present.
$Log->Message(2,*LOG,"Deleting Destination : $Destination");
eval{

    system("rmdir","/s/q",$Destination) if(-d $Destination);
};
if($@ || $?){

    $Log->Error(2,*LOG,"Error deleting Destination folder"),exit(1) if(!-d $Source);
}


#Start Copying....
eval{

    $StartTime=time();
    system("xcopy",$Source,$Destination,"/s/y/i");
};
if($? || $@){

    $Log->Error(2,*LOG,"Copying Failed with Error code $?");
    exit(1);
}
else{

    $EndTime=time;
    open(INI,"> $Bin/../Logs/Report.Ini"),close INI if(!-f "$Bin/../Logs/Report.Ini" );
    $Report->read("$Bin/../Logs/Report.Ini");
    $Report->{"Iteration_".$Iteration}->{FileCopy_StartTime}=localtime($StartTime);
    $Report->{"Iteration_".$Iteration}->{FileCopy_EndTime}=localtime($EndTime);
    $Report->{"Iteration_".$Iteration}->{FileCopy_TimeTaken}=$EndTime-$StartTime;
    $Report->write("$Bin/../Logs/Report.Ini");
}
