use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/../../Lib";
use Logger;
use Getopt::Long;
use Config::INI::Simple;
use Time::HiRes qw(time);
use File::Path;
use VSO;

my $Conf=new Config::INI::Simple;
my $DelIni=new Config::INI::Simple;
my $Log=new Logger;
my $InstallPath;
my @FilesToDel;
my $FilesToDel;

mkpath "..\\Logs";
open(LOG,">>..\\Logs\\ProductScenarios.log") || warn "Could not open the log file\n";
select(LOG);
$|=1;
select(STDOUT);
$|=1;


$Conf->read("$Bin/../ProductScenariosConfig.ini");
$DelIni->read("$Bin/FilesToDelete.ini");

if($Conf->{Updates}->{MSC}==1){

    $InstallPath=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\MSC\Install Dir');
    $Log->Message(3,*LOG,"Deleting Files from MSC folder..");
    $FilesToDel=$DelIni->{MSC}->{ProductFiles};
    @FilesToDel=split(",",$FilesToDel);
    foreach(@FilesToDel){

        $Log->Message(2,*LOG,"Deleting File $_");
        unlink "$InstallPath/$_";
    }

}
if($Conf->{Updates}->{MPS}==1){

    $InstallPath=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\MPS\Install Dir');
    $Log->Message(3,*LOG,"Deleting Files from MPS folder..");
    $FilesToDel=$DelIni->{MPS}->{ProductFiles};
    @FilesToDel=split(",",$FilesToDel);
    foreach(@FilesToDel){

        $Log->Message(2,*LOG,"Deleting File $_");
        unlink "$InstallPath/$_";
    }
}
if($Conf->{Updates}->{MPF}==1){

    $InstallPath=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\MPF\Install Dir');
    $Log->Message(3,*LOG,"Deleting Files from MPF folder..");
    $FilesToDel=$DelIni->{MPF}->{ProductFiles};
    @FilesToDel=split(",",$FilesToDel);
    foreach(@FilesToDel){

        $Log->Message(2,*LOG,"Deleting File $_");
        unlink "$InstallPath/$_";
    }
}
if($Conf->{Updates}->{MHN}==1){

    $InstallPath=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\MHN\Install Dir');
    $Log->Message(3,*LOG,"Deleting Files from MHN folder..");
    $FilesToDel=$DelIni->{MHN}->{ProductFiles};
    @FilesToDel=split(",",$FilesToDel);
    foreach(@FilesToDel){

        $Log->Message(2,*LOG,"Deleting File $_");
        unlink "$InstallPath/$_";
    }
}
if($Conf->{Updates}->{NMC}==1){

    $InstallPath=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\NMC\Install Dir');
    $Log->Message(3,*LOG,"Deleting Files from NMC folder..");
    $FilesToDel=$DelIni->{NMC}->{ProductFiles};
    @FilesToDel=split(",",$FilesToDel);
    foreach(@FilesToDel){

        $Log->Message(2,*LOG,"Deleting File $_");
        unlink "$InstallPath/$_";
    }
}
if($Conf->{Updates}->{MBK}==1){

    $InstallPath=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\MBK\Install Dir');
    $Log->Message(3,*LOG,"Deleting Files from MBK folder..");
    $FilesToDel=$DelIni->{MBK}->{ProductFiles};
    @FilesToDel=split(",",$FilesToDel);
    foreach(@FilesToDel){

        $Log->Message(2,*LOG,"Deleting File $_");
        unlink "$InstallPath/$_";
    }
}
if($Conf->{Updates}->{MQC}==1){

    $InstallPath=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\MQC\Install Dir');
    $Log->Message(3,*LOG,"Deleting Files from MQC folder..");
    $FilesToDel=$DelIni->{MQC}->{ProductFiles};
    @FilesToDel=split(",",$FilesToDel);
    foreach(@FilesToDel){

        $Log->Message(2,*LOG,"Deleting File $_");
        unlink "$InstallPath/$_";
    }
}
if($Conf->{Updates}->{VSO}==1 || $Conf->{Updates}->{VSO}==3){

    $InstallPath=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\AVEngine\DAT');
    $Log->Message(3,*LOG,"Deleting Files from VSO folder..");
    $FilesToDel=$DelIni->{VSO}->{DATFiles};
    @FilesToDel=split(",",$FilesToDel);
    foreach(@FilesToDel){

        $Log->Message(2,*LOG,"Deleting File $_");
        unlink "$InstallPath".$_;
    }
}
if($Conf->{Updates}->{VSO}==2 || $Conf->{Updates}->{VSO}==3){

    $InstallPath=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\VirusScan\InstallSettings\Install Dir');
    $Log->Message(3,*LOG,"Deleting Files from VSO folder..");
    $FilesToDel=$DelIni->{VSO}->{ProductFiles};
    @FilesToDel=split(",",$FilesToDel);
    foreach(@FilesToDel){

        $Log->Message(2,*LOG,"Deleting File $_");
        unlink "$InstallPath/$_";
    }
}
if($Conf->{Updates}->{MSK}==1 || $Conf->{Updates}->{MSK}==3){

    $InstallPath=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\MSK\Install Dir');
    $Log->Message(3,*LOG,"Deleting Files from MSK folder..");
    $FilesToDel=$DelIni->{MSK}->{FilterFiles};
    @FilesToDel=split(",",$FilesToDel);
    foreach(@FilesToDel){

        $Log->Message(2,*LOG,"Deleting File $_");
        unlink "$InstallPath/$_";
    }
}
if($Conf->{Updates}->{MSK}==2 || $Conf->{Updates}->{MSK}==3){

    $InstallPath=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\MSK\Install Dir');
    $Log->Message(3,*LOG,"Deleting Files from MSK folder..");
    $FilesToDel=$DelIni->{MSK}->{ProductFiles};
    @FilesToDel=split(",",$FilesToDel);
    foreach(@FilesToDel){

        $Log->Message(2,*LOG,"Deleting File $_");
        unlink "$InstallPath/$_";
    }
}


#Set the update option to 3 and get the time taken to get notified of the updates.
if($Conf->{Updates}->{CheckInitTime}==1){

    eval{

        $Log->Message(2,*LOG,"Calculating Update Initialization Time..");
        system("$Bin\\setupdate.exe","/n");
        system("$Bin\\manageupdates.exe");
    };
    sleep 2;
}

eval{

    $Log->Message(2,*LOG,"Calculating Update Time..");
    system("$Bin\\setupdate.exe","/p");
    system("$Bin\\manageupdates.exe","/download");

};
