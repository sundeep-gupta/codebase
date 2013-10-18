

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
        "ORBITAL_PORT"    => "2050",                                 # [console] Port number to access the Orbital device
        "TIMEOUT"         => 7200,                                   # [console] Sets the timeout value for TCP connections to either client/server machines (in seconds)
        "VERBOSE"         => 1,                                      # [console] If set, will output more information on test run progress through browser (1=on/0=off)
        "LOG"             => 1,                                      # [client/server] If set, will output detailed information on test execution to log file (1=on/0=off)
        "LOG_PATH"        => "/usr/local/orbital/logs/",             # [all] This sets the path/directory where log files will be saved
        "LOG_FILE"        => "debug.log",                            # [all] Name of log file
        "TRACE_FTP"       => 0,                                      # [console] If set, will copy trace logs to an FTP server (1=on/0=off)
        "TRACE_PATH"      => "/orbital/current/server/Trace/",       # [console] Path/directory of trace logs on Orbital device
        "FTP_HOST"        => "",                                     # [console] Host name or IP address of the FTP server
        "FTP_USER"        => "",                                     # [console] User name of the FTP server
        "FTP_PASSWORD"    => "",                                     # [console] Password of the FTP server user
        "CORE_PATH"       => "",                                     # [console] Path/directory of files containing core dumps on Orbital device
        "DB_USER"         => "orbtest",                              # [console] Database user
        "DB_PASSWORD"     => "orbtest",                              # [console] Database password
        "DB_NAME"         => "orbtest",                              # [console] Database name
        "DB_HOST"         => "localhost",                             # [console] Host name of the machine that the database is on (defaults to localhost)
	
    };
    
    bless $CONFIG, 'Config';   # Tag object with pkg name
    return $CONFIG;
}


1;

__END__
