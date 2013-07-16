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


class reports {
    
    // Object constructor
	function reports(&$myConfig) {
        // Object reference
        $this->myConfig =& $myConfig;
	}
    
    //
    // createResultsDir() - Function that creates the results directory for a test run
    // Input:  $dir - String that contains the timestamp of a the test run, which should be the location of the results
    // Output: String that contains the full path of the results directory
    function createResultsDir($dir='') {
        if (isset($dir) && $dir != "") {
            $path = $this->myConfig->RESULTS_PATH . $dir . (($this->myConfig->OS == "Linux") ? "/" : "\\" );
        }
        else {
            $path = $this->myConfig->RESULTS_PATH;
            return $path;
        }
        // Make sure the directory does not already exist
        if (file_exists($path)) {
            return $path;
        }
        $old_dir = getcwd();
        chdir($this->myConfig->RESULTS_PATH);
        // Try to create our directory, if not fail
        if (!mkdir($path, 0777)) {
            echo "ERROR: Could not create the results directory: $path \n";
            echo "Exiting......\n";
            exit;
        }
        
        // If we were successful in creating our new directory, make sure we log this in our configuration INI
        $config_ini = $this->getConfigInfo();
        $config_ini['GLOBAL']['LAST_RESULTS_DIR'] = $config_ini['GLOBAL']['RESULTS_DIR'];
        $config_ini['GLOBAL']['RESULTS_DIR'] = $dir;
        $retval = $this->write_ini_file($config_ini);
        if ($retval == false) {
            echo "ERROR: Could not write to configuration INI file.\n";
            echo "Exiting.....\n";
            exit;
        }
        
        return $path;
    }
    
    //
    // getResults() - Function that returns all results recursively (sorted by directories first, then files)
    // Input:  $dir - String that contains the timestamp of a test run, which should be the location of the results
    // Output: Returns an associative array containing all of our results
    function getResults($dir='') {
        if (isset($dir) && $dir != "") {
            $path = $this->myConfig->RESULTS_PATH . $dir . "/";
        }
        else {
            $path = $this->myConfig->RESULTS_PATH;
        }
        $results = $this->recursiveScanDir($path);
        if (empty($results)) {
            return false;
        }
        
        $this->arrayMultiSort($results, array($this, "cmp"));
        return (isset($results)) ? $results : false;
    }
    
    //
    // recursiveScanDir() - Function that recursively scans a directory and returns its' contents
    // Input:  $dir - String that contains the full path of the directory to scan
    // Output: Associative array containing our directory contents
    function recursiveScanDir($dir) {
        $files = array();
        if ($handle = opendir($dir)) {
            while (($file = readdir($handle)) != false) {
                if ($file != ".." && $file != ".") {
                    if (is_dir($dir . "/" . $file)) {
                        $files[$file] = $this->recursiveScanDir($dir . "/" . $file);
                    }
                    else {
                        $files[] = $file;
                    }
                }
            }
            closedir($handle);
            return $files;
        }
    }
    
    //
    // arrayMultiSort() - Function that sorts a multi-dimensional array in descending order
    // Input:  $arr  - Array reference containing our items to be sorted
    //         $func - Function that is applied to our array
    // Output: Sorts our original array reference
    function arrayMultiSort(&$arr, $func) {
        uksort($arr, $func);
        while (list($key, $val) = each($arr)) {
            if (is_array($val)) {
                $this->arrayMultiSort($arr[$key], $func);
            }
        }
    }
    
    //
    // getMetricFields() - Function that returns all metric field names captured by our test run.
    //                     These field names exist within the results file collected
    // Input:  $results_file - String containing the full path and file name of our results file to read
    // Output: Returns an array containing all of our field names for the given test run
    function getMetricFields($results_file) {
        if (empty($results_file)) {
            return false;
        }
        if (!file_exists($results_file)) {
            return false;
        }
        $contents = $this->file2array($results_file);
        $fields = array_shift($contents);
        $metrics = explode(",", $fields);
        array_shift($metrics);
        return (isset($metrics)) ? $metrics : false;
    }
    
    //
    // getMetricFieldName() - Function that returns a specific field name based upon it's array cell 
    //                        number captured from the function getMetricFields()
    // Input:  $results_file - String containing the full path and file name of our results file to read
    //         $col_num      - String containing the column number of the field name needed
    // Output: Returns a string containing a specific field name
    function getMetricFieldName($results_file,$col_num) {
        $metrics = $this->getMetricFields($results_file);
        if (empty($metrics)) {
            return false;
        }
        
        // TODO: make sure that the $col_num is not bigger than the size of the array
        
        $field = $metrics[$col_num];
        return (isset($field)) ? $field : false;
    }
    
    //
    // getConfigInfo() - Returns an associative array containing the configuration parameters of the configuration INI
    // Input:  Nothing
    // Output: Array:  Contains the config.ini settings and parameters
    function getConfigInfo() {
        // Define the following
        $ini_file = $this->myConfig->CONFIG_PATH . "config.ini";
        $ini_array = parse_ini_file($ini_file, true);
        return ($ini_array);
    }
    
    //
    // write_ini_file() - Write output to configuration INI file
    // Input:  $assoc_array - Associative array containing our INI file data to write
    // Output: Returns true on success and false on failure
    function write_ini_file($assoc_array) {
        $ini_file = $this->myConfig->CONFIG_PATH . "config.ini";
        
        $content = "";
        foreach($assoc_array as $key => $item) {
            if (is_array($item)) {
                $content .= "\n[{$key}]\n";
                foreach ($item as $key2 => $item2) {
                    if(is_numeric($item2) || is_bool($item2)) {
                        $content .= "{$key2} = {$item2}\n";
                    }
                    else {
                        $content .= "{$key2} = \"{$item2}\"\n";
                    }
                }
            }
            else {
                if (is_numeric($item) || is_bool($item)) {
                    $content .= "{$key} = {$item}\n";
                }
                else {
                    $content .= "{$key} = \"{$item}\"\n";
                }
            }
        }
        
        if (!$handle = fopen($ini_file, 'w')) {
            return false;
        }
        
        if (!fwrite($handle, $content)) {
            return false;
        }
        
        fclose($handle);
        return true;
    }
    
    //
    // file2array() - Returns the given file contents as an array
    // Input:  $filename - The file name and full path of the file to parse
    // Output: Array containing our file contents, where each line is a cell in the array
    function file2array($filename) {
        $fp = fopen($filename, "r");
        $buffer = fread($fp, filesize($filename));
        fclose($fp);
        $buffer = ltrim($buffer);
        $buffer = rtrim($buffer);
        $lines = preg_split("/\r?\n|\r/", $buffer);
        return $lines;
    }
    
    //
    // cmp() - Function that compares two given values and returns either a 1, 0, or -1 based upon the
    //         data type and which value is higher
    // Input:  $a - String or Integer value
    //         $b - String or Integer value
    // Output: Returns a positive, negative or neutral integer based upon a comparison between two values
    function cmp($a, $b) {
        if (is_string($a) && is_string($b)) {
            return (strcmp($a, $b) > 0) ? 1 : -1; 
        }
        elseif (is_int($a) && is_int($b)) {
            return ($a > $b) ? 1 : -1;
        }
        elseif (is_int($a) && is_string($b)) {
            return 1;
        }
        elseif (is_string($a) && is_int($b)) {
            return -1;
        }
        else {
            return 0;
        }
    }

    //
    // fetchDate() - This function creates a basic formatted timestamp
    // Input:  $timestamp - 
    // Output: Returns the local time in the format of: 'MM/DD/YY - HH:MM:SS'
    function fetchDate($timestamp) {
        $today = getdate($timestamp);
        $localtime = $today['mon'] . "/" . $today['mday'] . "/" . $today['year'] . " - " . $today['hours'] . ":" . $today['minutes'] . ":" . $today['seconds'];
        return $localtime;
    }


    
}


    $myReports = &new reports($myConfig);


?>
