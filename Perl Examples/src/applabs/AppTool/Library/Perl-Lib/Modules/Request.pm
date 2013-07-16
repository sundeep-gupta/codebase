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

use System::Environment;
use Modules::Config;
use Modules::Logger;
use LWP::UserAgent;
use URI::URL;
use HTTP::Headers;
use HTTP::Request;
use XML::Simple;
use strict;

# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# xml_request_header() - Returns a string containing the XML request header
# Input:  Nothing
# Output: String containing our XML request header
sub xml_request_header {
    my $xml = <<END_OF_XML;
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<initialization_variables>
END_OF_XML

    return ($xml);
}

#
# xml_request_footer() - Returns a string containing the XML request footer
# Input:  Nothing
# Output: String containing our XML request footer
sub xml_request_footer {
    my $xml = <<END_OF_XML;
</initialization_variables>
END_OF_XML

    return ($xml);
}

#
# package_request() - Package the request data into an xml string
# Input: $request_data - Hash of the request data parameters
# Output: XML string containing our request information for the HTTP request
sub package_request {
    my($request_data) = shift;
    
    my $action = (defined($request_data->{'action'})) ? $request_data->{'action'} : "Unknown or Missing";
    my $item   = (defined($request_data->{'item'})) ? $request_data->{'item'} : "Unknown or Missing";
    my $params = (defined($request_data->{'parameters'})) ? $request_data->{'parameters'} : "Unknown or Missing";
    
    my $parameters = package_parameters($action,$item,$params);
    
    # Create our xml string
    my $xml = <<END_OF_XML;
<command>
<action>$action</action>
<item>$item</item>
<parameters>
$parameters
</parameters>
</command>
END_OF_XML

    print "DEBUG>> package_request() -> xml (\n$xml\n) \n" if ($CONFIG->{'DEBUG'} > 1);

    return ($xml);
}

#
# package_parameters() - Package the command parameters into an XML string
# Input:  $action - The command type
#         $item   - The item affected by the command
#         $params - Reference containing our parameter list (array, hash or string)
# Output: String containing our XML formatted parameter list
sub package_parameters {
    my $action = shift;
    my $item = shift;
    my $params = shift;
    
    my $xml;
    
    # If the parameters are in an array, fetch them
    if (ref($params) eq 'ARRAY') {
        foreach my $parameter (@$params) {
            # Depending on the item, our XML changes
            if ($item eq "userdata") {
                if ($action eq "add") {
                    my $file_ext = (defined($parameter->{'FileExt'}) && $parameter->{'FileExt'} ne "") ? $parameter->{'FileExt'} : "txt";
                    my $file_datatype = (defined($parameter->{'FileDataType'}) && $parameter->{'FileDataType'} ne "") ? $parameter->{'FileDataType'} : "strings";
                    
                    $xml .= <<END_OF_XML;
<source>
<location>$parameter->{'FileFilterPath'}</location>
<file_count>$parameter->{'FileCount'}</file_count>
<file_size>$parameter->{'FileSize'}</file_size>
<file_ext>$file_ext</file_ext>
<file_datatype>$file_datatype</file_datatype>
</source>
END_OF_XML
                }
                elsif ($action eq "copy") {
                    
                    $xml .= <<END_OF_XML;
<share>
<source>$parameter->{'FileFilterSource'}</source>
<source_ip>$CONFIG->{'SERVER_IP'}</source_ip>
<destination>$parameter->{'FileFilterPath'}</destination>
<username>$CONFIG->{'SERVER_USERNAME'}</username>
<password>$CONFIG->{'SERVER_PASSWORD'}</password>
</share>
END_OF_XML
                }
                else {
                    $xml .= <<END_OF_XML;
<source>$parameter->{'FileFilterPath'}</source>
END_OF_XML
                }
            }
            elsif ($item eq "profile") {
                $xml .= <<END_OF_XML;
<profile>
<username>$parameter->{'UserName'}</username>
<password>$parameter->{'Password'}</password>
</profile>
END_OF_XML
            }
            elsif ($item eq "registry") {
                my $regValueName = (defined($parameter->{'RegValueName'})) ? $parameter->{'RegValueName'} : "";
                my $regValue = (defined($parameter->{'RegValue'})) ? $parameter->{'RegValue'} : "";
                
                if (($action eq "add") && ($regValueName ne "") && ($regValue ne "")) {
                    $xml .= <<END_OF_XML;
<regkey name=\"$parameter->{'RegValueName'}\" value=\"$parameter->{'RegValue'}\">$parameter->{'RegFilterPath'}</regkey>
END_OF_XML
                }
                else {
                    $xml .= <<END_OF_XML;
<regkey>$parameter->{'RegFilterPath'}</regkey>
END_OF_XML
                }
            }
            else {
                $xml .= "<undef>ARRAY: " . Dumper($parameter) . "</undef>"
            }
        }
    }
    # If we have a hash value, then we have an error
    elsif (ref($params) eq 'HASH') {
        if ($action eq "monitor") {
            $xml .= <<END_OF_XML;
<operation>$params->{'OPERATION'}</operation>
<runtime>$params->{'TEST_TIME_LENGTH'}</runtime>
<collection>
END_OF_XML

            if ($params->{'CPU_STATS'} == 1) { $xml .= "<metric>CPU_STATS</metric>"; }
            if ($params->{'MEMORY_STATS'} == 1) { $xml .= "<metric>MEMORY_STATS</metric>"; }
            if ($params->{'NETWORK_STATS'} == 1) { $xml .= "<metric>NETWORK_STATS</metric>"; }
            if ($params->{'PROCESSES'} == 1) { $xml .= "<metric>PROCESSES</metric>"; }
            if ($params->{'PAGE_SWAP_STATS'} == 1) { $xml .= "<metric>PAGE_SWAP_STATS</metric>"; }
            if ($params->{'SOCKET_STATS'} == 1) { $xml .= "<metric>SOCKET_STATS</metric>"; }
            if ($params->{'DISK_STATS'} == 1) { $xml .= "<metric>DISK_STATS</metric>"; }
            if ($params->{'DATABASE_STATS'} == 1) { $xml .= "<metric>DATABASE_STATS</metric>"; }
            if ($params->{'DISK_USAGE'} == 1) { $xml .= "<metric>DISK_USAGE</metric>"; }
            if ($params->{'LOAD_AVG'} == 1) { $xml .= "<metric>LOAD_AVG</metric>"; }
            if ($params->{'FILE_STATS'} == 1) { $xml .= "<metric>FILE_STATS</metric>"; }
            if ($params->{'PROCESS_UTIL'} == 1) { $xml .= "<metric>PROCESS_UTIL</metric>"; }
            if ($params->{'PROCESSOR_STATS'} == 1) { $xml .= "<metric>PROCESSOR_STATS</metric>"; }
            
            $xml .= <<END_OF_XML;
</collection>
END_OF_XML
        }
        elsif ($action eq "setup") {
            # Fetch all of our sections and parameters for our INI file
            $xml .= <<END_OF_XML;
<config_ini>
END_OF_XML
            while (my($sect_key,$sect_value) = each %$params) {
                $xml .= "<section name=\"$sect_key\">\n";
                if (defined($sect_value)) {
                    while (my($field_key,$field_value) = each %$sect_value) {
                        $xml .= "<field name=\"$field_key\">" . $field_value . "</field>\n";
                    }
                }
                $xml .= "</section>\n";
            }
            $xml .= <<END_OF_XML;
</config_ini>
END_OF_XML
        }
        elsif ($action eq "execute") {
            my $test_tmp = Dumper($params);
            # Fetch our command parameters
            if (defined($params->{'program'}) && $params->{'program'} ne "") {
                $xml .= "<program>" . $params->{'program'} . "</program>\n";
            }
            
            $xml .= <<END_OF_XML;
<path>$params->{'path'}</path>
<file>$params->{'file'}</file>
END_OF_XML
            
            if (defined($params->{'flags'}) && $params->{'flags'} ne "") {
                $xml .= "<flags>" . $params->{'flags'} . "</flags>\n";
            }
        }
        else {
            $xml .= "<undef>HASH: " . Dumper($params) . "</undef>"
        }
    }
    # Else if our parameters are a string, fetch it.
    # TODO:  fix the xml elements in this section
    else {
        if ($item eq "performance") {
            $xml .= <<END_OF_XML;
<operation>$params</operation>
END_OF_XML
        }
        else {
            $xml .= "<undef>STRING: " . Dumper($params) . "</undef>"
        }
    }
    
    $xml =~ s/\s+$//;
    
    return ($xml);
}

#
# send_request() - Send an xml request to a remote machine (client/server) and return an xml response
# Input:  $xmldata       - Concatenated xml request string
#         $remotemachine - Hash of the remote machine parameters (host, path, port)
# Output: Returns our response content, or error message on failure
sub send_request {
    my($xmldata,$remotemachine) = @_;

    # Format the request headers
    my $content_length = length $xmldata;
    my $headers = new HTTP::Headers(
        'Accept'         => [qw(text/html text/plain text/xml)],
        'Content-Type'   => 'text/xml',
        'Content-Length' => $content_length
    );

    # Define the URL to send our xml request
    my $url;
    if (exists($remotemachine->{'port'}) && $remotemachine->{'port'} ne "") {
        $url = new URI::URL("http://".$remotemachine->{'host'}.":".$remotemachine->{'port'}.$remotemachine->{'path'});
    }
    else {
        $url = new URI::URL("http://".$remotemachine->{'host'}.$remotemachine->{'path'});
    }

    # Create the xml request
    my $request = new HTTP::Request("POST", $url, $headers, $xmldata);

    # Create our request carrier
    my $ua = new LWP::UserAgent;
    $ua->timeout($CONFIG->{'TIMEOUT'});

    # Fetch the response
    my $response = $ua->request($request);

    # Unpack our response object and return the content, or error if it exists
    my $retval = ($response->is_success) ? $response->content : $response->error_as_HTML;

    # Log our events
    logEvent("[Event]: XML request being sent to http://" . $remotemachine->{'host'} . ":" . $remotemachine->{'port'} . $remotemachine->{'path'});
    logEvent("[Event]: XML response received as: [" . $retval . "]");
    
    return ($retval);
}

#
# unpack_results() - Convert results xml into results hash data structure
# Input:  $results - Concatenated string of our results xml
# Output: Hash data structure containing results of the command executed remotely
sub unpack_results {
    my($results) = shift;

    # Clean results
    $results =~ s/^\s+//;
    $results =~ s/\s+$//;

    # Create our xml object
    my $xs = XML::Simple->new();
    my $xml = $xs->XMLin($results);

    return ($xml);
}

#
# parse_xml_response() - Parse the XML response and return an object
# Input:  $response - String containing the XML response for the current machine
# Output: Object containing the XML response and details
sub parse_xml_response {
    my($response) = shift;

    # Clean results
    $response =~ s/^\s+//;
    $response =~ s/\s+$//;

    # Create our xml object
    my $xs = XML::Simple->new();
    my $xml = $xs->XMLin($response);
    
    return ($xml);
}

#
# result_status() - Returns the result status of the command executed on the remote machine (either pass/fail)
# Input:  $xml - Hash reference containing the XML response for the current machine
# Output: Strings with the result status of either "pass" or "fail". If there is a failure, then a reason for the failure is also returned
sub result_status {
    my ($xml) = shift;

    my $status;
    my $reason;
    
    # NOTE: The only time a 'result' is not defined is due to a timeout failure along the way
    if (defined($xml->{'status'})) {
        $status = $xml->{'status'};
        $reason = $xml->{'reason'};
    }
    elsif (defined($xml->{'content'})) {
        $status = "fail";
        $reason = $xml->{'content'};
    }
    else {
        $status = "fail";
        $reason = (defined($xml->{'reason'}) && $xml->{'reason'} ne "") ? $xml->{'reason'} : "There was no failure reason that was defined in the response.";
    }

    return ($status,$reason);
}

#
# nl2br() - Change all new line characters (\n) to html <br> characters
# Input:  String
# Output: Interpolated string
sub nl2br {
    my $t = @_;
    $t =~ s/\r\n$/<br>$1/gx;
    return $t;
}

#
# get_time() - This function creates a basic formatted time string
# Input:  Nothing
# Output: Returns the local time in the format of: 'HH:MM:SS'
sub get_time {
    # Time Information
    my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    $year = $year + 1900;
    $mon  = $mon + 1;
    my $localtime = "$hour:$min:$sec";
    return $localtime;
}

#
# get_date() - This function creates a basic formatted date string
# Input:  Nothing
# Output: Returns the local date in the format of: 'YYYY-MM-DD'
sub get_date {
    # Time Information
    my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    $year = $year + 1900;
    $mon  = $mon + 1;
    my $localtime = "$year-$mon-$mday";
    return $localtime;
}

#
# display_response() - Displays response from client/server (currently used for debugging)
# Input:  $response - Object from HTTP::Request
# Output: HTML information on success or failure of xml request
sub display_response {
    my($response) = shift;

    # HTML to return
    my $html = "RESPONSE: \n$response\n\n";
    
    return ($html);
}



1;

__END__
