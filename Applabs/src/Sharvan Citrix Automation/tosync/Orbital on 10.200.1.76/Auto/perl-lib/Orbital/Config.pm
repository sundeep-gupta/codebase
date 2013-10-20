#!/usr/bin/perl -w
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.9 $
# Last Modified: $Date: 2005/08/18 23:56:23 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbital/control/perl-lib/Orbital/Config.pm,v $
#
####################################################################################
##
##


package Config;

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input: - Nothing
# Output - Object
# NOTE: Comments are made for each configuration item as well as which machine the config option applies to (console,client,server,all)
sub new {

    my $CONFIG = {
        "CONFIG_TEMPLATE" => "config.xml",                           # [console] Name of the template file that contains a list of all Visual Test scripts to run on clients/servers
        "CONFIG_FILE"     => "config.xml",                           # [all] Name of the XML file containing configuration information for tests to run on clients/servers
        "RESULTS_FILE"    => "results.xml",                          # [client/server] Name of the XML file containing results information from a test run
        "BASEURL"         => "http://10.201.201.91/orbital/",        # [console] Base URL of the web application. Usually setup beneath Apache's docroot
        "BASEPATH"        => "/var/www/html/orbital/",               # [console] Base path/directory of the web application. Underneath Apache's docroot
        "ORBITAL_PATH"    => "/usr/local/orbital/",                  # [all] Path/directory of the testing tool's core libraries and Visual Test scripts
        "ORBITAL_PORT"    => "2050",                                 # [console] Port number to access the Orbital device
        "CONSOLE_IP"      => "10.1.1.5",                             # [console] Sets up the IP address for the console (used in the config.xml file)
        "TIMEOUT"         => 7200,                                   # [console] Sets the timeout value for TCP connections to either client/server machines (in seconds)
        "USE_ORBITALS"    => 1,                                      # [console] If set, will connect and configure the Orbital devices, including trace log capture (1=on/0=off)
        "USE_DELAYROUTER" => 1,                                      # [console] If set, will connect and configure the delay router (1=on/0=off)
        "VERBOSE"         => 1,                                      # [console] If set, will output more information on test run progress through browser (1=on/0=off)
        "DEBUG"           => 1,                                      # [all] If set, will output debugging information (1=on/0=off)
        "LOG"             => 1,                                      # [client/server] If set, will output detailed information on test execution to log file (1=on/0=off)
        "LOG_PATH"        => "/usr/local/orbital/logs/",             # [all] This sets the path/directory where log files will be saved
        "LOG_FILE"        => "debug.log",                            # [all] Name of log file
        "TRACE"           => 1,                                      # [console] If set, will toggle Orbital trace log capture (1=on/0=off)
        "TRACE_FTP"       => 0,                                      # [console] If set, will copy trace logs to an FTP server (1=on/0=off)
        "TRACE_PATH"      => "/orbital/current/server/Trace/",       # [console] Path/directory of trace logs on Orbital device
        "FTP_HOST"        => "",                                     # [console] Host name or IP address of the FTP server
        "FTP_USER"        => "",                                     # [console] User name of the FTP server
        "FTP_PASSWORD"    => "",                                     # [console] Password of the FTP server user
        "CORE_PATH"       => "",                                     # [console] Path/directory of files containing core dumps on Orbital device
        "DB_USER"         => "orbtest",                              # [console] Database user
        "DB_PASSWORD"     => "orbtest",                              # [console] Database password
        "DB_NAME"         => "orbtest",                              # [console] Database name
        "DB_HOST"         => "localhost"                             # [console] Host name of the machine that the database is on (defaults to localhost)
    };
    
    bless $CONFIG, 'Config';   # Tag object with pkg name
    return $CONFIG;
}

#
# create_session_id() - Create a unique randomly generated session id
# Input:  Nothing
# Output: String containing the session id value generated
sub create_session_id {
    my $session_id;
    my $_rand;

    # Setup our default session id length
    my $string_length = 32;

    # Include the following alpha-numeric characters (excluding the letters i, I, l, L, o, O)
    my @chars = ("a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "m", "n", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
                 "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                 "A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
                 );

    srand;
    for (my $i=0; $i < $string_length; $i++) {
        $_rand = int(rand(56));
        $session_id .= $chars[$_rand];
    }
    
    return $session_id;
}

#
# create_timestamp() - Generate a unix timestamp and return it
# Input:  Nothing
# Output: String containing unix timestamp
sub create_timestamp {
    my $timestamp = time();
    return $timestamp;
}



1;

__END__
