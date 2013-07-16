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


class logger {
    
    // Object constructor
	function logger(&$myConfig) {
        // Object reference
        $this->myConfig =& $myConfig;
	}
    
    //
    // logEvent() - This function logs any data passed to it
    // Input:  $content - String containing the content to be logged
    // Output: Returns true if successful and false if failed
    function logEvent($content='') {
        $log_file = $this->myConfig->{'LOG_PATH'} . $this->myConfig->{'LOG_FILE'};
        $timestamp = $this->fetchDate();
        
        # Make sure our content is defined
        if (isset($content) && ($content != "")) {
            $content = ($this->myConfig->{'OS'} == "Windows") ? "[$timestamp]: $content\r\n" : "[$timestamp]: $content\n";
        }
        else {
            echo "DEBUG: failed, no content\n";
            return false;
        }
        
        # Append
        if (file_exists($log_file)) {
            if (!$handle = fopen($log_file, 'a')) {
                echo "DEBUG: failed, could not append\n";
                return false;
            }
            
            if (!fwrite($handle, $content)) {
                return false;
            }
            
            fclose($handle);
        }
        # Create
        else {
            if (!$handle = fopen($log_file, 'w')) {
                echo "DEBUG: failed, could not write\n";
                return false;
            }
            
            if (!fwrite($handle, $content)) {
                return false;
            }
            
            fclose($handle);
        }
        
        return true;
    }
    
    //
    // fetchDate() - This function creates a basic formatted timestamp
    // Input:  Nothing
    // Output: Returns the local time in the format of: 'MM/DD/YY - HH:MM:SS'
    function fetchDate() {
        $today = getdate();
        $localtime = $today['mon'] . "/" . $today['mday'] . "/" . $today['year'] . " - " . $today['hours'] . ":" . $today['minutes'] . ":" . $today['seconds'];
        return $localtime;
    }

}


    $myLogger = &new logger($myConfig);


?>
