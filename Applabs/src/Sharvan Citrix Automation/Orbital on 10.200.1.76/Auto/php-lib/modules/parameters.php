<?php

######################################################################################
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.1.1.1 $
# Last Modified: $Date: 2005/09/28 23:31:11 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbitaldata/control/php-lib/modules/parameters.php,v $
#
######################################################################################



class parameters {


    function parameters() {
    	// Object constructor
    }

    //
    // getParamSets() - Get a detailed list of all parameter sets (including parameter settings)
    // Input:  $db - Database object
    // Output: Associative array containing parameter set details
    function getParamSets($db, $SortBy, $Direction) {
		if (empty($SortBy)) {
			$SortBy = "ParamSetID";
		}
		if (empty($Direction)) {
			$Direction = "ASC";
		}
        $results = $db->get_results("SELECT ps.ParamSetID, ps.Name, ps.Description, ps.DefaultSet, '' AS parameters
                                     FROM paramsets ps ORDER BY ps.$SortBy $Direction");
        
        // Iterate through each param set and fetch the associated parameters and values
        foreach ($results as $param) {
            $parameters = $db->get_results("SELECT p.ParamName, p.MachineType, pv.Value, ps.ParamSetID
                                            FROM params p 
                                            INNER JOIN paramvalues pv USING (ParamsID) 
                                            INNER JOIN paramsets_params_paramvalues ppp USING (ParamValuesID) 
                                            INNER JOIN paramsets ps USING (ParamSetID) 
                                            WHERE ps.ParamSetID = '".$param->{'ParamSetID'}."'");
            $param->{'parameters'} = $parameters;
        }
        
        return ($results) ? $results : false;
    }

    //
    // addParamSet() - Add a new parameter set and return the new primary key id value
    // Input:  $db          - Database object
    //         $Name        - Name of new parameter set
    //         $Description - Description of new parameter set
    // Output: Returns the new primary key id value
    function addParamSet($db, $Name, $Description) {
        $row = $db->get_row("SELECT * FROM paramsets WHERE Name = '$Name'");
        
        // If a record already exists with the same parameter set data, return false
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO paramsets SET
                        Name        = '$Name',
                        Description = '$Description'");
        
        return (isset($db->insert_id)) ? $db->insert_id : false;
    }
    
    //
    // editParamSet() - Edit the given parameter set
    // Input:  $db          - Database object
    //         $ParamSetID  - Parameter set id
    //         $Name        - Name of new parameter set
    //         $Description - Description of new parameter set
    // Output: Returns true on success or false on failure
    function editParamSet($db, $ParamSetID, $Name, $Description, $Timestamp) {
        $row = $db->get_row("SELECT * FROM paramsets WHERE ParamSetID = '$ParamSetID'");

        // If a record doesn't exist return false
        if (empty($row)) {
            return false;
        }
        
        // Next, archive our original data
        $this->archiveParamSet($db, $ParamSetID, $Name, $Description, $Timestamp);

        // Finally, edit the data
        $retval = $db->query("UPDATE paramsets SET
                                  Name        = '$Name',
                                  Description = '$Description',
                                  Modified    = '1'
                              WHERE ParamSetID = '$ParamSetID'");
        
        return ($retval) ? true : false;
    }
    
    //
    // archiveParamSet() - Archive the given parameter set
    // Input:  $db          - Database object
    //         $ParamSetID  - Parameter set id
    //         $Name        - Name of new parameter set
    //         $Description - Description of new parameter set
    // Output: Returns the number of rows affected or false on failure
    function archiveParamSet($db, $ParamSetID, $Name, $Description, $Timestamp) {
        
        $db->query("INSERT INTO archive_paramsets SET
                        ParamSetID  = '$ParamSetID',
                        Name        = '$Name',
                        Description = '$Description',
                        Timestamp   = '$Timestamp'");

        return (isset($db->num_rows)) ? true : false;
    }
    
    //
    // getParamSetDetails() - Fetch detailed parameter set information using the given id value
    // Input:  $db         - Database object
    //         $ParamSetID - Parameter set id
    // Output: Associative array containing parameter set details
    function getParamSetDetails($db, $ParamSetID) {
        $row = $db->get_row("SELECT ps.ParamSetID, ps.Name, ps.Description, ps.DefaultSet, '' AS parameters
                             FROM paramsets ps
                             WHERE ps.ParamSetID = '$ParamSetID'");

        // Make sure we returned a record
        if (empty($row)) {
            return false;
        }
        
        // Fetch our parameter values for each parameter
        $results = $db->get_results("SELECT ppp.ParamSetID, p.ParamsID, p.ParamName, pv.ParamValuesID, pv.Value
                                     FROM paramsets_params_paramvalues ppp, params p, paramvalues pv 
                                     WHERE ppp.ParamsID = p.ParamsID AND
                                        ppp.ParamValuesID = pv.ParamValuesID AND
                                        ParamSetID = '$ParamSetID'");

        // Put the parameter values into the parameter set
        $row->parameters = $results;
        
        return ($row) ? $row : false;
    }
    
    //
    // getParamValues() - Fetch a list of all the values for a given parameter
    // Input:  $db       - Database object
    //         $ParamsID - Parameter id value
    // Output: Returns a list of all values for given parameter
    function getParamValues($db, $ParamsID) {
        $results = $db->get_results("SELECT * FROM paramvalues WHERE ParamsID = '$ParamsID' ORDER BY Value ASC");
        
        return ($results) ? $results : false;
    }
    
    //
    // addParamValue() - Add a new parameter value and return the new primary key id value
    // Input:  $db       - Database object
    //         $ParamsID - Parameter id value
    //         $Value    - Value of the given parameter
    // Output: Returns the new primary key id value
    function addParamValue($db, $ParamsID, $Value) {
        $row = $db->get_row("SELECT * FROM paramvalues WHERE ParamsID = '$ParamsID' AND Value = '$Value'");
        
        // If a record already exists with the same parameter value data, return false
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO paramvalues SET
                        ParamsID = '$ParamsID',
                        Value    = '$Value'");
        
        return (isset($db->insert_id)) ? $db->insert_id : false;
    }
    
    //
    // addParamSetValues() - Adds a parameter value to a given parameter set
    // Input:  $db            - Database object
    //         $ParamValuesID - Parameter value id
    //         $ParamsID      - Parameter id
    //         $ParamSetID    - Parameter set id
    // Output: Returns the number of rows affected or false on failure
    function addParamSetValues($db, $ParamValuesID, $ParamsID, $ParamSetID) {
        $row = $db->get_row("SELECT * FROM paramsets_params_paramvalues
                             WHERE ParamValuesID = '$ParamValuesID',
                                ParamsID         = '$ParamsID',
                                ParamSetID       = '$ParamSetID'");

        // If a record already exists with the same parameter set values, return false
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO paramsets_params_paramvalues SET
                        ParamValuesID = '$ParamValuesID',
                        ParamsID      = '$ParamsID',
                        ParamSetID    = '$ParamSetID'");

        return (isset($db->num_rows)) ? $db->num_rows : false;
    }

    //
    // editParamSetValue() - Edit the parameter value for the given parameter set
    // Input:  $db            - Database object
    //         $ParamValuesID - Parameter values id
    //         $ParamsID      - Parameter id value
    //         $ParamSetID    - Parameter set id
    function editParamSetValue($db, $ParamValuesID, $ParamsID, $ParamSetID) {
        $row = $db->get_row("SELECT * FROM paramsets_params_paramvalues
                             WHERE ParamsID = '$ParamsID' AND
                                ParamSetID = '$ParamSetID'");

        // If a record doesn't exist return false
        if (empty($row)) {
            return false;
        }
        
        $db->query("UPDATE paramsets_params_paramvalues SET
                        ParamValuesID = '$ParamValuesID'
                    WHERE ParamSetID = '$ParamSetID' AND ParamsID = '$ParamsID'");
                    
        return (isset($db->num_rows)) ? $db->num_rows : false;
    }

    //
    // deleteParamSetValue() - Delete the parameter value from the database for the given parameter set
    // Input:  $db            - Database object
    //         $ParamSetID    - Parameter set id
    //         $ParamsID      - Parameter id value
    //         $ParamValuesID - Parameter value id
    // Output: Returns the number of rows affected or false on failure
    function deleteParamSetValue($db, $ParamSetID, $ParamsID, $ParamValuesID) {
        
        $db->query("DELETE FROM paramsets_params_paramvalues WHERE
                        ParamValuesID = '$ParamValuesID' AND
                        ParamsID      = '$ParamsID' AND
                        ParamSetID    = '$ParamSetID'");

        return (isset($db->num_rows)) ? $db->num_rows : false;
    }
    
    //
    // archiveParamSetValue() - Archive a parameter value for the given parameter set
    // Input:  $db            - Database object
    //         $ParamSetID    - Parameter set id
    //         $ParamsID      - Parameter id value
    //         $ParamValuesID - Parameter value id
    //         $Timestamp     - Unix timestamp value
    // Output: Returns the number of rows affected or false on failure
    function archiveParamSetValue($db, $ParamSetID, $ParamsID, $ParamValuesID, $Timestamp) {
        
        $db->query("INSERT INTO archive_paramsets_params_paramvalues SET
                        ParamValuesID = '$ParamValuesID',
                        ParamsID      = '$ParamsID',
                        ParamSetID    = '$ParamSetID',
                        Timestamp     = '$Timestamp'");

        return (isset($db->num_rows)) ? $db->num_rows : false;
    }
    
    //
    // getParameters() - Returns an associative array containing parameter details
    // Input:  $db - Database object
    // Output: Associative array containing parameter details
    function getParameters($db) {
        $results = $db->get_results("SELECT ParamsID, ParamName, MachineType
                                     FROM params");

        return ($results) ? $results : false;
    }
    
    //
    // addParameter() - Add a new parameter to the database
    // Input:  $db          - Database object
    //         $ParamName   - Parameter name
    //         $MachineType - Machine that the parameter is associated with
    // Output: Returns the last insert id value or false on failure
    function addParameter($db, $ParamName, $MachineType) {
        $row = $db->get_row("SELECT * FROM params WHERE ParamName = '$ParamName'");
        
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO params SET
                    ParamName   = '$ParamName',
                    MachineType = '$MachineType'");
        
        return (isset($db->insert_id)) ? $db->insert_id : false;
    }
    
    //
    // getParameterDetails() - Get detailed information on a given parameter (including values)
    // Input:  $db       - Database object
    //         $ParamsID - Parameter id value
    // Output: Returns an associative array containing detailed parameter information
    function getParameterDetails($db, $ParamsID) {
        $row = $db->get_row("SELECT *, '' AS ParamValues FROM params WHERE ParamsID = '$ParamsID'");
        
        if (empty($row)) {
            return false;
        }
        
        $row->ParamValues = $this->getParamValues($db, $ParamsID);
        
        return ($row) ? $row : false;
    }
    
    //
    // existsParamSetValue() - Determine if a given parameter set value exists or not
    // Input:  $db            - Database object
    //         $ParamSetID    - Parameter set id
    //         $ParamsID      - Parameter id
    //         $ParamValuesID - Parameter value id
    // Output: Returns true if value exists or false otherwise
    function existsParamSetValue($db, $ParamSetID, $ParamsID) {
        $row = $db->get_row("SELECT * FROM paramsets_params_paramvalues
                             WHERE ParamSetID = '$ParamSetID' AND
                                ParamsID = '$ParamsID'");
        
        return ($row) ? true : false;
    }
    
    //
    // getParamMachineTypes() - Get a list of all enum fields for parameter machine types
    // Input:  $db - Database object
    // Output: Array containing all enum fields for parameter machine types
    function getParamMachineTypes($db) {
        $row = $db->query("SHOW COLUMNS FROM params LIKE 'MachineType'");
        
        // Get the second row from the cached results by using a null query
        $row_details = $db->get_row(null, ARRAY_A, 0);

        // Fetch the enum values for the field
        $values = explode("','", preg_replace("/(enum|set)\('(.+?)'\)/", "\\2", $row_details['Type']));

        return $values;
    }
    
    
}

    $myParameters = &new parameters();

?>
