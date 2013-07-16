<?php

######################################################################################
#
# Copyright:     AppLabs Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision:  $
# Last Modified: $Date:  $
# Modified By:   $Author:  $
# Source:        $Source:  $
#
######################################################################################

    // Session variables required for monitoring
    session_start();

    include('Library/Php-Lib/modules/config.php');
    include('Library/Php-Lib/modules/logger.php');
    include('Library/Php-Lib/modules/reports.php');
    include('Library/Php-Lib/adodb/adodb.inc.php');


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

    // Tick use required as of PHP 4.3.0
    declare(ticks = 1);
    
    // Define the following variables
    $startTime   = time();
    $elapsedTime = 0;
    $resultsDir  = $myReports->createResultsDir($startTime);
    $resultsFile = $resultsDir . "database.csv";
    $loop        = "true";

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

    // Signal handler function
    function sig_handler($signo) {
        switch ($signo) {
            case SIGINT:
                // Handle shutdown tasks
                echo "Keyboard pressed...\n";
                echo "\n[" . time() . "]: DB-Monitor is stopping....\n";
                $myLogger->logEvent("[" . time() . "]: DB-Monitor is stopping.");
                exit;
                break;
            default:
                // Handle all other signals
        }
    }
    
    //
    // getmicrotime() - Returns the current time in microseconds
    // Input:  Nothing
    // Output: String:  Returns the current time in microseconds
    function getmicrotime() {
        list($usec, $sec) = explode(" ",microtime());
        return ((float)$usec + (float)$sec);
    }
    
# -----------------------------------------------------------
# MAIN:
# -----------------------------------------------------------

    // Setup signal handlers
    if (($myConfig->OS == "Linux") && (function_exists('pcntl_signal'))) {
        pcntl_signal(SIGINT, "sig_handler");
    }
    
    // Create the database connection
    $db =& ADONewConnection($myConfig->DB_DRIVER);
#    $db->debug = true;
    if (preg_match("/mssql/i", $myConfig->DB_DRIVER)) {
        $dsn = "Driver={SQL Server};Server=" . $myConfig->DB_SERVER . ";Database=" . $myConfig->DB_NAME . ";";
        $db->Connect($dsn,$myConfig->DB_USER,$myConfig->DB_PASSWORD);
    }
    else {
        $db->Connect($myConfig->DB_SERVER,$myConfig->DB_USER,$myConfig->DB_PASSWORD,$myConfig->DB_NAME);
    }
    
    
    // Send message to log file
    echo "\n[" . $startTime . "]: DB-Monitor is starting....\n";
    $myLogger->logEvent("[" . $startTime . "]: DB-Monitor is starting.");
    $myLogger->logEvent("[" . $startTime . "]: Connecting to [" . $myConfig->DB_DRIVER . "." . $myConfig->DB_NAME . "] on " . $myConfig->DB_SERVER);
    
    // Enter our continuous-loop
    while ($loop == "true") {
        // Create the performance monitor
        $perf =& NewPerfMonitor($db);
        $results = $perf->HealthCheckCLI();
        $resultsArray = explode("\n", $results);
        
        // Capture our metrics and iterate through each counter
        foreach ($resultsArray as $row) {
            $row = preg_replace("/^\s+/", "", $row);
            $row = preg_replace("/\s+\$/", "", $row);
            if (preg_match("/^\-\-/", $row)) {
                continue;
            }
            if ($row == "") {
                continue;
            }
            list($tmpHeaders,$tmpValues) = preg_split("/\s+\=\>\s+/", $row);
            
            $headerArray[] = $tmpHeaders;
            $valueArray[] = $tmpValues;
        }
        
        array_unshift($headerArray, "Elapsed Time");
        array_unshift($valueArray, $elapsedTime);
        
        $headers = implode(",", $headerArray);
        $values = implode(",", $valueArray);
        
        // Check if our results file exists or not
        if (file_exists($resultsFile)) {
            // Make sure we can open our file
            if (!$handle = fopen($resultsFile, 'a')) {
                echo "Cannot open file ($resultsFile).\n";
                exit;
            }
            // Make sure we output to our file
            if (fwrite($handle, $values."\n") === FALSE) {
                echo "Cannot write to file ($resultsFile)";
                exit;
            }
            fclose($handle);
        }
        else {
            // Write out our headers and initial values
            if (!$handle = fopen($resultsFile, 'a')) {
                echo "Cannot open file ($resultsFile).\n";
                exit;
            }
            // Make sure we output to our file
            if (fwrite($handle, $headers."\n".$values."\n") === FALSE) {
                echo "Cannot write to file ($resultsFile)";
                exit;
            }
            fclose($handle);
        }
        
        unset($headerArray, $valueArray);
        $headers = "";
        $values  = "";
        
        # Calculate our elapsed time value
        $elapsedTime += $myConfig->INTERVAL;
        
        echo "DB-Monitor is running.....\n";
        
        sleep($myConfig->INTERVAL);
        
        echo "Elapsed Time : $elapsedTime secs.\n";
    }
    
    
?>
