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


// Define which operating system we are using, Windows or Linux
if (!defined('OS')) {
    $os = "";
    if (isset($_ENV['OS']) && ($_ENV['OS'] == "Windows_NT")) {
        $os = "Windows";
    }
    else if (isset($_SERVER['OS']) && ($_SERVER['OS'] == "Windows_NT")) {
        $os = "Windows";
    }
    else if (isset($_SERVER['SERVER_SOFTWARE']) && preg_match("/Microsoft/i", $_SERVER['SERVER_SOFTWARE'])) {
        $os = "Windows";
    }
    else {
        $os = "Linux";
    }
    define('OS', $os);
    
    $inc_path = (OS == "Windows") ? "C:\\AppLabs\\AppTool\\Library\\Php-Lib" : "/opt/AppLabs/AppTool/Library/Php-Lib";
    set_include_path($inc_path);
}

class config {

    var $BASEURL;               // Domain name of the current site. (HTTP)
    var $SECUREURL;             // Secure domain name of the current site (HTTPS)
    var $CGIURL;                // URL of the cgi-bin
    var $BASEPATH;              // Document root of the current site (i.e. wwwroot)
    var $INPUTPATH;             // Directory where the input data is located
    var $LOGPATH;               // Directory where the log files are located
    var $RESULTSPATH;           // Directory where the test results are located

    var $DB_USER;               // Database user
    var $DB_PASSWORD;           // Password for database user
    var $DB_NAME;               // Database name
    var $DB_HOST;               // Database host

    var $DEBUGGING_MODE;
    var $HANDLE_ERRORS;
    var $SHOW_ERRORS;
    var $MAIL_ERRORS;
    var $REDIRECT_PAGE;

    var $ERROR_LIST;
    var $ERROR_TYPE;
    var $ERROR_EMAIL;
    var $ERROR_LOG;
    var $ERROR_FILE;

    var $LOG_ERRORS;
    var $LOG_WARNINGS;
    var $LOG_NOTICES;
    var $LOG_UNKNOWN;
    var $MAIL_WARNINGS;
    var $MAIL_NOTICES;
    var $MAIL_UNKNOWN;


    function config() {
        // Environment path settings
        $this->OS               = (OS == "Windows") ? "Windows" : "Linux";
        $this->TOOL_PATH        = (OS == "Windows") ? "C:\\AppLabs\\AppTool\\" : "/opt/AppLabs/AppTool/";
        $this->LIB_PATH         = (OS == "Windows") ? "C:\\AppLabs\\AppTool\\Library\\" : "/opt/AppLabs/AppTool/Library/";
        $this->LOG_PATH         = (OS == "Windows") ? "C:\\AppLabs\\AppTool\\Logs\\" : "/opt/AppLabs/AppTool/Logs/";
        $this->RESULTS_PATH     = (OS == "Windows") ? "C:\\Inetpub\\wwwroot\\apptool\\results\\" : "/opt/AppLabs/AppTool/Interface/apptool/results/";
        $this->SQL_PATH         = (OS == "Windows") ? "C:\\AppLabs\\AppTool\\Library\\Sql-Lib\\" : "/opt/AppLabs/AppTool/Library/Sql-Lib/";
        $this->CONFIG_PATH      = (OS == "Windows") ? "C:\\AppLabs\\AppTool\\Config\\" : "/opt/AppLabs/AppTool/Config/";
        $this->AGENT_PATH       = (OS == "Windows") ? "C:\\AppLabs\\AppTool\\Agent\\" : "/opt/AppLabs/AppTool/Agent/";
        $this->BASEPATH         = (OS == "Windows") ? "C:\\Inetpub\\wwwroot\\apptool\\" : "/opt/AppLabs/AppTool/Interface/apptool/";
        
        // Fetch our configuration INI values
        $config_ini = $this->getConfigInfo($this->CONFIG_PATH);
        
        // Web server settings
        $this->BASEURL          = "http://" . $config_ini['CONSOLE']['IP_ADDRESS'] . "/apptool/";
        $this->SECUREURL        = "http://" . $config_ini['CONSOLE']['IP_ADDRESS'] . "/apptool/";
        $this->CGIURL           = "http://" . $config_ini['CONSOLE']['IP_ADDRESS'] . "/apptool/cgi-bin/";
        
        // Configuration settings
        $this->INTERVAL         = $config_ini['GLOBAL']['INTERVAL'];
        $this->TEST_TIME_LENGTH = $config_ini['GLOBAL']['TEST_TIME_LENGTH'];
        $this->DEBUG            = 1;                // Debugging mode (1=on / 0=off)
        $this->LOG              = 1;                // Logging mode (1=on / 0=off)
        $this->LOG_FILE         = "history.log";
        
        // Database settings
        $this->DB_DRIVER        = $config_ini['DATABASE']['DB_DRIVER'];
        $this->DB_SERVER        = $config_ini['DATABASE']['DB_SERVER'];
        $this->DB_USER          = $config_ini['DATABASE']['DB_USER'];
        $this->DB_PASSWORD      = $config_ini['DATABASE']['DB_PASSWORD'];
        $this->DB_NAME          = $config_ini['DATABASE']['DB_NAME'];

        // Debugging and error settings
        $this->DEBUGGING_MODE   = true;    //true;
        $this->HANDLE_ERRORS    = false;   //true;
        $this->SHOW_ERRORS      = true;    //true;
        $this->MAIL_ERRORS      = false;
        $this->REDIRECT_PAGE    = false;
        $this->ERROR_EMAIL      = "support@applabs.com";
        $this->ERROR_LOG        = $this->LOG_PATH . "error_log.txt";
        $this->ERROR_PAGE       = "error.php";

        #######################################################################
        ## DO NOT EDIT BELOW THIS LINE
        #######################################################################

        if ($this->DEBUGGING_MODE) {
            error_reporting(E_ALL);
        }
        else {
            error_reporting(0);
        }

        if ($this->HANDLE_ERRORS) {
            $this->ERROR_LIST = array();

            // Notify, Warning, Error, Fatal values
            $this->LOG_ERRORS    = true;
            $this->LOG_WARNINGS  = true;
            $this->LOG_NOTICES   = true;
            $this->LOG_UNKNOWN	 = true;
            $this->MAIL_WARNINGS = true;
            $this->MAIL_NOTICES  = true;
            $this->MAIL_UNKNOWN  = true;

            set_error_handler( array( &$this, 'triggerError'));
            register_shutdown_function( array( &$this, '_config'));

            // Define error types
            $this->ERROR_TYPE = array (
				1	=> "PHP Error",
				2	=> "PHP Warning",
				4	=> "Parsing Error",
				8	=> "PHP Notice",
				16	=> "Core Error",
				32	=> "Core Warning",
				64	=> "Compile Error",
				128	=> "Compile Warning",
				256	=> "PHP User Error",
				512	=> "PHP User Warning",
				1024	=> "PHP User Notice" );
        }
    }

    // Restores the current error handler to the default error handler
    function _config() {
        restore_error_handler();
        return;
    }

    // Parses the variable that is passed in for any anomalous (meta) characters
    function parseData($variable) {
        return trim(stripslashes(htmlspecialchars(strip_tags($variable), ENT_QUOTES)));
    }

    // Overriding error handler with this one
    function triggerError($errorNo, $errorMessage, $errorFile, $errorLine, $context) {
        $myErrorMessage = $this->ERROR_TYPE[$errorNo].": ".$errorMessage." on line ".$errorLine.". FILE: ".$errorFile;

        switch($errorNo) {
            case E_ERROR:
            case E_USER_ERROR:
                $this->ERROR_LIST[] = array( "type" => "FATAL", "message" => $myErrorMessage);
                break;
            case E_WARNING:
            case E_USER_WARNING:
                $this->ERROR_LIST[] = array( "type" => "WARNING", "message" => $myErrorMessage);
                break;
            case E_NOTICE:
            case E_USER_NOTICE:
                $this->ERROR_LIST[] = array( "type" => "NOTICE", "message" => $myErrorMessage);
                break;
            default:
                $this->ERROR_LIST[] = array( "type" => "UNKNOWN", "message" => $myErrorMessage);
                break;
        }
    }

    // Check to see if errors have happened on the page and act accordingly
    function checkErrors() {
        // If errors occurred, log and email them, or if it was a fatal error send them to the correct page.
        if (count($this->ERROR_LIST) > 0) {
            $body = "";

            foreach ($this->ERROR_LIST as $myError) {
                $body .= "Type: ".$myError["type"]."\r\n";
                $body .= "message: ".$myError["message"]."\r\n\r\n";

                if ($this->SHOW_ERRORS) {
                    //print_r($this->ERROR_LIST);
                    echo "<strong>Type:</strong> ".$myError["type"]."<br>";
                    echo "<strong>Message:</strong> ".$myError["message"]."<br><br>";
                }

                //if($myError["type"] == "FATAL")
                //	$this->REDIRECT_PAGE = true;
            }

            $headers  = "From: ".$this->mySite."\r\n";
            $headers .= "MIME-Version: 1.0\r\n";
            $headers .= "Content-type: text/plain; charset=iso-8859-1\r\n";
            $subject  = "Error Report";

            if ($this->MAIL_ERRORS) {
                mail($this->ERROR_EMAIL, $subject, $body, $headers);
            }
            if ($this->REDIRECT_PAGE) {
                header("location: ".$this->BASEURL.$this->ERROR_PAGE);
                exit;
            }
        }
    }
    
    //
    // getConfigInfo() - Returns an associative array containing the configuration parameters of the configuration INI
    // Input:  $LIB_PATH - String containing the path of the Library files
    // Output: Array:  Contains the config.ini settings and parameters
    function getConfigInfo($LIB_PATH='') {
        // Define the following
        $ini_file = $LIB_PATH . "config.ini";
        $ini_array = parse_ini_file($ini_file, true);
        
        // Parse our database driver value
        // Drivers:  mysqli, odbc_mssql, oci8
        if (isset($ini_array['DATABASE']['DB_DRIVER']) && preg_match("/mssql/i", $ini_array['DATABASE']['DB_DRIVER'])) {
            $ini_array['DATABASE']['DB_DRIVER'] = "odbc_mssql";
        }
        else if (isset($ini_array['DATABASE']['DB_DRIVER']) && preg_match("/oracle/i", $ini_array['DATABASE']['DB_DRIVER'])) {
            $ini_array['DATABASE']['DB_DRIVER'] = "oci8";
        }
        
        return ($ini_array);
    }

}

    $myConfig = &new config();


?>