

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
	"ORBITAL1"	  => "10.201.201.92",		             # Orbital 1 IP address; will come from console
	"ORBITAL2"	  => "10.201.201.93",	                     # Orbital 2 IP address; will come from console
	"NODE1"		  => "10.1.2.20",		             # NODE1 will be treated as server
	"NODE2"		  => "10.1.1.2",	        	     # NODE2 will be treated as client
	"SHARE"		  => "kshare",		        	     # Share name on server; will come from console
	"SHARE_PATH"	  => "c:/kshare",			     # Share path on server; will come either from console or default
	"WAN_SIMULATOR"	  => "10.201.201.103",			     # WAN Simulator IP address; will come from console
    "ORBITAL_PORT"    => "2050",                                 # [console] Port number to access the Orbital device
    "SCRIPT_LOG"	  => "script.log",			     # Script log name
	"SCRIPT_ERROR_LOG"=> "script.error.log",	             # Script Error Log file name
    "FTP_USER"        => "anonymous",                            # [console] User name of the FTP server
    "FTP_PASSWORD"    => "nopass\@nopass.com",                   # [console] Password of the FTP server user
    };
    
    bless $CONFIG, 'Config';   # Tag object with pkg name
    return $CONFIG;
}


1;

__END__
