use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/../../Lib";
use Logger;
use Getopt::Long;
use Config::INI::Simple;
use Win32::OLE;
use Win32::Process;
use VSO;
use Time::HiRes qw(time usleep);
use Win32::AbsPath;


my $Log=new Logger();
my $Conf=new Config::INI::Simple;
my $WordObject;
my $ExcelObject;
my $PPTObject;
my $PDFObject;
my $Object;
my $CurrentIteration;
my $Report=new Config::INI::Simple;
my $StartTime;
my $EndTime;
my $WMPObject;
my $WinBin=Win32::AbsPath::Fix $Bin;

chdir $WinBin;

#Open the log file for writing
open(LOG,">> $Bin/../Logs/UserScenarios.log") or warn;
$|=1;
$Log->Message(2,*LOG,"Executing OpenApps.pl...");

$Conf->read("$Bin/../UserScenariosConfig.Ini");
$CurrentIteration=$Conf->{Settings}->{IterationCounter};
$CurrentIteration++;

################################################################
#open a word doc
################################################################
if($Conf->{Applications}->{Word}==1){

    $Log->Message(2,*LOG,"Opening Word Document...");
	system("cscript","$WinBin\\OpenWord.vbs","$WinBin\\AppFiles\\Test.doc","//nologo");
	VSO::Counter(10);
=pod
    $WordObject=Win32::OLE->new("word.application");
    $WordObject->{Visible}=1;
    $StartTime=time;
    $Object=$WordObject->{Documents}->open({Filename => "$Bin/AppFiles/Test.doc"});
    $EndTime=time;
    $Report->read("$Bin/../Logs/Report.ini");
    $Report->{"Iteration_".$CurrentIteration}->{OpenDOC_StartTime}=localtime($StartTime);
    $Report->{"Iteration_".$CurrentIteration}->{OpenDOC_EndTime}=localtime($EndTime);
    $Report->{"Iteration_".$CurrentIteration}->{OpenDOC_TimeTaken}=$EndTime-$StartTime;
    $Report->write("$Bin/../Logs/Report.ini");
    $Log->Error(2,*LOG,"Error Opening Doc..") unless $Object;
    sleep 2;
    $WordObject->Quit();
=cut
}
else{

    $Log->Message(3,*LOG,"Skipping Word Document...");
}

################################################################
#open an excel doc
################################################################
if($Conf->{Applications}->{Excel}==1){

    $Log->Message(2,*LOG,"Opening Excel Document...");

    $ExcelObject=Win32::OLE->new("excel.application");
    $ExcelObject->{Visible}=1;
    $StartTime=time;
    $Object=$ExcelObject->{Workbooks}->open({Filename => "$Bin/AppFiles/Test.xls"});
    $EndTime=time;
    $Report->read("$Bin/../Logs/Report.ini");
    $Report->{"Iteration_".$CurrentIteration}->{OpenXLS_StartTime}=localtime($StartTime);
    $Report->{"Iteration_".$CurrentIteration}->{OpenXLS_EndTime}=localtime($EndTime);
    $Report->{"Iteration_".$CurrentIteration}->{OpenXLS_TimeTaken}=$EndTime-$StartTime;
    $Report->write("$Bin/../Logs/Report.ini");
    $Log->Error(2,*LOG,"Error Opening Excel..") unless $Object;
    sleep 2;
    $ExcelObject->Quit();
	VSO::Counter(10);
}
else{

    $Log->Message(3,*LOG,"Skipping Excel Document...");
}

################################################################
#Open a PPT Doc
################################################################
if($Conf->{Applications}->{PPT}==1){

    $Log->Message(2,*LOG,"Opening PPT Document...");

    $PPTObject=Win32::OLE->new("powerpoint.application");
    $PPTObject->{Visible}=1;
    $StartTime=time;
    $Object=$PPTObject->{Presentations}->open({Filename => "$Bin/AppFiles/Test.ppt"});
    $EndTime=time;
    $Report->read("$Bin/../Logs/Report.ini");
    $Report->{"Iteration_".$CurrentIteration}->{OpenPPT_StartTime}=localtime($StartTime);
    $Report->{"Iteration_".$CurrentIteration}->{OpenPPT_EndTime}=localtime($EndTime);
    $Report->{"Iteration_".$CurrentIteration}->{OpenPPT_TimeTaken}=$EndTime-$StartTime;
    $Report->write("$Bin/../Logs/Report.ini");
    $Log->Error(2,*LOG,"Error Opening PPT..") unless $Object;

    sleep 2;

    $PPTObject->Quit();
	VSO::Counter(10);
}
else{

    $Log->Message(3,*LOG,"Skipping PPT Document...");
}

################################################################
# Open a PDF document
################################################################
if($Conf->{Applications}->{PDF}==1){

    $Log->Message(2,*LOG,"Opening PDF File...");
    my $AdobeInstallPath=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\Adobe\Acrobat Reader\8.0\InstallPath\\\\');
    my $FilePath;
    my $CPUUsage;
    my $Stable=0;

    $AdobeInstallPath=$AdobeInstallPath.'\AcroRd32.exe';
    $FilePath="$Bin/AppFiles/Test.pdf";
    $FilePath=~s/\//\\/g;
    $StartTime=time;
    Win32::Process::Create($PDFObject,$AdobeInstallPath," \"$FilePath\"",0,NORMAL_PRIORITY_CLASS,".");

    $CPUUsage=VSO::GetProcCPUUsage("AcroRd32");
    while($Stable < 5)
    {
        print "AcroRd32.exe CPU Usage : $CPUUsage ";
        if ($CPUUsage <= 2){

            if($Stable ==1)
            {
                $EndTime=time;
            }
            print "($Stable of 5)\n";
            $Stable++;

        }
        else{

            $Stable=1;
            print "\n";
        }
        $CPUUsage=VSO::GetProcCPUUsage("AcroRd32");
    }
    $Report->read("$Bin/../Logs/Report.ini");
    $Report->{"Iteration_".$CurrentIteration}->{OpenPDF_StartTime}=localtime($StartTime);
    $Report->{"Iteration_".$CurrentIteration}->{OpenPDF_EndTime}=localtime($EndTime);
    $Report->{"Iteration_".$CurrentIteration}->{OpenPDF_TimeTaken}=$EndTime-$StartTime;
    $Report->write("$Bin/../Logs/Report.ini");

    sleep 2;
    KillProc("AcroRd32");
	VSO::Counter(10);

}
else{

    $Log->Message(3,*LOG,"Skipping PDF Document...");
}

################################################################
# Open a MP3 File
################################################################
if($Conf->{Applications}->{MP3}==1){

    $Log->Message(2,*LOG,"Opening MP3 File...");

    $WMPObject=Win32::OLE->new("wmplayer.ocx");
    $WMPObject->{url}="$Bin/AppFiles/Test.mp3";
    $WMPObject->{Controls}->play();
    $StartTime=time;
    while($WMPObject->{Controls}->{CurrentPosition} < 3){

        sleep 1;
    }
    $EndTime=time;
    $WMPObject->{Controls}->stop();
    $WMPObject->Close();
    $Report->read("$Bin/../Logs/Report.ini");
    $Report->{"Iteration_".$CurrentIteration}->{OpenMP3_StartTime}=localtime($StartTime);
    $Report->{"Iteration_".$CurrentIteration}->{OpenMP3_EndTime}=localtime($EndTime);
    $Report->{"Iteration_".$CurrentIteration}->{OpenMP3_TimeTaken}=$EndTime-$StartTime;
    $Report->write("$Bin/../Logs/Report.ini");
	VSO::Counter(10);

}
else{

    $Log->Message(3,*LOG,"Skipping MP3.....");
}