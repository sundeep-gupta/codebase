use strict;
use FindBin qw($Bin);
use lib "$Bin/../../Lib";
use Logger;
use VSO;
use File::Copy;
use File::Path;
use Win32;

my $oldlocation;
my $newlocation;
my $HomeDir=$Bin;
my $Log=new Logger;

chdir $HomeDir;

mkpath "..\\Logs";
open(LOG,">>..\\Logs\\ProductScenarios.log") || warn "Could not open the log file\n";
select(LOG);
$|=1;
select(STDOUT);
$|=1;

############### Redirect all Error messages to LOG  ######################
*STDERR=*LOG;

######################## End of SIG section #######################################

#This is to Register mctest.dll using regsvr32.exe.
#Here the @window Returns the window ID of the Dialog Box which comes after registering the mctest.dll.
#the dll is registered only if not done previously
if(! -f  "C:\\Program Files\\McAfee\\VirusScan\\mctest.dll")
{
    # Here the mctest.dll is being copied to the Virus Scan Folder in C:\ProgramFiles\mcafee\Mcafee

  $oldlocation = $HomeDir."\\mctest.dll";

    $newlocation = "C:\\Program Files\\McAfee\\VirusScan\\mctest.dll";

    $Log->Message(2,*LOG,"Copying  $oldlocation to $newlocation");
    if (copy($oldlocation, $newlocation) > 0)
    {
        $Log->Message(2,*LOG,"The file $newlocation has been successfully copied");
    }
    else
    {
        $Log->Message(2,*LOG,"The file $newlocation  could not be copied");
        exit;
    }

    $Log->Message(2,*LOG,"Registering the Mctest.dll");
    eval
    {
        Win32::RegisterServer("C:\\Program Files\\McAfee\\VirusScan\\mctest.dll");
    };
    if($@)
    {
        $Log->Message(2,*LOG,"Registration of McTest.dll Failed");
        exit;
    }

}


eval
{
  $Log->Message(2,*LOG,"Calling Scan.vbs...");
  $Log->Message(2,*LOG,"ODS has started...please wait for it to finish");
  system("cscript","$HomeDir\\Scan.vbs","//Nologo",1);
  $Log->Message(2,*LOG,"ODS has Finshed.Please see ODS.log for more details of PIDs in case of errors");
};

if($?  ||  $@)
{
  $Log->Error(2,*LOG,"Error is Scan.vbs execution\n");
  exit 1;
}
