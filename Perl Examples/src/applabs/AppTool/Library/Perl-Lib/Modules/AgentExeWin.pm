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


package AgentExe;

use System::Environment;
use Modules::Config;
use Modules::Library;
use Modules::Automation;
use Config::IniFiles;
use File::Path;
use Win32::NetAdmin qw(UsersExist UserDelete UserCreate LocalGroupAddUsers GetUsers UserGetAttributes);
use Win32::TieRegistry( Delimiter=>"/" );
use Win32::Service;
use strict;
use Data::Dumper;

srand;    # Random number generator

# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

my $AUTO = Automation::new();

my $USER_PROFILE_PATH = "C:\\Documents and Settings\\";

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input:  None
# Output: Object for Agent Executable (Windows) module
sub new {
    
    my $AGENT = {
        "CONFIG_INI" => $CONFIG->{'CONFIG_PATH'} . "config.ini",
        "SERVICES"   => {
            "agent"   => "AgentDaemon",          # Windows Services:  Service type => Service name
            "monitor" => "AgentMonitor"
        }
    };
    
    bless $AGENT, 'AgentExe';   # Tag object with pkg name
    return $AGENT;
}

#
# execute_command() - Executes the given command through a shell by first parsing the XML to find out which command was issued
# Input:  $xml - XML object
# Output: String that contains an XML formatted string with a response or return value of the given command
sub execute_command {
    my($AGENT) = shift;
    my($xml) = @_;
    
    # Define the following
    my $parameters = $xml->{'parameters'};
    my $action     = $xml->{'action'};
    my $item       = $xml->{'item'};
    my $status;             # Determines whether our command passed or failed
    my @params;             # List of parameters to be sent to our command
    my $retval;             # Return value
    my $retxml;             # XML to return if any

    # Capture our parameter list for the given command
    if (defined($parameters)) {
        if (ref($parameters) eq 'ARRAY') {
            foreach my $param (@$parameters) {
                push(@params, $param);
            }
        }
        else {
            push(@params, $parameters);
        }
    }
    else {
        $status = "fail";
        $retval .= "ERROR: There were no parameters found for the given command: [$action $item].\n";
        logEvent("[Error]: There were no parameters found for the given command: [$action $item].");
    }

    # Determine which command needs to be executed
    if ($action =~ /add/i) {
        if ($item =~ /userdata/i) {
            foreach my $param (@params) {
                my $paramvalue = $param->{'source'};
                if (ref($paramvalue) eq 'ARRAY') {
                    foreach my $temp (@$paramvalue) {
                        my($tmp_status,$tmp_retval) = add_userdata($temp);
                        $status = $tmp_status;
                        $retval .= $tmp_retval;
                    }
                }
                else {
                    my($tmp_status,$tmp_retval) = add_userdata($paramvalue);
                    $status = $tmp_status;
                    $retval .= $tmp_retval;
                }
            }
        }
        elsif ($item =~ /profile/i) {
            foreach my $param (@params) {
                my $paramvalue = $param->{'profile'};
                if (ref($paramvalue) eq 'ARRAY') {
                    foreach my $temp (@$paramvalue) {
                        my($tmp_status,$tmp_retval) = add_user($temp);
                        $status = $tmp_status;
                        $retval .= $tmp_retval;
                    }
                }
                else {
                    my($tmp_status,$tmp_retval) = add_user($paramvalue);
                    $status = $tmp_status;
                    $retval .= $tmp_retval;
                }
            }
        }
        elsif ($item =~ /registry/i) {
            foreach my $param (@params) {
                my $paramvalue = $param->{'regkey'};
                if (ref($paramvalue) eq 'ARRAY') {
                    foreach my $temp (@$paramvalue) {
                        my($tmp_status,$tmp_retval) = add_registry($temp);
                        $status = $tmp_status;
                        $retval .= $tmp_retval;
                    }
                }
                elsif (ref($paramvalue) eq 'HASH') {
                    # NOTE: The registry value name must be unique per key, otherwise older values will be overwritten
                    while (my($pv_key,$pv_value) = each %$paramvalue) {
                        my $tmp_pv = {
                            "content" => $pv_value->{'content'},
                            "value"   => $pv_value->{'value'},
                            "name"    => $pv_key
                        };
                        my($tmp_status,$tmp_retval) = add_registry($tmp_pv);
                        $status = $tmp_status;
                        $retval .= $tmp_retval;
                    }
                }
                else {
                    my($tmp_status,$tmp_retval) = add_registry($paramvalue);
                    $status = $tmp_status;
                    $retval .= $tmp_retval;
                }
            }
        }
        else {
            $status = "fail";
            $retval .= "ERROR: ADD action and item not found: [$action $item].\n";
            logEvent("[Error]: ADD action and item not found: [$action $item].");
        }
    }
    elsif ($action =~ /delete/i) {
        if ($item =~ /userdata/i) {
            foreach my $param (@params) {
                my $paramvalue = $param->{'source'};
                if (ref($paramvalue) eq 'ARRAY') {
                    foreach my $temp (@$paramvalue) {
                        my($tmp_status,$tmp_retval) = delete_userdata($temp);
                        $status = $tmp_status;
                        $retval .= $tmp_retval;
                    }
                }
                else {
                    my($tmp_status,$tmp_retval) = delete_userdata($paramvalue);
                    $status = $tmp_status;
                    $retval .= $tmp_retval;
                }
            }
        }
        elsif ($item =~ /profile/i) {
            foreach my $param (@params) {
                my $paramvalue = $param->{'profile'};
                if (ref($paramvalue) eq 'ARRAY') {
                    foreach my $temp (@$paramvalue) {
                        my($tmp_status,$tmp_retval) = delete_user($temp);
                        $status = $tmp_status;
                        $retval .= $tmp_retval;
                    }
                }
                else {
                    my($tmp_status,$tmp_retval) = delete_user($paramvalue);
                    $status = $tmp_status;
                    $retval .= $tmp_retval;
                }
            }
        }
        elsif ($item =~ /registry/i) {
            foreach my $param (@params) {
                my $paramvalue = $param->{'regkey'};
                if (ref($paramvalue) eq 'ARRAY') {
                    foreach my $temp (@$paramvalue) {
                        my($tmp_status,$tmp_retval) = delete_regkey($temp);
                        $status = $tmp_status;
                        $retval .= $tmp_retval;
                    }
                }
                else {
                    my($tmp_status,$tmp_retval) = delete_regkey($paramvalue);
                    $status = $tmp_status;
                    $retval .= $tmp_retval;
                }
            }
        }
        else {
            $status = "fail";
            $retval .= "ERROR: DELETE action and item not found: [$action $item].\n";
            logEvent("[Error]: DELETE action and item not found: [$action $item].");
        }
    }
    elsif ($action =~ /copy/i) {
        if ($item =~ /userdata/i) {
            foreach my $param (@params) {
                my $paramvalue = $param->{'share'};
                if (ref($paramvalue) eq 'ARRAY') {
                    foreach my $temp (@$paramvalue) {
                        my($tmp_status,$tmp_retval) = copy_userdata($temp);
                        $status = $tmp_status;
                        $retval .= $tmp_retval;
                    }
                }
                else {
                    my($tmp_status,$tmp_retval) = copy_userdata($paramvalue);
                    $status = $tmp_status;
                    $retval .= $tmp_retval;
                }
            }
        }
        else {
            $status = "fail";
            $retval .= "ERROR: COPY action and item not found: [$action $item].\n";
            logEvent("[Error]: COPY action and item not found: [$action $item].");
        }
    }
    elsif ($action =~ /monitor/i) {
        if ($item =~ /performance/i) {
            foreach my $param (@params) {
                my $paramvalue = $param->{'operation'};
                if ($paramvalue =~ /start/i) {
                    my($tmp_status,$tmp_retval) = service_stop_start($AGENT->{'SERVICES'}->{'monitor'});
                    $status = $tmp_status;
                    $retval .= $tmp_retval;
                }
                elsif ($paramvalue =~ /stop/i) {
                    my($tmp_status,$tmp_retval) = service_stop_start($AGENT->{'SERVICES'}->{'monitor'});
                    $status = $tmp_status;
                    $retval .= $tmp_retval;
                }
            }
        }
        else {
            $status = "fail";
            $retval .= "ERROR: MONITOR action and item not found: [$action $item].\n";
            logEvent("[Error]: MONITOR action and item not found: [$action $item].");
        }
    }
    elsif ($action =~ /collect/i) {
        if ($item =~ /metrics/i) {
            foreach my $param (@params) {
                my $paramvalue = $param->{'collection'};
                my($tmp_xml,$tmp_status,$tmp_retval) = collect_metrics($paramvalue);
                $status = $tmp_status;
                $retval .= $tmp_retval;
                $retxml .= $tmp_xml;
            }
        }
        else {
            $status = "fail";
            $retval .= "ERROR: COLLECT action and item not found: [$action $item].\n";
            logEvent("[Error]: COLLECT action and item not found: [$action $item].");
        }
    }
    elsif ($action =~ /execute/i) {
        if ($item =~ /command/i) {
            foreach my $param (@params) {
                # Execute the given command
                my($tmp_status,$tmp_retval) = $AUTO->runCmdlineProgram($param);
                $status = $tmp_status;
                $retval .= $tmp_retval;
            }
        }
        else {
            $status = "fail";
            $retval .= "ERROR: EXECUTE action and item not found: [$action $item].\n";
            logEvent("[Error]: EXECUTE action and item not found: [$action $item].");
        }
    }
    elsif ($action =~ /setup/i) {
        if ($item =~ /configuration/i) {
            foreach my $param (@params) {
                # Create a new repository configuration INI file
                my($tmp_status,$tmp_retval) = $AUTO->writeConfigIni();
                $status = $tmp_status;
                $retval .= $tmp_retval;
            }
        }
        else {
            $status = "fail";
            $retval .= "ERROR: SETUP action and item not found: [$action $item].\n";
            logEvent("[Error]: SETUP action and item not found: [$action $item].");
        }
    }
    elsif ($action =~ /capture/i) {
        if ($item =~ /screenshot/i) {
            foreach my $param (@params) {
                # Capture a screenshot of the client machine's current activity
                my($tmp_status,$tmp_retval) = $AUTO->captureScreenshot();
                $status = $tmp_status;
                $retval .= $tmp_retval;
            }
        }
        else {
            $status = "fail";
            $retval .= "ERROR: CAPTURE action and item not found: [$action $item].\n";
            logEvent("[Error]: CAPTURE action and item not found: [$action $item].");
        }
    }
    else {
        $status = "fail";
        $retval .= "ERROR: Windows command not found: [$action $item].\n";
        logEvent("[Error]: Windows command not found: [$action $item].");
    }
    
    return ($retxml,$retval,$status);
}

#
# parse_reg_key() - Interpolates the given registry key with the perl module root path
# Input:  $regkey - String containing our registry key
# Output: String containing our newly interpolated registry key
sub parse_reg_key {
    my $regkey = shift;
    
    # Interpolate our root keys with perl mod variables
    if ($regkey =~ /HKEY_CLASSES_ROOT/) {
        $regkey =~ s/HKEY_CLASSES_ROOT/Classes/;
    }
    elsif ($regkey =~ /HKEY_CURRENT_USER/) {
        $regkey =~ s/HKEY_CURRENT_USER/CUser/;
    }
    elsif ($regkey =~ /HKEY_LOCAL_MACHINE/) {
        $regkey =~ s/HKEY_LOCAL_MACHINE/LMachine/;
    }
    elsif ($regkey =~ /HKEY_USERS/) {
        $regkey =~ s/HKEY_USERS/Users/;
    }
    elsif ($regkey =~ /HKEY_PERFORMANCE_DATA/) {
        $regkey =~ s/HKEY_PERFORMANCE_DATA/PerfData/;
    }
    elsif ($regkey =~ /HKEY_CURRENT_CONFIG/) {
        $regkey =~ s/HKEY_CURRENT_CONFIG/CConfig/;
    }
    elsif ($regkey =~ /HKEY_DYN_DATA/) {
        $regkey =~ s/HKEY_DYN_DATA/DynData/;
    }
    else {
        logEvent("[Error]: Registry key is not defined [$regkey].");
        print "ERROR: Registry key is not defined [$regkey]. Exiting.....\n" if ($CONFIG->{'DEBUG'} > 0);
    }
    
    return ($regkey);
}

#
# add_registry() - Add the given registry key or value and add any upper hierarchical levels as well
# Input:  $registryref - Hash reference or string containing the registry key/value to add
# Output: Strings containing the status (pass/fail) and output data
sub add_registry {
    my $registryref = shift;
    
    my $status;       # Status (pass/fail)
    my $retval;       # Value to return
    my $regkey;       # Registry key
    my $regvalname;   # Registry value name
    my $regvalue;     # Registry value
    my @create;       # List of upper level registry keys to create before our main key
    
    # If the reference is a hash, then we have a registry key and value
    if (ref($registryref) eq 'HASH') {
        $regkey = parse_reg_key($registryref->{'content'});
        $regvalname = $registryref->{'name'};
        $regvalue = $registryref->{'value'};
    }
    # Otherwise we only have a registry key
    else {
        $regkey = parse_reg_key($registryref);
    }
    
    unless ($regkey =~ /\/$/) {
        $regkey .= "/";
    }
    
    # Check to make sure all upper keys exist before we create our key
    my @regkey_list = split(/\//, $regkey);
    my @reverse_list = reverse(@regkey_list);
    for (my $i=0; $i <= ($#reverse_list); $i++) {
        last if ($i == ($#reverse_list));
        my @current_list = @regkey_list;
        
        # remove N elements from the end of the array
        my $N = $i + 1;
        splice(@current_list, -$N);
        my $keypath = join("/", @current_list);
        
        # Create our object
        my $regobj = $Registry->{$keypath};
        unless (defined($regobj)) {
            # Since our key doesn't yet exist, we need to add it to our array
            unless ($keypath =~ /\/$/) {
                $keypath .= "/";
            }
            logEvent("[Event]: The registry key [$keypath] doesn't yet exist. Adding to array.....") if ($CONFIG->{'LOG'} > 1);
            push (@create, $keypath);
        }
    }
    
    # Add our initial registry key
    my $regobj = $Registry->{$regkey};
    unless (defined($regobj)) {
        logEvent("[Event]: The registry key [$regkey] doesn't yet exist. Adding to array.....") if ($CONFIG->{'LOG'} > 1);
        unshift (@create, $regkey);
    }
    
    # If there are no keys to create, then return
    if ($#create < 0) {
        logEvent("[Event]: The registry key [$regkey] already exists. Skipping....");
        return ("pass", "The registry key [$regkey] already exists.\n");
    }
    
    # Now, create all keys that need to be created (including upper level hierarchical keys)
    my @reverse = reverse(@create);
    for (my $j=0; $j <= ($#reverse); $j++) {
        my $create_key = $reverse[$j];
        my $values;
        # If we are at our end key, then check if there are any registry values to add
        if (($j == $#reverse) && (defined($regvalname))) {
            $values = { $regvalname => $regvalue };
        }
        
        # Create our new registry key (and values if they exist)
        if (defined($values)) {
            $Registry->{$create_key}= $values;
        }
        else {
            $Registry->{$create_key}= { };
        }
        
        $status = "pass";
        $retval .= "Created new registry key [$create_key].\n";
        $retval .= "Registry values: [" . ((defined($values)) ? "$regvalname=$regvalue" : "None") . "]\n";
        
        logEvent("[Event]: Creating registry key: [$create_key].");
        logEvent("[Event]: Assigning registry value name: [$regvalname].");
        logEvent("[Event]: Assigning registry value: [$regvalue].");
    }
    
    return ($status,$retval);
}

#
# delete_regkey() - Deletes the given registry key and recursively deletes all subkeys
# Input:  $key - String containing the registry key to delete
# Output: Strings containing the status (pass/fail) and output data
sub delete_regkey {
    my $key = shift;
    
    unless ($key =~ /\/$/) {
        $key .= "/";
    }

    my $status;  # Status (pass/fail)
    my $retval;  # Value to return
    
    # Interpolate our root key with a perl module variable
    $key = parse_reg_key($key);
    
    # Fetch a list of all subkeys if they exist
    my $regkey = $Registry->{$key};
    unless (defined($regkey)) {
        $status = "fail";
        $retval = "Can't read registry key [$key].... Skipping..... \n";
        logEvent("[Error]: Cannot read registry key: [$key]. Skipping....");
        return ($status,$retval);
    }
    my @keylist= $regkey->SubKeyNames();
    
    # Determine if we need to delete any subkeys
    if ($#keylist < 0) {
        $status = "pass";
        $retval = "Deleted the registry key [$key].\n";
        my $old = delete $Registry->{$key};
        logEvent("[Event]: Deleted the registry key: [$key].");
    }
    else {
        $status = "pass";
        $retval = "Deleted the registry key [$key] and all subkeys.\n";
        recursive_regkey_delete($regkey);
        my $old = delete $Registry->{$key};
        logEvent("[Event]: Deleted the registry key [$key] and all subkeys.");
    }
    
    return ($status,$retval);
}

#
# recursive_regkey_delete() - Recursively delete a registry key and all subkeys
# Input:  $key - Object reference to our registry key
# Output: Nothing
sub recursive_regkey_delete {
    my $key = shift;
    
    # Search recursively for all registry subkeys from the given key
    if (keys %{$key}) {
        foreach my $sub (%{$key}) {
            next unless (defined($sub));
            next unless $sub =~ /\\/;
            recursive_regkey_delete($key->{$sub}) if $sub =~ /\\$/;
            my $old = delete $key->{$sub};
        }
    }
}

#
# add_userdata() - Dynamically generates user data in a specific location with a given file count and file size
# Input:  Hash reference containing our user data, including destination path, file count and file size
# Output: Strings containing the result status (pass/fail) and any verbose information
sub add_userdata {
    my($userdata) = shift;
    
    # Define the following
    my $default_user_path = "C:/Documents and Settings/";
    my $status;
    my $retval;
    
    # Define our user data attributes
    my $dest_path  = $userdata->{'location'};
    my $file_count = $userdata->{'file_count'};
    my $file_size  = $userdata->{'file_size'};
    my $file_ext   = (defined($userdata->{'file_ext'})) ? $userdata->{'file_ext'} : "txt";
    my $file_datatype = (defined($userdata->{'file_datatype'})) ? $userdata->{'file_datatype'} : "strings";
    unless ($dest_path =~ /\/$/) {
        $dest_path .= "/";
    }
    
    $file_size =~ s/\s+//;
    $file_size =~ tr/[a-z]/[A-Z]/;
    
    # Log start time
    my $startTime = time();
    
    # Check to see if we are creating data for each USER profile. If so, create it
    if ($dest_path =~ m/\$USER/) {
        # Define a temporary variable for interpolation
        my $temp_path = $dest_path;
        $temp_path =~ s/\$USER//;
        
        # First, fetch a list of all users that currently exist on the machine
        my $tmp_current_users = get_users();
        my @current_users = @$tmp_current_users;
        
        for (my $j=0; $j <= ($#current_users); $j++) {
            my $local_user = $current_users[$j];
            my $local_user_path = $default_user_path . $local_user;
            my $destination = $local_user_path . $temp_path;
            
            # Check if our destination path exists, if not create it
            if (-d $destination) {
                $retval .= "The destination path [$destination] already exists. Skipping....\n";
                logEvent("[Event]: The destination path [$destination] already exists. Skipping....");
            }
            else {
                my($tmp_status,$tmp_retval) = create_directory($destination);
                $status = $tmp_status;
                $retval .= $tmp_retval;
                if ($status eq "fail") {
                    return ($status,$retval);
                }
            }
            
            # Create all of our files with the given file size
            for (my $i=0; $i < $file_count; $i++) {
                # Define our output file
                my $filename = $destination . "file_$i." . $file_ext;
                my($tmp_status,$tmp_retval) = generate_file($filename,$file_size,$file_datatype);
                if ($tmp_status eq "fail") {
                    return ($tmp_status,$tmp_retval);
                }
            }
        }
    }
    else {
        # Define our destination path
        $dest_path = "C:/" . $dest_path;
        
        # Check if our destination path exists, if not create it
        if (-d $dest_path) {
            $retval .= "The destination path [$dest_path] already exists. Skipping....\n";
            logEvent("[Event]: The destination path [$dest_path] already exists. Skipping....");
        }
        else {
            my($tmp_status,$tmp_retval) = create_directory($dest_path);
            $status = $tmp_status;
            $retval .= $tmp_retval;
            if ($status eq "fail") {
                return ($status,$retval);
            }
        }
        
        # Create all of our files with the given file size
        for (my $i=0; $i < $file_count; $i++) {
            # Define our output file
            my $filename = $dest_path . "file_$i." . $file_ext;
            my($tmp_status,$tmp_retval) = generate_file($filename,$file_size,$file_datatype);
            if ($tmp_status eq "fail") {
                return ($tmp_status,$tmp_retval);
            }
        }
    }
    
    # Log end time
    my $endTime = time();
    my $elapsedTime = $endTime - $startTime;
    
    $status = "pass";
    $retval .= "Created $file_count $file_size file(s) successfully in $elapsedTime (secs.).\n";
    logEvent("[Event]: Created $file_count $file_size file(s) successfully in $elapsedTime (secs.).");
    
    return ($status,$retval);
}

#
# delete_userdata() - Deletes the given file or folder on the client machine
# Input:  $userdata - String containing the file or folder to be deleted
# Output: Strings containing the result status (pass/fail) and any verbose information
sub delete_userdata {
    my ($userdata) = shift;
    
    # Define the following
    my $default_user_path = "C:/Documents and Settings/";
    my $status;
    my $retval;
    
    # Check to see if we are deleting data for each USER profile. If so, delete it
    if ($userdata =~ m/\$USER/) {
        # Define a temporary variable for interpolation
        my $temp_path = $userdata;
        $temp_path =~ s/\$USER//;
        
        # First, fetch a list of all users that currently exist on the machine
        my $tmp_current_users = get_users();
        my @current_users = @$tmp_current_users;
        
        for (my $j=0; $j <= ($#current_users); $j++) {
            my $local_user = $current_users[$j];
            my $local_user_path = $default_user_path . $local_user;
            my $destination = $local_user_path . $temp_path;
            
            # Check if userdata is a file, if so delete it
            if (-f $destination) {
                unlink($destination) or return("fail", "ERROR: Can't delete file $destination: $!\n");
                $status = "pass";
                $retval .= "The file [$destination] was successfully deleted.\n";
                logEvent("[Event]: The file [$destination] was successfully deleted.");
            }
            # Else if the userdata is a folder, recursively delete the userdata underneath it
            elsif (-d $destination) {
                my $files_deleted = rmtree($destination);
                $status = "pass";
                $retval .= "There were $files_deleted directories/files deleted from the root directory [$destination]\n";
                logEvent("[Event]: There were $files_deleted directories/files deleted from the root directory [$destination].");
            }
            # Else, skip
            else {
                $status = "pass";
                $retval .= "The file/folder [$destination] does not exist. Skipping.....\n";
                logEvent("[Event]: The file/folder [$destination] does not exist. Skipping.....");
            }
        }
    }
    else {
        # Define our destination path
        $userdata = "C:/" . $userdata;
        
        # Check if userdata is a file, if so delete it
        if (-f $userdata) {
            unlink($userdata) or return("fail", "ERROR: Can't delete file $userdata: $!\n");
            $status = "pass";
            $retval .= "The file [$userdata] was successfully deleted.\n";
            logEvent("[Event]: The file [$userdata] was successfully deleted.");
        }
        # Else if the userdata is a folder, recursively delete the userdata underneath it
        elsif (-d $userdata) {
            my $files_deleted = rmtree($userdata);
            $status = "pass";
            $retval .= "There were $files_deleted directories/files deleted from the root directory [$userdata]\n";
            logEvent("[Event]: There were $files_deleted directories/files deleted from the root directory [$userdata].");
        }
        # Else, skip
        else {
            $status = "pass";
            $retval .= "The file/folder [$userdata] does not exist. Skipping.....\n";
            logEvent("[Event]: The file/folder [$userdata] does not exist. Skipping.....");
        }
    }
    
    return ($status,$retval);
}

#
# copy_userdata() - Copy user data from a source location (located remotely) to a destination location (located locally)
# Input:  Hash reference containing our user data, including source and destination paths
# Output: Strings containing the result status (pass/fail) and any verbose information
sub copy_userdata {
    my($userdata) = shift;
    
    # Define the following
    my $default_user_path = "C:/Documents and Settings/";
    my $status;
    my $retval;
    
    # Define our user data attributes
    my $dest_path   = $userdata->{'destination'};
    my $source_path = $userdata->{'source'};
    my $source_ip   = $userdata->{'source_ip'};
    my $username    = $userdata->{'username'};
    my $password    = $userdata->{'password'};
    unless ($dest_path =~ /\/$/) {
        $dest_path .= "/";
    }
    unless ($source_path =~ /\/$/) {
        $source_path .= "/";
    }
    
    # Log start time
    my $startTime = time();
    
    # Check to see if we are copying data for each USER profile. If so, copy it
    if ($dest_path =~ m/\$USER/) {
        # Define a temporary variable for interpolation
        my $temp_path = $dest_path;
        $temp_path =~ s/\$USER//;
        
        # First, close all open connections to the server
        # NOTE: Using the backtick operator captures the output instead of printing it to the screen
        my $command = "net use * /delete /y";
        my @output = `$command`;
        my $rv = join("", @output);
        $rv =~ s/^\s+//g;
        $rv =~ s/\s+$//g;
        
        # Open our network share
        $command = "net use x: \\\\$source_ip\\repository /USER:$username $password";
        @output = `$command`;
        $rv = join("", @output);
        $rv =~ s/^\s+//g;
        $rv =~ s/\s+$//g;
        logEvent("[Event]: $command");
        
        # First, fetch a list of all users that currently exist on the machine
        my $tmp_current_users = get_users();
        my @current_users = @$tmp_current_users;
        
        for (my $j=0; $j <= ($#current_users); $j++) {
            my $local_user = $current_users[$j];
            my $local_user_path = $default_user_path . $local_user;
            my $destination = $local_user_path . $temp_path;
            
            # Check if our destination path exists, if not create it
            unless (-d $destination) {
                my($tmp_status,$tmp_retval) = create_directory($destination);
                $status = $tmp_status;
                $retval .= $tmp_retval;
                if ($status eq "fail") {
                    return ($status,$retval);
                }
            }
            
            # Clean-up our paths
            $source_path =~ s/\//\\/gx;
            $destination =~ s/\//\\/gx;
            
            # Copy our data
            $command = "xcopy /E \"X:\\" . $source_path . "*\" \"" . $destination . "\" /Y";
            @output = `$command`;
            $rv = join("", @output);
            $rv =~ s/^\s+//g;
            $rv =~ s/\s+$//g;
            logEvent("[Event]: $rv");
        }
    }
    else {
        # Define our destination path
        $dest_path = "C:/" . $dest_path;
        
        # Check if our destination path exists, if not create it
        unless (-d $dest_path) {
            my($tmp_status,$tmp_retval) = create_directory($dest_path);
            $status = $tmp_status;
            $retval .= $tmp_retval;
            if ($status eq "fail") {
                return ($status,$retval);
            }
        }
        
        # First, close all open connections to the server
        # NOTE: Using the backtick operator captures the output instead of printing it to the screen
        my $command = "net use * /delete /y";
        my @output = `$command`;
        my $rv = join("", @output);
        $rv =~ s/^\s+//g;
        $rv =~ s/\s+$//g;
        
        # Open our network share
        $command = "net use x: \\\\$source_ip\\repository /USER:$username $password";
        @output = `$command`;
        $rv = join("", @output);
        $rv =~ s/^\s+//g;
        $rv =~ s/\s+$//g;
        logEvent("[Event]: $command");
        
        # Clean-up our paths
        $source_path =~ s/\//\\/gx;
        $dest_path   =~ s/\//\\/gx;
        
        # Copy our data
        $command = "xcopy /E \"X:\\" . $source_path . "*\" \"" . $dest_path . "\" /Y";
        @output = `$command`;
        $rv = join("", @output);
        $rv =~ s/^\s+//g;
        $rv =~ s/\s+$//g;
        logEvent("[Event]: $rv");
    }
    
    # Log end time
    my $endTime = time();
    my $elapsedTime = $endTime - $startTime;
    
    $status = "pass";
    $retval .= "Copied data from [$source_ip] successfully in $elapsedTime (secs.).\n";
    logEvent("[Event]: Copied data from [$source_ip] successfully in $elapsedTime (secs.).");
    
    return ($status,$retval);
}

#
# define_acct_info() - Defines our basic account information configuration parameters
# Input:  $username - User name
#         $password - Password of the user
# Output: Hash reference containing our basic user account info
sub define_acct_info {
    my ($username) = shift;
    my ($password) = shift;
    
    my %Account = (
        "server"      => "",
        "name"        => $username,
        "password"    => $password,
        "passwordAge" => 0,
        "priv"        => 1,              # USER_PRIV_USER (1)
        "homeDir"     => $USER_PROFILE_PATH,
        "comment"     => "",
        "flags"       => 513,            # UF_SCRIPT (512) + UF_NORMAL_ACCOUNT (1)
        "scriptPath"  => ""
    );

    return (\%Account);
}

#
# add_user() - Add the given user to the NT station
# Input:  $user - Hash reference containing basic user information (i.e. username, password, etc.)
# Output: Strings containing the status of whether the user was successfully added (pass/fail) and any output info
sub add_user {
    my ($user) = shift;
    
    # Define the following
    my $status;
    my $retval;
    
    # Define our user configuration parameters
    my $acct = define_acct_info($user->{'username'}, $user->{'password'});
    
    # Check if the user exists, if so we skip the profile
    my $user_exists = UsersExist("", $user->{'username'});
    if ($user_exists eq "") {
        UserCreate(
                   $acct->{'server'}, 
                   $acct->{'name'}, 
                   $acct->{'password'}, 
                   $acct->{'passwordAge'}, 
                   $acct->{'priv'}, 
                   $acct->{'homeDir'} . $acct->{'name'}, 
                   $acct->{'comment'}, 
                   $acct->{'flags'}, 
                   $acct->{'scriptPath'}
        );
        $status = "pass";
        $retval .= "The user [" . $acct->{'name'} . "] was successfully added.\n";
        logEvent("[Event]: The user [" . $acct->{'name'} . "] was successfully added.");
    }
    else {
        $status = "pass";
        $retval .= "The user [" . $acct->{'name'} . "] already exists. Skipping.....\n";
        logEvent("[Event]: The user [" . $acct->{'name'} . "] already exists. Skipping.....");
    }
    
    if ($status eq "pass") {
        LocalGroupAddUsers("", "Users", $acct->{'name'});
        
        # Make our user directory
        my $user_dir = $acct->{'homeDir'} . $acct->{'name'};
        unless (-d $user_dir) {
            mkdir($user_dir, 0777) || print "Error creating home dir: $!\n";
        }
    }
    
    return ($status,$retval);
}

#
# delete_user() - Deletes a user profile including any files/folders in Documents and Settings
# Input:  $user - Hash reference containing our user profile info to delete
# Output: Strings containing our status whether it is a pass or fail, also an additional string containing verbose info
sub delete_user {
    my $user = shift;
    
    my $status;
    my $retval;
    
    # Check if the user exists, if so we delete the profile
    my $user_exists = UsersExist("", $user->{'username'});
    if ($user_exists ne "") {
        my $delete_user = UserDelete("", $user->{'username'});
        if ($delete_user == 1) {
            $status = "pass";
            $retval .= "The user [" . $user->{'username'} . "] was successfully deleted.\n";
            logEvent("[Event]: The user [" . $user->{'username'} . "] was successfully deleted.");
        }
        else {
            $status = "fail";
            $retval .= "An error occurred and the user [" . $user->{'username'} . "] could not be deleted.\n";
            logEvent("[Error]: An error occurred and the user [" . $user->{'username'} . "] could not be deleted.");
        }
    }
    else {
        $status = "pass";
        $retval .= "The user [" . $user->{'username'} . "] was not found. Skipping.....\n";
        logEvent("[Event]: The user [" . $user->{'username'} . "] was not found. Skipping.....");
    }
    
    if ($status eq "pass") {
        # We need to delete the user profile folders
        my $profile_path = $USER_PROFILE_PATH . $user->{'username'};
        
        # Check if the user profile folder exists, if so then recursively delete the data underneath it
        if (-d $profile_path) {
            my $files_deleted = rmtree($profile_path);
        }
    }
    
    return ($status,$retval);
}

#
# get_users() - Returns a list of users that currently exist on the local machine
# Input:  Nothing
# Output: Returns an array listing all users on the local machine
sub get_users {
    # Define our user list to return
    my @local_users;
    
    # Define our exclude list
    my @exclude = (
        "ASPNET"
    );
    
    my @users;
    GetUsers("", 0, \@users);
    
    LOCAL_USERS:
    foreach my $user (@users) {
        # Fetch the user's attributes
        my ($password, $passwordAge, $privilege, $homeDir, $comment, $flags, $scriptPath);
        UserGetAttributes("", $user, $password, $passwordAge, $privilege, $homeDir, $comment, $flags, $scriptPath);
        
        # Filter out SYSTEM users
        unless ($privilege > 0) {
            next LOCAL_USERS;
        }
        
        # Filter out users in our EXCLUDE list
        foreach my $exclude_user (@exclude) {
            if ($user eq $exclude_user) {
                next LOCAL_USERS;
            }
        }
        
        push @local_users, $user;
    }
    
    return (\@local_users);
}

#
# service_stop_start() - Stops/Starts the given Windows service
# Input:  $service - Name of the service to start/stop
# Output: String containing whether the service was successfully started or not
sub service_stop_start {
    my $service = shift;
    
    my $retval;  # Output to return
    my %status;  # Defines our current service status
	
	Win32::Service::GetStatus("", $service, \%status);
	if ($status{CurrentState} eq "4") {
		$retval .= "Stopping service: [$service]....\n";
		Win32::Service::StopService("", $service) or return ("fail", "Failed to stop service: [$service]\n");
        logEvent("[Event]: Stopping service: [$service].");
	}
	else {
		$retval .= "Starting service: [$service]....\n";
		Win32::Service::StartService("", $service) or return ("fail", "Failed to start service: [$service]\n");
        logEvent("[Event]: Starting service: [$service].");
	}
	sleep 5;
	Win32::Service::GetStatus("", $service, \%status);
	if ($status{CurrentState} eq "4") { 
        $retval .= "Service [$service] has started successfully.\n";
        logEvent("[Event]: Service [$service] has started successfully.");
    }
	else {
        $retval .= "Service [$service] has stopped successfully.\n";
        logEvent("[Event]: Service [$service] has stopped successfully.");
    }

    return ("pass", $retval);
}

#
# collect_metrics() - Capture the performance metrics from the remote machine
# Input:  $paramvalue - Parameter value that defines which log files to capture and return
# Output: String on whether capturing the metrics has passed or failed
#         XML string containing all of our metric data OR failure reason
sub collect_metrics {
    my $paramvalue = shift;
    
    # Define the following.
    my $status;
    my $retval;
    my $retxml;
    
    # TODO: First we need to verify that the Monitoring process has ended, if not kill it
    
    # Next, we capture all of the files of the last performance monitoring session
    my $tmp_files = fetch_files($CONFIG->{'AGENT_PATH'} . "Results\\");
    my @files = @$tmp_files;
    
    # Define our last ran performance monitoring session folder
    my $results_folder = $CONFIG->{'AGENT_PATH'} . "Results\\" . $files[$#files] . "\\";
    
    # Capture all metrics files
    my $tmp_result_files = fetch_files($results_folder);
    my @result_files = @$tmp_result_files;
    
    # Make sure we returned some metrics files, otherwise return false
    if ($#result_files < 0) {
        logEvent("[Error]: There were no metrics files to return for folder: $results_folder.");
        return ("fail", "There were no metrics files to return for folder: $results_folder.\n");
    }
    
    # Collect all metric file contents
    foreach my $metric_file (@result_files) {
        my $tmp_metric_file = $results_folder . $metric_file;
        my($tmp_xml,$tmp_status,$tmp_retval) .= return_xml_metrics($tmp_metric_file);
        $status = $tmp_status;
        $retval .= $tmp_retval;
        $retxml .= $tmp_xml;
    }
    
    logEvent("[Event]: Collecting performance metrics for files located in: $results_folder.");
    
    return ($retxml,$status,$retval);
}

#
# return_xml_metrics() - Read the given metrics file and return it's contents as XML
# Input:  $metric_file - String containing the full path and file name of the metrics file
# Output: $status - String containing info on whether our function passed or failed
#         $retval - XML string containing the contents of the given metrics file OR failure reason
sub return_xml_metrics {
    my $metric_file = shift;
    
    unless (defined($metric_file)) {
        logEvent("[Error]: The metrics file ($metric_file) has been moved or is missing.");
        return ("fail","The metrics file ($metric_file) has been moved or is missing.");
    }
    
    # Make sure our file exists
    unless (open INFILE, $metric_file) {
        logEvent("[Error]: The metrics file ($metric_file) could not be found.");
        return ("fail","The metrics file ($metric_file) could not be found.");
    }
    my @contents = <INFILE>;
    close (INFILE);
    
    $metric_file =~ s/(\.\w\w\w)$//i;
    my $xmlout = { "type" => $metric_file, "data" => \@contents };
    
    # Package our metrics data into xml
    my $xs = XML::Simple->new(RootName => 'metric', ForceArray => 1, NoAttr => 1);
    my $xml = $xs->XMLout($xmlout);
    $xml =~ s/\s+$//;
    
    my $status = "pass";
    my $retval = "The metric file ($metric_file) was successfully collected.";

    return ($xml,$status,$retval);
}

#
# fetch_files() - Fetch a list of all files/directories for the given path
# Input:  $path - Full path of the directory to fetch file list from
# Output: Array reference containing our file list
sub fetch_files {
    my $path = shift;
    
    # Make sure we remember where we are
    use Cwd;
    my $old_path = cwd;
    $old_path =~ s/\//\\/g;
    
    # Change into the directory where the results exist
    chdir($path) || die "ERROR: Cannot chdir to: $path ($!)\n";
    
    my $current_path = cwd;
    $current_path =~ s/\//\\/g;
    
    # Files found
    my @files;
    my $filename;
    
    # Read our directory for all files/folders
    opendir(RESULTSDIR, $current_path) or die "ERROR: Couldn't open results directory [$current_path] : $! \n";
    while ( defined ($filename = readdir(RESULTSDIR)) ) {
        next if $filename =~ /^\.\.?$/;     # skip . and ..
        push (@files, $filename);
    }
    closedir(RESULTSDIR);
    
    # Sort our directory
    my @sorted = sort(@files);
    
    return (\@sorted);
}

#
# kill_processes() - Kill the given list of processes
# Input:  $PIDS - Array reference containing a list of all the process IDs to terminate
# Output: Nothing
sub kill_processes {
    my($PIDS) = shift;
    
    # Define the following
    my $path    = $CONFIG->{'AUTO_PATH'} . "Common\\";    # Path/directory of our common tools
    my $command = "pskill.exe -t";                        # Command to kill our process
    
    # Make sure we remember where we are
    use Cwd;
    my $old_path = cwd;
    $old_path =~ s/\//\\/g;
    
    # Change into the directory that our tools scripts exist
    chdir("$path") || die "Cannot chdir to: $path ($!)\n";
    
    my $current_path = cwd;
    $current_path =~ s/\//\\/g;
    
    # Iterate through each process
    foreach my $process (@$PIDS) {
        # NOTE: Using the backtick operator captures the output instead of printing it to the screen
        my @output = `$command $process`;
        my $rv = join("", @output);
        $rv =~ s/^\s+//g;
        $rv =~ s/\s+$//g;
        print "DEBUG>> kill process: [$rv] \n" if ($CONFIG->{'DEBUG'} > 0);
    }
    
    # Change back to old path when we finish, so relative paths continue to make sense
    chdir($old_path);
}

#
# create_directory() - Creates a new directory and any upper level directories as well
# Input:  $directory - Full path of the directory to create
# Output: Strings containing the result status (pass/fail) and any verbose information
sub create_directory {
    my($directory) = shift;
    
    # Define the following
    my $status;
    my $retval;
    my @create;
    
    # Clean up our directory
    $directory =~ s/^C:\///;
    $directory =~ s/\/$//;
    
    # Check to make sure all upper directories exist before we create our user data directory
    my @path_list = split(/\//, $directory);
    my @reverse_list = reverse(@path_list);
    for (my $i=0; $i <= ($#reverse_list); $i++) {
        last if ($i == ($#reverse_list));
        my @current_list = @path_list;
        
        # remove N elements from the end of the array
        my $N = $i + 1;
        splice(@current_list, -$N);
        my $current_path = join("/", @current_list);
        unless ($current_path =~ /\/$/) {
            $current_path .= "/";
        }
        $current_path = "C:/" . $current_path;
        
        # Check if our path exists, if not we add it to our array
        unless (-d $current_path) {
            logEvent("[Event]: The user data directory [$current_path] doesn't yet exist... Adding to array.") if ($CONFIG->{'LOG'} > 1);
            push (@create, $current_path);
        }
    }
    
    $directory = "C:/" . $directory;
    unless ($directory =~ /\/$/) {
        $directory .= "/";
    }
    
    unshift (@create, $directory);
    
    # If there are no directories to create, then return
    if ($#create < 0) {
        logEvent("[Event]: The user data directory [$directory] already exists.");
        return ("pass", "The user data directory [$directory] already exists.\n");
    }
    
    # Now, create all directories that need to be created (including upper level directories)
    my @reverse = reverse(@create);
    for (my $j=0; $j <= ($#reverse); $j++) {
        my $create_path = $reverse[$j];
        
        # Create our new directory
        my $create = mkdir($create_path);
        
        # Did we pass or fail?
        if ($create > 0) {
            $status = "pass";
            $retval .= "Created new user data directory: [$create_path].\n";
            logEvent("[Event]: Created new user data directory: [$create_path].");
        }
        else {
            $status = "fail";
            $retval .= "Failed to create user data directory: [$create_path].\n";
            logEvent("[Error]: Failed to create user data directory: [$create_path].");
            return ($status,$retval);
        }
    }
    
    return ($status,$retval);
}

#
# calculate_file_size() - Calculate the size of the file in MB
# Input:  $size - String containing the numeric value representing the size of the file and unit
# Output: String containing the file size in MB
sub calculate_file_size {
    my($size) = shift;
    
    # Make sure we have units defined
    unless ($size =~ /KB|MB|GB/i) {
        return 0;
    }
    
    # If there is a decimal value for our KB size, then we round down
    if (($size =~ /\./) && ($size =~ /KB/i)) {
        $size =~ s/(\.\d+)//;
    }
    
    my $total_file_size = 0;
    
    # Find our unit and size values
    my $filesize;
    my $unit;
    if ($size =~ /\./) {
        $size =~ /(\d+\.\d+)([a-zA-Z]+)/;
        $filesize = $1;
        $unit = $2;
    }
    else {
        $size =~ /(\d+)([a-zA-Z]+)/;
        $filesize = $1;
        $unit = $2;
    }
    
    if ($unit eq "GB") {
        $total_file_size = ($filesize * 1000) * 102.4;
    }
    elsif ($unit eq "MB") {
        $total_file_size = $filesize * 102.4;
    }
    else {
        $total_file_size = ($filesize / 1000) * 102.4;
    }
    
    return ($total_file_size);
}

#
# generate_file() - Randomly generate a file with unique content based upon a given file size
# Input:  $filename - String containing the name of the file
#         $filesize - String containing the size of the file in either KB, MB or GB
#         $datatype - String containing information on how to create the file, by using strings or individual characters
# Output: Strings containing the result status (pass/fail) and any verbose information
sub generate_file {
    my($filename) = shift;
    my($filesize) = shift;
    my($datatype) = shift;
    
    my $tmp_library = string_library();         # Define our library of words (used to generate files)
    my @LIBRARY = @$tmp_library;
    
    # We will create 10K sections of what will become our file
    my $file_size_build = calculate_file_size($filesize);
    
    # Define the following
    my $string_length;
    my $startval;
    
    # If our file is less than 1 MB, then let's generate our files by the following
    # NOTE:  The string length subtracts 2 from it's value because there is a new line added to the end of each string
    if ($file_size_build < 102.4) {
        $file_size_build = $file_size_build * 10;
        $startval = 1;
        $string_length = 1022;               # Setup our default string length (size = 1KB)
    }
    else {
        $startval = 0;
        $string_length = (1024 * 10) - 2;    # Setup our default string length (size = 10KB)
    }
    
    # Determine if the output file already exists. If so, append to it
    if (-e $filename) {
        open(OUTPUTFILE, ">>$filename") || return("fail","Cannot append to file $filename: $!\n");
    }
    else {
        open(OUTPUTFILE, ">$filename") || return("fail","Cannot create file $filename: $!\n");
    }
    
    # Create our file based upon the data type
    if (defined($datatype) && $datatype eq "strings" && ($file_size_build >= (1024 * 100))) {
        # Build file using strings (list of words)
        my $total_file_size = 0;
        do {
            my $string;
            my $tmp_buffer = 0;
            while ($tmp_buffer < (1024 * 100)) {      # Continue while our string is less than 100KB
                $string .= $LIBRARY[ int( rand(@LIBRARY) ) ] . " ";
                $tmp_buffer = length $string;
            }
            my $tmp_file_size = length $string;
            print OUTPUTFILE "$string\n";
            $total_file_size = $total_file_size + $tmp_file_size;
        } until ($total_file_size > $file_size_build);
    }
    else {
        # Build file using single characters
        for (my $repeat=$startval; $repeat < $file_size_build; $repeat++) {
            my $string;
            my $_rand;
            
            # Include the following alpha-numeric characters (excluding the letters i, I, l, L, o, O)
            my @chars = ("a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "m", "n", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
                         "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                         "A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
                         );
            
            for (my $i=0; $i < $string_length; $i++) {
                $string .= $chars[ int( rand(@chars) ) ];
            }
            
            print OUTPUTFILE "$string\n";
        }
    }
    
    # Closing the test file.
    close(OUTPUTFILE) || return("fail","Cannot close file $filename: $!\n");
    
    return("pass","File [$file_size_build MB] created successfully.\n");
}

#
# logHistory() - This function logs any data passed to it. The history log contains server actions.
# Input:  $content - String containing the content to be logged
# Output: Returns 1 if successful and undef if failed
sub logHistory {
    my($content) = @_;
    
    my $log_file = $CONFIG->{'LOG_PATH'} . $CONFIG->{'LOG_FILE'};
    my $timestamp = fetchDate();
    
    # Make sure our content is defined
    if (defined($content) && ($content ne "")) {
        $content = "[$timestamp]: $content";
    }
    else {
        return;
    }
    
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
    
    return 1;
}

#
# logEvent() - This function logs any data passed to it
# Input:  $content - String containing the content to be logged
# Output: Returns 1 if successful and undef if failed
sub logEvent {
    my($content) = @_;
    
    my $log_file = $CONFIG->{'LOG_PATH'} . $CONFIG->{'EVENT_LOG'};
    my $timestamp = fetchDate();
    
    # Make sure our content is defined
    if (defined($content) && ($content ne "")) {
        $content = "[$timestamp]: $content";
    }
    else {
        return;
    }
    
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
    
    return 1;
}

#
# fetchDate() - This function creates a basic formatted timestamp
# Input:  Nothing
# Output: Returns the local time in the format of: 'MM/DD/YY - HH:MM:SS'
sub fetchDate {
    # Time Information
    my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    $year = $year + 1900;
    $mon  = $mon + 1;
    my $localtime = "$mon/$mday/$year - $hour:$min:$sec";
    return $localtime;
}



1;

__END__

