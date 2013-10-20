#!/usr/bin/perl
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.25 $
# Last Modified: $Date: 2005/08/22 19:17:55 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbital/control/perl-lib/Orbital/Receiver.pm,v $
#
####################################################################################
##
##


use strict;
use vars qw($CONFIG_FILE $RESULTS_FILE $ORBITAL_PATH $LOG_PATH);
use lib "C:\\usr\\local\\orbital\\console\\perl-lib\\";
use Orbital::Config;
use Orbital::Windows;
use CGI qw(:standard :nodebug);
use HTTP::Daemon;  # need LWP-5.32 or better
use HTTP::Response;
use HTTP::Status;
use LWP::UserAgent;
use XML::Simple;
use Sys::HostIP;

# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

# Define the following
my $CONFIG_FILE  = $CONFIG->{'CONFIG_FILE'};              # Name of the config file created from our xml request
my $RESULTS_FILE = $CONFIG->{'RESULTS_FILE'};             # Name of results file created from VisualTest scripts
my $ORBITAL_PATH = "..\\..\\";                            # Directory of the Orbital Test Tool software package
my $LOG_PATH     = "C:\\usr\\local\\orbital\\logs\\";     # Path of the log files

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

    my $local_host = hostip();   # IP address of the local machine (client/server)

    my $server = HTTP::Daemon->new(
        'LocalPort' => $local_port,
        'LocalHost' => $local_host,
        'Proto'     => 'tcp',
        'Listen'    => 2,
        'Reuse'     => 1) || die "Cannot create new HTTP daemon: $!";

    log_events($LOG_PATH,"=========================") if ($CONFIG->{'LOG'} > 0);
    log_events($LOG_PATH,"Start Receiver") if ($CONFIG->{'LOG'} > 0);
    log_events($LOG_PATH,"[Server $0 accepting clients]") if ($CONFIG->{'LOG'} > 0);
    log_events($LOG_PATH,"Daemon data: ".( ($server) ? "Server object exists" : "Server object does NOT exist" )) if ($CONFIG->{'LOG'} > 0);
    log_events($LOG_PATH,"Server: $server") if ($CONFIG->{'LOG'} > 0);
    log_events($LOG_PATH,"Root url: ".$server->url) if ($CONFIG->{'LOG'} > 0);
    log_events($LOG_PATH,"Tokens: ".$server->product_tokens) if ($CONFIG->{'LOG'} > 0);
    log_events($LOG_PATH,"Client ip: ".( (exists($ENV{'REMOTE_ADDR'})) ? $ENV{'REMOTE_ADDR'} : "127.0.0.1" )) if ($CONFIG->{'LOG'} > 0);
    log_events($LOG_PATH,"Timestamp: ".timestamp()) if ($CONFIG->{'LOG'} > 0);

    return ($server);
}

#
# daemon_listener() - HTTP daemon that waits and listens for a request from the Console machine
# Input:  $server - Daemon object (created using HTTP::Daemon)
# Output: Nothing
sub daemon_listener {
    my ($server) = shift;

    while (my $client = $server->accept()) {

        log_events($LOG_PATH,"OPEN: connection") if ($CONFIG->{'LOG'} > 0);

        my $content;   # Content that is captured by the daemon listener

        CONNECTION:
        while (my $answer = $client->get_request) {
            log_events($LOG_PATH,"Request Method: ".( (exists($ENV{'REQUEST_METHOD'})) ? $ENV{'REQUEST_METHOD'} : "None" )) if ($CONFIG->{'LOG'} > 0);
            log_events($LOG_PATH,"Content Type: ".( (exists($ENV{'CONTENT_TYPE'})) ? $ENV{'CONTENT_TYPE'} : "Undefined" )) if ($CONFIG->{'LOG'} > 0);
            log_events($LOG_PATH,"Content-Length: ".( (exists($ENV{'CONTENT_LENGTH'})) ? $ENV{'CONTENT_LENGTH'} : 0 )) if ($CONFIG->{'LOG'} > 0);
            log_events($LOG_PATH,"User Agent: ".( (exists($ENV{'HTTP_USER_AGENT'})) ? $ENV{'HTTP_USER_AGENT'} : "None" )) if ($CONFIG->{'LOG'} > 0);

            $client->autoflush;
            last CONNECTION if ($answer =~ /\n\n$/g);

            # Define our content to return
            $content .= $answer->content;
        }
        log_events($LOG_PATH,"CLOSE: ".$client->reason) if ($CONFIG->{'LOG'} > 0);

        $content =~ s/^\s+//;
        $content =~ s/\s+$//;

        log_events($LOG_PATH,"START_CONTENT>>\n".$content."\nEND_CONTENT>>") if ($CONFIG->{'LOG'} > 0);

        # Parse our xml request
        my $xml = parse_xml($content);

        # Set the path for our test case
        my $TC_PATH = $ORBITAL_PATH.$xml->{'share'}."\\";

        log_events($LOG_PATH,"TC_PATH: $TC_PATH");

        # Write out our config.xml file into the test case directory
        write_config_xml($TC_PATH.$CONFIG_FILE,$content);

        log_events($LOG_PATH,"SCRIPT EXE: ".$xml->{'script_exe'});

        # Execute Visual Test script
        my $rv = execute_script($TC_PATH,$xml->{'script_exe'});

        # Capture results
        if ($xml->{'script_exe'} =~ /server/i) {
            until (-e $TC_PATH.$RESULTS_FILE) {
                sleep 5;
            }
        }
        my $results = open_results_file($TC_PATH.$RESULTS_FILE,"string");

        log_events($LOG_PATH,"Result Contents: ".$results."\n") if ($CONFIG->{'LOG'} > 1);

        # Format our xml results into a valid http response
        my $response = format_response($results);

        # Clean up our test run by making sure no runaway Visual Test processes are still alive
        cleanUpMachine();
        
        # Send our response back to the client
        $client->send_response($response);
        $client->close;
        undef $client;
    }

    log_events($LOG_PATH,"End Receiver\n");
}

#
# execute_script() - Executes the given Visual Test script through a shell
# Input:  $path       - Path to change into to run our Visual Test script
#         $script_exe - Path and file name of the script to execute
# Output: Returns STDOUT from the Visual Test script (currently nothing)
sub execute_script {
    my($path,$script) = @_;

    my $OS = "windows";    ## TODO: need to come up with a better way of determining the local OS

    # Make sure we remember where we are
    use Cwd;
    my $old_path = cwd;
    if ($OS =~ /windows/i) {
        $old_path =~ s/\//\\/g;
    }
    
    print "DEBUG>> old path: $old_path \n" if ($CONFIG->{'DEBUG'} > 1);
    print "DEBUG>> new path: $path \n" if ($CONFIG->{'DEBUG'} > 1);

    # Change into the directory that the Visual Test script exists
    chdir("$path") || die "Cannot chdir to: $path ($!)";

    my $current_path = cwd;
    if ($OS =~ /windows/i) {
        $current_path =~ s/\//\\/g;
    }

    print "DEBUG>> cur path: $current_path \n" if ($CONFIG->{'DEBUG'} > 1);

    # NOTE: Using the backtick operator, the script will continue running, and suspend everything 
    #       until either the script finishes running, or fails
    my @output = system("$script");
    my $rv = join("", @output);

    print "DEBUG>> return value: [$rv] \n" if ($CONFIG->{'DEBUG'} > 1);
    
    # Change back to old path when we finish
    # so relative paths continue to make sense
    chdir($old_path);
    
    return $rv;
}

#
# format_response() - Function that formats our xml results into a valid http response
# Input:  $results - XML results captured from our Results.xml file
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

    # Parsing the config.xml.template file returns the following elements:
    log_events($LOG_PATH,"Test Case: ".$xml->{test_case});
    log_events($LOG_PATH,"Share: ".$xml->{share});

    return ($xml);
}

#
# open_results_file() - Return the results file as an array or string.
# Input:  $file_name   - Name of the file, including full path, to open
#         $return_type - Data type to return, either 'string' or 'array'
# Output: Returns the file contents as the data type specified
sub open_results_file {
    my($file_name,$return_type) = @_;

    # Open up the selected file. If the file does not exist, then return an error message.
    unless (open INFILE, $file_name) {
        return ("Can't open: results.xml file missing");
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
# write_config_xml() - Writes out a new config.xml file to our test script directory
# Input:  $config_file - The path and file name of the file to create (defaults to config.xml)
#         $content     - Content to be written to file
# Output: 0 sucess : 1 failure
sub write_config_xml {
    my($config_file,$content) = @_;
    
    # Write out a new config.xml file. (overwrites any config file that currently exists)
    open(OUTFILE, ">$config_file") || die "Cannot create config.xml: $config_file: $!";
    print OUTFILE "$content";
    close(OUTFILE);
    return 0;
}

#
# log_events() - This function logs any data passed to it
# Input:  $LOG_PATH - Path of the log file (NOTE: Path needs to be writeable)
#         $content  - Content to be logged
# Output: Returns nothing
sub log_events {
    my($LOG_PATH,$content) = @_;

    my $log_file = $LOG_PATH."receiver_log.txt";
    
    # Append
    if (-e $log_file) {
        open(OUTFILE, ">>$log_file") || die "Cannot append to $log_file: $!\n";
        print OUTFILE "$content\n";
        close(OUTFILE);
    }
    # Create
    else {
        open(OUTFILE, ">$log_file") || die "Cannot create $log_file: $!\n";
        print OUTFILE "$content\n";
        close(OUTFILE);
    }
}

#
# timestamp() - This function creates a basic formatted timestamp
# Input:  Nothing
# Output: Returns the local time in the format of: 'MM/DD/YY - HH:MM:SS'
sub timestamp {
    # Time Information
    my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    $year = $year + 1900;
    $mon  = $mon + 1;
    my $localtime = "$mon/$mday/$year - $hour:$min:$sec";
    return $localtime;
}

# dump_data() - Dumps all CGI Environment data, including Perl Environment data, plus all variables used in the corresponding package (object) name
# Input:  $pkg_name - Name of package/object
# Output: STDOUT of all CGI environment data, perl environment data, plus all variables used for the given package/object name
sub dump_data {
    my($pkg_name) = @_;

    use Dumpvalue;
    my $dumper = new Dumpvalue;
    $dumper->set(globPrint => 1);
    #$dumper->dumpValue(\*::);
    $dumper->dumpvars($pkg_name);
}


1;

__END__
