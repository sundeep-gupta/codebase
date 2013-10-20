#!/usr/local/bin/perl
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.30 $
# Last Modified: $Date: 2005/08/18 23:56:23 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbital/control/perl-lib/Orbital/Database.pm,v $
#
####################################################################################
##
##

#package Database;

use vars qw($DEBUG $DB_USER $DB_PASSWORD $DB_NAME $DB_HOST);
use lib qw(/usr/local/lib/perl5/5.8.6 /usr/local/orbital/console/perl-lib);
use Orbital::Config;
use DBI;


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

# Define the following
my $DB_USER     = $CONFIG->{'DB_USER'};       # Database user name
my $DB_PASSWORD = $CONFIG->{'DB_PASSWORD'};   # Database password for user
my $DB_NAME     = $CONFIG->{'DB_NAME'};       # Database name
my $DB_HOST     = $CONFIG->{'DB_HOST'};       # Database host

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input: - Class method name
# Output - Nothing
#sub new {
#	my $self = { };
#	bless $self;
#	return $self;
#}

#
# get_testrun_data() - 
# Input:  $testRunId - The test run id for the test instance that you want to run
# Output: Multi-dimensional hash containing our test run data
sub get_testrun_data {
    my $testRunId  = shift;

	my $dbh = DBI->connect( "DBI:mysql:$DB_NAME:$DB_HOST", $DB_USER, $DB_PASSWORD ) or die "Can't connect to mysql at $DB_NAME:$DB_HOST";
	$dbh->{RaiseError} = 1;

    # Get all testcase instances for the given test run
	my $testcaseinstances = get_testcase_instances($dbh,$testRunId);

    # Iterate through all testcase instances
	foreach $key (keys %$testcaseinstances) {
        # Get client data
		my $clients = get_clients($dbh,$key);

        # Get server data
		my $servers = get_servers($dbh,$key);

        # Get orbital device data	
		my $orbitals = get_orbitals($dbh,$key);
        
        my $orbital_parameters = get_machine_parameters($dbh,$key,"orbital");
		foreach $orb_machine (keys %$orbitals) {
			$orbitals->{$orb_machine}->{'settings'} = $orbital_parameters;
		}
		
        # Get wansim data
		my $wansim = get_wansim($dbh,$key);

        my $wansim_parameters = get_machine_parameters($dbh,$key,"wansim");
        $wansim->{'settings'} = $wansim_parameters;

        # flesh out master hash
		$testcaseinstances->{$key}->{'clients'} = $clients;
		$testcaseinstances->{$key}->{'servers'} = $servers;
		$testcaseinstances->{$key}->{'orbitals'} = $orbitals;
		$testcaseinstances->{$key}->{'wansim'} = $wansim;
	}
    
	return($testcaseinstances);
}

#
# add_results() - Returns the last insert id for the new results record, or false on failure
# Input:  $dbh               - Database handle object
#         $testRunInstanceId - Test run/test case instance id
#         $instanceResults   - Hash reference containing all the results for each testrun/testcase instance
# Output: Returns last insert id for new results record, or false on failure
sub add_results {
    my($testRunInstanceId,$instanceResults) = @_;
    
    my $dbh = DBI->connect( "DBI:mysql:$DB_NAME:$DB_HOST", $DB_USER, $DB_PASSWORD ) or die "Can't connect to mysql at $DB_NAME:$DB_HOST";
	$dbh->{RaiseError} = 1;

    # Define our insert fields
    my $Result = (exists($instanceResults->{'result'}) && defined($instanceResults->{'result'})) ? $instanceResults->{'result'} : "fail";
    my $FailureDetail;
    if ($Result eq "pass") {
        $FailureDetail = "''";
    }
    else {
        if (exists($instanceResults->{'reason'}) && defined($instanceResults->{'reason'})) {
            my $tmp_reason = $instanceResults->{'reason'};
            my $tmpFailure = join("\n", @$tmp_reason);
            $FailureDetail = $dbh->quote($tmpFailure);
        }
        else {
            my $tmpFailure = "No failure reasons were sent back by the testrun analysis.";
            $FailureDetail = $dbh->quote($tmpFailure);
        }
    }
    my $AnalysisType  = (exists($instanceResults->{'analysis_type'}) && defined($instanceResults->{'analysis_type'})) ? $instanceResults->{'analysis_type'} : "Unknown";
    my $StartTime     = (exists($instanceResults->{'start_time'}) && defined($instanceResults->{'start_time'})) ? $instanceResults->{'start_time'} : "00:00:00";
    my $EndTime       = (exists($instanceResults->{'end_time'}) && defined($instanceResults->{'end_time'})) ? $instanceResults->{'end_time'} : "00:00:00";
    my $Date          = (exists($instanceResults->{'date'}) && defined($instanceResults->{'date'})) ? $instanceResults->{'date'} : "0000-00-00";
    my $TestStatus    = (exists($instanceResults->{'test_status'}) && defined($instanceResults->{'test_status'})) ? $instanceResults->{'test_status'} : "complete";
    my $TestSuiteID   = (exists($instanceResults->{'test_suite_id'}) && defined($instanceResults->{'test_suite_id'})) ? $instanceResults->{'test_suite_id'} : "0";
    my $Timestamp     = (exists($instanceResults->{'timestamp'}) && defined($instanceResults->{'timestamp'})) ? $instanceResults->{'timestamp'} : "Unknown";
    my $InitiateType  = (exists($ENV{'HTTP_USER_AGENT'})) ? "browser" : "cmdline";
    my $Build         = determine_build($instanceResults->{'build'});

    my $sql = qq{
        INSERT INTO results SET
            TestRun_TestCaseInstanceID = '$testRunInstanceId',
            TestSuiteID                = '$TestSuiteID',
            Result                     = '$Result',
            FailureDetail              = $FailureDetail,
            Build                      = '$Build',
            AnalysisType               = '$AnalysisType',
            StartTime                  = '$StartTime',
            EndTime                    = '$EndTime',
            Date                       = '$Date',
            TestStatus                 = '$TestStatus',
            InitiateType               = '$InitiateType',
            Timestamp                  = '$Timestamp'
    };

    my $sth = $dbh->prepare($sql) or return undef;
    $sth->execute() or return undef;
    my $rows = $sth->rows;
    my $id = $dbh->last_insert_id(undef, undef, qw(results ResultsID));
    $sth->finish;

    if (exists($instanceResults->{'CPU'}) && defined($instanceResults->{'CPU'})) {
        my $retval = add_cpu_times($dbh, $id, $instanceResults->{'CPU'});
    }
    
    if (exists($instanceResults->{'elapsed_times'}) && defined($instanceResults->{'elapsed_times'})) {
        my $retval2 = add_elapsed_times($dbh, $id, $instanceResults->{'elapsed_times'});
    }
    
    return($rows);
}

#
# add_cpu_times() - Add a list of Orbital CPU time data to the database as part of the results
# Input:  $dbh       - Database handle
#         $ResultsID - Results id value
#         $CPU       - Array reference containing a list of hashes with CPU time data for each Orbital device
# Output: The number of rows affected, or undef on failure
sub add_cpu_times {
    my ($dbh, $ResultsID, $CPU) = @_;
    
    foreach my $cpu_data (@$CPU) {
        my $cpu_times = $cpu_data->{'CPU'};
        my $description = $cpu_data->{'Description'};
        
        while(my($device_name, $device) = each(%$cpu_times)) {
            my $user   = (exists($device->{'user'}) && defined($device->{'user'})) ? $device->{'user'} : "0";
            my $nice   = (exists($device->{'nice'}) && defined($device->{'nice'})) ? $device->{'nice'} : "0";
            my $system = (exists($device->{'system'}) && defined($device->{'system'})) ? $device->{'system'} : "0";
            my $idle   = (exists($device->{'idle'}) && defined($device->{'idle'})) ? $device->{'idle'} : "0";
            my $ip_address = (exists($device->{'ip_address'}) && defined($device->{'ip_address'})) ? $device->{'ip_address'} : "0.0.0.0";
            my $timestamp  = (exists($device->{'timestamp'}) && defined($device->{'timestamp'})) ? $device->{'timestamp'} : "Unknown";
            
            # Insert into database
            my $sql = qq{
                INSERT INTO results_cpu_data SET
                    ResultsID   = '$ResultsID',
                    IPaddress   = '$ip_address',
                    User        = '$user',
                    Nice        = '$nice',
                    System      = '$system',
                    Idle        = '$idle',
                    Description = '$description',
                    ExeTime     = '$timestamp'
            };
            
            my $sth = $dbh->prepare($sql) or return undef;
            $sth->execute() or return undef;
            my $rows = $sth->rows;
            $sth->finish;
        }
    }
    
    return $rows;
}

#
# add_elapsed_times() - Add a list of elapsed time values for each client machine
# Input:  $dbh           - Database handle
#         $ResultsID     - Results id value
#         $elapsed_times - Array reference containing a list of elapsed time values
# Output: The number of rows affected, or undef on failure
sub add_elapsed_times {
    my ($dbh, $ResultsID, $elapsed_times) = @_;
    
    foreach my $etime (@$elapsed_times) {
        my $ip_address = (exists($etime->{'ip_address'}) && defined($etime->{'ip_address'})) ? $etime->{'ip_address'} : "0.0.0.0";
        my $timevalues = $etime->{'elapsed_times'};
        
        foreach my $timedata (@$timevalues) {
            if (exists($timedata->{'timevalue'}) && defined($timedata->{'timevalue'}) && $timedata->{'timevalue'} ne "") {
                my $timevalue   = $timedata->{'timevalue'};
                my $description = (exists($timedata->{'description'}) && defined($timedata->{'description'})) ? $timedata->{'description'} : "None Available";
                my $timestamp   = (exists($timedata->{'exetime'}) && defined($timedata->{'exetime'})) ? $timedata->{'exetime'} : "Unknown";
                
                my $sql = qq{
                    INSERT INTO results_timedata SET
                        ResultsID   = '$ResultsID',
                        IPaddress   = '$ip_address',
                        TimeValue   = '$timevalue',
                        Description = '$description',
                        ExeTime     = '$timestamp'
                };
                
                my $sth = $dbh->prepare($sql) or return undef;
                $sth->execute() or return undef;
                my $rows = $sth->rows;
                $sth->finish;
            }
        }
    }
    
    return $rows;
}

#
# get_testsuites() - Get a list of all test suites available
# Input:  Nothing
# Output: Hash reference containing a list of all test suites available
sub get_testsuites {
    my $dbh = DBI->connect( "DBI:mysql:$DB_NAME:$DB_HOST", $DB_USER, $DB_PASSWORD ) or die "Can't connect to mysql at $DB_NAME:$DB_HOST";
	$dbh->{RaiseError} = 1;
    
    my $sql = qq{
        SELECT * FROM testsuites
    };
    my $rows = $dbh->selectall_hashref($sql,1);
    
    return ($rows);
}

#
# get_testsuite_details() - Get details on the given test suite
# Input:  $TestSuiteID - Test suite id value
# Output: Hash reference containing details on the given test suite
sub get_testsuite_details {
    my ($TestSuiteID) = @_;
    
    my $dbh = DBI->connect( "DBI:mysql:$DB_NAME:$DB_HOST", $DB_USER, $DB_PASSWORD ) or die "Can't connect to mysql at $DB_NAME:$DB_HOST";
	$dbh->{RaiseError} = 1;
    
    my $sql = qq{
        SELECT * FROM testsuites WHERE TestSuiteID = '$TestSuiteID'
    };
    my $row = $dbh->selectrow_hashref($sql);
    
    return ($row);
}

#
# get_testruns_in_suite() - Get a list of all test runs available in a given test suite
# Input:  $TestSuiteID - Test suite id value
# Output: Hash reference containing a list of all test runs available in a given test suite
sub get_testruns_in_suite {
    my ($TestSuiteID) = @_;
    
    my $dbh = DBI->connect( "DBI:mysql:$DB_NAME:$DB_HOST", $DB_USER, $DB_PASSWORD ) or die "Can't connect to mysql at $DB_NAME:$DB_HOST";
	$dbh->{RaiseError} = 1;
    
    my $sql = qq{
        SELECT tr.TestRunID, tr.Name, tr.Description 
        FROM testruns tr, testsuites_testruns tstr 
        WHERE tstr.TestRunID = tr.TestRunID
        AND tstr.TestSuiteID = '$TestSuiteID' 
        ORDER BY tr.Name
    };
    my $rows = $dbh->selectall_hashref($sql,1);
    
    return ($rows);
}

#
# get_testgroup_name() - Get our testgroup/testrun name and return it
# Input:  $testRunId - Test run id
# Output: String containing our testgroup/testrun name
sub get_testgroup_name {
    my ($testRunId) = @_;
    
    my $dbh = DBI->connect( "DBI:mysql:$DB_NAME:$DB_HOST", $DB_USER, $DB_PASSWORD ) or die "Can't connect to mysql at $DB_NAME:$DB_HOST";
	$dbh->{RaiseError} = 1;
    
    my $sql = qq{
        SELECT * FROM testruns WHERE TestRunID = '$testRunId'
    };
    my $testgroup = $dbh->selectrow_hashref($sql);
    
    return (exists($testgroup->{'Name'}) && $testgroup->{'Name'} ne "") ? $testgroup->{'Name'} : "Name could not be found";
}

#
# get_progress_size() - Returns the size number of the total progress possible
# Input:  $testSuite - Array reference containing a list of all test run ids to be executed
# Output: Integer containing the size of the total progress possible
sub get_progress_size {
    my ($testSuite) = @_;
    
    my $dbh = DBI->connect( "DBI:mysql:$DB_NAME:$DB_HOST", $DB_USER, $DB_PASSWORD ) or die "Can't connect to mysql at $DB_NAME:$DB_HOST";
	$dbh->{RaiseError} = 1;

    my $progress_size  = 0;   # Size number of the total progress possible
    my $testrun_count  = 0;   # Number of test runs
    my $computer_count = 0;   # Number of computers for all test case instances

    foreach my $TestRunID (@$testSuite) {
        my $sql = qq{
            SELECT TestCaseInstanceID FROM testruns_testcaseinstances
            WHERE TestRunID = '$TestRunID'
        };
        my $testCaseInstances = $dbh->selectall_arrayref($sql);
        
        $progress_size += @$testCaseInstances;
        
        # Iterate through each test case instance and find the number of computers (clients & servers) used
        foreach my $instance (@$testCaseInstances) {
            $computer_count += get_computer_count($dbh, @$instance[0]);
        }
        
        $testrun_count++;
    }

    $progress_size += $testrun_count;    # We include the number of test runs
    $progress_size += $computer_count;   # We also include the number of computers
    
    return ($progress_size + 1);    # We include an extra tick so when our start our GUI, it gives the apperance of progress
}

#
# get_testsuite_size() - Get the number of test runs within a test suite
# Input:  $TestSuiteID - Test suite id value
# Output: Returns an integer whose value contains the number of test runs within a test suite
sub get_testsuite_size {
    my ($TestSuiteID) = @_;
    
    my $dbh = DBI->connect( "DBI:mysql:$DB_NAME:$DB_HOST", $DB_USER, $DB_PASSWORD ) or die "Can't connect to mysql at $DB_NAME:$DB_HOST";
	$dbh->{RaiseError} = 1;
    
    my $sql = qq{
        SELECT TestRunID FROM testsuites_testruns
        WHERE TestSuiteID = '$TestSuiteID'
    };
    my $testRuns = $dbh->selectall_arrayref($sql);

    my $testsuite_size = @$testRuns;
    
    return ($testsuite_size);
}

#
# get_testrun_size() - Get the number of test case instances within a test run
# Input:  $TestRunID - Test run id value
# Output: Returns an integer whose value contains the number of test case instances within a test run
sub get_testrun_size {
    my ($TestRunID) = @_;
    
    my $dbh = DBI->connect( "DBI:mysql:$DB_NAME:$DB_HOST", $DB_USER, $DB_PASSWORD ) or die "Can't connect to mysql at $DB_NAME:$DB_HOST";
	$dbh->{RaiseError} = 1;
    
    my $sql = qq{
        SELECT TestCaseInstanceID FROM testruns_testcaseinstances
        WHERE TestRunID = '$TestRunID'
    };
    my $testInstances = $dbh->selectall_arrayref($sql);

    my $testrun_size = @$testInstances;
    
    return ($testrun_size);
}

#
# get_computer_count() - Returns the number of computers (clients & servers) used for the current test case instance
# Input:  $dbh                - Database handle
#         $TestCaseInstanceID - Test case instance id value
# Output: Integer containing the number of computers used for the test case instance
# NOTE: We need to remember that we iterate through all combinations of machines, thus we need to include servers * clients + number of combos (otherwise server count)
sub get_computer_count {
    my ($dbh, $TestCaseInstanceID) = @_;

    my $sql = qq{
        SELECT count(*) FROM machines m
        INNER JOIN machinegroups_machines mgm USING (MachineID)
        INNER JOIN machinegroups mg USING (MachineGroupID)
        INNER JOIN testcaseinstances tci USING (MachineGroupID)
        WHERE m.MachineType = 'client'
        AND tci.TestCaseInstanceID = '$TestCaseInstanceID'
    };
    
    my $row = $dbh->selectrow_hashref($sql);
    my $client_count = $row->{'count(*)'};

    $sql = qq{
        SELECT count(*) FROM machines m
        INNER JOIN machinegroups_machines mgm USING (MachineID)
        INNER JOIN machinegroups mg USING (MachineGroupID)
        INNER JOIN testcaseinstances tci USING (MachineGroupID)
        WHERE m.MachineType = 'server'
        AND tci.TestCaseInstanceID = '$TestCaseInstanceID'
    };
    
    $row = $dbh->selectrow_hashref($sql);
    my $server_count = $row->{'count(*)'};
    
    my $computer_count = ($client_count * $server_count) + $server_count;

    return $computer_count;
}

#
# get_testcase_instances() - Return hash data structure containing testcase instance data based upon testrun id
# Input:  $dbh       - Database handle object
#         $testRunId - String containing test run id
# Output: Hash reference containing all of our testcase instance data
sub get_testcase_instances {
    my($dbh,$testRunId) = @_;
    
    # Get all testcase instances for the given test run
	my $sql = qq{
		SELECT tr_tci.TestRun_TestCaseInstanceID, tci.TestCaseInstanceID, tc.TestCaseID AS test_case_id, tc.Name AS test_case, tc.Path AS share, 
        tr.KillConnections as kill_connections, tc.Concurrent
		FROM testruns tr
		INNER JOIN testruns_testcaseinstances tr_tci USING (TestRunID)
		INNER JOIN testcaseinstances tci USING (TestCaseInstanceID)
		INNER JOIN testcases tc USING (TestCaseID)
		WHERE tr.TestRunID = $testRunId
		ORDER BY tci.TestCaseInstanceID
	};
	my $testcaseinstances = $dbh->selectall_hashref($sql,1);
    
    return($testcaseinstances);
}

#
# get_clients() - Return hash reference containing all client machine data based upon testrun_testcaseinstance_id
# Input:  $dbh               - Database handle object
#         $testRunInstanceId - Test run instance id
# Output: Hash reference containing all client machine data
sub get_clients {
    my($dbh,$testRunInstanceId) = @_;

    my $sql = qq{
		SELECT m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password
		FROM machines m
		INNER JOIN machinegroups_machines mg_m USING (MachineID)
		INNER JOIN machinegroups mg USING (MachineGroupID)
        INNER JOIN testcaseinstances tci USING (MachineGroupID)
		INNER JOIN testruns_testcaseinstances tr_tci USING (TestCaseInstanceID)
		WHERE tr_tci.TestRun_TestCaseInstanceID = $testRunInstanceId
		AND m.MachineType = 'client'
    };
	my $clients = $dbh->selectall_hashref($sql,1);

    return($clients);
}

#
# get_servers() - Return hash reference containing all server machine data based upon testrun_testcaseinstance_id
# Input:  $dbh               - Database handle object
#         $testRunInstanceId - Test run instance id
# Output: Hash reference containing all server machine data
sub get_servers {
    my($dbh,$testRunInstanceId) = @_;

    my $sql = qq{
		SELECT m.Name AS name, m.IPaddress AS ip_address, m.ProxyIPaddress AS proxy_ip_address, m.ProxyPort as proxy_port, m.OS AS os, m.UserID AS user, m.Passw AS password
        FROM machines m
		INNER JOIN machinegroups_machines mg_m USING (MachineID)
		INNER JOIN machinegroups mg USING (MachineGroupID)
        INNER JOIN testcaseinstances tci USING (MachineGroupID)
		INNER JOIN testruns_testcaseinstances tr_tci USING (TestCaseInstanceID)
		WHERE tr_tci.TestRun_TestCaseInstanceID = $testRunInstanceId
		AND m.MachineType = 'server'
	};	
	my $servers = $dbh->selectall_hashref($sql,1);

    return($servers);
}

#
# get_orbitals() - Returns hash reference containing all orbital device data based upon testrun_testcaseinstance_id
# Input:  $dbh               - Database handle object
#         $testRunInstanceId - Test run instance id
# Output: Hash reference containing all orbital device data
sub get_orbitals {
    my($dbh,$testRunInstanceId) = @_;

    my $sql = qq{
		SELECT m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password
		FROM machines m
		INNER JOIN machinegroups_machines mg_m USING (MachineID)
		INNER JOIN machinegroups mg USING (MachineGroupID)
        INNER JOIN testcaseinstances tci USING (MachineGroupID)
		INNER JOIN testruns_testcaseinstances tr_tci USING (TestCaseInstanceID)
		WHERE tr_tci.TestRun_TestCaseInstanceID = $testRunInstanceId
		AND m.MachineType = 'orbital'
	};	
	my $orbitals = $dbh->selectall_hashref($sql,1);
    
    return($orbitals);
}

#
# get_wansim() - Returns hash reference containing all WAN-simulator device data based upon testrun_testcaseinstance_id
# Input:  $dbh               - Database handle object
#         $testRunInstanceId - Test run instance id
# Output: Hash reference containing all WAN-simulator data
sub get_wansim {
    my($dbh,$testRunInstanceId) = @_;

    my $sql = qq{
		SELECT m.Name AS name, m.IPaddress AS ip_address
		FROM machines m
		INNER JOIN machinegroups_machines mg_m USING (MachineID)
		INNER JOIN machinegroups mg USING (MachineGroupID)
        INNER JOIN testcaseinstances tci USING (MachineGroupID)
		INNER JOIN testruns_testcaseinstances tr_tci USING (TestCaseInstanceID)
		WHERE tr_tci.TestRun_TestCaseInstanceID = $testRunInstanceId
		AND m.MachineType = 'delayrouter'
	};	
	my $wansim = $dbh->selectrow_hashref($sql);
    
    return($wansim);
}

#
# get_machine_parameters() - Returns hash that contains all parameters for the given machine type
# Input:  $dbh               - Database handle object
#         $testRunInstanceId - Test run instance id
#         $machineType       - Machine type (orbital/wansim)
# Output: Hash containing all parameters for the given machine type
sub get_machine_parameters {
    my($dbh,$testRunInstanceId,$machineType) = @_;

    my $sql = qq{
        SELECT ParamName, Value
        FROM testruns_testcaseinstances tr_tci
        INNER JOIN testcaseinstances tci USING (TestCaseInstanceID)
        INNER JOIN paramsets s USING (ParamSetID)
        INNER JOIN paramsets_params_paramvalues psv USING (ParamSetID)
        INNER JOIN paramvalues v USING (ParamValuesID)
        INNER JOIN params p USING (ParamsID)
        WHERE tr_tci.TestRun_TestCaseInstanceID = $testRunInstanceId 
        AND p.MachineType = '$machineType'
    };
    my $sth = $dbh->prepare($sql);
    $sth->execute();
    
    # Parameter hash to return
    my %parameters;
    
    my($param,$value);
    while (($param,$value) = $sth->fetchrow) {
        $parameters{$param} = $value;
    }
    $sth->finish;
    
    return(\%parameters);
}

#
# determine_build() - Determine what the build version is, and make sure the build is the same across all devices
# Input:  $build - Array reference containing build version information for all Orbital devices
# Output: String containing the actual build version
sub determine_build {
    my ($build) = shift;
    
    my $last_build = "";
    my $version = "Unknown";
    
    foreach my $device (@$build) {
        if ($device->{'Version'} ne $last_build && $last_build ne "") {
            $version = "Software builds on each device are not the same.";
            last;
        }
        $version = $device->{'Version'};
        $last_build = $device->{'Version'};
    }
    
    return($version);
}


1;

__END__