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
use Win32::OLE;
use Win32::Process;
use File::Copy;
use Config::Tiny;


my $Conf=new Config::INI::Simple;
my $Log=new Logger;
my $EmailsOnServer;
my $StartTime;
my $EndTime;
my $Rpt=new Config::INI::Simple;
my $CurrentIteration;


mkpath "..\\Logs";
open(LOG,">>..\\Logs\\ProductScenarios.log") || warn "Could not open the log file\n";
select(LOG);
$|=1;
select(STDOUT);
$|=1;


$Conf->read("$Bin/../ProductScenariosConfig.ini");
$Rpt->read("$Bin/../Logs/Report.ini");
$CurrentIteration=$Conf->{Settings}->{IterationCounter};
$CurrentIteration++;

=pod
if($Conf->{EmailScan}->{SendEmails}==1 && $Conf->{EmailScan}->{FirstSendSuccess}==0){

    if (SendEmails()==1){

        $Conf->{EmailScan}->{FirstSendSuccess}=1;
        $Conf->{EmailScan}->{DeleteOnServer}=0;
    }
    else{

        $Conf->{EmailScan}->{FirstSendSuccess}=0;
    }
    $Conf->write("$Bin/../ProductScenariosConfig.ini");
}

if($Conf->{EmailScan}->{SendEmails}==2){

    SendEmails();
}
=cut

#Check the Config if Clean==1
if($Conf->{EmailScan}->{Clean}==1){

    #Check the account on the server for the number of emails.
	SendEmails($Conf->{EmailScan}->{Clean_ToEmailID},$Conf->{EmailScan}->{Clean_Password},$Conf->{EmailScan}->{Clean_PopServer},"$Bin/CleanMails");
    $EmailsOnServer=VSO::GetEmailsOnServer($Conf->{EmailScan}->{Clean_PopServer},$Conf->{EmailScan}->{Clean_ToEmailID},$Conf->{EmailScan}->{Clean_Password});
    $Log->Message(2,*LOG,"There are $EmailsOnServer emails on ther server for email id $Conf->{EmailScan}->{Clean_ToEmailID}");
    $StartTime=undef;
    $EndTime=undef;

    #Download Emails only if there are more than 0 zero emails
    if($EmailsOnServer > 0){

        DownloadEmails($Conf->{EmailScan}->{Clean_UserName},$Conf->{EmailScan}->{Clean_ToEmailID},$Conf->{EmailScan}->{Clean_Password},$Conf->{EmailScan}->{Clean_PopServer},$EmailsOnServer);
        $Rpt->{"Iteration_".$CurrentIteration}->{CleanEmails_StartTime}=localtime($StartTime);
        $Rpt->{"Iteration_".$CurrentIteration}->{CleanEmails_EndTime}=localtime($EndTime);
        $Rpt->{"Iteration_".$CurrentIteration}->{CleanEmails_TimeTaken}=$EndTime-$StartTime;
        $Rpt->write("$Bin/../Logs/Report.ini");
    }


}


#Download Spam emails if enabled in Config File.
if($Conf->{EmailScan}->{Spam}==1){

    SendEmails($Conf->{EmailScan}->{Spam_ToEmailID},$Conf->{EmailScan}->{Spam_Password},$Conf->{EmailScan}->{Spam_PopServer},"$Bin/Spammails");
	#Check the account on the server for the number of emails.
    $EmailsOnServer=VSO::GetEmailsOnServer($Conf->{EmailScan}->{Spam_PopServer},$Conf->{EmailScan}->{Spam_ToEmailID},$Conf->{EmailScan}->{Spam_Password});
    $Log->Message(2,*LOG,"There are $EmailsOnServer emails on ther server for email id $Conf->{EmailScan}->{Spam_ToEmailID}");
    $StartTime=undef;
    $EndTime=undef;
    if($EmailsOnServer > 0){

        DownloadEmails($Conf->{EmailScan}->{Spam_UserName},$Conf->{EmailScan}->{Spam_ToEmailID},$Conf->{EmailScan}->{Spam_Password},$Conf->{EmailScan}->{Spam_PopServer},$EmailsOnServer);
        $Rpt->{"Iteration_".$CurrentIteration}->{SpamEmails_StartTime}=localtime($StartTime);
        $Rpt->{"Iteration_".$CurrentIteration}->{SpamEmails_EndTime}=localtime($EndTime);
        $Rpt->{"Iteration_".$CurrentIteration}->{SpamEmails_TimeTaken}=$EndTime-$StartTime;
        $Rpt->write("$Bin/../Logs/Report.ini");
    }

}


sub DownloadEmails{


    #The Emails already downloaded will not be downloaded again if some the outlook.pst is not modified.Any other tweak will also work for this.
    unlink $ENV{USERPROFILE}.'\Local Settings\Application Data\Microsoft\Outlook\outlook.pst';
    copy("$Bin/outlook.pst",$ENV{USERPROFILE}.'\Local Settings\Application Data\Microsoft\Outlook\outlook.pst');

    my $OutlookApp=Win32::OLE->new("Outlook.Application");
    my $Mapi=$OutlookApp->GetNamespace("MAPI");
    my $OutlookInbox=$Mapi->GetDefaultFolder(6);
    my $ExistingInboxmails=$OutlookInbox->{items}->{count};
    my $Removed;
    my $UserName=shift;
    my $EmailID=shift;
    my $Pwd=shift;
    my $Server=shift;
    my $ExpectedEmails=shift;
    my $OS=VSO::GetOS();
    my $Outlook;
    my $InboxItems;


    #Delete the existing emails from the Inbox.
    if($ExistingInboxmails > 0){

        $Log->Message(2,*LOG,"Deleteing mails from the Inbox...");
        for(my $i=$ExistingInboxmails;$i>0;$i--){

            $OutlookInbox->{Items}->{$i}->Delete;
            $Removed ++;
        }
        $Log->Message(2,*LOG,"Deleted $Removed mails from the Inbox");
    }


    #Configure the user details.
    $Log->Message(2,*LOG,"Configuring user credentials...");
    eval{

        #system("$Bin/credentials.exe",$UserName,$EmailID,$Pwd,$Server);
		#system("$Bin/credentials.exe",$UserName,$EmailID,$Server,$Server,$Pwd);
        #system("regedit","/s","$Bin/Deleteprofile.reg");
        #system("regedit","/s","$Bin/Template.reg");
        #system("perl","Credentials.pl",$UserName,$EmailID,$Server,$Server);
    };
    if($@|| $?){

        $Log->Error(2,*LOG,"Error in entering user credentials");
    }

    #Launch Outlook.The path depends on the operating system.
    if($OS=~m/64/){

        Win32::Process::Create($Outlook,"C:\\Program Files (x86)\\Microsoft Office\\OFFICE11\\OUTLOOK.EXE","",0,NORMAL_PRIORITY_CLASS,".");
    }
    else{

        Win32::Process::Create($Outlook,"C:\\Program Files\\Microsoft Office\\OFFICE11\\OUTLOOK.EXE","",0,NORMAL_PRIORITY_CLASS,".");
    }

    #sleep 3;
    
	if($Conf->{EmailScan}->{RunOnce}==0){

        eval{

            #system("$Bin/SetOutlookoptions.exe");
        };
        $Conf->{EmailScan}->{RunOnce}=1;
        $Conf->write("$Bin/../ProductScenariosConfig.ini");
    }
    #system("perl","$Bin/password.pl",$Pwd);

    #Wait for the emails to download.
    $Log->Message(2,*LOG,"Waiting for the first email...");
    $InboxItems=$OutlookInbox->{items}->{count};
    while($InboxItems == 0){

        $InboxItems=$OutlookInbox->{items}->{count};
        usleep(1);
    }

    #This is the time that the first email has arrived.
    $StartTime=time;

    $Log->Message(2,*LOG,"Waiting for all the emails...");
    while($InboxItems < $ExpectedEmails){

        $InboxItems=$OutlookInbox->{items}->{count};
        print "Emails in Inbox : $InboxItems of  $ExpectedEmails\r";
        sleep 1;
    }
    $EndTime=time;
    $OutlookApp->Quit();
	VSO::KillProc("outlook");

}





################################################################
# This method send emails
################################################################
sub SendEmails{

    my $MailsDeleted=0;
	my $ToEmailID=shift;
	my $Password=shift;
	my $POP3Server=shift;
	my $Folder=shift;
    my $Desc;
    
    if($Folder=~m/spam/i){
        
        $Desc="Spam";
    }
    elsif($Folder=~m/Clean/i){
        
        $Desc="Clean";
    }
    else{
        
        $Desc="Unknown";
    }
	
	if($Conf->{EmailScan}->{DeleteOnServer}==1){

            $Log->Message(2,*LOG,"Deleting Emails on server..");
            $MailsDeleted=VSO::DeleteMailsOnServer($POP3Server,$ToEmailID,$Password);
            $Log->Message(2,*LOG,"Deleted $MailsDeleted Emails on server..");
    }

	$Log->Message(2,*LOG,"Sending Clean Emails..");
	$StartTime=time;
	eval{

		system("$Bin/smtpsender.exe",$ToEmailID,$POP3Server,$Folder);
	};
	$EndTime=time;
	$Rpt->{"Iteration_".$CurrentIteration}->{"Send_".$Desc."_StartTime"}=localtime($StartTime);
	$Rpt->{"Iteration_".$CurrentIteration}->{"Send_".$Desc."_StartTime"}=localtime($EndTime);
	$Rpt->{"Iteration_".$CurrentIteration}->{"Send_".$Desc."_StartTime"}=$EndTime-$StartTime;
	$Rpt->write("$Bin/../Logs/Report.ini");


    print "\nPlease Wait....\n";
    VSO::Counter(40);
    return 1;
}