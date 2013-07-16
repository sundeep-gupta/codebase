# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::Appusage;
use strict;
use Testcase;
use Const;
use AppleScript;
use File::Spec;
use Time::HiRes qw/gettimeofday/;

our @ISA = ('Testcase');
sub new {
    my ($package, $rh_param) = @_;
    my $self = Testcase->new($rh_param) ;
    bless $self, $package;
    $self->{'application_map'} = { 'entourage' => 'Microsoft Entourage',
        'word' => 'Microsoft Word',
        'excel' => 'Microsoft Excel',
        'firefox' => 'Firefox',
        'safari'  => 'Safari',
        'itunes' => 'iTunes',
        'ichat' => 'iChat',
        'powerpoint' => 'Microsoft Powerpoint',
        'mail' =>'Mail',
    };
    return $self;
}

sub init {
    my ($self) = @_;
    my $log       = $self->{'log'};
    my $status = $TRUE;
    foreach my $app_name ( @ {$self->{'config'}->{'applications'} } ) {
               
        &AppleScript::quit_application ( $self->{'application_map'}->{$app_name} );
        &AppleScript::wait_till_quit   ( $self->{'application_map'}->{$app_name} , 5);
        if ( $app_name eq 'entourage' or $app_name eq 'apple_mail') {
        } elsif ( $app_name eq 'firefox' or $app_name eq 'safari' ) {
            $log->error("url not defined for $app_name") unless $self->{'config'}->{'url'};
            $status = $FALSE;
        } elsif ( $app_name eq 'word') {
            $log->error("Testcase data does not exist") unless -e $DATA_DIR."/Appusage/content_for_word.txt";
            $status = $FALSE;
        }
    }
    return $status;
}

sub clean {
    my ($self) = @_;
    $self->{'log'}->info("Cleaning AppUsage");
    foreach my $app_name ( @ {$self->{'config'}->{'applications'} } ) {
        &AppleScript::quit_application ( $self->{'application_map'}->{$app_name} );
        &AppleScript::wait_till_quit   ( $self->{'application_map'}->{$app_name} );
    }
}

sub execute {
    my ($self)       = @_;
    my $rh_tc_config = $self->{'config'};
    my $result_log   = $self->{'result_log'};
    my $log          = $self->{'log'};
    my $total_time   = 0; 
    my $rh_apptime   = {};
	
    $self->{'start_time'} = [ gettimeofday() ];
    foreach my $app_name (@{ $rh_tc_config->{'applications'} }) {
        $log->info("Appusage : $app_name") ;
	$self->$app_name();
        #launch and close the app (through applescript)
    }
    $self->{'end_time'} =  [ gettimeofday() ];
    $self->{'result'}   = {'Appusage' => $PASS };
}


sub entourage {
    my ($self) = @_;
    my $attachment  = &Cwd::abs_path( "$DATA_DIR/appusage/Test.docx" );
    my $apple_script = AppleScript->new();
    $apple_script->append('set theSubject to "Know about egypt"');

    $apple_script->append('set theBody to "An aid in the study of the Ptolemaic"');
    $apple_script->append('set theAttachment to "$attachment"');

    $apple_script->append('tell application "Microsoft Entourage"');
    $apple_script->append('set theRecipients to {{address:{display name:"Performance Entourage", '.
		       'address:"performance\@vsmac.com"}, recipient type:to recipient}, '.
		       '{address:{display name:"SSM Team", address:"performance\@vsmac.com"}, '.
		       'recipient type:cc recipient}}');
    $apple_script->append('set theMessage to make new outgoing message with properties '.
		       '{recipient:theRecipients, subject:theSubject, content:theBody, '.
		        'attachment:theAttachment}');
    $apple_script->append('send theMessage');
    $apple_script->append('delay 2');
    $apple_script->append('quit');
    $apple_script->append('end tell');
    $apple_script->run();

}


sub apple_mail {
    my ($self) = @_;
    my $attachment  = "$DATA_DIR/appusage/Test.docx";
    $attachment = File::Spec->rel2abs($attachment);
    my $apple_script = AppleScript->new();
    $apple_script->append('set theSubject to "Know about Egypt"');
    $apple_script->append('set theBody to "An aid in the study of the Ptolemaic"');
    $apple_script->append('set theName to "Performance"');
    $apple_script->append('set theAddress to "performance\@vsmac.com"');
    $apple_script->append('set theAttachment to "$attachment"');
    $apple_script->append('tell application "Mail"');
    $apple_script->append('repeat 1 times');
    $apple_script->append('set newMessage to make new outgoing message with properties '.
		       '{subject:theSubject, content:theBody & return & return}');
    $apple_script->append('tell newMessage');
    $apple_script->append('set visible to true');
    $apple_script->append('make new to recipient at end of to recipients with properties '.
		       '{name:theName, address:theAddress}');
    $apple_script->append('make new attachment with properties {file name:theAttachment}');
    $apple_script->append('tell content'); 
    $apple_script->append('end tell');
    $apple_script->append('end tell');
    $apple_script->append('send newMessage');
    $apple_script->append('end repeat');
    $apple_script->append('quit');
    $apple_script->append('end tell');
    $apple_script->run();
}


#######################################################################
# Description : open the 'safari' browser and capture the time taken
#               in the log file.
# Parameters  : $run - the Nth run (used primarily in naming log)
# Return      : NONE
#######################################################################
sub word {
    my ($self)    = @_;
    my $data_file = "$DATA_DIR/appusage/content_for_word.txt";
    my $doc_file  = "$DATA_DIR/appusage/Test.docx";
    $data_file    = File::Spec->rel2abs($data_file); $doc_file = File::Spec->rel2abs($doc_file);
    $doc_file     =~ s/\//:/g; $doc_file =~ s/^://;

    open(FH, "$data_file");
    my @content = <FH>; my $content = join('',@content);
    close FH;
    my $apple_script = AppleScript->new();
    $apple_script->append('set theDocFile to "$doc_file"');
    $apple_script->append('tell application "Microsoft Word"');
    $apple_script->append('activate');
    $apple_script->append('open theDocFile');
    $apple_script->append('tell active document');
    $apple_script->append('set theRange to create range start 0 end 0');
    $apple_script->append('repeat 30 times');
    $apple_script->append('insert text "test paragraph for word" at theRange');
    $apple_script->append('end repeat');
    $apple_script->append('end tell');
    $apple_script->append('save active document');
    $apple_script->append('quit');
    $apple_script->append('end tell');
    $apple_script->run();

}

#######################################################################
# Description : open the 'safari' browser and capture the time taken
#               in the log file.
# Parameters  : $run - the Nth run (used primarily in naming log)
# Return      : NONE
#######################################################################
sub powerpoint {
    my ($self)    = @_;
    my $data_file = "$DATA_DIR/appusage/Test.pptx";
    $data_file    = File::Spec->rel2abs($data_file);
    $data_file    =~ s/\//:/g; $data_file =~ s/^://;

    my $apple_script = AppleScript->new();
    $apple_script->append('set myPPfile to "$data_file" ');
    $apple_script->append('tell application "Microsoft PowerPoint"');
    $apple_script->append('activate');
    $apple_script->append('open myPPfile');
    $apple_script->append('tell active presentation');
    $apple_script->append('repeat 5 times');
    $apple_script->append('make new slide at end with properties {layout:slide layout picture with caption}');
    $apple_script->append('end repeat');
    $apple_script->append('end tell');
    $apple_script->append('save active presentation');
    $apple_script->append('quit');
    $apple_script->append('end tell');
    $apple_script->run();

}


#######################################################################
# Description : open the 'safari' browser and capture the time taken
#               in the log file.
# Parameters  : $run - the Nth run (used primarily in naming log)
# Return      : NONE
#######################################################################
sub excel {
    my ($self) = @_;
    my $excel_file  = "$DATA_DIR/appusage/Test.xlsx";
    $excel_file = File::Spec->rel2abs($excel_file);
    $excel_file =~ s/\//:/g; $excel_file =~ s/^://;

    my $apple_script = AppleScript->new();
    $apple_script->append('set theXLFile to "$excel_file"');
    $apple_script->append('set mydata to "Filling the Excel Sheet with large data"');
    $apple_script->append('tell application "Microsoft Excel"');
    $apple_script->append('open theXLFile');
    $apple_script->append('tell worksheet "Sheet1" of active workbook');
    $apple_script->append('set value of range "A1:L3342" to mydata');
    $apple_script->append('end tell');
    $apple_script->append('tell worksheet "Sheet2" of active workbook');
    $apple_script->append('set value of range "A1:L3342" to mydata');
    $apple_script->append('end tell');
    $apple_script->append('tell worksheet "Sheet3" of active workbook');
    $apple_script->append('set value of range "A1:L3342" to mydata');
    $apple_script->append('end tell');
    $apple_script->append('tell worksheet "Sheet4" of active workbook');
    $apple_script->append('set value of range "A1:L3342" to mydata');
    $apple_script->append('end tell');
    $apple_script->append('tell worksheet "Sheet5" of active workbook');
    $apple_script->append('set value of range "A1:L3342" to mydata');
    $apple_script->append('end tell');
    $apple_script->append('save active workbook');
    $apple_script->append('quit');
    $apple_script->append('end tell');
    $apple_script->run();
}



sub safari {
	my ($self) = @_;
        my $ra_url = $self->{'config'}->{'url'};
        my $delay = $self->{'config'}->{'delay'} || 10;
    foreach my $url ( @$ra_url) {	
        &AppleScript::launch_application("Safari");
        &AppleScript::activate_application('Safari');
	my $apple_script = AppleScript->new();
	$apple_script->append("tell application \"System Events\"");
	$apple_script->append("open location \"$url\"");
	$apple_script->append("delay $delay");
	$apple_script->append("end tell");
	$apple_script->run();
	&AppleScript::quit_application("Safari");
        &AppleScript::wait_till_quit('Safari');
    }    
}

sub firefox {
	my ($self) = @_;
        my $ra_url = $self->{'config'}->{'url'};
        my $delay = $self->{'config'}->{'delay'} || 10;
	foreach my $url ( @$ra_url ) {
            &AppleScript::launch_application("Firefox");
            &AppleScript::activate_application('Firefox');
	    my $apple_script = AppleScript->new();
            $apple_script->append("tell application \"Firefox\"");
	    $apple_script->append("delay $delay");
	    $apple_script->append("open location \"$url\"");
	    $apple_script->append("delay $delay");
	    $apple_script->append("end tell");
	    $apple_script->run();
	    &AppleScript::quit_application("Firefox");
            &AppleScript::wait_till_quit('Firefox');
        }
}
sub itunes {
	my ($self) = @_;
        my $delay = $self->{'config'}->{'delay'} || 10;
	&AppleScript::launch_application("iTunes");
        &AppleScript::activate_application('iTunes');
	my $apple_script = AppleScript->new();
	$apple_script->append("tell application \"System Events\"");
	$apple_script->append("if (not (exists window \"iTunes\" of process \"iTunes\")) then");
	$apple_script->append("click menu item \"Quit iTunes\" of menu 1 of menu bar item \"iTunes\" of menu bar 1 ".
						  "of application process \"iTunes\"");
	$apple_script->append("end if");
	$apple_script->append("delay $delay");
	$apple_script->run();
	&AppleScript::quit_application("iTunes");
        &AppleScript::wait_till_quit('iTunes');

}
sub ichat {
    my ($self) = @_;
	&AppleScript::launch_application("iChat");
        &AppleScript::activate_application('iChat');
	my $apple_script = AppleScript->new();
	$apple_script->append("tell application \"System Events\"");
	$apple_script->append("click menu item \"Bonjour List\" of menu 1 of menu bar item \"Window\" of menu bar 1 ".
						  "of application process \"iChat\"");
	$apple_script->append("end tell");

	$apple_script->run();
	&AppleScript::quit_application("iChat");
        &AppleScript::wait_till_quit('iChat');
}

1;
