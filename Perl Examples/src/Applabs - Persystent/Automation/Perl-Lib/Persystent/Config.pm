#!/usr/bin/perl -w
#
# Copyright:     AppLabs Technologies / Persystent Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision:  $
# Last Modified: $Date:  $
# Modified By:   $Author:  $
# Source:        $Source:  $
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
# Output - Object for global configurations to environment
sub new {

    my $CONFIG = {
        "ROOT_PATH"             => "C:\\persystent\\",                        # Root path where the Persystent test framework is located
        "AUTO_PATH"             => "C:\\persystent\\Automation\\",            # Path/directory of the automation framework's core PERL libraries and scripts
        "DEFAULT_INPUT_PATH"    => "C:\\persystent\\TestData\\InputData\\",   # Default path/directory of the input file
        "DEFAULT_INPUT_FILE"    => "Default.xls",                             # Default name of the input file
        "MANAGEMENT_IP"         => "216.119.203.129",                         # IP address of the Persystent Management Server
        "DATABASE_IP"           => "216.119.203.129",                         # IP address of the Persystent Database Server
        "WEBAPP_IP"             => "216.119.203.129",                         # IP address of the Persystent Web Application Server
        "WEB_SERVICE_PORT"      => "5002",                                    # Port number of the web service (Default is 5002)
        "HTTP_SERVICE_PORT"     => "8080",                                    # Port number of the Rembo Server Console service (Default is 8080)
        "POSTBOOT_SERVICE_PORT" => "5000",                                    # Port number of the post-boot service (Default is 5000)
        "TIMEOUT"               => 3600,                                      # Sets the timeout value for TCP connections to either client/server machines (in seconds)
        "DEBUG"                 => 1,                                         # If set, will output debugging information (1=on/0=off)
        "LOG"                   => 1,                                         # If set, will output detailed information on test execution to log file (1=on/0=off)
        "LOG_PATH"              => "C:\\persystent\\Automation\\Logs\\",      # This sets the path/directory where log files will be saved
        "LOG_FILE"              => "debug.log",                               # Name of log file
        "REBOOT_WAIT"           => 200                                        # Default number of seconds a script should wait for a reboot to complete
    };
    
    bless $CONFIG, 'Config';   # Tag object with pkg name
    return $CONFIG;
}


1;

__END__
