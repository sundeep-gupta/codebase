<?php

######################################################################################
#
# Copyright:     AppLabs Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: $
# Last Modified: $Date: $
# Modified By:   $Author: $
# Source:        $Source: $
#
######################################################################################


include_once("config.php");
include_once("xmlparser.php");


class stress {
    
    // Object constructor
	function stress(&$myConfig) {
        // Object reference
        $this->myConfig =& $myConfig;
	}
    
    //
    // fetchQueryTime() - Function that fetches the most up-to-date query time value. This value is captured in a
    //                    query xml file located in the log temp directory.
    // Input:  $query_type - String containing the type of query we want to capture data for.
    // Output: String containing the query time value
    function fetchQueryTime($query_type='') {
        if (isset($query_type) && $query_type != "") {
            $xml_file = $this->myConfig->{'LOG_PATH'} . "Temp" . (($this->myConfig->OS == "Linux") ? "/" : "\\" ) . $query_type . ".xml";
            // Make sure our file exists
            if (!file_exists($xml_file)) {
                return false;
            }
        }
        else {
            return false;
        }
        
        // Fetch our XML contents
        $p = new xmlParser();
        $p->parse($xml_file);
        $xml = $p->output;
        
        if (isset($xml[0]['child']['query_time']['content'])) {
            $query_time = $xml[0]['child']['query_time']['content'];
        }
        else {
            $query_time = "Unknown";
        }
        
        return $query_time;
    }
    
    //
    // fetchSqlFile() - Function that determines which SQL file we should use for our queries
    // Input:  $query_type - String containing the type of query we want to perform.
    // Output: String containing the file name of the SQL we want to use for our query.
    function fetchSqlFile($query_type='') {
        if (empty($query_type)) {
            return false;
        }
        
        $sql_file = "";
        if ($query_type == "select") {
            $sql_file = $this->myConfig->{'DB_DRIVER'} . "_select.sql";
        }
        else if ($query_type == "insert") {
            $sql_file = $this->myConfig->{'DB_DRIVER'} . "_insert.sql";
        }
        else if ($query_type == "update") {
            $sql_file = $this->myConfig->{'DB_DRIVER'} . "_update.sql";
        }
        else if ($query_type == "delete") {
            $sql_file = $this->myConfig->{'DB_DRIVER'} . "_delete.sql";
        }
        else {
            return false;
        }
        
        // Make sure our file exists
        $sql_file = $this->myConfig->{'SQL_PATH'} . $sql_file;
        if (!file_exists($sql_file)) {
            return false;
        }
        
        return $sql_file;
    }
    
    //
    // callTool() - Function that executes a command and puts it in the bakground, thus having the PHP script continue 
    //              to be interpreted contrary to the hanging in the process
    // Input:  $path  - String containing the full path of the executable file.
    //         $file  - String containing the file name of the executable.
    //         $attrs - String containing any command line attributes that need to be included with a call to the tool.
    // Output: 
    function callTool($path,$file,$attrs='') {
        // Check if we have any command line attributes
        $call = "";
        if (!empty($attrs)) {
            $call = $path . $file . " " . $attrs;
        }
        else {
            $call = $path . $file;
        }
        
        if ($this->myConfig->OS == "Windows") {
            chdir($path); 
            pclose(popen('start /b '.$call.'', 'w'));
        }
        else {
            chdir($path); 
            pclose(popen($call.' &', 'w'));
        }
    }
}


    $stressTest = &new stress($myConfig);


?>
