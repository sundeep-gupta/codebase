<?php

######################################################################################
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.6 $
# Last Modified: $Date: 2005/06/08 23:32:30 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbital/control/php-lib/modules/config.php,v $
#
######################################################################################



class config {

    var $BASEURL;               // Domain name of the current site. (HTTP)
    var $SECUREURL;             // Secure domain name of the current site (HTTPS)
    var $CGIURL;                // URL of the cgi-bin
    var $BASEPATH;              // Document root of the current site (i.e. wwwroot)

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
        // Default path and URL settings
        $this->BASEURL          = "http://10.201.201.91/orbital/";
        $this->SECUREURL        = "http://10.201.201.91/orbital/";
        $this->CGIURL           = "http://10.201.201.91/cgi-bin/";
        $this->BASEPATH         = "/var/www/html/orbital/";

        // Database settings
        $this->DB_USER          = "orbtest";
        $this->DB_PASSWORD      = "orbtest";
        $this->DB_NAME          = "orbtest";
        $this->DB_HOST          = "localhost";

        // Debugging and error settings
        $this->DEBUGGING_MODE   = false;   //true;
        $this->HANDLE_ERRORS    = false;   //true;
        $this->SHOW_ERRORS      = false;   //true;
        $this->MAIL_ERRORS      = false;
        $this->REDIRECT_PAGE    = false;
        $this->ERROR_EMAIL      = "root@orbitalconsole";
        $this->ERROR_LOG        = "/usr/local/orbital/console/logs/php_error_log";
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

}

    $myConfig = &new config();

?>
