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





    //
    // getConfigInfo() - Returns an associative array containing the configuration parameters
    // Input:  Nothing
    // Output: 
    function getConfigInfo() {
        // Define the following
        $ini_file = $this->myConfig->CONFIG_PATH . "config.ini";
        
        $ini_array = parse_ini_file($ini_file, true);
        
        return ($ini_array);
    }
    
    //
    // write_ini_file() - Write output to configuration INI file
    // Input:  $ini_file    - The file name and full path of the INI file to edit
    //         $assoc_array - Associative array containing our INI file data to write
    // Output: Returns true on success and false on failure
    function write_ini_file($ini_file, $assoc_array) {
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



?>