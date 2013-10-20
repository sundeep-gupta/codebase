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


package IO;

use System::Environment;
use Modules::Config;
use Config::IniFiles;
use Spreadsheet::BasicRead;   # Requirement (install from CPAN)
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

# -----------------------------------------------------------
# MAIN FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input:  None
# Output: Object for I/O module
sub new {

    my $IO = {
        "CONFIG_INI"  => $CONFIG->{'CONFIG_PATH'} . "config.ini",
        "CONFIG_XLS"  => $CONFIG->{'CONFIG_PATH'} . "config.xls",
        "SPREADSHEET" => "",
        "WORKSHEETS"  => [
            "Computers",
            "FileFilterPaths",
            "RegistryFilterPaths",
            "UserProfiles",
            "Commands",
            "Processes"
        ]
    };

    # Create new spreadsheet object
    my $xls = new Spreadsheet::BasicRead($IO->{'CONFIG_XLS'}) || die "Could not open '" . $IO->{'CONFIG_XLS'} . "': $! \n";

    # Set the heading row to 0
    $xls->setHeadingRow(0);

    # Collect our spreadsheet into our object
    $IO->{'SPREADSHEET'} = $xls;

    bless $IO, 'IO';   # Tag object with pkg name
    return $IO;
}

#
# getConfigInfo() - Fetch the configuration INI file and its contents
# Input:  $IO - Object
# Output: $cfg - Hash (associative array) containing the contents of the configuration INI file
sub getConfigInfo {
    my($IO) = shift;
    my $cfg = new Config::IniFiles( -file => $IO->{'CONFIG_INI'} );
    return ($cfg);
}

#
# configureResultsDir() - Configure the directory where the corresponding results will be stored. If the
#                         directory does not exist, then set one up.
# Input:  $IO - object
#         $timestamp - String containing the timestamp of the results and directory extension where the results will be stored
# Output: $results_dir - String containing the location of the current results directory, or undef if we
#         cannot find our results directory
sub configureResultsDir {
    my($IO) = shift;
    my($timestamp) = shift;

    my $results_dir = $IO->getResultsDir();

    # Check if we returned a results directory from our configuration INI
    if (defined($results_dir) && $results_dir ne "") {
        # Check if our results directory actually exists
        if (-d $CONFIG->{'RESULTS_PATH'} . $results_dir) {
            # Do nothing
        }
        # If not, create a new directory
        else {
            $results_dir = $IO->createResultsDir($timestamp);
            # Make sure we returned some value
            unless (defined($results_dir)) {
                print "[" . time() . "]: An error occurred!  There was an undef value returned for IO::createResultsDir().\n";
                logHistory("[" . time() . "]: An error occurred!  There was an undef value returned for IO::createResultsDir().");
                return;
            }
        }
    }
    # If no results directory exists in our INI, then let's create a new directory
    else {
        $results_dir = $IO->createResultsDir($timestamp);
        # Make sure we returned some value
        unless (defined($results_dir)) {
            print "[" . time() . "]: An error occurred!  There was an undef value returned for IO::createResultsDir().\n";
            logHistory("[" . time() . "]: An error occurred!  There was an undef value returned for IO::createResultsDir().");
            return;
        }
    }

    logHistory("[" . time() . "]: The following results directory was created: [$results_dir].");

    return $results_dir;
}

#
# getResultsDir() - Fetch the location of the current results directory (timestamp location)
# Input:  $IO - Object
# Output: $results_dir - String containing the location of the current results directory, or undef if we
#         cannot find our results directory
sub getResultsDir {
    my($IO) = shift;

    # Fetch the location of the last results directory created
    my $cfg = $IO->getConfigInfo();
    my $results_dir = $cfg->val( 'GLOBAL', 'RESULTS_DIR' );

    # If the directory doesn't exist, check if our LAST_RESULTS_DIR exists
    unless (-d $CONFIG->{'RESULTS_PATH'} . $results_dir) {
        $results_dir = $cfg->val( 'GLOBAL', 'LAST_RESULTS_DIR' );
        unless (-d $CONFIG->{'RESULTS_PATH'} . $results_dir) {
            return;
        }
    }

    return ($results_dir);
}

#
# createResultsDir() - Create the directory where our results will be placed
# Input:  $IO        - Object
#         $timestamp - The name of the folder where our current test run results will be stored (represents UNIX timestamp)
# Output: Returns 1 on success or undef on failure
sub createResultsDir {
    my($IO) = shift;
    my($timestamp) = shift;

    # Make sure we passed in a timestamp value
    unless (defined($timestamp)) {
        $timestamp = time();
    }

    my $results_dir = $CONFIG->{'RESULTS_PATH'} . $timestamp;

    # Check if our directory already exists
    if (-d $results_dir) {
        return $timestamp;
    }

    # Make sure we remember where we are
    use Cwd;
    my $oldPath = cwd;
    $oldPath =~ s/\//\\/g;

    # Change into the directory where our results exist
    chdir($CONFIG->{'RESULTS_PATH'}) || die "Cannot chdir to: " . $CONFIG->{'RESULTS_PATH'} . " ($!) \n";

    # Define our current path
    my $currentPath = cwd;
    $currentPath =~ s/\//\\/g;

    # Create our directory
    mkdir($timestamp,0777) || die "Cannot mkdir [$timestamp]: $! \n";

    # Change back to old path when we finish, so relative paths continue to make sense
    chdir($oldPath);

    # Check to make sure our new directory was created successfully
    unless (-d $results_dir) {
        print "[" . time() . "]: An error occurred!  The directory created ($results_dir) could not be found.\n";
        exit;
    }

    $IO->updateConfigIni($timestamp);

    return $timestamp;
}

#
# updateConfigIni() -
# Input:
# Output:
sub updateConfigIni {
    my($IO) = shift;
    my($timestamp) = shift;

    # Fetch the location of the last results directory created
    my $cfg = $IO->getConfigInfo();
    my $results_dir = $cfg->val( 'GLOBAL', 'RESULTS_DIR' );

    # Update our configuration INI values
    $cfg->setval("GLOBAL", "LAST_RESULTS_DIR", $results_dir);
    $cfg->setval("GLOBAL", "RESULTS_DIR", $timestamp);

    # Last, write out our new configuration data
    $cfg->RewriteConfig($IO->{'CONFIG_INI'});

    logEvent("[Event]: Updated the configuration INI file successfully.");
}

#
# getMetrics() - Capture the given performance metrics and output the results to an array
# Input:  $IO - Object
#         $metrics - Strings/Arrays containing our metric values
# Output: Array reference to the performance metrics captured
sub getMetrics {
    my($IO) = shift;
    my(@metrics) = @_;
    my @retval;

    foreach (@metrics) {
        push (@retval, $_);
    }

    return (\@retval);
}

#
# formatMetrics() - Format the performance metrics into a comma-delimited string
# Input:  $IO - Object
#         $metrics - Array reference to the performance metrics captured
# Output: String containing our formatted performance metrics
sub formatMetrics {
    my($IO) = shift;
    my($metrics) = shift;

    # Make sure we have values to format
    unless (defined($metrics)) {
        print "[" . time() . "]: An error occurred!  There were no performance metrics returned for formatting. Exiting....\n";
        exit;
    }

    # Define the following
    my $stdout = "";

    # Iterate through each performance metrics and format the values
    foreach my $stat (@$metrics) {
        $stdout .= $stat . ",";
    }

    $stdout =~ s/(,)$//;

    return ($stdout);
}

#
# formatMetricHeadings() - Formats the headings of the performance metrics
# Input:  $IO - Object
#         $headings - Array reference to the metric headings
# Output: Returns a string containing the formatted metric headings
sub formatMetricHeadings {
    my($IO) = shift;
    my($headings) = shift;

    my @keys = @$headings;

    # Define the following
    my $stdout = "";

    # Iterate through each performance counter and format the values
    for (my $i=0; $i <= ($#keys); $i++) {
        $stdout .= $keys[$i] . ",";
    }

    $stdout =~ s/(,)$//;

    return ($stdout);
}

#
# recordMetrics() - Record the performance metrics to the results file
# Input:  $timestamp -
#         $filename  -
#         $content   - String containing our performance metrics to record
#         $headings  -
# Output: Returns 1 if our file was successfully written, or undef on failure
sub recordMetrics {
    my($IO) = shift;
    my($timestamp) = shift;
    my($filename) =  shift;
    my($content) =   shift;
    my($headings) =  shift;

    # Make sure we have the content
    unless (defined($content)) {
        print "[" . time() . "]: An error occurred!  The content could not be found for the performance metrics. Exiting....\n";
        exit;
    }

    unless (-d $CONFIG->{'RESULTS_PATH'} . $timestamp) {
        my $rv = $IO->createResultsDir($timestamp);
    }

    my $resultsFile = $CONFIG->{'RESULTS_PATH'} . $timestamp . "/" . $filename;

    # Append
    if (-e $resultsFile) {
        open(OUTFILE, ">>$resultsFile") || die "Cannot append to $resultsFile: $!\n";
        print OUTFILE "$content\n";
        close(OUTFILE);
    }
    # Create
    else {
        my $metric_headings = $IO->formatMetricHeadings($headings);

        open(OUTFILE, ">$resultsFile") || die "Cannot create $resultsFile: $!\n";
        print OUTFILE "$metric_headings\n";
        print OUTFILE "$content\n";
        close(OUTFILE);
    }

    return 1;
}

#
# getWorksheetData() - Get a list of all data based upon the given worksheet
# Input:  $IO - Object
#         $worksheetName - String containing the name of the worksheet we want to capture data for
# Output: Array containing a list of all data for the given worksheet
sub getWorksheetData {
    my $IO = shift;
    my $worksheetName = shift;

    # Make sure we have a valid worksheet name
    if (!defined($worksheetName) || $worksheetName eq "") {
        return;
    }

    my $xls = $IO->{'SPREADSHEET'};

    # Reset back to the first worksheet
    $xls->setCurrentSheetNum(0);

    my $numSheets = $xls->numSheets();

    # Print the number of sheets
    print "There are ", $xls->numSheets(), " worksheets in the spreadsheet\n" if ($CONFIG->{'DEBUG'} > 1);

    # Array containing a list all worksheet data to return
    my @worksheet;

    WORKSHEET:
    for (my $i=0; $i < $numSheets; $i++) {
        # Make sure we actually have a valid worksheet
        unless (defined($xls->currentSheetName())) {
            next WORKSHEET;
        }

        # Print the name of the current sheet
        print "Current worksheet name is ", $xls->currentSheetName(), "\n" if ($CONFIG->{'DEBUG'} > 1);

        # Reset back to the first row of the sheet
        $xls->setRow(0);

        if ($xls->currentSheetName eq $worksheetName) {
            # Capture the headers and put into an associative array
            my $heading = $xls->getFirstRow();
            my %headers;
            my $cellCount = 0;
            foreach my $cell (@$heading) {
                print "Header[$cellCount] = $cell \n" if ($CONFIG->{'DEBUG'} > 1);
                $headers{$cell} = $cellCount++;
            }

            # Capture all records of the current sheet
            my $row = 0;
            while (my $data = $xls->getNextRow()) {
                # Define our details associative array
                my %details;

                my @dataArray = @$data;
                my $datasize  = $#dataArray + 1;

                # Capture our computer details
                my $itemCount  = 0;
                my $emptyCount = 0;
                foreach my $item (@$data) {
                    # Check if our values are empty
                    if ($item eq "") {
                        $emptyCount++;
                    }

                    foreach my $header (keys %headers) {
                        if ($headers{$header} eq $itemCount) {
                            $details{$header} = $item;
                            print "KEY = $header \t VALUE = $item \n" if ($CONFIG->{'DEBUG'} > 1);
                        }
                    }
                    $itemCount++;
                }
                if ($datasize == $emptyCount) {
                    last WORKSHEET;
                }

                $worksheet[$row] = \%details;
                $row++;
            }

            last WORKSHEET;
        }

        $xls->getNextSheet();
    }

    return (\@worksheet);
}

#
# fetchCommandParams() - Fetch a list of the parameters to be sent to the command
# Input:  $action - The command type
#         $item   - The item to be affected by the command
#         $option - An optional parameter passed to the command
# Output: Hash reference containing our parameter values
sub fetchCommandParams {
    my $IO = shift;
    my $action = shift;
    my $item = shift;
    my $option = shift;

    # Fetch a list of our parameters to use
    my $paramref;
    my %parameters;
    my @params;

    if ($item =~ m/userdata/i) {
        $paramref = $IO->getWorksheetData("FileFilterPaths");
    }
    elsif ($item =~ m/profile/i) {
        $paramref = $IO->getWorksheetData("UserProfiles");
    }
    elsif ($item =~ m/registry/i) {
        $paramref = $IO->getWorksheetData("RegistryFilterPaths");
    }
    elsif (($action =~ m/monitor/i) && ($option =~ m/start/i)) {
        $paramref = $IO->getMetricCounters($option);
    }
    elsif ($action =~ m/setup/i) {
        $paramref = $IO->getRepositoryConfig();
    }
    elsif ($action =~ m/execute/i) {
        $paramref = $option;
    }
    else {
        if ($option ne "") {
            $paramref = ( "$option" );
        }
    }

    $parameters{'parameters'} = $paramref;
    $parameters{'action'} = $action;
    $parameters{'item'} = $item;

    return (\%parameters);
}

#
# getComputers() - Get a list of all computers that we will communicate with
# Input:  $IO - Object
# Output: Array containing a list of all computers (client machines)
sub getComputers {
    my $IO = shift;

    my $data = $IO->getWorksheetData("Computers");

    return ($data);
}

#
# getFileFilters() - Get a list of all file filters (paths and/or files) to add/delete from client machines
# Input:  $IO - Object
# Output: Array containing a list of all file filters
sub getFileFilters {
    my $IO = shift;

    my $data = $IO->getWorksheetData("FileFilterPaths");

    return ($data);
}

#
# getRegistryFilters() - Get a list of all registry filters (registry keys) to add/delete from client machines
# Input:  $IO - Object
# Output: Array containing a list of all registry filters
sub getRegistryFilters {
    my $IO = shift;

    my $data = $IO->getWorksheetData("RegistryFilterPaths");

    return ($data);
}

#
# getUserProfiles() - Get a list of all user profiles to add/delete from the client machines
# Input:  $IO - Object
# Output: Array containing a list of all user profiles
sub getUserProfiles {
    my $IO = shift;

    my $data = $IO->getWorksheetData("UserProfiles");

    return ($data);
}

#
# getCommands() - Get a list of all commands that are defined within our input file
# Input:  $IO - Object
# Output: Array containing a list of all commands to execute remotely
sub getCommands {
    my $IO = shift;

    my $data = $IO->getWorksheetData("Commands");

    return ($data);
}

#
# getMetricCounters() - Function that fetches all the metric counters and a binary value whether to capture it or not
# Input:  $IO - Object
# Output: Hash reference containing a list of all metric counters to capture.
sub getMetricCounters {
    my $IO = shift;
    my $option = shift;

    # Get our configuration INI data
    my $cfg = $IO->getConfigInfo();

    my $metrics = {
        "OPERATION"        => $option,
        "TEST_TIME_LENGTH" => $cfg->val( 'GLOBAL', 'TEST_TIME_LENGTH' ),
        "CPU_STATS"        => $cfg->val( 'METRICS', 'CPU_STATS' ),
        "MEMORY_STATS"     => $cfg->val( 'METRICS', 'MEMORY_STATS' ),
        "PAGE_SWAP_STATS"  => $cfg->val( 'METRICS', 'PAGE_SWAP_STATS' ),
        "NETWORK_STATS"    => $cfg->val( 'METRICS', 'NETWORK_STATS' ),
        "SOCKET_STATS"     => $cfg->val( 'METRICS', 'SOCKET_STATS' ),
        "DISK_STATS"       => $cfg->val( 'METRICS', 'DISK_STATS' ),
        "DISK_USAGE"       => $cfg->val( 'METRICS', 'DISK_USAGE' ),
        "LOAD_AVG"         => $cfg->val( 'METRICS', 'LOAD_AVG' ),
        "FILE_STATS"       => $cfg->val( 'METRICS', 'FILE_STATS' ),
        "PROCESSES"        => $cfg->val( 'METRICS', 'PROCESSES' ),
        "PROCESS_UTIL"     => $cfg->val( 'METRICS', 'PROCESS_UTIL' ),
        "PROCESSOR_STATS"  => $cfg->val( 'METRICS', 'PROCESSOR_STATS' ),
        "DATABASE_STATS"   => $cfg->val( 'METRICS', 'DATABASE_STATS' ),
        "SYSTEM_INFO"      => $cfg->val( 'METRICS', 'SYSTEM_INFO' )
    };

    return ($metrics);
}

#
# getUserName() - Function that captures the first and last name of the given user.
# Input:  $IO - Object
#         $user_count - Integer representing the row that the user exists in the spreadsheet.
# Output: String containing the last name and first name of the user.
sub getUserName {
    my($IO) = shift;
    my($user_count) = shift;

    my $worksheetName = "UserProfiles";

    # Create new spreadsheet object
    my $xls = $IO->{'SPREADSHEET'};

    # Set the heading row to 0
    $xls->setHeadingRow(0);

    # Reset back to the first worksheet
    $xls->setCurrentSheetNum(0);

    my $numSheets = $xls->numSheets();

    my $last_name = "";
    my $first_name = "";

    WORKSHEET:
    for (my $i=0; $i < $numSheets; $i++) {
        # Make sure we actually have a valid worksheet
        unless (defined($xls->currentSheetName())) {
            next WORKSHEET;
        }

        # Reset back to the first row of the sheet
        $xls->setRow(0);

        if ($xls->currentSheetName eq $worksheetName) {
            $last_name = $xls->cellValue($user_count, 2);
            $first_name = $xls->cellValue($user_count, 3);
            last WORKSHEET;
        }

        $xls->getNextSheet();
    }

    return ($last_name,$first_name);
}

#
# getRepositoryConfig() - Fetch the repository configuration INI file and its contents
# Input:  $IO - Object
# Output: $cfg - Hash (associative array) containing the contents of the repository configuration INI file
sub getRepositoryConfig {
    my($IO) = shift;
    my $config_ini = $CONFIG->{'CONFIG_PATH'} . "repository.ini";
    my $cfg = new Config::IniFiles( -file => $config_ini );

    # We need to scrub the contents of our config INI of any values. The config INI should act more as a template.
    my @sections = $cfg->Sections();
    my %config;

    # Make sure we have sections
    if ($#sections < 0) {
        return;
    }

    SECTIONS:
    foreach my $section (@sections) {
        my @params = $cfg->Parameters($section);
        if ($#sections < 0) {
            next SECTIONS;
        }
        my %temp;
        foreach my $param (@params) {
            $temp{$param} = $cfg->val($section, $param);
        }
        $config{$section} = \%temp;
    }

    return (\%config);
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
# logEvent() - This function logs any data passed to it. The event log contains command events (i.e. read, write, execute).
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
