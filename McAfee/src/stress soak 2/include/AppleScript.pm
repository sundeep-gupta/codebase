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
    my $applescript = "tell application \"$app_name\"\n";
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

    my $apple_script = 'set theSubject to "Know about Egypt"'."\n";
    $apple_script    .= 'repeat 1 times'."\n";

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
-- Sending email along with Attachment in Entourage
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
-- Open PP and add blank slides and close
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
-- Open Existing Excel Sheet add data to 5 sheets and close

APPLE_SCRIPT

    &Mac::AppleScript::RunAppleScript($apple_script);

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