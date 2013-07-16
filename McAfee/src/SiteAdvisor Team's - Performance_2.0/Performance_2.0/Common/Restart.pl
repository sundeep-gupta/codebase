use Win32;
use VSO;
use Config::INI::Simple;
use File::Copy;
use Getopt::Long;

my $Conf=new Config::INI::Simple;
my $Counter;
my $NumberofTimes;
my $LoggedUsr=Win32::LoginName();
my @TimeDiff;
my %ErrorCode;
my $ConfigFlag;
my $RestartFlag;
my $StartupFlag;
my $WaitTime;

chdir "D:/Performance/Restart";

######################################################################
# Parses the cmd parameters for input.
######################################################################
GetOptions('/','count=i' => \$NumberofTimes,
                 '/','config' => \$ConfigFlag,
                 '/','startup' => \$StartupFlag,
                 '/','restart'  => \$RestartFlag,
                 '/','wait:i'     => \$WaitTime,
                 '/','help|?'  => \&Help);

if($ConfigFlag == 1)
{
  CreateConfig();
}
elsif($StartupFlag == 1)
{
  Startup();
}
elsif($RestartFlag == 1)
{
  Restart();
}
else
{
  Help();
}

######################################################################
# Creates the Configuration file.
######################################################################

sub CreateConfig
{
    my $YesNO;

    open(INI,'> Settings.ini') or die;
    close(INI);
    $Conf->read("settings.ini");
    $Conf->{RESTART}->{Counter}=0;
    $Conf->{RESTART}->{NumberofTimes}=$NumberofTimes || 1;
    $Conf->{RESTART}->{WaitTime}=$WaitTime || 120;
    $Conf->write("settings.ini");

    copy('./restart.bat',"C:\\Documents and Settings\\$LoggedUsr\\Start Menu\\Programs\\Startup\\restart.bat");
    print "\n\nThe test will run for $NumberofTimes iterations.Press Y to continue : ";
    $YesNo=<STDIN>;
    if($YesNo=~m/^y/i)
    {
      Restart();
    }
    else
    {
      exit(0);
    }

}

######################################################################
# The startup method.This method is called when the system restarts.This method checks  #
# McAgent is started and then notes the startup time.
######################################################################

sub Startup
{
    my $Confirm;
    $Conf->read("settings.ini");
    $Counter=$Conf->{RESTART}->{Counter};
    $NumberofTimes=$Conf->{RESTART}->{NumberofTimes};
    my $CPUUsage=VSO::GetCPUUsage();
    my $McShellPid=VSO::GetPID("mcagent");
    my $SystemUptime;

    while($Confirm <= 10)
    {
        print "McAgent Pid : $McShellPid \n";
        print "Current CPU Usage : $CPUUsage \n";

        if($CPUUsage < 2.000 && $McShellPid > 0)
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
        $CPUUsage=VSO::GetCPUUsage();
        $McShellPid=VSO::GetPID("mcagent");
    }

    $Conf->{"RESTART_".$Counter}->{StartupTime}=$SystemUptime;
    @TimDiff=VSO::TimeDiff($Conf->{"RESTART_".$Counter}->{shutdowntime},$SystemUptime);
    $Conf->{"RESTART_".$Counter}->{DIFF}="$TimDiff[0] Hrs : $TimDiff[1] Mins : $TimDiff[2] Secs";
    $Conf->write("settings.ini");
    while($Counter != $NumberofTimes)
    {
        print "\nWaiting for $Conf->{RESTART}->{WaitTime} secs before the next restart......\n";
        VSO::Counter($Conf->{RESTART}->{WaitTime});
        Restart();
    }
}

######################################################################
# This method is called when a system restart is required.
######################################################################

sub Restart
{
	$Conf->{RESTART}->{Counter}=$Conf->{RESTART}->{Counter} + 1;
  $Counter=$Conf->{RESTART}->{Counter};
  $Conf->{"RESTART_".$Counter}->{shutdowntime}=time;
	$Conf->write("settings.ini");
  Win32::InitiateSystemShutdown("","Shutdown",0,1,1);
}


######################################################################
# The Help method.
######################################################################

sub Help
{
    print "\n\nUsage Restart \n\n".
             "/count   = No of time the test should run.(should be used along with /config)\n".
             "/config  = Creates the settings.ini\n".
             "/wait    = Time to wait before the next restart.(Only if Restart iterations is             greater than 1,default 120 secs)\n".
             "/restart = Record the time and Restart the system.\n".
             "/startup = Record the time after the system restarts.\n\n";
}


