#---------------------------------------------------------------------------------
# This module handles the alerts for VS 13.x
#---------------------------------------------------------------------------------
package AlertHandler;

use 5.008008;
use strict;
use warnings;
use Win32::GuiTest qw(:ALL :SW);
use FindBin qw($Bin);
use lib "$Bin";
use VSO;

require Exporter;
#use AutoLoader;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Alert_handle ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(Getalert
				GetHeader
				Getbody
				GetInfectionName
				GetInfectedFile
				Getoptions
				TrustPUP
				RemovePUP
				NoactionPUP
				ClickOK
				ODS_closealert
				ODS_viewresult
				Closealert
				Close_detected
				VSVersion

);

our $VERSION = '0.01';
my $bodytext;
my $VSOVersion=VSO::GetVSOVersion();

sub Getalert{
    my ($win_alert) = WaitWindowLike(undef, "", "McAlertWndClass",undef,undef,5);
    if ($win_alert){
        SetForegroundWindow($win_alert);
        return 1;
    }
    else{
        #print "No alert has been displayed";
        return 0;
    }
}


sub GetHeader{

	Getalert();
	my $headertext;
    my ($alert_header) = FindWindowLike(undef, "", "McAlertHeaderWndClass");
    if($alert_header){
        $headertext=WMGetText($alert_header);
    }
    else{
        $headertext="Alert does not have header text";
    }
    return($headertext);
}


sub Getbody{

    Getalert();
	my ($alert_body) = FindWindowLike(undef, "", "McRichEditClass");
    if($alert_body){
        $bodytext=WMGetText($alert_body);
    }
    else{
        $bodytext="Alert does not have body text"
    }
    return($bodytext);
}



sub GetInfectionName{

    my $InfectionName;
    my $Temp;
    my @Temp2;
	my $Text=shift;

    @Temp2=split(/\n/,$Text);

	foreach(@Temp2){

        chomp $_;
        if(/(Name:|detected:|Detection:)/i){

           $InfectionName=$_;
           $InfectionName=~s/Name: |Detected: |Detection: //gi;
           return($InfectionName) if (defined $InfectionName);
        }
    }
}



sub GetInfectedFile{

    my $FilePath;
    my $Temp;
    my @Temp2;
	my $Text=shift;

    @Temp2=split(/\n/,$Text);
    foreach(@Temp2){

        chomp $_;
        if(/(location:|Quarantined From:|File Path: )/i){

           $FilePath=$_;
           $FilePath=~s/location: |Quarantined From: //gi;
           return $FilePath if(defined $FilePath);
        }
    }
}


sub Getoptions{
    my @alert_action = FindWindowLike(undef, "", "McAlertActionWndClass");
    if(@alert_action){
        my @alert_options=FindWindowLike(undef, "", "McAlertButtonClass");
        if (@alert_options){
            my $buttontext0=GetWindowText($alert_options[0]);
            my $buttontext1=GetWindowText($alert_options[1]);
            my $buttontext2=GetWindowText($alert_options[2]);
            return($buttontext0, $buttontext1, $buttontext2);
        }
        else{
            return 0;
        }
    }
}

sub Closealert{
    my ($button_OK)=FindWindowLike(undef, "", "McXpBtn2");
    if ($button_OK){
        SetForegroundWindow($button_OK);
        my ($lx,$ly, $rx, $ry)=GetWindowRect($button_OK);
        my $x_pos=($lx+$rx)/2;
        my $y_pos=($ly+$ry)/2;
        MouseMoveAbsPix($x_pos, $y_pos);
        SendMouse('{LeftCLICK}', '{ABS$x_pos,$y_pos}');
    }
}


sub TrustPUP{
    my ($win_alert) = WaitWindowLike(undef, "", "McAlertWndClass",undef,undef,5);
    my @alert_action = FindWindowLike(undef, "", "McAlertActionWndClass");
    if(@alert_action){
        if($VSOVersion=~m/13/){
			
			my @alert_options=FindWindowLike(undef, "", "McAlertComboBoxClass");
			if (@alert_options){
				SelComboItemText($alert_options[0],"Trust this program");
				return 1;
			}
			else{
				return 0;
			}
		}
		if($VSOVersion=~m/12|11/){
			
			my @alert_options=FindWindowLike(undef, "", "McAlertButtonClass");
			if (@alert_options){
				my $buttontext0=GetWindowText($alert_options[0]);
				my $buttontext1=GetWindowText($alert_options[1]);
				my $buttontext2=GetWindowText($alert_options[2]);
				PushChildButton($win_alert, $buttontext1);
				return 1;
			}
			else{
				return 0;
			}
		}
		
    }
}

sub RemovePUP{
    my ($win_alert) = WaitWindowLike(undef, "", "McAlertWndClass",undef,undef,5);
    my @alert_action = FindWindowLike(undef, "", "McAlertActionWndClass");
    if(@alert_action){
        
		if($VSOVersion=~m/13/){
			
			my @alert_options=FindWindowLike(undef, "", "McAlertComboBoxClass");
			if (@alert_options){
				SelComboItemText($alert_options[0],"Remove this program");
				return 1;
			}
			else{
				return 0;
			}
		}
		if($VSOVersion=~m/12|11/){
			
			my @alert_options=FindWindowLike(undef, "", "McAlertButtonClass");
			if (@alert_options){
				my $buttontext0=GetWindowText($alert_options[0]);
				my $buttontext1=GetWindowText($alert_options[1]);
				my $buttontext2=GetWindowText($alert_options[2]);
				PushChildButton($win_alert, $buttontext0);
				return 1;
			}
			else{
				return 0;
			}
		}
		
    }
}


sub NoactionPUP{
    my ($win_alert) = WaitWindowLike(undef, "", "McAlertWndClass",undef,undef,5);
    my @alert_action = FindWindowLike(undef, "", "McAlertActionWndClass");
    if(@alert_action){
        
		if($VSOVersion=~m/13/){
			
			my @alert_options=FindWindowLike(undef, "", "McAlertComboBoxClass");
			if (@alert_options){
				SelComboItemText($alert_options[0],"Close this alert");
				return 1;
			}
			else{
				return 0;
			}	
		}
		if($VSOVersion=~m/12|11/){
			
			my @alert_options=FindWindowLike(undef, "", "McAlertButtonClass");
			if (@alert_options){
				my $buttontext0=GetWindowText($alert_options[0]);
				my $buttontext1=GetWindowText($alert_options[1]);
				my $buttontext2=GetWindowText($alert_options[2]);
				PushChildButton($win_alert, $buttontext2);
				return 1;
			}
			else{
				return 0;
			}
		}
		
    }
}


sub ODS_closealert{
    my ($win_alert) = WaitWindowLike(undef, "", "McAlertWndClass", undef, undef, 5);
    my @alert_action = FindWindowLike(undef, "", "McAlertActionWndClass");
    if(@alert_action){
        
		if($VSOVersion=~m/13/){
			
			my @alert_options = FindWindowLike(undef, "", "McAlertComboBoxClass");
			if (@alert_options){
				SelComboItemText($alert_options[0],"Close this alert");
				return 1;
			}
			else{
				return 0;
			}
		}
		if($VSOVersion=~m/12|11/){
			
			my @alert_options = FindWindowLike(undef, "", "McAlertButtonClass");
			if (@alert_options){
				my $buttontext0=GetWindowText($alert_options[0]);
				my $buttontext1=GetWindowText($alert_options[1]);
				my $buttontext2=GetWindowText($alert_options[2]);
				PushChildButton($win_alert, $buttontext0);
				return 1;
			}
			else{
				return 0;
			}
		}
		
    }
}


sub ODS_viewresult{
    my ($win_alert) = WaitWindowLike(undef, "", "McAlertWndClass", undef, undef, 5);
    my @alert_action = FindWindowLike(undef, "", "McAlertActionWndClass");
    if(@alert_action){
        
		if($VSOVersion=~m/13/){
			
			my @alert_options = FindWindowLike(undef, "", "McAlertComboBoxClass");
			if (@alert_options){
				SelComboItemText($alert_options[0],"View scan details");
				return 1;
			}
			else{
				return 0;
			}
		}
		if($VSOVersion=~m/12|11/){
			
			my @alert_options = FindWindowLike(undef, "", "McAlertButtonClass");
			if (@alert_options){
				my $buttontext0=GetWindowText($alert_options[0]);
				my $buttontext1=GetWindowText($alert_options[1]);
				my $buttontext2=GetWindowText($alert_options[2]);
				PushChildButton($win_alert, $buttontext1);
				return 1;
			}
			else{
				return 0;
			}
		}
		
    }
}

#this is for other detected alerts like Virus detected and Trojan detected, for PUP it is NoActionPUP();
sub Close_detected{
    my ($win_alert) = WaitWindowLike(undef, "", "McAlertWndClass", undef, undef, 5);
    my @alert_action = FindWindowLike(undef, "", "McAlertActionWndClass");
    if(@alert_action){
        
		if($VSOVersion=~m/13/){
			
			my @alert_options = FindWindowLike(undef, "", "McAlertComboBoxClass");
			if (@alert_options){
				SelComboItemText($alert_options[0],"Close this alert");
				return 1;
			}
			else{
				return 0;
			}
		}
		if($VSOVersion=~m/12|11/){
			
			my @alert_options = FindWindowLike(undef, "", "McAlertButtonClass");
			if (@alert_options){
				my $buttontext0=GetWindowText($alert_options[0]);
				my $buttontext1=GetWindowText($alert_options[1]);
				PushChildButton($win_alert, $buttontext1);
				return 1;
			}
			else{
				return 0;
			}
		}
		
		
    }
}


#Handle the system guard alert
sub HandleSysGuardAlert{
    
    my $Action=shift || "block";
    my $Remember=shift || 0;

    my ($win_alert) = WaitWindowLike(undef, "", "McAlertWndClass", undef, undef, 10);
	
	if($VSOVersion=~/13/){

		my ($alert_options) = FindWindowLike(undef, "", "McAlertComboBoxClass");
		return -1 if (!defined $alert_options);

		if($Action=~m/^block/i){

			SelComboItemText($alert_options,"Block this change");
		}
		if($Action=~m/^allow/i){

			SelComboItemText($alert_options,"Allow this change");
		}
	}
	if($VSOVersion=~m/11|12/){

		if($Action=~m/^block/i){

		    PushChildButton($win_alert, "Block this change");
		}
		if($Action=~m/^allow/i){

		    PushChildButton($win_alert, "Allow this change");
		}
	}

	if($Remember == 1){

		my (@RememberCheckbox)=FindWindowLike(undef, "", "McAlertButtonClass");
		return -1 if(! defined $RememberCheckbox[2]);
		CheckButton($RememberCheckbox[2]);
	}
	
	Closealert();
	return 0;

}


1;
__END__

