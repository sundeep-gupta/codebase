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
use vars qw($LOCAL_HOST $TIMESTAMP);
use Modules::Config;
use Modules::Logger;
use CGI qw(:standard :nodebug);
use HTTP::Daemon;  # need LWP-5.32 or better
use HTTP::Response;
use HTTP::Status;
use LWP::UserAgent;
use XML::Simple;
use Sys::HostIP;
use strict;
use Data::Dumper;

if ($^O =~ /MSWin32/i) {
    require Modules::AgentExeWin;
}
else {
    require Modules::AgentExe;
}

# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

my $agentExe = AgentExe::new();

my $LOCAL_HOST = hostip();

my $TIMESTAMP = time();

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# start_daemon() - Small http daemon process that listens for incoming xml requests
# Input:  - Optional: Local port that the daemon needs to run on
# Output: - Daemon object
sub start_daemon {
    my ($local_port) = shift;

    unless (defined($local_port)) {
        $local_port = "8888";
    }

    my $server = HTTP::Daemon->new(
        'LocalPort' => $local_port,
        'LocalHost' => $LOCAL_HOST,         # IP address of the local machine (client/server)
        'Proto'     => 'tcp',
        'Listen'    => 2,
        'Reuse'     => 1) || die "Cannot create new HTTP daemon: $!";

    logHistory("\n[$TIMESTAMP]: ==========================") if ($CONFIG->{'LOG'} > 0);
    logHistory("[$TIMESTAMP]: Agent process is starting.") if ($CONFIG->{'LOG'} > 0);
    logHistory("[$TIMESTAMP]: Server $0 accepting clients.") if ($CONFIG->{'LOG'} > 0);
    logHistory("[$TIMESTAMP]: Daemon data: ".( ($server) ? "Server object exists" : "Server object does NOT exist" )) if ($CONFIG->{'LOG'} > 0);
    logHistory("[$TIMESTAMP]: Server: $server") if ($CONFIG->{'LOG'} > 0);
    logHistory("[$TIMESTAMP]: Root url: ".$server->url) if ($CONFIG->{'LOG'} > 0);
    logHistory("[$TIMESTAMP]: Tokens: ".$server->product_tokens) if ($CONFIG->{'LOG'} > 0);
    logHistory("[$TIMESTAMP]: Local IP: ".( (defined($LOCAL_HOST)) ? $LOCAL_HOST : "127.0.0.1" )) if ($CONFIG->{'LOG'} > 0);

    return ($server);
}

#
# daemon_listener() - HTTP daemon that waits and listens for a request from the Console machine
# Input:  $server - Daemon object (created using HTTP::Daemon)
# Output: Nothing
sub daemon_listener {
    my ($server) = shift;

    while (my $client = $server->accept()) {

        logHistory("[$TIMESTAMP]: Opening XML request connection.") if ($CONFIG->{'LOG'} > 0);

        my $content;   # Content that is captured by the daemon listener

        CONNECTION:
        while (my $answer = $client->get_request) {

        	logHistory(Dumper(\%ENV));
            logHistory("[$TIMESTAMP]: Request Method: ".( (exists($ENV{'REQUEST_METHOD'})) ? $ENV{'REQUEST_METHOD'} : "None" )) if ($CONFIG->{'LOG'} > 0);
            logHistory("[$TIMESTAMP]: Content Type: ".( (exists($ENV{'CONTENT_TYPE'})) ? $ENV{'CONTENT_TYPE'} : "Undefined" )) if ($CONFIG->{'LOG'} > 0);
            logHistory("[$TIMESTAMP]: Content-Length: ".( (exists($ENV{'CONTENT_LENGTH'})) ? $ENV{'CONTENT_LENGTH'} : 0 )) if ($CONFIG->{'LOG'} > 0);
            logHistory("[$TIMESTAMP]: User Agent: ".( (exists($ENV{'HTTP_USER_AGENT'})) ? $ENV{'HTTP_USER_AGENT'} : "None" )) if ($CONFIG->{'LOG'} > 0);

            $client->autoflush;
            last CONNECTION if ($answer =~ /\n\n$/g);

            # Define our content to return
            $content .= $answer->content;
        }
        logHistory("[$TIMESTAMP]: Closing XML request connection. ".$client->reason) if ($CONFIG->{'LOG'} > 0);

        $content =~ s/^\s+//;
        $content =~ s/\s+$//;

        # Output our request into an xml file
        write_xml_file($content, "request.xml");

        # Parse our xml request
        my $xml = parse_xml($content);

        # Check to see if we have multiple commands. If so, execute them
        my $results = xml_response_header();
        if (ref($xml->{'command'}) eq 'ARRAY') {
            my $commandList = $xml->{'command'};
            foreach my $command (@$commandList) {
                my($tmp_xml,$tmp_retval,$tmp_status) = $agentExe->execute_command($command);      # Send xml command parameters
                my $rv = xml_response($command,$tmp_retval,$tmp_status,$tmp_xml);      # Format the return values into an XML string
                $results .= $rv;
            }
        }
        else {
            my($tmp_xml,$tmp_retval,$tmp_status) = $agentExe->execute_command($xml->{'command'});     # Send xml command parameters
            my $rv = xml_response($xml->{'command'},$tmp_retval,$tmp_status,$tmp_xml);      # Format the return values into an XML string
            $results .= $rv;
        }
        $results .= xml_response_footer();

        # Output our response into an xml file
        write_xml_file($results, "response.xml");

        # Format our xml results into a valid http response
        my $response = format_response($results);

        # Send our results back to the client
        $client->send_response($response);
        $client->close;
        undef $client;
    }

    logEvent("[$TIMESTAMP]: Agent process stopping.");
}

#
# xml_response_header() - Returns a string that contains the XML response header
# Input:  Nothing
# Output: String containing the XML response header
sub xml_response_header {
    my $xml = <<END_OF_XML;
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<results>
END_OF_XML

    return ($xml);
}

#
# xml_response_footer() - Returns a string that contains the XML response footer
# Input:  Nothing
# Output: String containing the XML response footer
sub xml_response_footer {
    my $xml = <<END_OF_XML;
</results>
END_OF_XML

    return ($xml);
}

#
# xml_response() - Formats the results (pass/fail) into an xml string
# Input:  $command  - Hash reference containing our command details and parameters
#         $response - String containing the response/results
#         $status   - String containing the status of the results (pass/fail)
#         $xml      - String containing additional xml data
# Output: String formatted as xml containing the results
sub xml_response {
    my ($command) = shift;
    my ($response) = shift;
    my ($status) = shift;
    my ($xml) = shift;

    # Define the following
    my $action = $command->{'action'};
    my $item   = $command->{'item'};

    unless (defined($response)) {
        $response = "Not defined";
    }
    unless (defined($status)) {
        $status = "Not defined";
    }

    # Clean up our data (remove leading and trailing whitespace)
    $response =~ s/^\s+//;
    $response =~ s/\s+$//;

    # Create our xml string
    my $return_xml = <<END_OF_XML;
<command>
<action>$action</action>
<item>$item</item>
<status>$status</status>
<reason>$response</reason>
END_OF_XML

    if (defined($xml) && ($xml ne "") && ($action =~ /collect/i)) {
        $return_xml .= <<END_OF_XML;
<collection>$xml</collection>
END_OF_XML
    }

    $return_xml .= <<END_OF_XML;
</command>
END_OF_XML

    return ($return_xml);
}

#
# format_response() - Function that formats our xml results into a valid http response
# Input:  $results - String containing our XML results
# Output: Response object (allows for proper formatting of http headers)
sub format_response {
    my ($results) = shift;

    # 502 Bad Gateway / 504 Gateway Timeout
    # Note to implementors: some deployed proxies are known to
    # return 400 or 500 when DNS lookups time out.
    my $response = HTTP::Response->new( 200 );
    $response->content_type( "text/plain" );
    $response->content($results);

    return ($response);
}

#
# parse_xml() - Function that takes an xml string and returns a hash containing a data structure resembling the xml
# Input:  $xmldata - XML data in the form of a long concatenated string
# Output: XML object (basically a hash that contains our xml tag names as keys)
sub parse_xml {
    my ($xmldata) = shift;

    # Parse our xml request
    my $xs = new XML::Simple();
    my $xml = $xs->XMLin($xmldata);

    return ($xml);
}

#
# write_xml_file() - Function that outputs an xml string as a file
# Input:  $content  - String containing the content to be output
#         $filename - String containing the name of the file to output to.
# Output: Returns 1 if successful and undef if failed
sub write_xml_file {
    my($content, $filename) = @_;

    # Make sure we have a valid file name
    unless (defined($filename) && ($filename ne "")) {
        logEvent("[Error]: The file name provided for write_xml_file() is invalid.");
        return;
    }

    my $xml_file = $CONFIG->{'AGENT_PATH'} . $filename;

    # Make sure our content is defined
    unless (defined($content) && ($content ne "")) {
        logEvent("[Error]: The content provided for write_xml_file() is non-existant.");
        return;
    }

    open(OUTFILE, ">$xml_file") || die "Cannot create agent xml file $xml_file: $!\n";
    print OUTFILE "$content\n";
    close(OUTFILE);

    return 1;
}



1;

__END__