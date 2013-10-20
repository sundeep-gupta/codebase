#!/usr/bin/perl
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.3 $
# Last Modified: $Date: 2005/10/18 22:24:09 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbitaldata/control/perl-lib/Orbital/Caller.pm,v $
#
####################################################################################
##
##


#package Caller;

use vars qw($CONFIG_TEMPLATE $CONFIG_FILE $BASEPATH $ORBITAL_PATH $CONSOLE_IP $TIMEOUT);
use lib qw(/usr/local/lib/perl5/5.8.6 /usr/local/orbital/console/perl-lib);
use Orbital::Config;
use LWP::UserAgent;
use HTTP::Headers;      # Linux needs to call this explicitly
use HTTP::Request;      # Linux needs to call this explicitly
use URI::URL;
use XML::Simple;

# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

# Define the following
my $CONFIG_TEMPLATE = $CONFIG->{'CONFIG_TEMPLATE'};    # Default xml config template name
my $CONFIG_FILE     = $CONFIG->{'CONFIG_FILE'};        # Configuration file for VisualTest scripts
my $BASEPATH        = $CONFIG->{'BASEPATH'};           # Base path of the web server
my $ORBITAL_PATH    = $CONFIG->{'ORBITAL_PATH'};       # Directory of the Orbital Test Tool software package
my $CONSOLE_IP      = $CONFIG->{'CONSOLE_IP'};
my $TIMEOUT         = $CONFIG->{'TIMEOUT'};

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input: - Class method name
# Output - Nothing
sub new {
	my $self = { };
	bless $self;
	return $self;
}

#
# package_config() - Package the Visual Test config data into an xml string
# Input: $config_template - The name of the Visual Test xml config file, including path (default: config.xml)
#        $config_data     - Hash of the Visual Test config data parameters
# Output: XML string containing our configuration information for server machine, client machine, orbitals, and wan-simulator
# NOTE: <local_ip> = This helps the machine that the script is running on distinguish what role it is playing, server or client. Also,
#                    this value is used to setup a unique share on server machines, when running in concurrent mode
sub package_config {
    my($config_template, $config_data) = @_;

    # Read the config.xml.template file and return a concatenated string
    my $xmldata = open_template_file($config_template,"string");
    my($client_scripts,$server_scripts) = fetch_script_data($xmldata);

    # Create our xml string
    my $xml = <<END_OF_XML;
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<initialization_variables>
<test_case>$config_data->{'test_case'}</test_case>
<share>$config_data->{'share'}</share>
<console>$CONSOLE_IP</console>
<local_ip>__LOCAL_IP__</local_ip>
<kill_connections>$config_data->{'kill_connections'}</kill_connections>
<synctime>__SYNCTIME__</synctime>
<script_exe>__SCRIPT_EXE__</script_exe>
END_OF_XML

    # Package our machine data
    $xml .= package_machine($config_data->{'clients'},"clients",$client_scripts);    # client machines
    $xml .= package_machine($config_data->{'servers'},"servers",$server_scripts);    # server machines
    $xml .= package_device($config_data->{'orbitals'},"orbitals");                   # orbital machines

    # Package our wan-simulator data
    my $xs = XML::Simple->new(RootName => 'wansim', ForceArray => 1, NoAttr => 1);
    $xml .= $xs->XMLout($config_data->{'wansim'});

    # End of xml string
    $xml .= <<END_OF_XML;
</initialization_variables>
END_OF_XML

    print "DEBUG>> package_config() -> xml (\n$xml\n) \n" if ($CONFIG->{'DEBUG'} > 1);

    return ($xml);
}

#
# package_machine() - Package our machine xml data
# Input:  $machine - Hash of machine data
#         $name    - Name to give the encapsulating xml tags
#         $scripts - XML formatted string containing any Visual Test scripts for that particular machine
# Output: String containing our formatted xml for the specified machine data
sub package_machine {
    my ($machine,$name,$scripts) = @_;

    my $multi_machine = "false";  # Defines if we need to include multiple machines in our xml or not (true/false)
    my $xml = "<$name>\n";        # Machine xml to return
    $xml .= $scripts;             # We include our machine specific script information

    # If we need a multi-machine setup, use the following xml
    if ($multi_machine eq "true") {
        # Create our xml object
        my $xs = XML::Simple->new(RootName => 'machine', ForceArray => 1, NoAttr => 1);
        # Iterate through each machine
        while(my($machine_name, $data) = each(%$machine)) {
            $xml .= $xs->XMLout($data);
        }
    }
    # Else, use the single-machine xml
    else {
        my $machine_name = ($name =~ /server/i) ? "__SERVER_NAME__" : "__CLIENT_NAME__";
        my $machine_ip   = ($name =~ /server/i) ? "__SERVER_IP__" : "__CLIENT_IP__";
        my $machine_os   = ($name =~ /server/i) ? "__SERVER_OS__" : "__CLIENT_OS__";
        my $machine_pwd  = ($name =~ /server/i) ? "__SERVER_PWD__" : "__CLIENT_PWD__";
        my $machine_user = ($name =~ /server/i) ? "__SERVER_USER__" : "__CLIENT_USER__";
        $xml .= <<END_OF_XML;
<machine>
    <name>$machine_name</name>
    <ip_address>$machine_ip</ip_address>
    <os>$machine_os</os>
    <password>$machine_pwd</password>
    <user>$machine_user</user>
</machine>
END_OF_XML
    }

    $xml .= "</$name>\n";

    return ($xml);
}

#
# package_device() - Package our device xml data
# Input:  $machine - Hash of device data
#         $name    - Name to give the encapsulating xml tags
# Output: String containing our formatted xml for the specified device data
sub package_device {
    my ($machine,$name) = @_;

    # Create our xml object
    my $xs = XML::Simple->new(RootName => 'machine', ForceArray => 1, NoAttr => 1);

    # Iterate through each machine
    my $xml = "<$name>\n";
    while(my($machine_name, $data) = each(%$machine)) {
        my $tmp = $xs->XMLout($data);
        $xml .= $tmp;
    }
    $xml .= "</$name>\n";

    return ($xml);
}

#
# fetch_script_data() - Parses the config.xml file for the client/server script information and 
#                       returns the data formatted as xml
# Input:  $xmldata - String containing our xml data
# Output: Strings containing our formatted script data for both client and server
sub fetch_script_data {
    my ($xmldata) = shift;

    # Create our xml object
    my $xs = XML::Simple->new(NoAttr => 1);
    my $xml = $xs->XMLin($xmldata);
    my $client_scripts = $xs->XMLout($xml->{clients}->{scripts}, RootName => 'scripts');
    my $server_scripts = $xs->XMLout($xml->{servers}->{scripts}, RootName => 'scripts');

    return ($client_scripts,$server_scripts);
}

#
# fetch_script_list() - Returns a set of lists of all script names for both client and server machines
# Input:  $config_template - The file name and path of the configuration template
#         $os              - Operating system that the scripts need to run on (win/nix)
# Output: Array of all scripts for the given machine type
sub fetch_script_list {
    my($config_template,$os) = @_;

    print "DEBUG>> fetch_script_list() - Entering function \n" if ($CONFIG->{'DEBUG'} > 1);

    # Read the config.xml file
    my $xmldata = open_template_file($config_template,"string");

    # Create our xml object
    my $xs = XML::Simple->new(NoAttr => 1);
    my $xml = $xs->XMLin($xmldata);

    # Create reference to script data (either string or array)
    my $ref_client_scripts = $xml->{clients}->{scripts}->{$os}->{name};
    my $ref_server_scripts = $xml->{servers}->{scripts}->{$os}->{name};
    
    # List of client scripts and list of server scripts
    my (@clients,@servers);

    # Check our client scripts data structure
    if (ref($xml->{clients}->{scripts}->{$os}->{name}) eq 'ARRAY') {
        # Dereference our client scripts array
        my @client_scripts = @$ref_client_scripts;
        for (my $i=0; $i <= $#client_scripts; $i++) {
            push @clients, $client_scripts[$i];
        }
    }
    else {
        push @clients, $ref_client_scripts;
    }

    # Check our server scripts data structure
    if (ref($xml->{servers}->{scripts}->{$os}->{name}) eq 'ARRAY') {
        # Dereference our server scripts array
        my @server_scripts = @$ref_server_scripts;
        for (my $i=0; $i <= $#server_scripts; $i++) {
            push @servers, $server_scripts[$i];
        }
    }
    else {
        push @servers, $ref_server_scripts;
    }

    print "DEBUG>> fetch_script_list() - Exiting function \n" if ($CONFIG->{'DEBUG'} > 1);
    
    return (\@clients,\@servers);
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
    $ua->timeout($TIMEOUT);

    # Fetch the response
    my $response = $ua->request($request);

    # Unpack our response object and return the content, or error if it exists
    my $retval = ($response->is_success) ? $response->content : $response->error_as_HTML;

    return ($retval);
}

#
# build_machine_hash() - Using xml results from client and server, build hash data structure
# Input:  $server_response - String containing server xml results
#         $client_response - String containing client xml results
# Output: Hash data structure containing our machine pair results
sub build_machine_hash {
    my($server_response,$client_response) = @_;

    my $server_results = unpack_machine_results($server_response);
    my $client_results = unpack_machine_results($client_response);

    my %machine_pairs = ( "server" => $server_results, "client" => $client_results );

    return (\%machine_pairs);
}

#
# build_machine_list_hash() - Using xml results from client or server machines, build a hash data structure
# Input:  $client_results_list - List (array) of all results for the client machines
#         $server_results_list - List (array) of all results for the server machines 
# Output: Hash containing a list of all results for both the client and server machines
sub build_machine_list_hash {
    my($client_results_list,$server_results_list) = @_;

    my @cr_list = @$client_results_list;
    my @sr_list = @$server_results_list;

    my %client_machine_list;
    for (my $i=0; $i <= $#cr_list; $i++) {
        my $results = unpack_machine_results($cr_list[$i]);
        $client_machine_list{$i} = $results;
    }

    my %server_machine_list;
    for (my $i=0; $i <= $#sr_list; $i++) {
        my $results = unpack_machine_results($sr_list[$i]);
        $server_machine_list{$i} = $results;
    }

    my %retval = ( "server" => \%server_machine_list, "client" => \%client_machine_list );

    return (\%retval);
}

#
# unpack_machine_results() - Convert results xml into results hash data structure
# Input:  $results - Concatenated string of our results xml
# Output: Hash data structure containing a machine (client/server) results
sub unpack_machine_results {
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
# interpolate_machine_data() - Interpolate variables with machine (client/server) data
# Input:  $machine      - Hash reference containing machine specific information
#         $config_xml   - String containing our xml config data
#         $machine_type - String containing our machine type (client/server)
# Output: String containing our interpolated config.xml
sub interpolate_machine_data {
    my($machine,$config_xml,$machine_type) = @_;

    my $machine_name = $machine->{'name'};
    my $machine_ip   = $machine->{'ip_address'};
    my $machine_os   = $machine->{'os'};
    my $machine_pwd  = $machine->{'password'};
    my $machine_user = $machine->{'user'};

    if ($machine_type =~ /client/i) {
        $config_xml =~ s/__CLIENT_NAME__/$machine_name/;
        $config_xml =~ s/__CLIENT_IP__/$machine_ip/;
        $config_xml =~ s/__CLIENT_OS__/$machine_os/;
        $config_xml =~ s/__CLIENT_PWD__/$machine_pwd/;
        $config_xml =~ s/__CLIENT_USER__/$machine_user/;
        $config_xml =~ s/__LOCAL_IP__/$machine_ip/;         # This value is only used for client machines
    }
    if ($machine_type =~ /server/i) {
        $config_xml =~ s/__SERVER_NAME__/$machine_name/;
        $config_xml =~ s/__SERVER_IP__/$machine_ip/;
        $config_xml =~ s/__SERVER_OS__/$machine_os/;
        $config_xml =~ s/__SERVER_PWD__/$machine_pwd/;
        $config_xml =~ s/__SERVER_USER__/$machine_user/;
    }

    return ($config_xml);
}

#
# result_status() - Returns the result status of the Visual Test script (either pass/fail)
# Input:  $response - The xml response for the current machine (client/server)
# Output: Result status of either "pass" or "fail". If there is a failure, then a reason for the failure is also returned
sub result_status {
    my($response) = shift;

    # Clean results
    $response =~ s/^\s+//;
    $response =~ s/\s+$//;

    # Create our xml object
    my $xs = XML::Simple->new();
    my $xml = $xs->XMLin($response);

    my $result;
    my $reason;

    # NOTE: The only time a 'result' is not defined is due to a timeout failure along the way
    if (defined($xml->{'result'})) {
        $result = $xml->{'result'};
        $reason = $xml->{'reason'};
    }
    else {
        $result = "fail";
        $reason = (defined($xml->{'reason'}) && $xml->{'reason'} ne "") ? $xml->{'reason'} : "There was no failure reason defined within the results.xml.";
    }

    return ($result,$reason);
}

#
# capture_elapsed_times() - Returns an array reference containing a list of all elapsed times for a given client
# Input:  $response - The xml response for the current machine (client)
# Output: Array reference containing a list of all elapsed times for a given client
sub capture_elapsed_times {
    my($response) = shift;
    
    # Clean results
    $response =~ s/^\s+//;
    $response =~ s/\s+$//;

    # Create our xml object
    my $xs = XML::Simple->new();
    my $xml = $xs->XMLin($response);
    
    my @elapsed_times = ();
    my $timevalue;
    my $description;
    my $timestamp = $CONFIG->create_timestamp();
    my $xml_elapsed_times = $xml->{'elapsed_times'};

    if (defined($xml_elapsed_times)) {
        # Find out if we have multiple elapsed time elements within our xml
        if (ref($xml_elapsed_times) eq 'ARRAY') {
            print "DEBUG>> Elapsed Times Element IS ARRAY \n" if ($CONFIG->{'DEBUG'} > 1);
            
            foreach my $timedata (@$xml_elapsed_times) {
                $timevalue   = $timedata->{'timedata'}->{'time'};
                $description = $timedata->{'timedata'}->{'desc'};
                push(@elapsed_times, { "timevalue" => $timevalue, "description" => $description, "exetime" => $timestamp++ });
            }
        }
        else {
            print "DEBUG>> Elapsed Times Element IS HASH \n" if ($CONFIG->{'DEBUG'} > 1);
            
            $timevalue   = $xml_elapsed_times->{'timedata'}->{'time'};
            $description = $xml_elapsed_times->{'timedata'}->{'desc'};
            
            push(@elapsed_times, { "timevalue" => $timevalue, "description" => $description, "exetime" => $timestamp });
        }
    }
    else {
        $timevalue   = "";
        $description = "";
        
        push(@elapsed_times, { "timevalue" => $timevalue, "description" => $description, "exetime" => $timestamp });
    }
    
    return (\@elapsed_times);
}

#
# open_template_file() - Return the template file as an array or string.
# Input:  $file_name   - Name of the file, including full path, to open
#         $return_type - Data type to return, either 'string' or 'array'
# Output: Returns the file contents as the data type specified
sub open_template_file {
    my($file_name,$return_type) = @_;

    # Open up the selected file. If the file does not exist, then return an error message.
    unless (open INFILE, $file_name) {
        return ("Template file ($file_name) is missing.");   ## TODO: might die() instead of return error
    }
    my @contents = <INFILE>;
    close (INFILE);

    if ($return_type eq "array") {
        return (@contents);
    }
    else {
        my $rv;
        for (my $i=0; $i <= $#contents; $i++) {
            $contents[$i] =~ s/^\s+//;
            $contents[$i] =~ s/\s+$//;
            $rv .= $contents[$i];
        }
        return ($rv)
    }
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
