<?php

######################################################################################
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.4 $
# Last Modified: $Date: 2005/09/30 21:01:03 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbitaldata/control/php-lib/modules/testsuite.php,v $
#
######################################################################################



class testSuite {


    function testSuite() {
    	// Object constructor
    }

    //
    // getTestInstances() - Get a detailed list of all test case instances (including machines involved and parameter settings)
    // Input:  $db - Database object
    // Output: Associative array containing test instance details
    function getTestInstances($db, $SortBy='', $Direction='') {
        if (empty($SortBy) || $SortBy == "Name") {
            $SortBy = "tc.Name";
        }
		if ($SortBy == "TestCaseInstanceID") {
			$SortBy = "tci.TestCaseInstanceID";
		}
        if (empty($Direction)) {
            $Direction = "ASC";
        }
	    $results = $db->get_results("SELECT tci.TestCaseInstanceID, tci.TestCaseID AS test_case_id, tc.Name AS test_case,
                                        tci.ParamSetID, tci.MachineGroupID, '' AS param_set, '' AS machine_group, mg.Name AS machine_group_name, 
                                        mg.Description AS machine_group_desc, ps.Name AS param_set_name
                                     FROM testcaseinstances tci, testcases tc, machinegroups mg, paramsets ps
                                     WHERE tci.TestCaseID = tc.TestCaseID
                                     AND tci.MachineGroupID = mg.MachineGroupID
                                     AND tci.ParamSetID = ps.ParamSetID
                                     ORDER BY $SortBy $Direction");
        
        // Iterate through each test case instance
        foreach ($results as $instance) {
            // Fetch all parameter configurations for each test case instance
            $parameters = $db->get_results("SELECT p.ParamName, p.MachineType, pv.Value, ps.ParamSetID 
                                            FROM params p 
                                            INNER JOIN paramvalues pv USING (ParamsID) 
                                            INNER JOIN paramsets_params_paramvalues ppp USING (ParamValuesID) 
                                            INNER JOIN paramsets ps USING (ParamSetID) 
                                            WHERE ps.ParamSetID = '".$instance->{'ParamSetID'}."'");
            
            $instance->{'param_set'} = $parameters;

            // Fetch our machine groups (list of clients, servers, orbitals, and wan-sim involved)
            $machines = $db->get_results("SELECT m.Name as name, m.IPaddress AS ip_address, m.OS AS os, m.MachineType, mg.MachineGroupID, mg.Description
                                          FROM machines m
                                          INNER JOIN machinegroups_machines mgm USING (MachineID)
                                          INNER JOIN machinegroups mg USING (MachineGroupID)
                                          WHERE mg.MachineGroupID = '".$instance->{'MachineGroupID'}."' ");
            $instance->{'machine_group'} = $machines;
        }
        
        return ($results) ? $results : false;
    }

    //
    // addTestInstance() - Add the given test instance to the database (make sure we don't duplicate instances)
    // Input:  $db             - Database object
    //         $TestCaseID     - The test case id
    //         $ParamSetID     - The parameter set id
    //         $MachineGroupID - The machine group id
    // Output: Returns the insert id value for the new record or false on failure
    function addTestInstance($db, $TestCaseID, $ParamSetID, $MachineGroupID) {
        $row = $db->get_row("SELECT * FROM testcaseinstances
                             WHERE TestCaseID = '$TestCaseID' AND
                                ParamSetID = '$ParamSetID' AND
                                MachineGroupID = '$MachineGroupID' ");
        
        // If a record already exists with the same instance data, return false
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO testcaseinstances SET
                        TestCaseID     = '$TestCaseID',
                        ParamSetID     = '$ParamSetID',
                        MachineGroupID = '$MachineGroupID' ");
        
        return (isset($db->insert_id)) ? $db->insert_id : false;
    }

    //
    // editTestInstance() - Edit the given test instance in the database (make sure instance exists)
    // Input:  $db                 - Database object
    //         $TestCaseInstanceID - Test test case instance id
    //         $TestCaseID         - The test case id
    //         $ParamSetID         - The parameter set id
    //         $MachineGroupID     - The machine group id
    // Output: Returns true on success or false on failure
    function editTestInstance($db, $TestCaseInstanceID, $TestCaseID, $ParamSetID, $MachineGroupID) {
        $row = $db->get_row("SELECT * FROM testcaseinstances
                             WHERE TestCaseInstanceID = '$TestCaseInstanceID'");
        
        // If a record doesn't exist, return false
        if (empty($row)) {
            return false;
        }
        
        // Next, let's archive the original data
        $this->archiveTestInstance($db, $row->TestCaseInstanceID, $row->TestCaseID, $row->ParamSetID, $row->MachineGroupID, time());
        
        // Finally, let's edit the data
        $retval = $db->query("UPDATE testcaseinstances SET
                                  TestCaseID     = '$TestCaseID',
                                  ParamSetID     = '$ParamSetID',
                                  MachineGroupID = '$MachineGroupID',
                                  Modified       = '1'
                              WHERE TestCaseInstanceID = '$TestCaseInstanceID'");
        
        return ($retval) ? true : false;
    }
    
    //
    // archiveTestInstance() - Archive the given test case instance in the database
    // Input:  $db                 - Database object
    //         $TestCaseInstanceID - Test case instance id
    //         $TestCaseID         - The test case id
    //         $ParamSetID         - The parameter set id
    //         $MachineGroupID     - The machine group id
    // Output: Returns the number of rows affected or false on failure
    function archiveTestInstance($db, $TestCaseInstanceID, $TestCaseID, $ParamSetID, $MachineGroupID, $Timestamp) {
        
        $db->query("INSERT INTO archive_testcaseinstances SET
                        TestCaseInstanceID = '$TestCaseInstanceID',
                        TestCaseID         = '$TestCaseID',
                        ParamSetID         = '$ParamSetID',
                        MachineGroupID     = '$MachineGroupID',
                        Timestamp          = '$Timestamp'");
        
        return (isset($db->rows_affected)) ? $db->rows_affected : false;
    }
    
    //
    // getTestInstanceDetails() - Get detailed information on the test case instance using the given id value
    // Input:  $db                 - Database object
    //         $TestCaseInstanceID - Test case instance id
    // Output: Associative array containing the test case instance details
    function getTestInstanceDetails($db, $TestCaseInstanceID) {
        $row = $db->get_row("SELECT tci.TestCaseInstanceID, tc.TestCaseID, tc.Name, ps.ParamSetID, ps.Name, mg.MachineGroupID, mg.Name
                             FROM testcaseinstances tci, testcases tc, paramsets ps, machinegroups mg
                             WHERE tci.TestCaseID = tc.TestCaseID AND
                                tci.ParamSetID = ps.ParamSetID AND
                                tci.MachineGroupID = mg.MachineGroupID AND
                                TestCaseInstanceID = '$TestCaseInstanceID'");
        
        return ($row) ? $row : false;
    }
    
    //
    // getTestCases() - Get a detailed list of all test cases
    // Input:  $db - Database object
    // Output: Associative array containing test case details
    function getTestCases($db, $SortBy, $Direction) {
        if (empty($SortBy)) {
            $SortBy = "Name";
        }
        if (empty($Direction)) {
            $Direction = "ASC";
        }
        $results = $db->get_results("SELECT tc.TestCaseID AS test_case_id, tc.Name AS test_case, tc.Path AS share, tc.Description, tc.Version, tc.Category, tc.ExecType, tc.Concurrent
		                             FROM testcases tc
                                     ORDER BY tc.$SortBy $Direction");
        
        return ($results) ? $results : false;
    }

    //
    // addTestCase() - Add the given test case to the database (check to make sure the record is not a duplicate)
    // Input:  $db          - Database object
    //         $Name        - Name of the test case
    //         $Description - Description of the test case
    //         $Version     - Version of the test case
    //         $Path        - Path of the test case
    //         $Category    - Test case category
    //         $ExecType    - Test case execution type
    // Output: Returns the insert id value for the new record or false on failure
    function addTestCase($db, $Name, $Description='', $Version, $Path, $Category, $ExecType, $Concurrent='') {
        $row = $db->get_row("SELECT * FROM testcases
                             WHERE Name  = '$Name' AND
                                Version  = '$Version' AND
                                Path     = '$Path' AND
                                Category = '$Category' AND
                                ExecType = '$ExecType'");
        
        // If a record already exists with the same test case data, return false
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO testcases SET
                        Name        = '$Name',
                        Description = '$Description',
                        Version     = '$Version',
                        Path        = '$Path',
                        Category    = '$Category',
                        Concurrent  = '$Concurrent',
                        ExecType    = '$ExecType'");
        
        return (isset($db->insert_id)) ? $db->insert_id : false;
    }

    //
    // editTestCase() - Edit the given test case in the database (check to make sure the record exists)
    // Input:  $db          - Database object
    //         $TestCaseID  - Test case id value
    //         $Name        - Name of the test case
    //         $Description - Description of the test case
    //         $Version     - Version of the test case
    //         $Path        - Path of the test case
    //         $Category    - Test case category
    //         $ExecType    - Test case execution type
    // Output: Returns true on success or false on failure
    function editTestCase($db, $TestCaseID, $Name, $Description='', $Version, $Path, $Category, $ExecType, $Concurrent='') {
        $row = $db->get_row("SELECT * FROM testcases
                             WHERE TestCaseID = '$TestCaseID'");
        
        // If a record does not exist, return false
        if (empty($row)) {
            return false;
        }
        
        // Next, let's archive the original data
        $this->archiveTestCase($db, $row->TestCaseID, $row->Name, $row->Description, $row->Version, $row->Path, $row->Category, $row->ExecType, $row->Concurrent, time());
        
        // Finally, let's edit the data
        $retval = $db->query("UPDATE testcases SET
                                  Name        = '$Name',
                                  Description = '$Description',
                                  Version     = '$Version',
                                  Path        = '$Path',
                                  Category    = '$Category',
                                  Concurrent  = '$Concurrent',
                                  ExecType    = '$ExecType',
                                  Modified    = '1'
                              WHERE TestCaseID = '$TestCaseID'");
        
        return ($retval) ? true : false;
    }

    //
    // archiveTestCase() - Archive the given test case in the database
    // Input:  $db          - Database object
    //         $TestCaseID  - Test case id value
    //         $Name        - Name of the test case
    //         $Description - Description of the test case
    //         $Version     - Version of the test case
    //         $Path        - Path of the test case
    //         $Category    - Test case category
    //         $ExecType    - Test case execution type
    //         $Timestamp   - Timestamp of when data was entered
    // Output: Returns the number of rows affected or false on failure
    function archiveTestCase($db, $TestCaseID, $Name, $Description='', $Version, $Path, $Category, $ExecType, $Concurrent='', $Timestamp) {
        
        $db->query("INSERT INTO archive_testcases SET
                        TestCaseID  = '$TestCaseID',
                        Name        = '$Name',
                        Description = '$Description',
                        Version     = '$Version',
                        Path        = '$Path',
                        Category    = '$Category',
                        Concurrent  = '$Concurrent',
                        ExecType    = '$ExecType',
                        Timestamp   = '$Timestamp'");
        
        return (isset($db->rows_affected)) ? $db->rows_affected : false;
    }
    
    //
    // getTestCaseDetails() - Get the details of a specific test case using the given test case ID
    // Input:  $db         - Database object
    //         $TestCaseID - Test case id value
    // Output: Associative array containing test case details
    function getTestCaseDetails($db, $TestCaseID) {
        $row = $db->get_row("SELECT tc.TestCaseID AS test_case_id, tc.Name AS test_case, tc.Path AS share, tc.Description, tc.Version, tc.Category, tc.ExecType, tc.Concurrent
		                     FROM testcases tc
                             WHERE TestCaseID = '$TestCaseID'");
        
        return ($row) ? $row : false;
    }

    // getTestSuites() - Get a list of all test suites
    // Input:  $db - Database object
    // Output: Associative array containing a list of all test suites
    function getTestSuites($db, $SortBy='', $Direction='') {
        if (empty($SortBy)) {
            $SortBy = "Name";
        }
        if (empty($Direction)) {
            $Direction = "ASC";
        }
        $results = $db->get_results("SELECT * FROM testsuites ORDER BY $SortBy $Direction");
        
        return ($results) ? $results : false;
    }
    
    //
    // addTestSuite() - Add the given test suite to the database (check to make sure the record is not a duplicate)
    // Input:  $db            - Database object
    //         $TestGroupList - Array containing a list of test group id values
    //         $Name          - Name of the test suite
    //         $Description   - Description of the test suite
    // Output: Returns the insert id value for the new record or false on failure
    function addTestSuite($db, $TestGroupList, $Name, $Description='') {
        $row = $db->get_row("SELECT * FROM testsuites
                             WHERE Name = '$Name'");
        
        // If a record already exists with the same test suite data, return false
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO testsuites SET
                        Name        = '$Name',
                        Description = '$Description'");
        
        if (empty($db->insert_id)) {
            return false;
        }
        
        $TestSuiteID = $db->insert_id;
        
        // Insert all test groups into the new test suite
        foreach ($TestGroupList as $TestRunID) {
            $db->query("INSERT INTO testsuites_testruns SET
                            TestSuiteID = '$TestSuiteID',
                            TestRunID   = '$TestRunID'");
        }
        
        return $TestSuiteID;
    }

    //
    // editTestSuite() - Edit the given test suite in the database (check to make sure the record exists)
    // Input:  $db            - Database object
    //         $TestSuiteID   - Test suite id value
    //         $TestGroupList - Array containing a list of test group id values
    //         $Name          - Name of the test suite
    //         $Description   - Description of the test suite
    // Output: Returns true on success or false on failure
    function editTestSuite($db, $TestSuiteID, $TestGroupList, $Name, $Description='') {
        $row = $db->get_row("SELECT * FROM testsuites
                             WHERE TestSuiteID = '$TestSuiteID'");
        
        // If a record does not exist, return false
        if (empty($row)) {
            return false;
        }

        // Fetch our test groups to archive
        $archiveGroups = $db->get_results("SELECT * FROM testsuites_testruns WHERE TestSuiteID = '$TestSuiteID'");

        // Make sure we have a list of test groups
        if (empty($archiveGroups)) {
            return false;
        }

        // Next, let's archive the original data
        $this->archiveTestSuite($db, $row->TestSuiteID, $archiveGroups, $row->Name, $row->Description, time());
        
        // Finally, let's edit the data
        $retval = $db->query("UPDATE testsuites SET
                                  Name        = '$Name',
                                  Description = '$Description',
                                  Modified    = '1'
                              WHERE TestSuiteID = '$TestSuiteID'");
        
        // Edit all test groups within the suite
        $group_count = 0;
        foreach ($TestGroupList as $TestRunID) {
            // Check if the group we want to add already exists in the database
            $group_exists = false;
            for ($i=0; $i <= sizeof($archiveGroups); $i++) {
                if ($TestRunID == $archiveGroups[$i]->TestRunID) {
                    // If the group does exist, we dump it out of our "delete" list
                    array_splice($archiveGroups, $i, 1);
                    $group_exists = true;
                    break;
                }
            }
            
            // If the group doesn't exist, add it to our suite
            if ($group_exists == false) {
                $retval = $this->addTestGroupToSuite($db, $TestSuiteID, $TestRunID);
            }
            $group_count++;
        }
        
        // Finally, delete the groups that have not been selected
        foreach ($archiveGroups as $deleteTestRun) {
            $retval = $this->deleteTestGroupFromSuite($db, $TestSuiteID, $deleteTestRun->TestRunID);
        }

        return ($group_count == sizeof($TestGroupList)) ? $group_count : false;
    }

    //
    // archiveTestSuite() - Archive the given test suite in the database
    // Input:  $db           - Database object
    //         $TestSuiteID  - Test suite id value
    //         $Name         - Name of the test suite
    //         $Description  - Description of the test suite
    // Output: Returns the number of rows affected or false on failure
    function archiveTestSuite($db, $TestSuiteID, $TestGroupList, $Name, $Description='', $Timestamp) {
        
        $db->query("INSERT INTO archive_testsuites SET
                        TestSuiteID = '$TestSuiteID',
                        Name        = '$Name',
                        Description = '$Description',
                        Timestamp   = '$Timestamp'");
        
        // Insert all test groups into the archive
        foreach ($TestGroupList as $testgroup) {
            $db->query("INSERT INTO archive_testsuites_testruns SET
                            TestSuite_TestRunID = '".$testgroup->TestSuite_TestRunID."',
                            TestSuiteID         = '$TestSuiteID',
                            TestRunID           = '".$testgroup->TestRunID."',
                            Timestamp           = '$Timestamp'");
        }

        return (isset($db->num_rows)) ? true : false;
    }

    //
    // getTestSuiteDetails() - Get the details of a specific test suite using the given test suite ID
    // Input:  $db          - Database object
    //         $TestSuiteID - Test suite id value
    // Output: Associative array containing test suite details
    function getTestSuiteDetails($db, $TestSuiteID) {
        $row = $db->get_row("SELECT ts.TestSuiteID, ts.Name, ts.Description, '' AS TestGroups
		                     FROM testsuites ts
                             WHERE TestSuiteID = '$TestSuiteID'");
        
        if (empty($row)) {
            return false;
        }
        
        $row->TestGroups = $this->getTestGroupsInSuite($db, $TestSuiteID);
        
        return ($row) ? $row : false;
    }

    //
    // addTestGroupToSuite() - Add a test group to the given test suite
    // Input:  $db          - Database object
    //         $TestSuiteID - Test suite id value
    //         $TestRunID   - Test run id value
    // Output: Returns the last insert id or false on failure
    function addTestGroupToSuite($db, $TestSuiteID, $TestRunID) {
        $row = $db->get_row("SELECT * FROM testsuites_testruns
                             WHERE TestSuiteID = '$TestSuiteID'
                             AND TestRunID = '$TestRunID'");
        
        // If a record already exists with the same test group data for the test suite, return false
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO testsuites_testruns SET
                        TestSuiteID = '$TestSuiteID',
                        TestRunID   = '$TestRunID'");
        
        return (isset($db->insert_id)) ? $db->insert_id : false;
    }

    //
    // deleteTestGroupFromSuite() - Delete the selected test group from the given test suite
    // Input:  $db          - Database object
    //         $TestSuiteID - Test suite id value
    //         $TestRunID   - Test run id
    // Output: Returns true on success and false on failure
    function deleteTestGroupFromSuite($db, $TestSuiteID, $TestRunID) {
        $db->query("DELETE FROM testsuites_testruns
                    WHERE TestSuiteID = '$TestSuiteID' AND TestRunID = '$TestRunID'");
        
        return (isset($db->rows_affected)) ? true : false;
    }

    // getTestSuitesForRun() - Get a list of all test suites for the given test run
    // Input:  $db        - Database object
    //         $TestRunID - Test run id value
    // Output: Associative array containing a list of all test suites for the given test run
    function getTestSuitesForRun($db, $TestRunID) {
        $results = $db->get_results("SELECT ts.TestSuiteID, ts.Name
                                     FROM testsuites ts, testsuites_testruns tstr
                                     WHERE tstr.TestSuiteID = ts.TestSuiteID
                                     AND tstr.TestRunID = '$TestRunID'");
        
        return ($results) ? $results : false;
    }
    
    //
    // getTestGroups() - Get a list of all test groups
    // Input:  $db - Database object
    // Output: Array containing all test group details
    function getTestGroups($db, $SortBy = '', $Direction = '') {
        if (empty($SortBy)) {
            $SortBy = "Name";
        }
        if (empty($Direction)) {
            $Direction = "ASC";
        }
        $results = $db->get_results("SELECT * FROM testruns ORDER BY $SortBy $Direction");
        
        return ($results) ? $results : false;
    }
    
    //
    // getTestGroupDetails() - Get detailed information on a specific test group, including all test suites associated with and a list of all test case instances
    // Input:  $db        - Database object
    //         $TestRunID - Test run id value
    // Output: Associative array containing detailed information on a specific test group (test run)
    function getTestGroupDetails($db, $TestRunID) {
        $row = $db->get_row("SELECT tr.TestRunID, tr.Name, tr.Description, tr.KillConnections, '' AS test_suites, '' AS instances
                             FROM testruns tr WHERE tr.TestRunID = '$TestRunID'");
        
        if (empty($row)) {
            return false;
        }
        
        $row->test_suites = $this->getTestSuitesForRun($db, $TestRunID);
        $row->instances = $this->getTestRunDetails($db, $TestRunID);
        
        return ($row) ? $row : false;
    }
    
    //
    // editTestGroupDetails() - Edit the details of the given test group
    // Input:  $db          - Database object
    //         $TestRunID   - Test run id value
    //         $Name        - Name of the test group
    //         $Description - Description of the test group
    //         $SuiteList   - Array containing a list of all test suite id values to associate the test group with
    // Output: Returns true on success or false on failure
    function editTestGroupDetails($db, $TestRunID, $Name, $Description='', $SuiteList) {
        $row = $db->get_row("SELECT * FROM testruns WHERE TestRunID = '$TestRunID'");
        
        if (empty($row)) {
            return false;
        }
        
        // Archive the test group details
        $this->archiveTestGroupDetails($db, $TestRunID, $row->Name, $row->Description, $row->KillConnections, time());
        
        $retval = $db->query("UPDATE testruns SET
                                  Name        = '$Name',
                                  Description = '$Description'
                              WHERE TestRunID = '$TestRunID'");
        
        // Fetch a list of all test suites for the current test group
        $archiveSuites = $this->getTestSuitesForRun($db, $TestRunID);
        
        // Edit all test suites for the given group
        $suite_count = 0;
        foreach ($SuiteList as $TestSuiteID) {
            // Check if the test suite we want to add already exists in the database
            $suite_exists = false;
            for ($i=0; $i <= sizeof($archiveSuites); $i++) {
                if ($TestSuiteID == $archiveSuites[$i]->TestSuiteID) {
                    // If the test suite does exist, we dump it out of our "delete" list
                    array_splice($archiveSuites, $i, 1);
                    $suite_exists = true;
                    break;
                }
            }
            
            // If the test suite doesn't exist, add it to our test group
            if ($suite_exists == false) {
                $retval = $this->addSuiteToTestGroup($db, $TestSuiteID, $TestRunID);
            }
            $suite_count++;
        }
        
        // Finally, delete the test suites that have not been selected
        foreach ($archiveSuites as $deleteTestSuite) {
            $retval = $this->deleteSuiteFromTestGroup($db, $TestRunID, $deleteTestSuite->TestSuiteID);
        }

        return ($suite_count == sizeof($SuiteList)) ? $suite_count : false;
    }
    
    //
    // archiveTestGroupDetails() - Archive the given test group data
    // Input:  $db          - Database object
    //         $TestRunID   - Test run id value
    //         $Name        - Name of test run
    //         $Description - Description of test run
    // Output: Returns the number of rows affected or false on failure
    function archiveTestGroupDetails($db, $TestRunID, $Name, $Description, $KillConnections='', $Timestamp) {
        $db->query("INSERT INTO archive_testruns SET
                        TestRunID       = '$TestRunID',
                        Name            = '$Name',
                        Description     = '$Description',
                        KillConnections = '$KillConnections',
                        Timestamp       = '$Timestamp'");
        
        return (isset($db->num_rows)) ? true : false;
    }
    
    //
    // addSuiteToTestGroup() - Add a test suite to the given test group
    // Input:  $db          - Database object
    //         $TestSuiteID - Test suite id value
    //         $TestRunID   - Test run id value
    // Output: Returns the last insert id or false on failure
    function addSuiteToTestGroup($db, $TestSuiteID, $TestRunID) {
        $row = $db->get_row("SELECT * FROM testsuites_testruns
                             WHERE TestSuiteID = '$TestSuiteID'
                             AND TestRunID = '$TestRunID'");
        
        // If a record already exists with the same test group data for the test suite, return false
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO testsuites_testruns SET
                        TestSuiteID = '$TestSuiteID',
                        TestRunID   = '$TestRunID'");
        
        return (isset($db->insert_id)) ? $db->insert_id : false;
    }

    //
    // deleteSuiteFromTestGroup() - Delete the selected test suite from the given test group
    // Input:  $db          - Database object
    //         $TestSuiteID - Test suite id value
    //         $TestRunID   - Test run id
    // Output: Returns true on success and false on failure
    function deleteSuiteFromTestGroup($db, $TestRunID, $TestSuiteID) {
        $db->query("DELETE FROM testsuites_testruns
                    WHERE TestSuiteID = '$TestSuiteID' AND TestRunID = '$TestRunID'");
        
        return (isset($db->rows_affected)) ? true : false;
    }
    
    //
    // editTestGroupInstances() - Edit which test case instances should be associated with the given test group (test run)
    // Input:  $db           - Database object
    //         $TestRunID    - Test run id value
    //         $InstanceList - Array containing a list of all test case instances to include in our test group
    // Output: Returns true on success or false on failure
    function editTestGroupInstances($db, $TestRunID, $InstanceList) {
        $row = $db->get_row("SELECT * FROM testruns WHERE TestRunID = '$TestRunID'");
        
        if (empty($row)) {
            return false;
        }
        
        // Fetch our original test case instances
        $archiveInstances = $db->get_results("SELECT * FROM testruns_testcaseinstances WHERE TestRunID = '$TestRunID'");
        
        if (!empty($archiveInstances)) {
            // Archive our original instance values
            $this->archiveTestGroupInstances($db, $TestRunID, $archiveInstances, time());
        }
        
        // Edit all test case instances within the test group
        $instance_count = 0;
        foreach ($InstanceList as $TestCaseInstanceID) {
            // Check if the instance we want to add already exists in the database
            $instance_exists = false;
            for ($i=0; $i <= sizeof($archiveInstances); $i++) {
                if ($TestCaseInstanceID == $archiveInstances[$i]->TestCaseInstanceID) {
                    // If the instance does exist, we dump it out of our "delete" list
                    array_splice($archiveInstances, $i, 1);
                    $instance_exists = true;
                    break;
                }
            }
            
            // If the instance doesn't exist, add it to our test group
            if ($instance_exists == false) {
                $retval = $this->addInstanceToTestGroup($db, $TestRunID, $TestCaseInstanceID);
            }
            $instance_count++;
        }
        
        // Finally, delete the instances that have not been selected
        foreach ($archiveInstances as $deleteInstance) {
            $retval = $this->deleteInstanceFromTestGroup($db, $TestRunID, $deleteInstance->TestCaseInstanceID);
        }

        return ($instance_count == sizeof($InstanceList)) ? $instance_count : false;
    }
    
    //
    // archiveTestGroupInstances() - Archive the list of test case instances into the database
    // Input:  $db           - Database object
    //         $TestRunID    - Test run id value
    //         $InstanceList - Array containing a list of all test case instances
    //         $Timestamp    - String containing a timestamp value
    // Output: Returns the number of rows affected or false on failure
    function archiveTestGroupInstances($db, $TestRunID, $InstanceList, $Timestamp) {
        // Insert all test case instances into the archive
        foreach ($InstanceList as $instance) {
            $db->query("INSERT INTO archive_testruns_testcaseinstances SET
                            TestRun_TestCaseInstanceID = '".$instance->TestRun_TestCaseInstanceID."',
                            TestRunID                  = '$TestRunID',
                            TestCaseInstanceID         = '".$instance->TestCaseInstanceID."',
                            Timestamp                  = '$Timestamp'");
        }

        return (isset($db->num_rows)) ? true : false;
    }
    
    //
    // addInstanceToTestGroup() - Add the test case instance to the given test group
    // Input:  $db                 - Database object
    //         $TestRunID          - Test run id value
    //         $TestCaseInstanceID - Test case instance id value
    // Output: Returns the last inserted id value on success, or false on failure
    function addInstanceToTestGroup($db, $TestRunID, $TestCaseInstanceID) {
        $row = $db->get_row("SELECT * FROM testruns_testcaseinstances
                             WHERE TestRunID = '$TestRunID'
                             AND TestCaseInstanceID = '$TestCaseInstanceID'");
        
        // If a record already exists with the same test case instance data for the test group, return false
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO testruns_testcaseinstances SET
                        TestRunID          = '$TestRunID',
                        TestCaseInstanceID = '$TestCaseInstanceID'");
        
        return (isset($db->insert_id)) ? $db->insert_id : false;
    }
    
    //
    // deleteInstanceFromTestGroup() - Delete the test case instance for the given test group
    // Input:  $db                 - Database object
    //         $TestRunID          - Test run id value
    //         $TestCaseInstanceID - Test case instance id value
    // Output: Returns true on success or false on failure
    function deleteInstanceFromTestGroup($db, $TestRunID, $TestCaseInstanceID) {
        $db->query("DELETE FROM testruns_testcaseinstances
                    WHERE TestRunID = '$TestRunID' AND TestCaseInstanceID = '$TestCaseInstanceID'");
        
        return (isset($db->rows_affected)) ? true : false;
    }
    
    //
    // getTestGroupsInSuite() - Get a list of all test groups (test runs) within the given test suite
    // Input:  $db          - Database object
    //         $TestSuiteID - Test suite id
    // Output: Array containing all test group details
    function getTestGroupsInSuite($db, $TestSuiteID) {
        $results = $db->get_results("SELECT tr.TestRunID, tr.Name, tr.Description, ts.TestSuiteID
                                     FROM testsuites ts
                                     INNER JOIN testsuites_testruns tstr USING (TestSuiteID)
                                     INNER JOIN testruns tr USING (TestRunID)
                                     WHERE ts.TestSuiteID = '$TestSuiteID'");
        
        return ($results) ? $results : false;
    }
    
    //
    // getInstancesInTestGroup() - Get a list of all test case instances within a given test group
    // Input:  $db        - Database object
    //         $TestRunID - Test run id value
    // Output: Associative array containing a list of all test case instances within a given test group
    function getInstancesInTestGroup($db, $TestRunID) {
        $results = $db->get_results("SELECT tci.TestCaseInstanceID, tc.TestCaseID, tc.Name as test_case_name, ps.ParamSetID, ps.Name as param_set_name,
                                     mg.MachineGroupID, mg.Name as machine_group_name 
                                     FROM paramsets ps, machinegroups mg, testruns_testcaseinstances trtci
                                     INNER JOIN testcaseinstances tci USING (TestCaseInstanceID)
                                     INNER JOIN testcases tc USING (TestCaseID)
                                     WHERE tci.ParamSetID = ps.ParamSetID
                                     AND tci.MachineGroupID = mg.MachineGroupID
                                     AND trtci.TestRunID = '$TestRunID'");
        
        return ($results) ? $results : false;
    }
    
    //
    // getTestCaseCategories() - Get a list of all enum fields for test case categories
    // Input:  $db - Database object
    // Output: Array containing all enum fields for test case category types
    function getTestCaseCategories($db) {
        $row = $db->query("SHOW COLUMNS FROM testcases LIKE 'Category'");

        // Get the second row from the cached results by using a null query
        $row_details = $db->get_row(null, ARRAY_A, 0);

        // Fetch the enum values for the field
        $values = explode("','", preg_replace("/(enum|set)\('(.+?)'\)/", "\\2", $row_details['Type']));

        return $values;
    }

    //
    // getExecutionTypes() - Get a list of all enum fields for test case execution types
    // Input:  $db - Database object
    // Output: Array containing all enum fields for test case execution types
    function getExecutionTypes($db) {
        $row = $db->query("SHOW COLUMNS FROM testcases LIKE 'ExecType'");
        
        // Get the second row from the cached results by using a null query
        $row_details = $db->get_row(null, ARRAY_A, 0);

        // Fetch the enum values for the field
        $values = explode("','", preg_replace("/(enum|set)\('(.+?)'\)/", "\\2", $row_details['Type']));

        return $values;
    }
    
    //
    // getTestCaseInstances() - Get a list of all instances (including details) for each given test case (from a list of testcases)
    // Input:  $db        - Database object
    //         $TestCases - Array containing a list of all test case ids
    // Output: Multi-dimensional associative array containing a list of test cases, and a list of instances for each test case
    function getTestCaseInstances($db, $TestCases) {
        // Make sure we have a list of test cases
        if (empty($TestCases)) {
            return false;
        }
        
        // Initialize our array to return
        $TestCaseInstances = array();
        
        foreach ($TestCases as $TestCaseID) {
            // Fetch a list of all test case instances for the given test case
            $instances = $this->getInstancesForTestCase($db, $TestCaseID);
            
            $TestCaseInstances[$TestCaseID] = $instances;
        }
        
        return ($TestCaseInstances) ? $TestCaseInstances : false;
    }
    
    //
    // getInstancesForTestCase() - Get a list (including details) of all instances for the given test case
    // Input:  $db         - Database object
    //         $TestCaseID - Test case id
    // Output: Multi-dimensional associative array containing detailed information on all test case instances for the given test case
    function getInstancesForTestCase($db, $TestCaseID) {
        $results = $db->get_results("SELECT tci.TestCaseInstanceID, tci.TestCaseID AS test_case_id, tc.Name AS test_case,
                                         tci.ParamSetID, ps.Name AS param_set_name, ps.Description AS param_set_desc, '' AS param_set, 
                                         tci.MachineGroupID, mg.Name AS machine_group_name, mg.Description AS machine_group_desc, '' AS machine_group 
                                     FROM testcaseinstances tci, testcases tc, machinegroups mg, paramsets ps
                                     WHERE tci.TestCaseId = tc.TestCaseId
                                     AND tci.MachineGroupID = mg.MachineGroupID
                                     AND tci.ParamSetID = ps.ParamSetID
                                     AND tci.TestCaseID = '$TestCaseID'");
        
        // Make sure we returned some results
        if (empty($results)) {
            return false;
        }
        
        // Iterate through each instance
        foreach ($results as $instance) {
            // Fetch our machine groups (list of clients, servers, orbitals, and wan-sim involved)
            $machines = $db->get_results("SELECT m.Name as name, m.IPaddress AS ip_address, m.OS AS os, m.MachineType, mg.MachineGroupID, mg.Description
                                          FROM machines m
                                          INNER JOIN machinegroups_machines mgm USING (MachineID)
                                          INNER JOIN machinegroups mg USING (MachineGroupID)
                                          WHERE mg.MachineGroupID = '".$instance->{'MachineGroupID'}."' 
                                          ORDER BY MachineType, Name");
            $instance->{'machine_group'} = $machines;
            
            // Fetch all parameter configurations for each test case instance
            $parameters = $db->get_results("SELECT p.ParamName, p.MachineType, pv.Value, ps.ParamSetID 
                                            FROM params p 
                                            INNER JOIN paramvalues pv USING (ParamsID) 
                                            INNER JOIN paramsets_params_paramvalues ppp USING (ParamValuesID) 
                                            INNER JOIN paramsets ps USING (ParamSetID) 
                                            WHERE ps.ParamSetID = '".$instance->{'ParamSetID'}."'
                                            ORDER BY MachineType, ParamName");
            $instance->{'param_set'} = $parameters;
        }
        
        return ($results) ? $results : false;
    }

    //
    // addTestRun() - Add a test run to the database
    // Input:  $db          - Database object
    //         $Name        - Name of test run
    //         $Description - Description of test run
    // Output: Integer containing the new test run id
    function addTestRun($db, $Name, $Description) {
        $row = $db->get_row("SELECT * FROM testruns WHERE Name = '$Name'");
        
        // If a record already exists with the same test run data, return false
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO testruns SET
                        Name        = '$Name',
                        Description = '$Description'");
        
        return (isset($db->insert_id)) ? $db->insert_id : false;
    }

    //
    // addTestInstanceToRun() - Add a test case instance to the given test run
    // Input:  $db                 - Database object
    //         $TestRunID          - Test run id value
    //         $TestCaseInstanceID - Test case instance id
    // Output: Returns the last insert id or false on failure
    function addTestInstanceToRun($db, $TestRunID, $TestCaseInstanceID) {
        $row = $db->get_row("SELECT * FROM testruns_testcaseinstances
                             WHERE TestRunID = '$TestRunID'
                             AND TestCaseInstanceID = '$TestCaseInstanceID'");
        
        // If a record already exists with the same test case instance data for the test run, return false
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO testruns_testcaseinstances SET
                        TestRunID          = '$TestRunID',
                        TestCaseInstanceID = '$TestCaseInstanceID'");
        
        return (isset($db->insert_id)) ? $db->insert_id : false;
    }
    
    //
    // addRunToSuite() - Add a test run to the given test suite
    // Input:  $db          - Database object
    //         $TestRunID   - Test run id value
    //         $TestSuiteID - Test suite id
    // Output: Returns the last insert id value or false on failure
    function addRunToSuite($db, $TestRunID, $TestSuiteID) {
        $row = $db->get_row("SELECT * FROM testsuites_testruns
                             WHERE TestRunID = '$TestRunID'
                             AND TestSuiteID = '$TestSuiteID'");
        
        // If a record already exists with the same test run/test suite data, return false
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO testsuites_testruns SET
                        TestRunID   = '$TestRunID',
                        TestSuiteID = '$TestSuiteID'");
        
        return (isset($db->insert_id)) ? $db->insert_id : false;
    }

    //
    // getTestRunDetails() - Get a list of all test case instances (including, machines in machine group and parameter values in the parameter set) for a given test run
    // Input:  $db        - Database object
    //         $TestRunID - Test run id
    // Output: Returns a list of detailed information on each test case instance within a test group, or false on failure
    function getTestRunDetails($db, $TestRunID) {
        $results = $db->get_results("SELECT tci.TestCaseInstanceID, tci.TestCaseID AS test_case_id, tc.Name AS test_case, 
                                        tci.ParamSetID, ps.Name AS param_set_name, ps.Description AS param_set_desc, '' AS param_set, 
                                        tci.MachineGroupID, mg.Name AS machine_group_name, mg.Description AS machine_group_desc, '' AS machine_group
                                     FROM testcaseinstances tci, testcases tc, machinegroups mg, paramsets ps, testruns_testcaseinstances trtci, testruns tr
                                     WHERE tci.TestCaseId = tc.TestCaseId
                                     AND tci.MachineGroupID = mg.MachineGroupID
                                     AND tci.ParamSetID = ps.ParamSetID
                                     AND tci.TestCaseInstanceID = trtci.TestCaseInstanceID
                                     AND trtci.TestRunID = tr.TestRunID
                                     AND tr.TestRunID = '$TestRunID'");
        
        // Make sure we returned some results
        if (empty($results)) {
            return false;
        }
        
        // Iterate through each instance
        foreach ($results as $instance) {
            // Fetch our machine groups (list of clients, servers, orbitals, and wan-sim involved)
            $machines = $db->get_results("SELECT m.Name as name, m.IPaddress AS ip_address, m.OS AS os, m.MachineType, mg.MachineGroupID, mg.Description
                                          FROM machines m
                                          INNER JOIN machinegroups_machines mgm USING (MachineID)
                                          INNER JOIN machinegroups mg USING (MachineGroupID)
                                          WHERE mg.MachineGroupID = '".$instance->{'MachineGroupID'}."' 
                                          ORDER BY MachineType, Name");
            $instance->{'machine_group'} = $machines;
            
            // Fetch all parameter configurations for each test case instance
            $parameters = $db->get_results("SELECT p.ParamName, p.MachineType, pv.Value, ps.ParamSetID 
                                            FROM params p 
                                            INNER JOIN paramvalues pv USING (ParamsID) 
                                            INNER JOIN paramsets_params_paramvalues ppp USING (ParamValuesID) 
                                            INNER JOIN paramsets ps USING (ParamSetID) 
                                            WHERE ps.ParamSetID = '".$instance->{'ParamSetID'}."'
                                            ORDER BY MachineType, ParamName");
            $instance->{'param_set'} = $parameters;
        }
        
        return ($results) ? $results : false;
    }
    

}

    $myTestSuite = &new testSuite();

?>
