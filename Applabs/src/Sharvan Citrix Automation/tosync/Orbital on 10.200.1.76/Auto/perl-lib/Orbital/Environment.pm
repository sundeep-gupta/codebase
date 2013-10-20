#!/usr/bin/perl -w
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.9 $
# Last Modified: $Date: 2005/08/22 19:17:23 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbital/control/perl-lib/Orbital/Environment.pm,v $
#
####################################################################################
##
##


package Environment;

use lib qw(/usr/local/lib/perl5/5.8.6 /usr/local/lib/perl5/site_perl/5.8.6 /usr/local/orbital/console/perl-lib);
use vars qw($RPC_URI $RPC_PORT);
use Orbital::Config;
use Orbital::DeviceSettings;
use XMLRPC::Lite;          # System Requirement (install from CPAN)
use LWP::Simple;
use Net::SSH qw(ssh);      # System Requirement (install from CPAN)
use Net::SCP qw(scp);      # System Requirement (install from CPAN)
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# INSTALLATION NOTES:
# -----------------------------------------------------------
# This module requires that you copy the RSA public key from the management
# console onto each Orbital device that you want to connect to. The first thing that
# should be created is the RSA public key by using the ssh-keygen command.
# This public key (id_rsa.pub) then needs to be copied into the .ssh/authorized_keys
# file of each device you would like to connect to. This allows for no password
# authentication. This needs to be setup for both user 'root' and user 'apache'.
# For user 'apache', perform the following:
#
#           mkdir ~apache/.ssh
#           chmod 700 ~apache/.ssh
#           chown apache ~apache/.ssh
#           su apache -s/bin/sh -c 'ssh-keygen -t rsa'
#
# Also, note that on the management console, the user 'apache'
# needs to have each Orbital device listed in the known_hosts file. This can be
# accomplished by changing apache's shell to /bin/sh instead of /sbin/nologin
# by using the following command as root:
#
#           su apache -s/bin/sh
#
# Once logged in as 'apache', you then need to ssh into each Orbital device as
# user root, automatically setting up the known_hosts file
# -----------------------------------------------------------

# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

my $RPC_URI  = "/RPC2";
my $RPC_PORT = $CONFIG->{'ORBITAL_PORT'};

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input: - $orbitals - Hash reference containing a list of all Orbital devices being used for the current instance
# Output - Hash reference containing our network environment settings
sub new {
    my $orbitals = shift;
    
    my $NETENV = {
        "Orbitals"   => $orbitals,
        "ActiveConn" => 0,
        "TestStatus" => 0,
        "Timestamp"  => ""
    };
    bless $NETENV, 'Environment';   # Tag object with pkg name
    return $NETENV;
}

#
# getSystemConn() - Get a detailed list of all active TCP connections on all Orbital devices in the current machine group
# Input:  Object reference
# Output: Returns an array of hashes containing all active TCP connections
sub getSystemConn {
    my $NETENV = shift;
    
    my $orbitals = $NETENV->{'Orbitals'};
    
    my @active_conn = ();
    
    foreach my $device (keys %$orbitals) {
        my $ip = $orbitals->{$device}->{'ip_address'};

        # Fetch detailed user connection on the given Orbital device
        my $connections = getDeviceConn($ip);
        
        my @tmp_conn = @$connections;
        if ($#tmp_conn > 0) {
            push(@active_conn,@tmp_conn);
        }
    }
    
    return (\@active_conn);
}

#
# getDeviceConn() - Fetch detailed user connection information on an Orbital device using the given IP address
# Input:  $RPC_SERVER - String containing the IP address of the remote Orbital machine
# Output: Multi-dimensional hash containing detailed user connection information on the given Orbital machine
sub getDeviceConn {
    my($RPC_SERVER) = @_;
    
    # Define our RPC URL
    my $url = "http://" . $RPC_SERVER . ":" . $RPC_PORT . $RPC_URI;
    
    # Defines which parameter data we need returned
    my @param = ["ClientLogicalAddress", "ClientPhysicalAddress", "ServerLogicalAddress", "ServerPhysicalAddress",
                 "Duration", "InstanceNumber", "BytesTransferred", "IdleTime", "Accelerated", "Agent", "IsCompressed", "CompressionRatio"];
    
    my $response =  XMLRPC::Lite
            ->proxy($url)
            ->call('Get', {Class => "CONNECTION", Attribute => @param })
            ->result;

    return ($response) ? $response : undef;
}

#
# validateConnExists() - Validate a list of IP addresses (taken from XMLRPC of Orbital device), to make sure that a connection to the given machine is not active
# Input:  $connections - Hash reference containing a detailed list of all current TCP connections on the given Orbital device
#         $client_ip   - IP address of the client machine to validate
#         $server_ip   - IP address of the server machine to validate
# Output: Returns either true, if a connection does exist for the given IP address, or false if no connection exists
sub validateConnExists {
    my($connections, $client_ip, $server_ip) = @_;
    
    my $conn_exists = "false";
    foreach my $machine (@$connections){
        if ($machine->{'ClientPhysicalAddress'}->{'Dotted'} eq $client_ip) {
            # Display if the client machine is active
            print display_output("Client TCP Connection is Active for",$client_ip) if ($CONFIG->{'VERBOSE'} > 0);
            
            if ($machine->{'ServerPhysicalAddress'}->{'Dotted'} eq $server_ip) {
                print display_output("TCP Connection between Client and Server is Active for (client/server)",$client_ip . "/" . $server_ip) if ($CONFIG->{'VERBOSE'} > 0);
                $conn_exists = "true";
                last;
            }
        }
    }
    
    return ($conn_exists);
}

#
# getSystemBuild() - Get the software build for all Orbital devices in the current machine group
# Input:  Object reference
# Output: Returns an array of hashes containing the software build
sub getSystemBuild {
    my $NETENV = shift;
    
    my $orbitals = $NETENV->{'Orbitals'};
    
    my @devices = ();
    
    foreach my $device (keys %$orbitals) {
        my $ip = $orbitals->{$device}->{'ip_address'};

        # Fetch software build on the given Orbital device
        my $build = getDeviceBuild($ip);
        if (defined($build)) {
            $build->{'ip_address'} = $ip;
            push(@devices,$build);
        }
    }
    
    return (\@devices);
}

#
# getDeviceBuild() - Fetch the software build on an Orbital device using the given IP address
# Input:  $RPC_SERVER - String containing the IP address of the remote Orbital machine
# Output: Multi-dimensional hash containing software build information on the given Orbital machine
sub getDeviceBuild {
    my($RPC_SERVER) = @_;
    
    # Define our RPC URL
    my $url = "http://" . $RPC_SERVER . ":" . $RPC_PORT . $RPC_URI;
    
    # Defines which parameter data we need returned
    my @param = ["Version"];
    
    my $response =  XMLRPC::Lite
            ->proxy($url)
            ->call('Get', {Class => "SYSTEM", Attribute => @param })
            ->result;

    return ($response) ? $response : undef;
}

#
# getSystemCPU() - Get a list of all the per-CPU times for all Orbital devices
# Input:  Object reference
# Output: Hash reference containing a list of all the per-CPU times for all Orbital devices
sub getSystemCPU {
    my $NETENV = shift;
    
    my $orbitals = $NETENV->{'Orbitals'};
    
    my $timestamp = $CONFIG->create_timestamp();

    # Return the per-CPU times for all Orbital devices
    my %system_cpu;
    
    foreach my $device (keys %$orbitals){
        my $user = $orbitals->{$device}->{'user'};
        my $password = $orbitals->{$device}->{'password'};
        my $host = $orbitals->{$device}->{'ip_address'};
        
        my $CPU = getDeviceCPU($user, $password, $host);
        
        $system_cpu{$device} = {
            "ip_address" => $host,
            "user"       => $CPU->{'user'},
            "nice"       => $CPU->{'nice'},
            "system"     => $CPU->{'system'},
            "idle"       => $CPU->{'idle'},
            "timestamp"  => $timestamp
        };
    }
    
    return (\%system_cpu);
}

#
# getDeviceCPU() - Fetch the per-CPU time values of a remote machine
# Input:  $user     - User name of the remote device
#         $password - Password of the remote device
#         $host     - IP address of the remote host
# Output: Hash reference containing our remote device per-CPU time: user, nice, system, idle
sub getDeviceCPU {
    my($user, $password, $host) = @_;

    # Confirm that we have a valid user name, password, and host name
    $user =~ s/\s+//g;
    $password =~ s/\s+//g;
    
    # Confirm that we have a valid host name
    $host =~ s/\s+//g;
    unless ($host =~ m/^(\d+\.\d+\.\d+\.\d+)$/) {
        return undef;
    }
    
    # Get a directory listing of our Trace log directory
    my $cmd = "cat /proc/stat";
    my $stdout = Net::SSH::ssh_cmd("$user\@$host", $cmd);
    if ($stdout eq "") {
        return undef;
    }

    my $CPU = load_cpu($stdout);
    
    return ($CPU);
}

#
# load_cpu() - Captures the CPU values for the local machine
# Input:  $string - String containing the contents of the /proc/stat file
# Output: Hash reference containing the overall and per-CPU time: user, nice, system, idle
sub load_cpu {
    my($string) = shift;

    $string =~ s/^\s+//;
    $string =~ s/\s+$//;
    my @contents = split(/\n/,$string);

    my $cpu_string;
    for (my $i=0; $i <= $#contents; $i++) {
        $contents[$i] =~ s/^\s+//;
        $contents[$i] =~ s/\s+$//;
        if ($contents[$i] =~ /^(cpu\s+)/) {
            $cpu_string = $contents[$i];
            last;
        }
    }
    
    my %cpu_vars;
    if ($cpu_string ne "") {
        my @proc = split(/\s+/,$cpu_string);
        $cpu_vars{'user'} = $proc[1];
        $cpu_vars{'nice'} = $proc[2];
        $cpu_vars{'system'} = $proc[3];
        $cpu_vars{'idle'} = $proc[4];
    }

    return (\%cpu_vars);
}

#
# cpu_time_diff() - Calculates the difference in time values (in seconds)
# Input:  $first  - Hash reference to initial time value
#         $second - Hash reference to last time value
# Output: Returns hash reference for time difference values
sub cpu_time_diff {
    my($first, $second) = @_;
    
    # Dereference our hashes
    my %first_time = %$first;
    my %second_time = %$second;
    
    # Time difference hash
    my %timediff;
    $timediff{'user'}   = $second_time{'user'} - $first_time{'user'};
    $timediff{'nice'}   = $second_time{'nice'} - $first_time{'nice'};
    $timediff{'system'} = $second_time{'system'} - $first_time{'system'};
    $timediff{'idle'}   = $second_time{'idle'} - $first_time{'idle'};
    
    return (\%timediff);
}

#
# cpu_time_percentages() - Calculates the percent of time taken for each piece value (user, nice, system, idle) over the total time
# Input:  $diff - Hash reference containing our CPU time values
# Output: Hash reference containing our CPU time percentage values
sub cpu_time_percentages {
    my($diff) = @_;
    
    # Dereference our hash
    my %timediff = %$diff;
    
    my $total_time = 0;
    $total_time = $timediff{'user'} + $timediff{'nice'} + $timediff{'system'} + $timediff{'idle'};
    
    my %time_percentages;
    my $user   = ($timediff{'user'} / $total_time) * 100;
    my $nice   = ($timediff{'nice'} / $total_time) * 100;
    my $system = ($timediff{'system'} / $total_time) * 100;
    my $idle   = ($timediff{'idle'} / $total_time) * 100;
    
    $time_percentages{'user'} = sprintf("%.2f", $user);
    $time_percentages{'nice'} = sprintf("%.2f", $nice);
    $time_percentages{'system'} = sprintf("%.2f", $system);
    $time_percentages{'idle'} = sprintf("%.2f", $idle);

    return (\%time_percentages);
}

#
# preTestTrace() - Perform our pre-testing environment checks for Orbital trace logs
#                  1. Disable tracing
#                  2. Remove all existing trace logs
#                  3. Re-enable tracing
# Input:  $NETENV - Object reference
# Output: Nothing
sub preTestTrace {
    my $NETENV = shift;
    
    my $orbitals = $NETENV->{'Orbitals'};

    foreach my $device (keys %$orbitals){
        my $user = $orbitals->{$device}->{'user'};
        my $password = $orbitals->{$device}->{'password'};
        my $host = $orbitals->{$device}->{'ip_address'};
        
        # First, disable the trace logging on each Orbital device
        my $retval = disableTrace($host);
        print display_output("Tracing disabled on Orbital", $host) if ($CONFIG->{'VERBOSE'} > 0);
        
        # Second, remove all existing trace files
        my $logs_removed = removeTraceLogs($host, $user, $password);
        
        # Last, enable trace logging
        $retval = enableTrace($host);
        print display_output("Tracing re-enabled on Orbital", $host) if ($CONFIG->{'VERBOSE'} > 0);
    }
}

#
# postTestTrace() - Perform our post-testing environment checks for Orbital trace logs
#                   1. Disable tracing
#                   2. Copy trace logs to local machine
#                   3. Depending on configuration settings, copy trace logs to an ftp server
# Input:  $NETENV - Object reference
# Output: Nothing
sub postTestTrace {
    my $NETENV = shift;
    
    my $orbitals = $NETENV->{'Orbitals'};
    my $timestamp = $NETENV->{'Timestamp'};

    foreach my $device (keys %$orbitals){
        my $user = $orbitals->{$device}->{'user'};
        my $password = $orbitals->{$device}->{'password'};
        my $host = $orbitals->{$device}->{'ip_address'};
        
        # First, disable the trace logging on each Orbital device
        my $retval = disableTrace($host);
        
        # Next, check if a test failure occurred, if so, we automatically capture the trace log. Also, check if
        # the 'Trace' option has been set in the configuration file. If so, we automatically capture the trace log
        my $captured_log = "false";
        if (($NETENV->{'TestStatus'} eq "fail") || ($CONFIG->{'TRACE'} == 1)) {
            $captured_log = getTraceLogs($host, $device, $user, $password, $timestamp);
        }
    }
}

#
# enableTrace() - Enable trace logging on the given Orbital device
# Input:  $host - IP address of the Orbital device that needs logging enabled
# Output: Integer value of zero on success or undef on failure
sub enableTrace {
    my $host = shift;
    
    # Confirm that we have a valid host name
    $host =~ s/\s+//g;
    unless ($host =~ m/^(\d+\.\d+\.\d+\.\d+)$/) {
        return undef;
    }
    
    my $param = "Trace";
    my $value = "1";
    
    DeviceSettings::configure_orbital($host, $param, $value, "false");
    
    return 0;
}

#
# disableTrace() - Disable trace logging on the given Orbital device
# Input:  $host - IP address of the Orbital device that needs logging disabled
# Output: Integer value of zero on success or undef on failure
sub disableTrace {
    my $host = shift;
    
    # Confirm that we have a valid host name
    $host =~ s/\s+//g;
    unless ($host =~ m/^(\d+\.\d+\.\d+\.\d+)$/) {
        return undef;
    }
    
    my $param = "Trace";
    my $value = "0";
    
    DeviceSettings::configure_orbital($host, $param, $value, "false");
    
    return 0;
}

#
# getTraceLogs() - Get the trace logs located on the remote Orbital device
# Input:  $host      - IP address of the remote device
#         $hostname  - Machine name of the remote device
#         $user      - User name to log onto the remote device
#         $password  - Password of the user
#         $timestamp - Timestamp of the current test case instance
# Output: Returns true on success and false on failure
sub getTraceLogs {
    my ($host, $hostname, $user, $password, $timestamp) = @_;
    
    # Confirm that we have a valid user name and password
    $user =~ s/\s+//g;
    $password =~ s/\s+//g;
    
    # Confirm that we have a valid host name
    $host =~ s/\s+//g;
    unless ($host =~ m/^(\d+\.\d+\.\d+\.\d+)$/) {
        return undef;
    }
    
    # Define the following
    my $source      = $CONFIG->{'TRACE_PATH'} . "Trace.0.OrbTrace";
    my $destination = $CONFIG->{'LOG_PATH'} . "trace/Trace.$hostname.$timestamp.log";
    
    print display_output("SCP Trace log: source file", $source) if ($CONFIG->{'VERBOSE'} > 0);
    print display_output("SCP Trace log: destination file", $destination) if ($CONFIG->{'VERBOSE'} > 0);
    
    my $scp = Net::SCP->new( { "host" => $host, "user" => $user } );
    $scp->get($source, $destination) or print display_output("WARNING: Could not copy trace logs", $scp->{errstr});

    # TODO: Last, depending on the configuration settings, copy the trace logs to an ftp server
    #my $ftp_trace_logs = "false";
    #if (($NETENV->{'TestStatus'} eq "fail") || ($CONFIG->{'TRACE_FTP'} == 1)) {
    #    $ftp_trace_logs = ftpTraceLogs($host, $user, $password, $source, $destination);
    #}

    return 0;
}

#
# removeTraceLogs() - Removes all trace logs on the given Orbital device
# Input:  $host     - IP address of the Orbital device
#         $user     - User name to log into the Orbital device
#         $password - Password of the user
# Output: Returns an integer value of zero on success, or undef on failure
sub removeTraceLogs {
    my ($host, $user, $password) = @_;
    
    # Confirm that we have a valid user name and password
    $user =~ s/\s+//g;
    $password =~ s/\s+//g;
    
    # Confirm that we have a valid host name
    $host =~ s/\s+//g;
    unless ($host =~ m/^(\d+\.\d+\.\d+\.\d+)$/) {
        return undef;
    }
    
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
        print display_output("Removing trace log", $file) if ($CONFIG->{'VERBOSE'} > 0);
        $stdout = Net::SSH::ssh_cmd("$user\@$host", $cmd);
        if ($stdout ne "") {
            print display_output("WARNING: Trace log file removal failed for Orbital",$host);
        }
    }
    
    return 0;
}

#
# display_output() - Display the given data in either html or standard output
# Input:  $label - Label for output data
#         $field - Field data associated with label
# Output: String containing output data
sub display_output {
    my ($label,$field) = @_;
    
    my $stdout;  # Our data to display
    
    if (exists($ENV{'HTTP_USER_AGENT'})) {
        $stdout = <<END_OF_OUTPUT;
            <table class="testrun">
            <tr>
                <td class="trLabel">$label</td>
                <td class="trField">$field</td>
            </tr>
            </table>
END_OF_OUTPUT
    }
    else {
        $stdout = "ORBITAL>> $label: $field \n";
    }
    
    return $stdout;
}



1;

__END__

