package DeviceConfig;

use XMLRPC::Lite;
use ORAPP::Config;
use LWP::Simple;
#use Net::SCP qw(scp iscp);
use strict;
use Data::Dumper;

# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

# Define the following
my $ORBITAL_PORT = $CONFIG->{'ORBITAL_PORT'};    # Port number of the Orbital device

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input: - $hashref - Hash reference containing all of our test case instance information
# Output - Object reference
sub new {
	#shift();
	my $machine_ip = shift;
	my $self = {
		        "rpc_server_ip"=>$machine_ip
	};
	bless $self, 'DeviceConfig';
    return $self;
}



# set_orbital_parameter() - Configure Orbital device using the given parameters, values and ip address
# Input:  $param     - Parameter to be changed
#         $value     - Value of the parameter to be changed
# Output: None
sub set_orbital_parameter {
    chomp(my $self = shift);
    chomp(my $param = shift);
    chomp(my $value = shift);

    my $url = "http://$self->{rpc_server_ip}:$ORBITAL_PORT/RPC2";
    
	# Define our parameter names and values
    my $parameterName = ($param) ? $param : "Parameter name not defined";
    my $parameterValue = (($value) || ($value == 0)) ? $value : "Parameter value not defined";

    
    my $response =  XMLRPC::Lite
          ->proxy($url)
          ->call('Set', {Class => "PARAMETER", Attribute => $param, Value => eval($value) })
          ->result;

    if (defined(${$response}{'Fault'})) {
            print "${$response}{'Fault'}\n";
    }

}


# get_orbital_parameter() - Gets Orbital device configuration info for given parameters, values and ip address
# Input:  $param     - Parameter
# Output: Value of the Parameter
sub get_orbital_parameter {
    chomp(my $self = shift);
    chomp(my $param = shift);

    my $url = "http://$self->{rpc_server_ip}:$ORBITAL_PORT/RPC2";

    # Define our parameter names and values
    my $parameterName = ($param) ? $param : "Parameter name not defined";

    
    my $response =  XMLRPC::Lite
         ->proxy($url)
         ->call('Get', {Class => "PARAMETER", Attribute => "$param" })
         ->result;


    if (!defined(${$response}{$param}{'Fault'})) {
        while (( my $okey, my $oval) = each %$response) {
             if ($oval->{'XML'} =~ (m/^ARRAY/)) {
                  print  $okey . " = " . $oval->{'Text'} . "\n";
              }
             else {
                    print  $okey . " = " . $oval->{'XML'} . "\n";
              }
         }
     }
     else {
            print "${$response}{$param}{'Fault'} $param\n";
     }

}


# configure_wansimulator() - Configure the WAN-simulator using the given settings
# Input:  $wansim - Hash reference containing delay router settings
# Output: None
sub configure_wansimulator {
    my $wansimip = shift;
	my $wansim = shift;
    
    my $ip = $wansimip->{'rpc_server_ip'};
    my $bw = $wansim->{'bandwidth'};
    my $dly = $wansim->{'delay'};
    my $plr = $wansim->{'plr'};
    my $url = "http://$ip/cgi-bin/wansimconfig.cgi?bw=$bw&dly=$dly&plr=$plr";

    my $content = get($url);

    # Check to see if anything was returned
    if (!defined($content)) {
        print "ORAPP>> configure_wansimulator() -> ERROR: No content was returned for LWP::Simple::get() \n";
    }
}

#
# get_orbital_build() - Fetch the software build on an Orbital device using the given IP address
# Input:  Hash reference containing Orbital machine IP
# Output: Multi-dimensional hash containing software build information on the given Orbital machine
sub get_orbital_build {
    my $self = shift;
   
    # Define our RPC URL
    my $url = "http://$self->{'rpc_server_ip'}:$ORBITAL_PORT/RPC2";

    # Defines which parameter data we need returned
    my @param = ["Version"];
    
    my $response =  XMLRPC::Lite
            ->proxy($url)
            ->call('Get', {Class => "SYSTEM", Attribute => @param })
            ->result;

    return ($response) ? $response : undef;
}








#
# enable_tracing() - Enable trace logging on the given Orbital device
# Input:  $host - IP address of the Orbital device that needs logging enabled
# Output: Integer value of zero on success or undef on failure
sub enable_tracing {
    chomp(my $self = shift);
	my $param = "Trace";
    my $value = 1;

    my $url = "http://$self->{rpc_server_ip}:$ORBITAL_PORT/RPC2";
    
    my $response =  XMLRPC::Lite
          ->proxy($url)
          ->call('Set', {Class => "PARAMETER", Attribute => $param, Value => eval($value) })
          ->result;

    #Coding is required to verify the setting. Return the value accordingly.
}

#
# disable_tracing() - Enable trace logging on the given Orbital device
# Input:  $host - IP address of the Orbital device that needs logging enabled
# Output: Integer value of zero on success or undef on failure
sub disable_tracing {
    chomp(my $self = shift);
	my $param = "Trace";
    my $value = 0;

    my $url = "http://$self->{rpc_server_ip}:$ORBITAL_PORT/RPC2";
    
    my $response =  XMLRPC::Lite
          ->proxy($url)
          ->call('Set', {Class => "PARAMETER", Attribute => $param, Value => eval($value) })
          ->result;

    #Coding is required to verify the setting. Return the value accordingly.
}


#
# get_trace_logs() - Get the trace logs located on the remote Orbital device
# Input:  $host      - Ref of the remote device
#         $user      - User name to log onto the remote device
#         
# Output: Returns true on success and false on failure
sub get_trace_logs {
    my $self = shift;
	my $user = shift;
    my $hostname = shift=>{'rpc_server_ip'};
	
    # Define the following
    my $source      = $CONFIG->{'TRACE_PATH'} . "Trace.0.OrbTrace";
    my $destination = $CONFIG->{'LOG_PATH'} . "trace/Trace.$hostname.log";
    print $source;
    my $scp = Net::SCP->new( { "host" => $hostname, "user" => $user } );
    $scp->get($source, $destination) or $scp->{errstr};

    # TODO: Last, depending on the configuration settings, copy the trace logs to an ftp server
    
    return 0;
}

#
# remove_trace_logs() - Removes all trace logs on the given Orbital device
# Input:  $host     - IP address of the Orbital device
#         $user     - User name to log into the Orbital device
# Output: Returns an integer value of zero on success, or undef on failure
sub removeTraceLogs {
    my $self = shift;
	my $user = shift;
    my $host = shift=>{'rpc_server_ip'};
    
        
    # Get a directory listing of our Trace log directory
    my $cmd = "ls " . $CONFIG->{'TRACE_PATH'} . " | grep --directories=skip Trace";
    my $stdout = Net::SSH::ssh_cmd("$user\@$host", $cmd);
    if ($stdout eq "") {
        return undef;
    }
    
    # NOTE: If the file is non-existant or missing, the script will continue on
    VALID_FILE:
    foreach my $file (split /\n/, $stdout) {
	my $tmp_file = $CONFIG->{'TRACE_PATH'} . $file;
	if (-d $tmp_file) {
	    print "DEBUG>> $tmp_file is a Directory.\n";
            next VALID_FILE;
        }
	print "DEBUG>> $tmp_file is a File.\n";
        $cmd = "rm -f " . $CONFIG->{'TRACE_PATH'} . $file;
        
        $stdout = Net::SSH::ssh_cmd("$user\@$host", $cmd);
        if ($stdout ne "") {
            print "WARNING: Trace log file removal failed for Orbital ".$host;
        }
    }
    
    return 0;
}

1;

__END__
