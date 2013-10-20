#!/usr/bin/perl -w
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.28 $
# Last Modified: $Date: 2005/08/18 23:54:53 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbital/control/cgi-lib/caller.pl,v $
#
####################################################################################
##
##

# Include the following modules
use vars qw($VERSION);
use strict;
use lib qw(/usr/local/lib/perl5/5.8.6 /usr/local/orbital/console/perl-lib);
use Thread;
use Tie::Hash;
use Orbital::Config;
use Orbital::Caller;
use Orbital::Database;
use Orbital::DeviceSettings;
use Orbital::Analysis;
use Orbital::Environment;
use Orbital::Output;
use Data::Dumper;

$VERSION = "8.10.2005";
sub Version { $VERSION; }

# -----------------------------------------------------------------------------
# DO NOT EDIT BELOW LINE
# -----------------------------------------------------------------------------

my $CONFIG = Config::new();

# Define the following settings
my $CONFIG_TEMPLATE = $CONFIG->{'CONFIG_TEMPLATE'};    # Default xml config template name
my $CONFIG_FILE     = $CONFIG->{'CONFIG_FILE'};        # Configuration file for VisualTest scripts
my $BASEPATH        = $CONFIG->{'BASEPATH'};           # Base path of the web server
my $ORBITAL_PATH    = $CONFIG->{'ORBITAL_PATH'};       # Directory of the Orbital Test Tool software package
my $TIMESTAMP       = $CONFIG->create_timestamp();     # Unique session id created per invocation of the test run

my $TestSuiteID;       # Test suite id
my $TestRunValues;     # Test run id values taken from query string or standard input
my @testsuite = ();    # Array of test run id values

# Find out how our script is being called, through a browser or command-line
if (exists($ENV{'REQUEST_METHOD'}) && $ENV{'REQUEST_METHOD'} eq "GET") {
    # Browser:
    use CGI;
    my $query = CGI::new();
    $TestSuiteID = $query->param("TestSuiteID");
    $TestRunValues = $query->param("TestRunID");
    my $testSuite = get_testsuite_details($TestSuiteID);
    
    # Capture a list of all the test runs we want to execute
    if ($TestRunValues =~ /\s+/) {
        @testsuite = split(/\s+/, $TestRunValues);
    }
    else {
        push (@testsuite, $TestRunValues);
    }

    # Output our progress to the browser
    print "Content-Type: text/html\n\n";
    print page_header();
    print progress_bar_header($testSuite->{'Name'}) if ($CONFIG->{'VERBOSE'} < 1);
}
else {
    # Fetch a list of all test suites available
    my $TestSuiteList = get_testsuites();
    my @SuiteIDlist = keys %$TestSuiteList;
    
    # Display header
    print "\n===============================================================\n";
    print " Orbital Test Tool   v.$VERSION\n";
    print "===============================================================\n";
    print display_suite_list($TestSuiteList);
    print "Please select a suite ID:  ";
    SELECT_SUITE:
    while ($TestSuiteID = <>) {
        # Clean all whitespace
        $TestSuiteID =~ s/^\s+//;
        $TestSuiteID =~ s/\s+$//;
        
        # If they type in the letter 'q' or 'quit', we exit
        if ($TestSuiteID =~ /q|quit/i) {
            print "Exiting...... \n\n";
            exit;
        }
        
        # Make sure they enter in a number value only
        if (($TestSuiteID =~ /\D+/g) || ($TestSuiteID eq "")){
            print "Please enter one of the ID values only, or 'q' to quit:  ";
            goto SELECT_SUITE;
        }
        
        # Make sure that one of the values they enter is a valid test suite id
        for (my $i=0; $i <= $#SuiteIDlist; $i++) {
            if ($TestSuiteID == $SuiteIDlist[$i]) {
                last SELECT_SUITE;
            }
        }
        print "Please enter one of the ID values only, or 'q' to quit:  ";
    }
    
    # Fetch a list of all test runs available for the given suite
    my $TestRunList = get_testruns_in_suite($TestSuiteID);
    my @RunIDlist = keys %$TestRunList;
    print display_testrun_list($TestRunList);
    print "Please select the testrun ID(s) you wish to execute:  ";
    
    SELECT_RUNS:
    while ($TestRunValues = <>) {
        # Clean all whitespace
        $TestRunValues =~ s/^\s+//;
        $TestRunValues =~ s/\s+$//;
        
        # If they type in the letter 'q' or 'quit', we exit
        if ($TestRunValues =~ /q|quit/i) {
            print "Exiting...... \n\n";
            exit;
        }
        
        # Put all of the test run id values into an array
        @testsuite = ();
        if ($TestRunValues =~ /\s+/) {
            @testsuite = split(/\s+/, $TestRunValues);
        }
        elsif ($TestRunValues =~ /all/i) {
            push (@testsuite, @RunIDlist);
        }
        else {
            push (@testsuite, $TestRunValues);
        }
        
        # Make sure they enter in a number value only
        my $tmpRunValues = $TestRunValues;
        $tmpRunValues =~ s/\s+//g;
        if (($tmpRunValues =~ /\D+/g) || ($TestRunValues eq "")) {
            print "Please enter one or a list of ID values only, or 'q' to quit:  ";
            goto SELECT_RUNS;
        }
        
        # Make sure that one of the values they enter is a valid test suite id
        RUN_CHECK:
        for (my $i=0; $i <= $#testsuite; $i++) {
            my $runValid = "false";
            
            foreach my $selectedID (@RunIDlist) {
                if ($selectedID == $testsuite[$i]) {
                    $runValid = "true";
                    last;
                }
                else {
                    $runValid = "false";
                }
            }
            
            if ($runValid eq "false") {
                print "Please enter one or a list of ID values only, or 'q' to quit:  ";
                goto SELECT_RUNS;
            }
            if ($i == $#testsuite) {
                last SELECT_RUNS;
            }
        }
        print "Please enter one or a list of ID values only, or 'q' to quit:  ";
    }
}

# Define our progress variables
my $total_progress_size = get_progress_size(\@testsuite);         # Find out how many runs, instances, and computers we have to iterate through
my $progress_size       = 0;                                      # Our current progress size
my $percent_per_loop    = 100 / $total_progress_size;             # Calculate how many percents to advance per loop
my $percent_last        = 0;                                      # Preset variable to remember the percentage of the previous loop
my $percent_now         = 0;                                      # Our current percentage complete
my $runs_left           = @testsuite - 1;   # Find the number of test runs for the given test suite

# Calculate advance in progress percentages (+ test suite invocation)
$percent_now = int (++$progress_size * $percent_per_loop);
progress_bar_mark($percent_now, $percent_last) if ($CONFIG->{'VERBOSE'} < 1 && exists($ENV{'HTTP_USER_AGENT'}));
$percent_last = $percent_now;

# Iterate through all of our test runs
foreach my $TestRunID (@testsuite) {

    # Fetch our test run data (this is returned as a multi-dimensional hash)
    my $testrun = get_testrun_data($TestRunID);
    my $test_group_name = get_testgroup_name($TestRunID);

    # This is a hash of the results of all our test case instances for the given test run/group
    my %testrun_results;

    # This is a hash of our test instance details (includes start time, end time, date, test status, etc.)
    my %instance_details;

    # Find the number of test case instances for the given test run
    my $cases_left = get_testrun_size($TestRunID) - 1;

    # Iterate through each test instance, fetch the settings, and send an xml request
    # to each client and server machine
    # NOTE: $instance_id refers to the 'TestRun_TestCaseInstanceID' in the database
    while(my($instance_id, $instance) = each(%$testrun)) {
        # Fetch all relavent data
        my $test_case_id  = $instance->{'test_case_id'};
        my $test_case     = $instance->{'test_case'};
        my $share         = $instance->{'share'};
        my $clients       = $instance->{'clients'};   # Hash of all clients
        my $servers       = $instance->{'servers'};   # Hash of all servers
        my $orbitals      = $instance->{'orbitals'};  # Hash of all orbital machines
        my $wansim        = $instance->{'wansim'};
        my @CPU_TIMES     = ();                       # Array containing all of our CPU times from each Orbital device
        my @ELAPSED_TIMES = ();                       # Array containing the Visual Test script elapsed times from each client

        # Initialize our Orbital device tracing. We need to turn tracing off, clear out our log files, then turn tracing back on
        my $NETENV = Environment::new($orbitals);
        $NETENV->preTestTrace() if ($CONFIG->{'USE_ORBITALS'} > 0);
        $NETENV->{'Timestamp'} = $TIMESTAMP;

        # Capture CPU time before test execution
        my $CPU = $NETENV->getSystemCPU();
        push (@CPU_TIMES, { "CPU" => $CPU, "Description" => "Pre-Test" });
        
        # Capture the software build for each Orbital device
        my $BUILD = $NETENV->getSystemBuild();
        
        my $server_count = 0;   # Counter that helps us assign VT scripts to server machines
        my $client_count = 0;   # Counter that helps us assign VT scripts to client machines

        $instance->{'instance_id'} = $instance_id;
        $instance->{'test_group_name'} = $test_group_name;
        print testrun_table_header($instance) if ($CONFIG->{'VERBOSE'} > 0);
        print javascript_progress_stats($test_group_name, $runs_left, $test_case, $cases_left) if ($CONFIG->{'VERBOSE'} < 1);

        # Configure our orbitals & wansim
        my $DEVICES = DeviceSettings::new($instance);
        $DEVICES->configure_devices();

        # Format our config.xml file (NOTE: only 1 server & 1 client will be listed per config.xml)
        my $config_xml = package_config($ORBITAL_PATH.$share."/".$CONFIG_TEMPLATE,$instance);

        # Fetch a list of all scripts that need to be run on both client and server machines
        my ($tmp1, $tmp2) = fetch_script_list($ORBITAL_PATH.$share."/".$CONFIG_TEMPLATE,"win");   # TODO: Assuming windows machines for now, need to come up with a
        my @client_scripts = @$tmp1;                                                              #       way of determining which OS we want to use
        my @server_scripts = @$tmp2;

        my $set_count = 1;        # This is our machine set (client/server) count for the current test instance (used as a key for our $set_results hash)
        my %set_results;          # This is a hash of our machine set (client/server) results
        my $etime_count = 0;      # This is the number of elapsed time values captured per instance (only captured for client machines)
        my $tmp_etime_count = 0;  # This allows us to associate threads with their appropriate elapsed time values

        my $start_time = get_time();
        my $today = get_date();

        # Check if the test script needs to be run with concurrent clients
        if ($instance->{'Concurrent'} == 1) {

            # Iterate through each server machine
            while(my($server_name, $server) = each(%$servers)) {

                my $server_ip = $server->{'ip_address'};
                print display_output("Server IP Address",$server_ip) if ($CONFIG->{'VERBOSE'} > 0);

                # Proxy definitions
                my $proxy_ip = $server->{'proxy_ip_address'};
                my $proxy_port = $server->{'proxy_port'};
                print display_output("Proxy Server",$proxy_ip) if ($CONFIG->{'VERBOSE'} > 0 && defined $proxy_ip);
                print display_output("Proxy Port",$proxy_port) if ($CONFIG->{'VERBOSE'} > 0 && defined $proxy_port);

                my $synctime = time() + 120;    # (original was 60 seconds, we're upping it to allow clients a little longer to sync-up)

                # Define our results list for client and server machines
                my @client_results_list;
                my @server_results_list;

                # ------------------------------
                # XML Config: Perform our instance interpolations used by both clients and servers
                # ------------------------------
                my $tmp_config_xml = $config_xml;
                $tmp_config_xml =~ s/__SYNCTIME__/$synctime/;
                $tmp_config_xml = interpolate_machine_data($server,$tmp_config_xml,"server");
                # ------------------------------

                # ------------------------------
                # Server Script: This tells us which script needs to be executed on the server-side
                # ------------------------------
                if ($server_count > $#server_scripts) {
                    $server_count = 0;  # Reset our counter
                }
                my $server_exe = $server_scripts[$server_count++];
                # ------------------------------

                # ------------------------------
                # Server XML Config:
                # ------------------------------
                my $server_config_xml = $tmp_config_xml;
                $server_config_xml =~ s/__SCRIPT_EXE__/$server_exe/;
                # ------------------------------

                # ------------------------------
                # Server Request: Encapsulate our server xml request into a thread
                # ------------------------------
                my $server_machine = {
                    "host" => defined $proxy_ip ? $proxy_ip : $server_ip,
                    "port" => defined $proxy_port ? $proxy_port : "8888",
                    "path" => "/cgi-bin/receiver.pl"
                };
                my $st = Thread->new( \&send_request, $server_config_xml, $server_machine);
                # ------------------------------

                # ------------------------------
                # Server CPU Time: Capture the Orbital CPU time after server executes script
                # ------------------------------
                $CPU = $NETENV->getSystemCPU();
                push (@CPU_TIMES, { "CPU" => $CPU, "Description" => "While Server [$server_ip] Executes" });
                # ------------------------------

                my $thread_count = 0;
                my @thread_list;

                # Iterate through each client machine
                while(my($client_name, $client) = each(%$clients)) {

                    my $client_ip = $client->{'ip_address'};
                    print display_output("Client IP Address",$client_ip) if ($CONFIG->{'VERBOSE'} > 0);

                    # ------------------------------
                    # Client Script: This tells us which script needs to be executed on the client-side
                    # ------------------------------
                    if ($client_count > $#client_scripts) {
                        $client_count = 0;   # Reset our counter
                    }
                    my $client_exe = $client_scripts[$client_count++];
                    # ------------------------------

                    # ------------------------------
                    # Client XML Config:
                    # ------------------------------
                    my $client_config_xml = $tmp_config_xml;
                    $client_config_xml =~ s/__SCRIPT_EXE__/$client_exe/;
                    $client_config_xml = interpolate_machine_data($client,$client_config_xml,"client");
                    # ------------------------------

                    # ------------------------------
                    # Client Request Encapsulate our client xml request into a thread
                    # ------------------------------
                    my $client_machine = {
                        "host" => $client_ip,
                        "port" => "8888",
                        "path" => "/cgi-bin/receiver.pl"
                    };
                    $thread_list[$thread_count++] = Thread->new( \&send_request, $client_config_xml, $client_machine);
                    # ------------------------------
                    
                    # ------------------------------
                    # Client CPU Time: Capture the Orbital CPU time after client executes script
                    # ------------------------------
                    $CPU = $NETENV->getSystemCPU();
                    push (@CPU_TIMES, { "CPU" => $CPU, "Description" => "While Client [$client_ip] Executes" });
                    # ------------------------------
                    
                    # ------------------------------
                    # Elapsed Time Client Data:
                    # ------------------------------
                    $ELAPSED_TIMES[$etime_count++] = { "ip_address" => $client_ip, "elapsed_times" => "" };
                    #-------------------------------
                }

                # Calculate advance in progress percentages (+ client)
                $percent_now = int (++$progress_size * $percent_per_loop);
                progress_bar_mark($percent_now, $percent_last) if ($CONFIG->{'VERBOSE'} < 1 && exists($ENV{'HTTP_USER_AGENT'}));
                $percent_last = $percent_now;

                # Harvest our threads
                for (my $i=0; $i <= $#thread_list; $i++) {
                    # Fetch our client thread and any output (We assume the results are complete, since we've gotten this far)
                    my @retval = $thread_list[$i]->join();
                    my $client_response = join("", @retval);

                    # Find our results for the current thread
                    my($tmp_result,$tmp_reason) = result_status($client_response);

                    print display_output("Client Visual Test Result",$tmp_result) if ($CONFIG->{'VERBOSE'} > 0);
                    if (defined($tmp_reason) && $tmp_result eq "fail") {
                        print display_output("Client Visual Test Failure Reasons",$tmp_reason) if ($CONFIG->{'VERBOSE'} > 0);
                    }

                    # Store our client responses in an array
                    push @client_results_list, $client_response;
                    
                    # Capture the elapsed time values
                    my $etime = capture_elapsed_times($client_response);
                    $ELAPSED_TIMES[$tmp_etime_count++]->{'elapsed_times'} = $etime;
                }

                # Fetch our server thread
                my @server_retval = $st->join();
                my $server_response = join("", @server_retval);
                
                my($tmp_result,$tmp_reason) = result_status($server_response);

                print display_output("Server Visual Test Result",$tmp_result) if ($CONFIG->{'VERBOSE'} > 0);
                if (defined($tmp_reason) && $tmp_result eq "fail") {
                    print display_output("Server Visual Test Failure Reasons",$tmp_reason) if ($CONFIG->{'VERBOSE'} > 0);
                }

                # Store our server responses in an array
                push @server_results_list, $server_response;

                $set_results{$set_count++} = build_machine_list_hash(\@client_results_list,\@server_results_list);
            }
        
            # Calculate advance in progress percentages (+ server)
            $percent_now = int (++$progress_size * $percent_per_loop);
            progress_bar_mark($percent_now, $percent_last) if ($CONFIG->{'VERBOSE'} < 1 && exists($ENV{'HTTP_USER_AGENT'}));
            $percent_last = $percent_now;
        }
        # Else, the test script will be executed by client/server pairs, or linearly
        else {
            # Iterate through each server machine
            while(my($server_name, $server) = each(%$servers)) {

                my $server_ip = $server->{'ip_address'};
                print display_output("Server IP Address",$server_ip) if ($CONFIG->{'VERBOSE'} > 0);

                # Proxy definitions
                my $proxy_ip = $server->{'proxy_ip_address'};
                my $proxy_port = $server->{'proxy_port'};
                print display_output("Proxy Server",$proxy_ip) if ($CONFIG->{'VERBOSE'} > 0 && defined $proxy_ip);
                print display_output("Proxy Port",$proxy_port) if ($CONFIG->{'VERBOSE'} > 0 && defined $proxy_port);

                my $synctime = time() + 120;

                # Iterate through each client machine
                while(my($client_name, $client) = each(%$clients)) {

                    my $client_ip = $client->{'ip_address'};
                    print display_output("Client IP Address",$client_ip) if ($CONFIG->{'VERBOSE'} > 0);

                    # Define our results list for client and server machines
                    my @client_results_list;
                    my @server_results_list;

                    # ------------------------------
                    # XML Config: Perform our instance interpolations used by both clients and servers
                    # ------------------------------
                    my $tmp_config_xml = $config_xml;
                    $tmp_config_xml =~ s/__SYNCTIME__/$synctime/;
                    $tmp_config_xml = interpolate_machine_data($server,$tmp_config_xml,"server");
                    $tmp_config_xml = interpolate_machine_data($client,$tmp_config_xml,"client");
                    # ------------------------------

                    # ------------------------------
                    # Server Script: This tells us which script needs to be executed on the server-side
                    # ------------------------------
                    if ($server_count > $#server_scripts) {
                        $server_count = 0;  # Reset our counter
                    }
                    my $server_exe = $server_scripts[$server_count++];
                    # ------------------------------

                    # ------------------------------
                    # Server XML Config:
                    # ------------------------------
                    my $server_config_xml = $tmp_config_xml;
                    $server_config_xml =~ s/__SCRIPT_EXE__/$server_exe/;
                    # ------------------------------

                    # ------------------------------
                    # Server Request: Encapsulate our server xml request into a thread
                    # ------------------------------
                    my $server_machine = {
                        "host" => defined $proxy_ip ? $proxy_ip : $server_ip,
                        "port" => defined $proxy_port ? $proxy_port : "8888",
                        "path" => "/cgi-bin/receiver.pl"
                    };
                    my $t = Thread->new( \&send_request, $server_config_xml, $server_machine);
                    # ------------------------------

                    # ------------------------------
                    # Server CPU Time: Capture the Orbital CPU time after server executes script
                    # ------------------------------
                    $CPU = $NETENV->getSystemCPU();
                    push (@CPU_TIMES, { "CPU" => $CPU, "Description" => "While Server [$server_ip] Executes" });
                    # ------------------------------
                    
                    # ------------------------------
                    # Client Script: This tells us which script needs to be executed on the client-side
                    # ------------------------------
                    if ($client_count > $#client_scripts) {
                        $client_count = 0;   # Reset our counter
                    }
                    my $client_exe = $client_scripts[$client_count++];
                    # ------------------------------

                    # ------------------------------
                    # Client XML Config:
                    # ------------------------------
                    my $client_config_xml = $tmp_config_xml;
                    $client_config_xml =~ s/__SCRIPT_EXE__/$client_exe/;
                    # ------------------------------

                    # ------------------------------
                    # Client Request: Encapsulate our client xml request into a thread
                    # ------------------------------
                    my $client_machine = {
                        "host" => $client_ip,
                        "port" => "8888",
                        "path" => "/cgi-bin/receiver.pl"
                    };
                    my $client_response = send_request($client_config_xml,$client_machine);
                    push @client_results_list, $client_response;
                    # ------------------------------

                    # ------------------------------
                    # Client CPU Time: Capture the Orbital CPU time after client executes script
                    # ------------------------------
                    $CPU = $NETENV->getSystemCPU();
                    push (@CPU_TIMES, { "CPU" => $CPU, "Description" => "While Client [$client_ip] Executes" });
                    # ------------------------------

                    # ------------------------------
                    # Elapsed Time Client Data:
                    # ------------------------------
                    my $etime = capture_elapsed_times($client_response);
                    $ELAPSED_TIMES[$etime_count++] = { "ip_address" => $client_ip, "elapsed_times" => $etime };
                    #-------------------------------

                    # Fetch our server thread and any output (We assume the results are complete, since we've gotten this far)
                    my @retval = $t->join();
                    my $server_response = join("", @retval);
                    push @server_results_list, $server_response;

                    my $tmp_result;
                    my $tmp_reason;
                    ($tmp_result,$tmp_reason) = result_status($server_response);

                    print display_output("Server Visual Test Result",$tmp_result) if ($CONFIG->{'VERBOSE'} > 0);
                    if (defined($tmp_reason) && $tmp_result eq "fail") {
                        print display_output("Server Visual Test Failure Reasons",$tmp_reason) if ($CONFIG->{'VERBOSE'} > 0);
                    }

                    ($tmp_result,$tmp_reason) = result_status($client_response);

                    print display_output("Client Visual Test Result",$tmp_result) if ($CONFIG->{'VERBOSE'} > 0);
                    if (defined($tmp_reason) && $tmp_result eq "fail") {
                        print display_output("Client Visual Test Failure Reasons",$tmp_reason) if ($CONFIG->{'VERBOSE'} > 0);
                    }

                    # Unpack our responses from xml and create our results data structure
                    $set_results{$set_count++} = build_machine_list_hash(\@client_results_list,\@server_results_list);
                    
                    # Calculate advance in progress percentages (+ client)
                    $percent_now = int (++$progress_size * $percent_per_loop);
                    progress_bar_mark($percent_now, $percent_last) if ($CONFIG->{'VERBOSE'} < 1 && exists($ENV{'HTTP_USER_AGENT'}));
                    $percent_last = $percent_now;
                }
                
                # Calculate advance in progress percentages (+ server)
                $percent_now = int (++$progress_size * $percent_per_loop);
                progress_bar_mark($percent_now, $percent_last) if ($CONFIG->{'VERBOSE'} < 1 && exists($ENV{'HTTP_USER_AGENT'}));
                $percent_last = $percent_now;
            }
        }

        my $end_time = get_time();
        
        # Capture CPU time after test execution
        $CPU = $NETENV->getSystemCPU();
        push (@CPU_TIMES, { "CPU" => $CPU, "Description" => "Post-Test" });
        
        # Package our test instance details
        $instance_details{$instance_id} = {
            "start_time"    => $start_time,
            "end_time"      => $end_time,
            "date"          => $today,
            "timestamp"     => $TIMESTAMP,
            "test_suite_id" => $TestSuiteID,
            "CPU"           => \@CPU_TIMES,
            "build"         => $BUILD,
            "elapsed_times" => \@ELAPSED_TIMES,
            "test_status"   => "complete"
        };
        
        # Package our test instance results
        $testrun_results{$instance_id} = \%set_results;
        
        # Finalize our Orbital device tracing. Disable the device tracing, copy the trace log to the console, then copy log to FTP server
        $NETENV->postTestTrace() if ($CONFIG->{'USE_ORBITALS'} > 0);
        
        # Calculate advance in progress percentages (+ instance)
        $percent_now = int (++$progress_size * $percent_per_loop);
        progress_bar_mark($percent_now, $percent_last) if ($CONFIG->{'VERBOSE'} < 1 && exists($ENV{'HTTP_USER_AGENT'}));
        $percent_last = $percent_now;
        
        $cases_left--;   # Decrement the number of test case instances left
    }

    # ------------------------------
    # Results Analysis (per test run):
    # ------------------------------

    my $analyzed_results = results_analysis(\%testrun_results,\%instance_details);

    # Calculate advance in progress percentages (+ test run)
    $percent_now = int (++$progress_size * $percent_per_loop);
    progress_bar_mark($percent_now, $percent_last) if ($CONFIG->{'VERBOSE'} < 1 && exists($ENV{'HTTP_USER_AGENT'}));
    $percent_last = $percent_now;

    # Display command-line output
    unless (exists($ENV{'HTTP_USER_AGENT'})) {
        print Dumper($analyzed_results);                # Display on command-line only
        print display_output("Timestamp",$TIMESTAMP);   # Display on command-line only
    }
    
    $runs_left--;   # Decrement the number of test runs left
}


# ------------------------------
# Display output
# ------------------------------

if (exists($ENV{'HTTP_USER_AGENT'})) {
    print progress_bar_footer() if ($CONFIG->{'VERBOSE'} < 1);
    print page_footer();
    
    # Finally, let's wait for about 5 seconds, then redirect to our results page
    print display_redirect_javascript($TIMESTAMP);
}
else {
    print "\n100\% COMPLETE.\n\n";
}


exit;


