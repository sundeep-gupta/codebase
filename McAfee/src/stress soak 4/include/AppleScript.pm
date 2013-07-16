##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2009, McAfee Limited. All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################
package AppleScript;

use strict;
use Mac::AppleScript;
use MSMConst;
use MSMConfig;


################## PUBLIC METHODS ################################

#######################################################################
# Description : launch and close the given application.
# Parameters  : $app_name - application name.
# Return      : NONE
#######################################################################
sub launch_close_application {
    my $app_name = $_[0];
    my $applescript = "tell application \"$app_name\"\n";    $applescript .= "activate\n quit\n end tell\n";
    &Log::write( "Launching $app_name");
    &Mac::AppleScript::RunAppleScript($applescript);
}

#######################################################################
# Description : launch given application
# Parameters  : $app_name - application name
# Return      : NONE
#######################################################################
sub launch_application {
    my $app_name = $_[0];
    my $applescript = "tell application \"$app_name\" to activate\n";
    &Log::write( "Launching $app_name");
    &Mac::AppleScript::RunAppleScript($applescript);

}


#######################################################################
# Description : quit the application.
# Parameters  : $app_name = application to be quit.
# Return      : NONE
#######################################################################
sub close_application {
    my $app_name = $_[0];
    my $applescript = "tell application \"$app_name\" to quit\n";
    &Log::write( "Closing $app_name");
    &Mac::AppleScript::RunAppleScript($applescript);

}

#######################################################################
# Description : Sends an email using apple mail
# Parameters  : $run - the Nth run (used primarily in naming log)
# Return      : NONE
#######################################################################
sub apple_mail_usage {
    &Log::write( "Testing Apple Mail usage performance");
    my $rh_testcase_config = $_[0];
    my $to_mail            = $rh_testcase_config->{'to_email'};
    my $to_name            = $rh_testcase_config->{'to_name'};
    my $attachment_file    = $rh_testcase_config->{'attachment'};
    $attachment_file       =~ s/\//:/g; $attachment_file =~ s/^\///;
    my $data_file          = $rh_testcase_config->{'body_file'};

    open(FH, $data_file);
    my @content = <FH>; my $content = join('',@content);
    close FH;

    my $apple_script = 'set theSubject to "Know about Egypt"'."\n";    $apple_script    .= 'set theBody to "$content"'."\n";    $apple_script    .= 'set theName to "$to_name"'."\n";    $apple_script    .= 'set theAddress to "$to_mail"'."\n";    $apple_script    .= 'set theAttachment to "$attachment_file"'."\n";    $apple_script    .= 'tell application "Mail"'."\n";
    $apple_script    .= 'repeat 1 times'."\n";    $apple_script    .= 'set newMessage to make new outgoing message with properties {subject:theSubject, content:theBody & return & return}'."\n";    $apple_script    .= 'tell newMessage'."\n";    $apple_script    .= 'set visible to true'."\n";    $apple_script    .= 'make new to recipient at end of to recipients with properties {name:theName, address:theAddress}'."\n";    $apple_script    .= 'make new attachment with properties {file name:theAttachment}'."\n";    $apple_script    .= 'tell content'."\n";    $apple_script    .= 'end tell'."\n";    $apple_script    .= 'end tell'."\n";    $apple_script    .= 'send newMessage'."\n";    $apple_script    .= 'end repeat'."\n";    $apple_script    .= 'end tell'."\n";

    &Mac::AppleScript::RunAppleScript($apple_script);


}
#######################################################################
# Description : open the 'safari' browser and capture the time taken
#               in the log file.
# Parameters  : $run - the Nth run (used primarily in naming log)
# Return      : NONE
#######################################################################
sub entourage_usage {
    &Log::write( "Testing Microsoft Entourage usage performance");

    my $rh_testcase_config = $_[0];
    my $to_mail            = $rh_testcase_config->{'to_email'};
    my $to_name            = $rh_testcase_config->{'to_name'};
    my $attachment_file    = $rh_testcase_config->{'attachment'};
    $attachment_file       =~ s/\//:/g; $attachment_file =~ s/^\///;
    my $data_file          = $rh_testcase_config->{'body_file'};

    open(FH, $data_file);
    my @content = <FH>; my $content = join('',@content);
    close FH;

    my $apple_script = <<APPLE_SCRIPT;
-- Sending email along with Attachment in Entourageset theSubject to "Test Email from Entourage"set theBody to "$content"set theAttachment to "$attachment_file"tell application "Microsoft Entourage"	set theRecipients to {{address:{display name:"Harihara Subramaniam", address:"sahana\@vsmac.com"}, recipient type:to recipient}, {address:{display name:"SSM Team", address:"purvang\@vsmac.com"}, recipient type:cc recipient}}	set theMessage to make new outgoing message with properties {recipient:theRecipients, subject:theSubject, content:theBody, attachment:theAttachment}	send theMessage	end tell
APPLE_SCRIPT

    &Mac::AppleScript::RunAppleScript($apple_script);
}

#######################################################################
# Description : open the 'safari' browser and capture the time taken
#               in the log file.
# Parameters  : $run - the Nth run (used primarily in naming log)
# Return      : NONE
#######################################################################
sub word_usage {
    &Log::write( "Testing Microsoft Word usage performance");
    my $data_file = "$DATA_DIR/appusage/content_for_word.txt";
    my $doc_file  = "$DATA_DIR/appusage/Performance.docx";
    $doc_file =~ s/\//:/g; $doc_file =~ s/^://;

    open(FH, "$data_file");
    my @content = <FH>; my $content = join('',@content);
    close FH;
    my $apple_script = <<APPLE_SCRIPT;
set theDocFile to "$doc_file"tell application "Microsoft Word"	open theDocFile	tell active document		set theRange to create range start 0 end 0		repeat 30 times			insert text "$content" at theRange		end repeat	end tell	save active document	quitend tell

APPLE_SCRIPT

    &Mac::AppleScript::RunAppleScript($apple_script);
}

#######################################################################
# Description : open the 'safari' browser and capture the time taken
#               in the log file.
# Parameters  : $run - the Nth run (used primarily in naming log)
# Return      : NONE
#######################################################################
sub powerpoint_usage {
    &Log::write( "Running powerpoint usage test");
    my $data_file    = "$DATA_DIR/appusage/Performance.ppt";
    $data_file =~ s/\//:/g; $data_file =~ s/^://;

    my $apple_script = <<APPLESCRIPT;
-- Open PP and add blank slides and closeset myPPfile to "$data_file" tell application "Microsoft PowerPoint"	activate	open myPPfile	tell active presentation		repeat 5 times			make new slide at end with properties {layout:slide layout picture with caption}		end repeat		tell slide of active presentation		end tell	end tell	save active presentation in myPPfile as save as presentation	quitend tell
APPLESCRIPT

    &Mac::AppleScript::RunAppleScript($apple_script);


}
#######################################################################
# Description : open the 'safari' browser and capture the time taken
#               in the log file.
# Parameters  : $run - the Nth run (used primarily in naming log)
# Return      : NONE
#######################################################################
sub excel_usage {
    &Log::write( "Testing Microsoft Excel usage performance");
    my $excel_file  = "$DATA_DIR/appusage/Performance.xlsx";
    $excel_file =~ s/\//:/g; $excel_file =~ s/^://;

my $apple_script = <<APPLE_SCRIPT;
-- Open Existing Excel Sheet add data to 5 sheets and closeset theXLFile to "$excel_file"set mydata to "Filling the Excel Sheet with large data"tell application "Microsoft Excel"	open theXLFile	--	tell active workbook		tell worksheet "Sheet1" of active workbook		set value of range "A1:L3342" to mydata	end tell	tell worksheet "Sheet2" of active workbook		set value of range "A1:L3342" to mydata	end tell	tell worksheet "Sheet3" of active workbook		set value of range "A1:L3342" to mydata	end tell	tell worksheet "Sheet4" of active workbook		set value of range "A1:L3342" to mydata	end tell	tell worksheet "Sheet5" of active workbook		set value of range "A1:L3342" to mydata	end tell	save active workbook	quitend tell

APPLE_SCRIPT

    &Mac::AppleScript::RunAppleScript($apple_script);}

#######################################################################
# Description : open the 'safari' browser and capture the time taken
#               in the log file.
# Parameters  : $run - the Nth run (used primarily in naming log)
# Return      : NONE
#######################################################################
sub ods_scan {
    my ($type, $data_dir) = @_;
    if($type eq 'ods_clean') {
        system("osascript $LIB_DIR/ods_clean.scpt");
    } else {
        system("osascript $LIB_DIR/ods_mixed.scpt");
    }
}

1;
