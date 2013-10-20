<?php

######################################################################################
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.1.1.1 $
# Last Modified: $Date: 2005/09/28 23:31:11 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbitaldata/control/php-lib/modules/reports.php,v $
#
######################################################################################



class reports {


    function reports() {
    	// Object constructor
    }

    //
    // getTestRunResults() - Get detailed information on our testsuite/testrun results and analysis
    // Input:  $db        - Database object
    //         $Timestamp - Timestamp of the testsuite/testruns that were executed
    // Output: Multi-dimensional hash containing our report data
    // NOTE: Theoretically, this should also be grouped automatically by testrun based upon the date and time
    function getTestRunResults($db, $Timestamp) {
        // Define our testrun results to return
        $testResults = array();
        
        // Fetch all of our test case instances that were run (group by testrun, date, time)
        $results = $db->get_results("SELECT ts.Name AS test_suite_name, ts.TestSuiteID, tr.Name AS test_group_name, tr.TestRunID, r.ResultsID, r.Result, 
                                         r.FailureDetail, r.AnalysisType, r.StartTime, r.EndTime, r.Date, r.TestStatus, r.InitiateType, r.Timestamp, r.SessionID, 
                                         tc.Name AS test_case, tci.TestCaseInstanceID, tci.MachineGroupID, tci.ParamSetID, tc.ExecType, 
                                         TIMEDIFF(r.StartTime,r.EndTime) AS elapsed_time, '' AS client, '' AS server, '' AS bandwidth, '' AS delay, '' AS params
                                     FROM results r, testruns_testcaseinstances trtci, testcaseinstances tci, testcases tc, testruns tr, testsuites ts, testsuites_testruns tstr
                                     WHERE r.TestRun_TestCaseInstanceID = trtci.TestRun_TestCaseInstanceID
                                     AND trtci.TestCaseInstanceID = tci.TestCaseInstanceID
                                     AND tci.TestCaseID = tc.TestCaseID
                                     AND trtci.TestRunID = tr.TestRunID
                                     AND r.TestSuiteID = ts.TestSuiteID
                                     AND ts.TestSuiteID = tstr.TestSuiteID
                                     AND tstr.TestRunID = tr.TestRunID
                                     AND r.Timestamp = '$Timestamp'
                                     ORDER BY r.Date, r.StartTime");
        
        // Make sure we returned some results
        if (empty($results)) {
            return false;
        }
        
        // Iterate through all of our test case instances
        for ($i=0; $i < sizeof($results); $i++) {
            if ($i == 0) {
                $testResults['start_time']      = $results[$i]->StartTime;
                $testResults['test_suite_name'] = $results[$i]->test_suite_name;
                $testResults['initiate_type']   = $results[$i]->InitiateType;
                $testResults['testing_date']    = $results[$i]->Date;
            }
            if ($i == (sizeof($results) - 1)) {
                $testResults['end_time'] = $results[$i]->EndTime;
            }
            
            // Find the server data
            $server = $this->getServersInGroup($db, $results[$i]->MachineGroupID);
            $results[$i]->server = $server;
            
            // Find the client data
            $client = $this->getClientsInGroup($db, $results[$i]->MachineGroupID);
            $results[$i]->client = $client;
            
            // Find the bandwidth setting
            $row = $this->getParamValueInParamSet($db, $results[$i]->ParamSetID, "bandwidth");
            $results[$i]->bandwidth = $row->Value;

            // Find the delay setting
            $row = $this->getParamValueInParamSet($db, $results[$i]->ParamSetID, "delay");
            $results[$i]->delay = $row->Value;
            
            // Find all the parameters and values used for the current instance
            $results[$i]->params = $this->getParamSetDetails($db, $results[$i]->ParamSetID, "", "");
        }
        
        $testResults['instances'] = $results;
        $testResults['revision']  = "1.0";
        
        return ($testResults) ? $testResults : false;
    }
    
    //
    // getClientsInGroup() - Get a list of all client machines within a machine group
    // Input:  $db             - Database object
    //         $MachineGroupID - Machine group id value
    // Output: Associative array containing details on the client machines within a machine group
    function getClientsInGroup($db, $MachineGroupID) {
        $results = $db->get_results("SELECT m.OS, m.Name, m.IPaddress, m.MachineType, mg.Modified AS MachineGroupModified, m.Modified AS MachineModified
                                     FROM machines m, machinegroups mg, machinegroups_machines mgm
                                     WHERE mg.MachineGroupID = mgm.MachineGroupID
                                     AND mgm.MachineID = m.MachineID
                                     AND m.MachineType = 'client'
                                     AND mg.MachineGroupID = '$MachineGroupID'");
        
        return (isset($results) && $results != "") ? $results : false;
    }
    
    //
    // getServersInGroup() - Get a list of all server machines within a machine group
    // Input:  $db             - Database object
    //         $MachineGroupID - Machine group id value
    // Output: Associative array containing details on the server machines within a machine group
    function getServersInGroup($db, $MachineGroupID) {
        $results = $db->get_results("SELECT m.OS, m.Name, m.IPaddress, m.MachineType, mg.Modified AS MachineGroupModified, m.Modified AS MachineModified
                                     FROM machines m, machinegroups mg, machinegroups_machines mgm
                                     WHERE mg.MachineGroupID = mgm.MachineGroupID
                                     AND mgm.MachineID = m.MachineID
                                     AND m.MachineType = 'server'
                                     AND mg.MachineGroupID = '$MachineGroupID'");
        
        return (isset($results) && $results != "") ? $results : false;
    }
    
    //
    // getParamValueInParamSet() - Get detailed information on a parameter and its value from a specific parameter set
    // Input:  $db         - Database object
    //         $ParamSetID - Parameter set id value
    //         $ParamName  - Parameter name
    // Output: Associative array containing detailed information on the parameter, value and whether it was modified or not
    function getParamValueInParamSet($db, $ParamSetID, $ParamName) {
        $row = $db->get_row("SELECT pv.Value, p.ParamName, ps.Modified AS ParamSetModified
                             FROM paramsets ps, params p, paramvalues pv, paramsets_params_paramvalues ppp
                             WHERE ps.ParamSetID = ppp.ParamSetID
                             AND ppp.ParamsID = p.ParamsID
                             AND ppp.ParamValuesID = pv.ParamValuesID
                             AND p.ParamName REGEXP '$ParamName'
                             AND ps.ParamSetID = '$ParamSetID'");
        
        return (isset($row) && $row != "") ? $row : false;
    }
    
    //
    // getResultsWithinDateRange() - Get a detailed list of all results within a given date range
    // Input:  $db        - Database object
    //         $StartDate - Starting date
    //         $EndDate   - Ending date
    // Output: Associative array containing detailed results within a given date range
    function getResultsWithinDateRange($db, $StartDate, $EndDate) {
        $results = $db->get_results("SELECT r.ResultsID, ts.TestSuiteID, ts.Name, '' AS Result, r.StartTime, '' AS EndTime, 
                                         r.Date, r.TestStatus, r.InitiateType, r.Timestamp, r.SessionID
                                     FROM results r, testsuites ts
                                     WHERE r.TestSuiteID = ts.TestSuiteID
                                     AND r.Date >= '$StartDate'
                                     AND r.Date <= '$EndDate'
                                     GROUP BY r.Timestamp
                                     ORDER BY r.Date, r.StartTime");
        
        // Make sure we returned some results
        if (empty($results)) {
            return false;
        }
        
        // Iterate through each result
        for ($i=0; $i < sizeof($results); $i++) {
            // Find out our end time for the current record
            $row = $db->get_row("SELECT EndTime FROM results
                                 WHERE Timestamp = '".$results[$i]->Timestamp."'
                                 ORDER BY EndTime DESC
                                 LIMIT 1");
            $results[$i]->EndTime = $row->EndTime;
            
            // Find out if there where any failures for the current record
            $tmp_results = $db->get_results("SELECT Result FROM results
                                             WHERE Timestamp = '".$results[$i]->Timestamp."'
                                             AND Result REGEXP 'fail'");
            $results[$i]->Result = (isset($tmp_results) && $tmp_results != "") ? "fail" : "pass";
        }
        
        return (isset($results) && $results != "") ? $results : false;
    }
    
    //
    // getTestCaseDetails() - Get a detailed information on a specific test case instance and it's results (pass/fail)
    // Input:  $db        - Database object
    //         $ResultsID - Results id value
    // Output: Associative array containing detailed information on a specific test case instance and it's results
    function getTestCaseDetails($db, $ResultsID) {
        $row = $db->get_row("SELECT ts.TestSuiteID, ts.Name AS test_suite_name, ts.Description AS test_suite_desc,
                                 tr.TestRunID, tr.Name AS test_run_name, tr.Description AS test_run_desc,
                                 r.ResultsID, r.Result, r.FailureDetail, r.AnalysisType, r.StartTime, r.EndTime, r.Date, r.TestStatus, r.InitiateType, r.Timestamp, r.SessionID, r.Build,
                                 TIMEDIFF(r.StartTime,r.EndTime) AS elapsed_time, tci.TestCaseInstanceID, tci.Modified AS InstanceModified,
                                 mg.MachineGroupID, mg.Name AS machine_group_name, mg.Description AS machine_group_desc, mg.Modified AS MachineGroupModified, 
                                 ps.ParamSetID, ps.Name AS param_set_name, ps.Description AS param_set_desc, ps.Modified AS ParamSetModified, 
                                 tc.TestCaseID, tc.Name AS test_case_name, tc.ShortTitle, tc.Description AS test_case_desc, tc.Version, tc.Category, tc.ExecType, tc.Modified AS TestCaseModified,
                                 '' AS machines, '' AS params, '' AS criteria, '' AS preconditions, '' AS procedures, '' AS CPU, '' AS timedata
                             FROM testsuites ts, testruns tr, machinegroups mg, paramsets ps, results r
                             INNER JOIN testruns_testcaseinstances trtci USING (TestRun_TestCaseInstanceID)
                             INNER JOIN testcaseinstances tci USING (TestCaseInstanceID)
                             INNER JOIN testcases tc USING (TestCaseID)
                             WHERE ts.TestSuiteID = r.TestSuiteID
                             AND trtci.TestRunID = tr.TestRunID
                             AND tci.MachineGroupID = mg.MachineGroupID
                             AND tci.ParamSetID = ps.ParamSetID
                             AND r.ResultsID = '$ResultsID'");
        
        // Make sure we returned some results
        if (empty($row)) {
            return false;
        }
        
        $row->machines = $this->getMachineGroupDetails($db, $row->MachineGroupID, $row->MachineGroupModified, $row->Timestamp);
        $row->params = $this->getParamSetDetails($db, $row->ParamSetID, $row->ParamSetModified, $row->Timestamp);
        $row->criteria = $this->getTestCaseCriteria($db, $row->TestCaseID);
        $row->preconditions = $this->getTestCasePreconditions($db, $row->TestCaseID);
        $row->procedures = $this->getTestCaseProcedures($db, $row->TestCaseID);
        $row->CPU = $this->getInstanceCPUdata($db, $ResultsID);
        $row->timedata = $this->getInstanceTimeData($db, $ResultsID);
        
        return ($row) ? $row : false;
    }
    
    //
    // getMachineGroupDetails() - Get detailed information on a machine group using the given machine group id. (do a validity check on modified data)
    // Input:  $db             - Database object
    //         $MachineGroupID - Machine group id
    //         $Modified       - Determines whether the machine group was modified or not (1 = yes, 0 = no)
    //         $Timestamp      - Timestamp of the results the machine group is tied to
    // Output: Returns an associative array containing the machine group details
    function getMachineGroupDetails($db, $MachineGroupID, $Modified, $Timestamp) {
        $results = $db->get_results("SELECT m.MachineID, m.Name, m.MachineType, m.IPaddress, m.OS, m.UserID, m.Passw, m.Active, m.Modified FROM machines m
                                     INNER JOIN machinegroups_machines mgm USING (MachineID)
                                     INNER JOIN machinegroups mg USING (MachineGroupID)
                                     WHERE mg.MachineGroupID = '$MachineGroupID'
                                     ORDER BY m.MachineType, m.IPaddress");
        
        // Make sure we returned some results
        if (empty($results)) {
            return false;
        }
        
        return ($results) ? $results : false;
    }

    //
    // getParamSetDetails() - Get detailed information on a parameter set using the given param set id. (do a validity check on modified data)
    // Input:  $db         - Database object
    //         $ParamSetID - Parameter set id
    //         $Modified   - Determines whether the parameter set was modified or not (1 = yes, 0 = no)
    //         $Timestamp  - Timestamp of the results that the parameter set is tied to
    // Output: Returns an associative array containing the parameter set details
    function getParamSetDetails($db, $ParamSetID, $Modified, $Timestamp) {
        $results = $db->get_results("SELECT ppp.ParamSetID, p.ParamsID, p.ParamName, pv.ParamValuesID, pv.Value, p.MachineType
                                     FROM paramsets_params_paramvalues ppp, params p, paramvalues pv
                                     WHERE ppp.ParamsID = p.ParamsID
                                     AND ppp.ParamValuesID = pv.ParamValuesID
                                     AND ParamSetID = '$ParamSetID'");
        
        // Make sure we returned some results
        if (empty($results)) {
            return false;
        }
        
        return ($results) ? $results : false;
    }
    
    //
    // getTestCaseCriteria() - Get a list of all the criteria for the given test case
    // Input:  $db         - Database object
    //         $TestCaseID - Test case id value
    // Output: Returns a list containing all of the criteria for the given test case
    function getTestCaseCriteria($db, $TestCaseID) {
        $results = $db->get_results("SELECT * FROM testcase_criteria tcc WHERE tcc.TestCaseID = '$TestCaseID' ORDER BY tcc.Order");
        
        return (isset($results) && $results != "") ? $results : false;
    }
    
    //
    // getTestCasePreconditions() - Get a list of all the preconditions for the given test case
    // Input:  $db         - Database object
    //         $TestCaseID - Test case id value
    // Output: Returns a list containing all of the preconditions for the given test case
    function getTestCasePreconditions($db, $TestCaseID) {
        $results = $db->get_results("SELECT * FROM testcase_preconditions tcp WHERE tcp.TestCaseID = '$TestCaseID' ORDER BY tcp.Order");
        
        return (isset($results) && $results != "") ? $results : false;
    }
    
    //
    // getTestCaseProcedures() - Get a list of all the procedures for the given test case
    // Input:  $db         - Database object
    //         $TestCaseID - Test case id value
    // Output: Returns a list containing all of the procecures for the given test case
    function getTestCaseProcedures($db, $TestCaseID) {
        $results = $db->get_results("SELECT * FROM testcase_procedures tcpr WHERE tcpr.TestCaseID = '$TestCaseID' ORDER BY tcpr.Order");
        
        return (isset($results) && $results != "") ? $results : false;
    }
    
    //
    // getInstanceCPUdata() - Get a list of the CPU time data for the given test case instance result
    // Input:  $db        - Database object
    //         $ResultsID - Results id value
    // Output: Associative array containing a list of CPU time data
    function getInstanceCPUdata($db, $ResultsID) {
        $results = $db->get_results("SELECT * FROM results_cpu_data WHERE ResultsID = '$ResultsID' ORDER BY IPaddress, ExeTime");
        
        return (isset($results) && $results != "") ? $results : false;
    }
    
    //
    // getInstanceTimeData() - Get a list of all elapsed times taken from Visual Test scripts
    // Input:  $db        - Database object
    //         $ResultsID - Results id value
    // Output: Associative array containing a list of all Visual Test elapsed times
    function getInstanceTimeData($db, $ResultsID) {
        $results = $db->get_results("SELECT * FROM results_timedata WHERE ResultsID = '$ResultsID' ORDER BY ExeTime");
        
        return (isset($results) && $results != "") ? $results : false;
    }
    
    //
    // getSummaryDetails() - Get detailed information about a test suite and the test case instances that were run for that suite, within a specific time range
    // Input:  $db          - Database object
    //         $TestSuiteID - Test suite id value
    //         $StartDate   - Starting date value
    //         $EndDate     - Ending date value
    // Output: Associative array containing detailed information about a test suite and all the test case instances run for that suite, within a specific time range
    function getSummaryDetails($db, $TestSuiteID, $StartDate, $EndDate) {
        $row = $db->get_row("SELECT ts.TestSuiteID, ts.Name, ts.Description, '' AS SummaryResults, 
                             '' AS TotalTestCount, '' AS TotalInstanceCount, '' AS TotalAutoCount, '' AS TotalManCount 
                             FROM testsuites ts
                             WHERE TestSuiteID = '$TestSuiteID'");
        
        if (empty($row)) {
            return false;
        }
        
        // Fetch our summary results
        $summaryResults = $this->getSummaryResults($db, $TestSuiteID, $StartDate, $EndDate);
        $testCount = $this->getSummaryTestCount($db, $TestSuiteID, $StartDate, $EndDate);
        
        $row->SummaryResults = $summaryResults;
        $row->TotalTestCount = sizeof($testCount);
        $row->TotalInstanceCount = sizeof($summaryResults);
        $row->TotalAutoCount = $this->getSummaryAutoCount($db, $TestSuiteID, $StartDate, $EndDate);
        $row->TotalManCount = $this->getSummaryManCount($db, $TestSuiteID, $StartDate, $EndDate);
        
        return (isset($row) && $row != "") ? $row : false;
    }
    
    //
    // getSummaryResults() - Get a detailed list of all test case instances run in a given test suite, within the date range specified
    // Input:  $db          - Database object
    //         $TestSuiteID - Test suite id value
    //         $StartDate   - Starting date range value
    //         $EndDate     - Ending date range value
    // Output: Associative array containing a list of all test case instances run in a given test suite, within a specified date range
    function getSummaryResults($db, $TestSuiteID, $StartDate, $EndDate) {
        $results = $db->get_results("SELECT r.ResultsID, ts.TestSuiteID, ts.Name AS test_suite_name, ts.Modified AS TestSuiteModified, 
                                     tr.TestRunID, tr.Name AS test_run_name, tr.Modified AS TestRunModified, 
                                     tc.TestCaseID, tc.Name AS test_case_name, tc.ShortTitle, tc.Path AS share, tc.Category, tc.ExecType, tc.Modified AS TestCaseModified, 
                                     r.Result, r.AnalysisType, r.Date, TIMEDIFF(r.StartTime,r.EndTime) AS elapsed_time, r.InitiateType, r.Timestamp
                                     FROM testsuites ts, testsuites_testruns tstr, testruns tr, results r
                                     INNER JOIN testruns_testcaseinstances trtci USING (TestRun_TestCaseInstanceID)
                                     INNER JOIN testcaseinstances tci USING (TestCaseInstanceID)
                                     INNER JOIN testcases tc USING (TestCaseID)
                                     WHERE r.TestSuiteID = ts.TestSuiteID
                                     AND ts.TestSuiteID = tstr.TestSuiteID
                                     AND tstr.TestRunID = tr.TestRunID
                                     AND r.Date >= '$StartDate'
                                     AND r.Date <= '$EndDate'
                                     AND ts.TestSuiteID = '$TestSuiteID'
                                     ORDER BY test_case_name, r.Timestamp");
        
        return (isset($results) && $results != "") ? $results : false;
    }
    
    //
    // getSummaryTestCount() - Return the number of test cases that were executed in a given test suite, within a specific time range
    // Input:  $db          - Database object
    //         $TestSuiteID - Test suite id value
    //         $StartDate   - Starting date range value
    //         $EndDate     - Ending date range value
    // Output: Integer containing the number of test cases that were executed in a given test suite, within a specific time range
    function getSummaryTestCount($db, $TestSuiteID, $StartDate, $EndDate) {
        $results = $db->get_results("SELECT tc.TestCaseID, tc.Name, count(tc.TestCaseID) AS TotalCount
                                     FROM testsuites ts, testsuites_testruns tstr, testruns tr, results r
                                     INNER JOIN testruns_testcaseinstances trtci USING (TestRun_TestCaseInstanceID)
                                     INNER JOIN testcaseinstances tci USING (TestCaseInstanceID)
                                     INNER JOIN testcases tc USING (TestCaseID)
                                     WHERE r.TestSuiteID = ts.TestSuiteID
                                     AND ts.TestSuiteID = tstr.TestSuiteID
                                     AND tstr.TestRunID = tr.TestRunID
                                     AND r.Date >= '$StartDate'
                                     AND r.Date <= '$EndDate'
                                     AND ts.TestSuiteID = '$TestSuiteID'
                                     GROUP BY tc.TestCaseID");
        
        return (isset($results) && $results != "") ? $results : false;
    }
    
    //
    // getSummaryManCount() - Returns the number of test case instances that were executed manually in a given test suite, within a specific time range
    // Input:  $db          - Database object
    //         $TestSuiteID - Test suite id value
    //         $StartDate   - Starting date range value
    //         $EndDate     - Ending date range value
    // Output: Integer containing the number of test case instances that were executed manually in a given test suite, within a specific time range
    function getSummaryManCount($db, $TestSuiteID, $StartDate, $EndDate) {
        $row = $db->get_row("SELECT count(tc.TestCaseID) AS TotalCount
                             FROM testsuites ts, testsuites_testruns tstr, testruns tr, results r
                             INNER JOIN testruns_testcaseinstances trtci USING (TestRun_TestCaseInstanceID)
                             INNER JOIN testcaseinstances tci USING (TestCaseInstanceID)
                             INNER JOIN testcases tc USING (TestCaseID)
                             WHERE r.TestSuiteID = ts.TestSuiteID
                             AND ts.TestSuiteID = tstr.TestSuiteID
                             AND tstr.TestRunID = tr.TestRunID
                             AND r.Date >= '$StartDate'
                             AND r.Date <= '$EndDate'
                             AND ts.TestSuiteID = '$TestSuiteID'
                             AND r.InitiateType = 'cmdline'");
        
        return (isset($row) && $row != "") ? $row->TotalCount : false;
    }
    
    //
    // getSummaryAutoCount() - Returns the number of test case instances that were executed automatically in a given test suite, within a specific time range
    // Input:  $db          - Database object
    //         $TestSuiteID - Test suite id value
    //         $StartDate   - Starting date range value
    //         $EndDate     - Ending data range value
    // Output: Integer containing the number of test case instances that were executed automatically in a given test suite, within a specific time range
    function getSummaryAutoCount($db, $TestSuiteID, $StartDate, $EndDate) {
        $row = $db->get_row("SELECT count(tc.TestCaseID) AS TotalCount
                             FROM testsuites ts, testsuites_testruns tstr, testruns tr, results r
                             INNER JOIN testruns_testcaseinstances trtci USING (TestRun_TestCaseInstanceID)
                             INNER JOIN testcaseinstances tci USING (TestCaseInstanceID)
                             INNER JOIN testcases tc USING (TestCaseID)
                             WHERE r.TestSuiteID = ts.TestSuiteID
                             AND ts.TestSuiteID = tstr.TestSuiteID
                             AND tstr.TestRunID = tr.TestRunID
                             AND r.Date >= '$StartDate'
                             AND r.Date <= '$EndDate'
                             AND ts.TestSuiteID = '$TestSuiteID'
                             AND r.InitiateType = 'browser'");
        
        return (isset($row) && $row != "") ? $row->TotalCount : false;
    }
    
    //
    // addTime() - Function that adds two time values in the format HH:MM:SS
    // Input:  $Time1 - First time value
    //         $Time2 - Second time value
    // Output: String containing the added time value in the format HH:MM:SS
    function addTime($Time1, $Time2) {
        list($hour1, $minute1, $second1) = split('[:]', $Time1);
        list($hour2, $minute2, $second2) = split('[:]', $Time2);
        
        // Calculate the total number of seconds that have elapsed
        $secondsElapsed = ($hour1 + $hour2) * 3600;
        $secondsElapsed += ($minute1 + $minute2) * 60;
        $secondsElapsed += $second1 + $second2;
        
        // Calculate our time variables
        $hours = floor($secondsElapsed / 3600);
        $remainingTime = $secondsElapsed - $hours * 3600;
        $minutes = floor($remainingTime / 60);
        $seconds = $remainingTime - $minutes * 60;
        
        // Define our time value
        $totalHours   = (($hours < 10) ? "0" : "") . $hours;
        $totalMinutes = (($minutes < 10) ? ":0" : ":") . $minutes;
        $totalSeconds = (($seconds < 10) ? ":0" : ":") . $seconds;
        $timeValue = $totalHours . $totalMinutes . $totalSeconds;
        
        return ($timeValue) ? $timeValue : "Undefined";
    }
    
}

    $myReport = &new reports();

?>
