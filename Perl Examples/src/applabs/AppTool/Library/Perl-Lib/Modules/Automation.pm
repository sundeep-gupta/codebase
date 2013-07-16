#!/usr/bin/perl -w
#
# Copyright:     AppLabs Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision:  $
# Last Modified: $Date:  $
# Modified By:   $Author:  $
# Source:        $Source:  $
#
####################################################################################
##
##


package Automation;

use System::Environment;
use Modules::Config;
use Config::IniFiles;
use XML::Simple;
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input:  $TestCaseID - String containing the Test Case Identification name or number
# Output: Object for Automation module
sub new {
    my ($TestCaseID) = shift;

    my $AUTO = {
        "TESTCASE_ID" => $TestCaseID
    };

    bless $AUTO, 'Automation';   # Tag object with pkg name
    return $AUTO;
}

#
# runCmdlineProgram() -
# Input:
# Output:
sub runCmdlineProgram {
    my ($self) = shift;
    my ($params) = shift;

    my $retval;  # Output to return
    my $status;  # Defines our current service status

    # Define our destination path
    my $dest_path = ($^O =~ /MSWin32/i) ? "C:/" : "/";
    $dest_path .= $params->{'path'};
    unless ($dest_path =~ /\/$/) {
        $dest_path .= "/";
    }

    # Check if our destination path exists, if not return error
    unless (-d $dest_path) {
        $retval .= "ERROR: The command-line path [$dest_path] does not exist.\n";
        logEvent("[Error]: The command-line path [$dest_path] does not exist.");
        return ("fail", $retval);
    }

    # Make sure we remember where we are
    use Cwd;
    my $oldPath = cwd;
    if ($^O =~ /MSWin32/i) {
        $oldPath =~ s/\//\\/g;
    }

    # Change into the directory where our command-line program exists.
    chdir($dest_path) || die "Cannot chdir to: " . $dest_path . " ($!) \n";

    # Define our current path
    my $currentPath = cwd;
    if ($^O =~ /MSWin32/i) {
        $currentPath =~ s/\//\\/g;
    }

    # Define our command
    my $cmd;
    if ($^O =~ /MSWin32/i) {
        $cmd = "start /b ";
        $cmd .= (defined($params->{'program'}) && $params->{'program'} ne "") ? $params->{'program'}." " : "";
        $cmd .= $dest_path . $params->{'file'};
        $cmd .= (defined($params->{'flags'}) && $params->{'flags'} ne "") ? " ".$params->{'flags'} : "";
    }
    else {
        $cmd = (defined($params->{'program'}) && $params->{'program'} ne "") ? $params->{'program'}." " : "";
        $cmd .= $dest_path . $params->{'file'};
        $cmd .= (defined($params->{'flags'}) && $params->{'flags'} ne "") ? " ".$params->{'flags'}." &" : " &";
    }

    # Since we are putting the process in the background, there should be no output.
    my $output = system "$cmd";

    # Change back to old path when we finish, so relative paths continue to make sense
    chdir($oldPath);

    return ("pass", "Successfully executed the program [$cmd].");
}

#
# writeConfigIni() -
# Input:  $self - Object
# Output: String defining pass or failure, and string defining reason for pass or failure.
sub writeConfigIni {
    my ($self) = shift;

    # Fetch our request xml file contents
    my $xml_file = $CONFIG->{'AGENT_PATH'} . "request.xml";
    my ($status,$xml) = $self->return_xml_request($xml_file);

    # Parse our xml for the config INI information only.
    my $xmlref = $self->parseXmlConfigIni($xml);

    # Define our configuration file to write to
    my $config_ini = $CONFIG->{'TEST_CONFIG_PATH'} . "config.ini";
    my $cfg = new Config::IniFiles();
    $cfg->SetFileName($config_ini);

    # If we only have one section, then output the following
    if (defined($xmlref->{'section'}->{'name'}) && defined($xmlref->{'section'}->{'field'})) {
        # Define our section name
        my $section_name = $xmlref->{'section'}->{'name'};
        $cfg->AddSection($section_name);

        # Define our field names and values
        my $hashref = $xmlref->{'section'}->{'field'};

        while (my($section_key,$section_value) = each %$hashref) {
            $cfg->newval($section_name, $section_key, $section_value->{'content'});
        }
        $cfg->WriteConfig($config_ini);

        return ("pass", "Successfully generated repository configuration INI file.");
    }
    # Else, if we have multiple sections, output the following
    elsif (ref($xmlref->{'section'}) eq 'HASH') {
        my $hashref = $xmlref->{'section'};

        while (my($section_key,$section_value) = each %$hashref) {
            $cfg->AddSection($section_key);

            my $section_ref = $section_value->{'field'};
            while (my($field_key,$field_value) = each %$section_ref) {
                $cfg->newval($section_key, $field_key, $field_value->{'content'});
            }
        }

        $cfg->WriteConfig($config_ini);

        return ("pass", "Successfully generated repository configuration INI file.");
    }
    else {
        return ("fail", "The configuration INI parameters were not defined in the request XML.");
    }
}

#
# getConfigInfo() - Fetch the configuration INI file and its contents
# Input:  $self - Object
# Output: $cfg - Hash (associative array) containing the contents of the configuration INI file
sub getConfigInfo {
    my ($self) = shift;
    my $config_ini = $CONFIG->{'TEST_CONFIG_PATH'} . "config.ini";
    my $cfg = new Config::IniFiles( -file => $config_ini );
    return ($cfg);
}

#
# return_xml_request() - Read the given xml request file and return it's contents as XML
# Input:  $self     - Object
#         $xml_file - String containing the full path and file name of the xml file
# Output: String containing info on whether our function passed or failed
#         Hash reference containing the contents of the xml request file OR failure reason
sub return_xml_request {
    my ($self) = shift;
    my ($xml_file) = shift;

    unless (defined($xml_file)) {
        return ("fail","The xml requests file ($xml_file) has been moved or is missing.");
    }

    # Make sure our file exists
    unless (-e $xml_file) {
        #logEvent("[Error]: The xml requests file ($xml_file) could not be found.");
        return ("fail","The xml requests file ($xml_file) could not be found.");
    }

    # Package our metrics data into xml
    my $xs = XML::Simple->new(RootName => "command");
    my $xml = $xs->XMLin($xml_file);
    $xml =~ s/\s+$//;

    return ("pass",$xml);
}

#
# parseXmlConfigIni() -
# Input:
# Output:
sub parseXmlConfigIni {
    my ($self) = shift;
    my ($xml) = shift;

    # Make sure our command data is defined
    unless (defined($xml->{'command'})) {
        return;
    }

    # Parse our xml for the command parameters
    if (ref($xml->{'command'}) eq 'ARRAY') {
        my $xmltmp = $xml->{'command'};
        foreach my $params (@$xmltmp) {
            if (defined($params->{'parameters'}->{'config_ini'})) {
                return ($params->{'parameters'}->{'config_ini'});
            }
        }
    }
    elsif (ref($xml->{'command'}) eq 'HASH') {
        # Make sure we have config INI information
        if (defined($xml->{'command'}->{'parameters'}->{'config_ini'})) {
            return $xml->{'command'}->{'parameters'}->{'config_ini'};
        }
        else {
            # TODO: Log error
            return;
        }
    }
    else {
        # TODO: Log error
        return;
    }
}

#
# ftpPutFiles() -
# Input:
# Output:
sub ftpPutFiles {

}

#
# captureScreenshot() -
# NOTE: This function requires the following to be installed
#       1)  ImageMagick-6.3.0-6-Q16-windows-dll.exe
#       2)  ActiveState Perl v5.8.8 Build 817 or higher
#       3)  CPAN Perl Module Win32-Screenshot
# Input:
# Output:
#sub captureScreenshot {
#    my ($self) = shift;
#
#    use Win32::Screenshot;
#
    # Define the following
#    my $image_file = $CONIG->{'TEST_RESULTS_PATH'} . time() . ".gif";

#    my $image = CaptureScreen();
#    $image->Write($image_file);

#    return ("pass", "Captured the following screenshot: $image_file.");
#}



1;

__END__
