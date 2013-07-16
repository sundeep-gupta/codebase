package Testcase::Appusage;
use strict;
use Testcase;
use MSMConst;
use Mac::AppleScript;
use File::Spec;


our @ISA = ('Testcase');
sub new {
    my ($package, $rh_config, $log, $msm, $result_log) = @_;
    my $self = Testcase->new($rh_config, $log, $msm);
    $self->{'result_log'} = $result_log if $result_log;
    $self->{'log'}        = $log        if $log;
    bless $self, $package;
    return $self;
}

sub init {
    my ($self) = @_;
    my $log       = $self->{'log'};
    my $data_file = "$DATA_DIR/appusage/content_for_word.txt";
    unless (-e $data_file) {
        $log->error("Testcase data does not exist") if $log;
        return 0;
    }
    return 1;
}


sub execute {
    my ($self)       = @_;
    my $rh_tc_config = $self->{'config'};
    my $result_log   = $self->{'result_log'};
    my $log          = $self->{'log'};
    my $total_time   = 0; 
    my $rh_apptime   = {};
	

    foreach my $app_name (@{ $rh_tc_config->{'applications'} }) {
        my $stime = time();
        $log->info("Appusage : $app_name") if $log;
	$self->$app_name();
        #launch and close the app (through applescript)
        my $time = time() - $stime;
        $total_time = $total_time + $time;
	$rh_apptime->{$app_name} = $time;
    }
    $rh_apptime->{'Appusage'} = $total_time;
    $result_log->append($rh_apptime) if $result_log;    
}


sub entourage {
	my ($self) = @_;
    my $attachment  = "$DATA_DIR/appusage/Test.docx";
	$attachment = File::Spec->rel2abs($attachment);
my $apple_script = <<APPLE_SCRIPT;
set theSubject to "Know about Egypt"
set theBody to "An aid in the study of the Ptolemaic"
set theAttachment to "$attachment"

tell application "Microsoft Entourage"
	set theRecipients to {{address:{display name:"Performance Entourage", address:"performance\@vsmac.com"}, recipient type:to recipient}, {address:{display name:"SSM Team", address:"performance\@vsmac.com"}, recipient type:cc recipient}}
	set theMessage to make new outgoing message with properties {recipient:theRecipients, subject:theSubject, content:theBody, attachment:theAttachment}
	send theMessage
	delay 2
	quit
end tell
APPLE_SCRIPT

    &Mac::AppleScript::RunAppleScript($apple_script);
}


sub apple_mail {
	my ($self) = @_;
    my $attachment  = "$DATA_DIR/appusage/Test.docx";
	$attachment = File::Spec->rel2abs($attachment);
	my $apple_script = <<APPLE_SCRIPT;

set theSubject to "Know about Egypt"
set theBody to "An aid in the study of the Ptolemaic"
set theName to "Performance"
set theAddress to "performance\@vsmac.com"
set theAttachment to "$attachment"
tell application "Mail"
	repeat 1 times
		set newMessage to make new outgoing message with properties {subject:theSubject, content:theBody & return & return}
		tell newMessage
			set visible to true
			make new to recipient at end of to recipients with properties {name:theName, address:theAddress}
			make new attachment with properties {file name:theAttachment}
			tell content 
			end tell
		end tell
		send newMessage
	end repeat
	quit
end tell
APPLE_SCRIPT

    &Mac::AppleScript::RunAppleScript($apple_script);

}


#######################################################################
# Description : open the 'safari' browser and capture the time taken
#               in the log file.
# Parameters  : $run - the Nth run (used primarily in naming log)
# Return      : NONE
#######################################################################
sub word {
	my ($self) = @_;
    my $data_file = "$DATA_DIR/appusage/content_for_word.txt";
    my $doc_file  = "$DATA_DIR/appusage/Test.docx";

	$data_file = File::Spec->rel2abs($data_file); $doc_file = File::Spec->rel2abs($doc_file);

    $doc_file =~ s/\//:/g; $doc_file =~ s/^://;

    open(FH, "$data_file");
    my @content = <FH>; my $content = join('',@content);
    close FH;
    my $apple_script = <<APPLE_SCRIPT;
set theDocFile to "$doc_file"

tell application "Microsoft Word"
activate
open theDocFile
tell active document
set theRange to create range start 0 end 0
repeat 30 times
insert text "test paragraph for word" at theRange
end repeat
end tell
save active document
quit
end tell

APPLE_SCRIPT
    &Mac::AppleScript::RunAppleScript($apple_script);

}

#######################################################################
# Description : open the 'safari' browser and capture the time taken
#               in the log file.
# Parameters  : $run - the Nth run (used primarily in naming log)
# Return      : NONE
#######################################################################
sub powerpoint {
	my ($self) = @_;
    my $data_file    = "$DATA_DIR/appusage/Test.pptx";
	$data_file = File::Spec->rel2abs($data_file);

    $data_file =~ s/\//:/g; $data_file =~ s/^://;

    my $apple_script = <<APPLESCRIPT;
-- Open PP and add blank slides and close
set myPPfile to "$data_file" 
tell application "Microsoft PowerPoint"
activate
open myPPfile
tell active presentation
repeat 5 times
make new slide at end with properties {layout:slide layout picture with caption}
end repeat
end tell
save active presentation
quit
end tell
APPLESCRIPT

    &Mac::AppleScript::RunAppleScript($apple_script);

}


#######################################################################
# Description : open the 'safari' browser and capture the time taken
#               in the log file.
# Parameters  : $run - the Nth run (used primarily in naming log)
# Return      : NONE
#######################################################################
sub excel {
    my $excel_file  = "$DATA_DIR/appusage/Test.xlsx";
	$excel_file = File::Spec->rel2abs($excel_file);
    $excel_file =~ s/\//:/g; $excel_file =~ s/^://;

my $apple_script = <<APPLE_SCRIPT;
-- Open Existing Excel Sheet add data to 5 sheets and close
set theXLFile to "$excel_file"
set mydata to "Filling the Excel Sheet with large data"
tell application "Microsoft Excel"
open theXLFile
--	tell active workbook
tell worksheet "Sheet1" of active workbook
set value of range "A1:L3342" to mydata
end tell
tell worksheet "Sheet2" of active workbook
set value of range "A1:L3342" to mydata
end tell
tell worksheet "Sheet3" of active workbook
set value of range "A1:L3342" to mydata
end tell
	tell worksheet "Sheet4" of active workbook
	set value of range "A1:L3342" to mydata
	end tell
	tell worksheet "Sheet5" of active workbook
	set value of range "A1:L3342" to mydata
	end tell
	save active workbook
	quit
	end tell

APPLE_SCRIPT

    &Mac::AppleScript::RunAppleScript($apple_script);
}


