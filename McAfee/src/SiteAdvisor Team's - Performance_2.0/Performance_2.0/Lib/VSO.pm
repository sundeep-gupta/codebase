package VSO;

use 5.008006;
use strict;
use warnings;
use Carp;
use File::Find;
use Win32::Process;
use Win32::Process::List;
use Win32::Service;
use Win32::TieRegistry;
use File::Path;
use File::Copy;
use Win32::PerfLib;
use File::DirWalk;
use Digest::MD5;
use Net::POP3;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT      = qw(
                   CountFilesInFolder
                   GetIP
                   GetPID
                   ChangeDATS
                   KillProc
                   Counter
                   Trim
                   LTrim
                   RTrim
                   GetExtension
                   ParsePath
                   GetCPUTime
                   GetServiceStatus
                   TimeDiff
                   GetOS
                   GetRegKeyValue
                   SetRegKeyValue
                   DelRegKeyValue
                   SwitchOAS
                   GetCPUUsage
                   GetProcCPUUsage
                   GetMD5
                   GetEmailsOnServer
                   DeleteMailsOnServer
				   GetInstallPath
                   );

our $VERSION = '1.0';

##########################################################################################
# Get the Files in a Folder
# Input  : Folder Path
# Output : File Count
##########################################################################################

sub CountFilesInFolder
{
  my $Folder=shift;
  my $Dwalk=new File::DirWalk;
  my $FileCount=0;

  if(-d $Folder)
  {

    $Dwalk->onFile(sub{
                                         my $File=shift;
                                         $FileCount++ if(-f  $File);
                                         return File::DirWalk::SUCCESS;
                                        });
    $Dwalk->walk($Folder);


    #find(\&Count,$Folder);
    return $FileCount;
  }
  else
  {
    croak "$Folder directory does not exist.";
  }
}


###########################################################################################
# Gets the IP of the system. if the system is not in the network it returns "localhost"
# Input : NULL
# Output: IP address
###########################################################################################

sub GetIP
{
  my $local_IP;
  my $local_name;

  $local_name = $ENV{HOSTNAME} || $ENV{HTTP_HOST} || (gethostbyname 'localhost')[0];
  $local_IP =  join('.',unpack('CCCC',(gethostbyname $local_name)[4]));


  return $local_IP;
}

###########################################################################################
# Gets the PID of a process whose name in full is given as the input eg: notepad.exe                                                            #
# Input : Process/Service Name                                                                                                                                                          #
# Output: PID                                                                                                                                                                                         #
###########################################################################################
sub GetPID
{
  my $ProcessName=shift;
  my $Process;
  my %ProcId;
  my $Proc;


  $Process = Win32::Process::List->new();
  %ProcId=$Process->GetProcessPid($ProcessName);
  foreach $Proc (keys %ProcId)
  {
    return $ProcId{$Proc};
    last;
  }


}

###########################################################################################
# Changes the DATs in the C:\Program Files\McAfee\VirusScan\DAT\<DAT VER> folder                                                 #
# Input  : New Dats path                                                                                                                                                                      #
# Output : NULL. The dats get changed                                                                                                                                           #
###########################################################################################

sub ChangeDATS
{
  my $srcpath=shift;
  my $McInsUpdPath;

  if(!-f "$srcpath\\vsodat.cab")
  {
    return "The vsodat.cab does not exist at $srcpath.\n";
  }
  $McInsUpdPath=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\VirusScan\InstallSettings\Install Dir');

  if(!-f  $McInsUpdPath."\\mcinsupd.exe")
  {
    return "Mcinsupd.exe does not exist";
  }
  else
  {
    eval
    {
      system($McInsUpdPath."\\mcinsupd.exe",$srcpath);
    };
    if($@ || $?)
    {
      return "$@.$?";
    }
    else
    {
      return 0;
    }
  }

}

###########################################################################################
# Kills a process.                                                                        #
# Input  : Process Name                                                                   #
# Output : Returns the exit code of the process,else -1 if the process does not return    #
###########################################################################################
sub KillProc
{
  my $ProcName=shift;
  my $ProcPID=GetPID($ProcName);
  my $ExitCode=-1;

  if($ProcPID != -1)
  {
    Win32::Process::KillProcess($ProcPID,$ExitCode);
    return $ExitCode;
  }
  else
  {
    print "The process $ProcName does not exist.\n";
  }
}

###########################################################################################
# Counts till a specified time,also acts like a sleep                                     #
# Input  : Sleep time                                                                     #
# Output :                                                                                #
###########################################################################################

sub Counter
{
  my $SleepTime=shift;
  my $Counter=0;
  print "\n\n";
  while($SleepTime >= 0)
  {
    select(STDOUT);
    $|=1;
	printf "Time Remaining(Secs): %2d \r",$SleepTime;
	$SleepTime--;
    sleep 1;
  }
  print "\n";
}


###########################################################################################
# Trims a string                                                                          #
# Input  : string                                                                         #
# Output : String without the leading or trailing spaces.                                 #
###########################################################################################

sub Trim
{
  my $string=shift;

  $string=~s/^\s+//;
  $string=~s/\s+$//;
  return $string;
}

###########################################################################################
# Left Trims a string                                                                     #
# Input  : string                                                                         #
# Output : String without the leading spaces.                                             #
###########################################################################################

sub LTrim
{
  my $string=shift;

  $string=~s/^\s+//;
  return $string;
}

###########################################################################################
# Right Trims a string                                                                    #
# Input  : string                                                                         #
# Output : String without the trailing spaces.                                            #
###########################################################################################

sub RTrim
{
  my $string=shift;

  $string=~s/\s+$//;
  return $string;
}


###########################################################################################
# This module returns the extension of a file                                             #
# Input  : File name                                                                      #
# Output : Extension                                                                      #
###########################################################################################

sub GetExtension
{
  my $FileName=shift;
  my $Extension;

  chomp($FileName);
  $FileName=Trim($FileName);

  ($Extension)=$FileName=~m/(.\w+)$/;

  return $Extension;
}

#############################################################################################
# This method separates the directory path and file name from an absolute path.             #
# Input : Absolute Path                                                                     #
# Output: Directory path and the file name.                                                 #
#############################################################################################
sub ParsePath
{
  my $FullPath=shift;
  my $Directory;
  my $FileName;

  chomp($FullPath);
  $FullPath=Trim($FullPath);

  ($Directory,$FileName)=$FullPath=~m/(.*\\|\/)(.*)$/;
  $Directory=~s/\\$//g;                                         # Remove the trailing back slash \\.
  return $Directory,$FileName;
}

#############################################################################################
# This method gets the total CPU time used by a process.                                    #
# Input : The process name                                                                  #
# Output: The Total CPU time or -1                                                          #
#############################################################################################

sub GetCPUTime
{
    require Win32::Process::Info;
    my $pid=shift;
    my @ProcInfo;
    my $Process;
    my $InitCPUTime=-1;

    $Process = Win32::Process::Info->new ("","WMI");
    @ProcInfo = $Process->GetProcInfo($pid);

  $InitCPUTime=$ProcInfo[0]->{"UserModeTime"} + $ProcInfo[0]->{"KernelModeTime"};

    return $InitCPUTime;
}

#############################################################################################
# This method checks if a service is running.                                               #
# Input : The service name                                                                  #
# Output: The status of the service, 7-paused, 4-running 1-stopped                          #
#############################################################################################

sub GetServiceStatus
{
  my $Service=shift;
  my %Status;
  Win32::Service::GetStatus("",$Service,\%Status);
  if (exists($Status{'CurrentState'}))
  {
    return $Status{'CurrentState'};
  }
  else
  {
    return -1;
  }

}

#############################################################################################
# This method finds the time difference in HH::MM::SS between two times.                    #
# Input : start time, end time.                                                             #
# Output: difference                                                                        #
#############################################################################################

sub TimeDiff
{
  my $StartTime=shift;
  my $EndTime=shift;
  my $Diff;
  my $Hr;
  my $Min;
  my $Sec;

  $Diff=$EndTime-$StartTime;
  $Hr=sprintf("%02d",int($Diff/3600)%24);
  $Min=sprintf("%02d",int(($Diff-$Hr)/60)%60);
  $Sec=sprintf("%02d",($Diff-$Hr+$Min)%60);

  return ($Hr,$Min,$Sec);
}

#############################################################################################
# This method gets the Operating system name                                                #
# Output: OS name                                                                           #
#############################################################################################

sub GetOS
{
  my $Os;
  my $Bit;
  my ($Desc,$Major,$Minor,$Build,$ID,$SPMajor)=Win32::GetOSVersion();

if($ID!=2){

        croak "Not a NT based system\n";
        return 0;
}
else{

        if($ID==2 && $Major==3 && $Minor==51){

                return "NT3.51";
        }

        if($ID==2 && $Major==4 && $Minor==0){

                return "NT4.0";
        }

        if($ID==2 && $Major==5 && $Minor==0){

                return "Win2000SP$SPMajor";
        }

        if($ID==2 && $Major==5 && $Minor==1){

                return "WinXPSP$SPMajor";
        }

        if($ID==2 && $Major==3 && $Minor==2){

                return "WinServer2003";
        }

        if($ID==2 && $Major==6 && $Minor==0){

                $Bit=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\PROCESSOR_ARCHITECTURE');
                if($Bit =~m/64/){

                  return "WinVista64";
                }
                else{

                  return "WinVista32";
                }

        }

  }
}

#############################################################################################
# This method gets the value of registry key specified                                      #
# Input: Registry key path                                                                                                  #
# Output:Registry Key value                                                                 #
#############################################################################################

sub GetRegKeyValue
{
    my $Key=shift;
    my $RegKey=$Registry->{$Key};

    if(defined $RegKey)
    {
        return $RegKey;
    }
    else
    {
        return undef;
    }
}

#############################################################################################
# This method sets the value of registry key specified                                      #
# Input: Registry key path and value                                                                      #
# Output:Success or failure                                                                 #
#############################################################################################

sub SetRegKeyValue
{
  my $Key=shift;
  my $Subkey=shift;
  my $Value=shift;
  my $Type=shift || "REG_SZ";

  if ($Type eq 'REG_DWORD' or $Type eq 'REG_BINARY')
  {
    $Registry->{$Key}->{"\\$Subkey"}=[pack("L",$Value),$Type];
  }
  else
  {
    $Registry->{$Key}->{"\\$Subkey"}=$Value;
  }

}

#############################################################################################
# This method sets the value of registry key specified                                      #
# Input: Registry key path and value                                                                      #
# Output:Success or failure                                                                 #
#############################################################################################

sub DelRegKeyValue
{
  my $Key=shift;

  delete $Registry->{$Key};
}

#############################################################################################
# This method switches ON/OFF  OAS according to the switch that is passed to it.                                  #
# Input : ON/OFF or 1/0                                                                                                                          #
#Output: switches OAS ON or OFF.                                                                                                         #
#############################################################################################

sub SwitchOAS
{
  my $Op=shift;
  my $ServiceStatus;
  $ServiceStatus=GetServiceStatus("mcshield");



  eval
  {
    if($Op=~m/ON|1/i)
    {
      return 0 if($ServiceStatus==4);
      if($ServiceStatus == 1)
      {
        system("net","start","mcshield");
        sleep 3;
        system("net","continue","mcshield");
      }
      if($ServiceStatus == 7)
      {
        system("net","continue","mcshield");
      }

    }

    if($Op=~m/OFF|0/i)
    {
      return 0 if($ServiceStatus==1);
      if($ServiceStatus == 4)
      {
        system("net","pause","mcshield");
        sleep 3;
        system("net","stop","mcshield");
      }
      if($ServiceStatus == 7)
      {
        system("net","stop","mcshield");
      }

    }
  };
  sleep 3;
  if($? || $@)
  {
      return 1;
  }
  else
  {
      return 0;
  }
}
#############################################################################################
# This method switches Gets the MD5 of the file or string.                                           .                                                                    #
# Input : File or a string .                                                                                                                                                                         #
#Output: The MD5 hash of the string or file                                                                                                                                         #
#############################################################################################
sub GetMD5
{
  my $Input=shift;
  my $Md5Object=Digest::MD5->new();
  my $md5Hash;

  if(-f $Input)
  {
    open(FH,$Input) or die "Could not open the file. $!\n";
    $Md5Object->addfile(*FH);
    close(FH);
  }
  else
  {
    $Md5Object->add($Input);
  }
  $md5Hash=$Md5Object->hexdigest();
  return $md5Hash;

}

#################################################################################################
# Gets the CPU usage in %
#################################################################################################
sub GetCPUUsage
{
  my ($server) = @ARGV;
# only needed for PrintHash subroutine
#Win32::PerfLib::GetCounterNames($server, \%counter);

my $processor = 238;
my $proctime = 6;
my %proc_time;
my $proctimeInPercent;

my $perflib = new Win32::PerfLib($server);
my $proc_ref0 = {};
my $proc_ref1 = {};
$perflib->GetObjectList($processor, $proc_ref0);
sleep 1;
$perflib->GetObjectList($processor, $proc_ref1);
$perflib->Close();
my $instance_ref0 = $proc_ref0->{Objects}->{$processor}->{Instances};
my $instance_ref1 = $proc_ref1->{Objects}->{$processor}->{Instances};

foreach my $p (keys %{$instance_ref0})
{
    my $counter_ref0 = $instance_ref0->{$p}->{Counters};
    my $counter_ref1 = $instance_ref1->{$p}->{Counters};

    foreach my $i (keys %{$counter_ref0})
    {

    next if $instance_ref0->{$p}->{Name} eq "_Total";
    if($counter_ref0->{$i}->{CounterNameTitleIndex} == $proctime)
    {
        my $Numerator0 = $counter_ref0->{$i}->{Counter};
        my $Denominator0 = $proc_ref0->{PerfTime100nSec};
        my $Numerator1 = $counter_ref1->{$i}->{Counter};
        my $Denominator1 = $proc_ref1->{PerfTime100nSec};
        $proc_time{$p} = (1- (($Numerator1 - $Numerator0) /
                  ($Denominator1 - $Denominator0 ))) * 100;
        $proctimeInPercent=sprintf("%.3f",$proc_time{$p});
        return abs $proctimeInPercent;
    }
    }
}
}

 #################################################################################################
# Gets the CPU usage in % of a process
#################################################################################################
sub GetProcCPUUsage
{
  my $server = "";
  my $Process=shift;
$Process=~s/\.exe//;
# only needed for PrintHash subroutine
#Win32::PerfLib::GetCounterNames($server, \%counter);

my $processor = 230;
my $proctime = 6;
my %proc_time;
my $proctimeInPercent;

my $perflib = new Win32::PerfLib($server);
my $proc_ref0 = {};
my $proc_ref1 = {};
$perflib->GetObjectList($processor, $proc_ref0);
sleep 1;
$perflib->GetObjectList($processor, $proc_ref1);
$perflib->Close();
my $instance_ref0 = $proc_ref0->{Objects}->{$processor}->{Instances};
my $instance_ref1 = $proc_ref1->{Objects}->{$processor}->{Instances};

foreach my $p (keys %{$instance_ref0})
{
    my $counter_ref0 = $instance_ref0->{$p}->{Counters};
    my $counter_ref1 = $instance_ref1->{$p}->{Counters};

    foreach my $i (keys %{$counter_ref0})
    {

    #next if $instance_ref0->{$p}->{Name} eq "explorer";
    if($counter_ref0->{$i}->{CounterNameTitleIndex} == $proctime && lc($instance_ref0->{$p}->{Name}) eq  lc($Process))
    {
        my $Numerator0 = $counter_ref0->{$i}->{Counter};
        #Data is collected every 100 nano secs.
        my $Denominator0 = $proc_ref0->{PerfTime100nSec};
        my $Numerator1 = $counter_ref1->{$i}->{Counter};
        my $Denominator1 = $proc_ref1->{PerfTime100nSec};
        $proc_time{$p} = (($Numerator1 - $Numerator0) /
                  ($Denominator1 - $Denominator0 )) * 100;
        $proctimeInPercent=sprintf("%.3f",$proc_time{$p});
        return abs $proctimeInPercent;
    }
    }
}
}


#####################################################################################################
# The Logging method
#####################################################################################################
sub Log
{
    my $LogTo=shift;  # 1- for loggiing to the sreen only, 2 for logging to both the screen and log file and 3 for only log file only.
    my $Type=shift;
    my $Handle=shift;
    my $Message=shift;

    if($LogTo==1 || $LogTo==2)
  {
    print "\n$Message\n";
  }
    if($LogTo==2 || $LogTo==3)
  {
    if($Type=~m/error/i)
    {
      print $Handle "[ Error ]--> ".localtime(time)." $Message\n";
    }

    if($Type=~m/notice|message/i)
    {
      print $Handle "[Message]--> ".localtime(time)." $Message\n";
    }
  }
}
#####################################################################################
# This method generates the short form of the OS that the client send back.eg : Microsoft windows XP will be
# shortened to XP.
#####################################################################################
sub ShortOS
{
    my $FullOsString=shift;
    my $ShortOsString;

     if($FullOsString=~m/windows 2000/i)
    {
        $ShortOsString='2K';
    }
    elsif($FullOsString=~m/Microsoft windows XP/i)
    {
        $ShortOsString='XP';
    }
    elsif($FullOsString=~m/windows vista 64/i)
    {
        $ShortOsString='Vista64';
    }
    elsif($FullOsString=~m/windows vista 32/i)
    {
        $ShortOsString='Vista32';
    }

    return $ShortOsString;
}

#####################################################################################
# This method gets the number of emails from the servers given the email id,server ip and password.
#####################################################################################
sub GetEmailsOnServer{

    my $POP3Server=shift;
    my $EmailID=shift;
    my $Pwd=shift;
    my $EMailsOnServer=0;

    my $POP=Net::POP3->new($POP3Server, Timeout => 120);
    if(defined $POP){

      $EMailsOnServer=$POP->login($EmailID,$Pwd);
      $POP->quit;
    }
    else{

      $EMailsOnServer=0;
    }


    return $EMailsOnServer;
}
#####################################################################################
# This method deletes the emails on the server given the email id,server ip and password.
#####################################################################################
sub DeleteMailsOnServer{

     my $POP3Server=shift;
    my $EmailID=shift;
    my $Pwd=shift;
    my $EMailsOnServer=0;
    my $MessageNumbers;
    my $MailsDeleted=0;

    my $POP=Net::POP3->new($POP3Server, Timeout => 120);
    if(defined $POP){

      $EMailsOnServer=$POP->login($EmailID,$Pwd);
      if($EMailsOnServer > 0){

             $MessageNumbers=$POP->list;
             foreach(keys %$MessageNumbers){

                 $POP->delete($_);
                 $MailsDeleted++;

             }
      }
      $POP->quit;
    }
     return $MailsDeleted;
}

#----------------------------------------------------------------------
# Get the install path of various McAfee Consumer products.
#----------------------------------------------------------------------
sub GetInstallPath{
	
	my $Product=shift;

	if(uc $Product eq 'VSO'){
		
		return GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\VirusScan\InstallSettings\Install Dir');
	}

	return 0;
}

#----------------------------------------------------------------------
# Get VSO Version
#----------------------------------------------------------------------
sub GetVSOVersion{

	return GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\VirusScan\InstallSettings\Substitute\Version') || 0;
}
1;
__END__
