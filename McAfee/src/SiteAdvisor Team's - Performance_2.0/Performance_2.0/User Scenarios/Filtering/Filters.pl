use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/../../Lib";
use Logger;
use Getopt::Long;
use Config::INI::Simple;
use VSO;
use Time::HiRes qw(time usleep);
use Win32;
use Win32::OLE;

my $Log=new Logger();
my $Conf=new Config::INI::Simple;
my $CurrentIteration;
my $MPSBuild=VSO::GetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\MPS\Build') || 0;
my @AllowedSites;
my @BlockedSites;
my $FilterIni=new Config::INI::Simple;
my @ImageFilterSites;
my @KeyWordFilterSites;

chdir $Bin;

#Open the log file for writing
open(LOG,">> $Bin/../Logs/UserScenarios.log") or warn;
$|=1;
$Log->Message(2,*LOG,"Executing Filters.pl...");

$Conf->read("$Bin/../UserScenariosConfig.Ini") ;
$CurrentIteration=$Conf->{Settings}->{IterationCounter};
$CurrentIteration++;

$Log->Message(2,*LOG,"Filters.pl running state is ".$Conf->{Filter}->{Running});
if($Conf->{Filter}->{Running}==0){

    $Log->Message(2,*LOG,"MPS build detected as $MPSBuild");
    
    ##############################################################
    #Check if MPS 10.0 is installed, if not then all these settings need not be done.
    ##############################################################
    if($MPSBuild=~m/10.0/g){

        #Register the msxml4.dll
        Win32::RegisterServer("$Bin/Tools/msxml4.dll");
        
        ##############################################################
        # Set the limited user as a young child and enable image and keyword filtering
        ##############################################################
        eval{
            
            system("$Bin/Tools/MPS10ApiCfgTool.exe","$Bin/Tools/MapLimitedUser.xml");
        };
        if($? || $@){
            
            $Log->Error(2,*LOG,"Mapping Limited user to young Child failed");
        }
        
        ##############################################################
        # Adding websites to the blocked list
        ##############################################################
        if($Conf->{Filter}->{WebSiteFilter}==1){
            
            eval{
            
                system("$Bin/Tools/MPS10ApiCfgTool.exe","$Bin/Tools/AddAllowedSitesUrls.xml");
                system("$Bin/Tools/MPS10ApiCfgTool.exe","$Bin/Tools/AddBlockedSitesUrls.xml");
            };
            if($? || $@){
                
                $Log->Error(2,*LOG,"Adding URL to blocked and allowed list failed");
            }
        }
        
        
        ##############################################################
        # Adding keywords to the blocked list
        ##############################################################
        if($Conf->{Filter}->{KeywordFilter}==1){
            
            eval{
            
                system("$Bin/Tools/MPS10ApiCfgTool.exe","$Bin/Tools/AddKeywords.xml");
            };
            if($? || $@){
                
                $Log->Error(2,*LOG,"Adding keywords to blocked list failed");
            }
        }
        
        
        ##############################################################
        # Switching on the Image Analyzer
        ##############################################################
        if($Conf->{Filter}->{ImageFilter}==1){
            
            eval{
            
                system("$Bin/Tools/MPS10ApiCfgTool.exe","$Bin/Tools/SwitchIAON.xml");
            };
            if($? || $@){
                
                $Log->Error(2,*LOG,"Switching Image Analyzer ON Failed");
            }
        }
        else{
            
            eval{
            
                system("$Bin/Tools/MPS10ApiCfgTool.exe","$Bin/Tools/SwitchIAOFF.xml");
            };
            if($? || $@){
                
                $Log->Error(2,*LOG,"Switching Image Analyzer OFF Failed");
            }
        }
    }
    
    $Log->Message(2,*LOG,"Setting Autologon with user ".$Conf->{Filter}->{'Limited UserName'}." and password ".$Conf->{Filter}->{'Limited Password'});

    #Set the autologon
    VSO::SetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon','AutoAdminLogon',1,'REG_SZ');
    VSO::SetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon','DefaultUserName',$Conf->{Filter}->{'Limited UserName'},'REG_SZ');
    VSO::SetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon','Defaultpassword',$Conf->{Filter}->{'Limited Password'},'REG_SZ');

    #Set the INI file value
    $Log->Message(2,*LOG,"Setting Running=1");
    $Conf->{Filter}->{Running}=1;
    $Conf->write("$Bin/../UserScenariosConfig.Ini") ;
    sleep 2;

    #Restart the machine now to logon in the non admin mode
    system("./../../Common/shutdown.exe","-f","-r","-t","10");
    exit(2);
}
else{

    
    $Log->Message(2,*LOG,"Executing Filters.pl after restart...");
    
    $FilterIni->read("$Bin/Filters.ini");
    
    
    ##############################################################
    # Check if the Website filter=1 then run the filtering test case.
    ##############################################################
    if($Conf->{Filter}->{WebSiteFilter}==1){
        
        
        ##############################################################
        #Open all the allowed websites
        ##############################################################
        @AllowedSites=split(/,/,$FilterIni->{WebSites}->{Allowed});
        foreach(@AllowedSites){
            
            $Log->Message(2,*LOG,"Opening Allowed Site $_...");
            eval{
                
                system("perl","$Bin/../IE/IENavigate.pl","/url",$_,"/desc","AllowedSite");
            };
        }
        
        ##############################################################
        # open all the blocked websites.
        ##############################################################
        @BlockedSites=split(/,/,$FilterIni->{WebSites}->{Blocked});
        foreach(@BlockedSites){
            
            $Log->Message(2,*LOG,"Opening Blocked Site $_...");
            eval{
                
                system("perl","$Bin/../IE/IENavigate.pl","/url",$_,"/desc","BlockedSite");
            };
        }
    }
    
    ##############################################################
    # Check if image filtering is ON and run the test case.
    ##############################################################
    if($Conf->{Filter}->{ImageFilter}==1){
        
        @ImageFilterSites=split(/,/,$FilterIni->{"Image Analyzer"}->{URL});
        foreach(@ImageFilterSites){
            
            $Log->Message(2,*LOG,"Opening ImageFiltered Site $_...");
            eval{
                
                system("perl","$Bin/../IE/IENavigate.pl","/url",$_,"/desc","ImageFilter");
            };
        }
    }
    
    ##############################################################
    # Check if keyword filter is on and open the webpage.
    ##############################################################
    if($Conf->{Filter}->{KeywordFilter}==1){
        
        @KeyWordFilterSites=split(/,/,$FilterIni->{Keywords}->{URL});
        foreach(@KeyWordFilterSites){
            
            $Log->Message(2,*LOG,"Opening KeyWordFiletred Site $_...");
            eval{
                
                system("perl","$Bin/../IE/IENavigate.pl","/url",$_,"/desc","KeyWordFilter");
            };
        }
    }
    
    ##############################################################
    # Change back the autologon to the administrator
    ##############################################################
    eval{
        
        $Log->Message(2,*LOG,"Setting administrator as default logon");
	system("$Bin/cpau.exe","-u",$Conf->{Filter}->{'Admin UserName'},"-p",$Conf->{Filter}->{'Admin Password'},"-ex","perl SetAdmin.pl" ,"-lwp");
    };
    
    
    #Reset the INI file value
    $Conf->{Filter}->{Running}=0;
	$Conf->{Settings}->{IterationCounter}++;
    $Conf->write("$Bin/../UserScenariosConfig.Ini") ;
    
    
    ##############################################################
    # Restart the machine again.
    ##############################################################
    eval{
        
        system("$Bin/cpau.exe","-u",$Conf->{Filter}->{'Admin UserName'},"-p",$Conf->{Filter}->{'Admin Password'},"-ex","$Bin/../../Common/shutdown.exe -f -r -t 10" ,"-lwp");
	exit(2);
    };
    
    
}
