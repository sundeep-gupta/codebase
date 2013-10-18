<?php

######################################################################################
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.1.1.1 $
# Last Modified: $Date: 2005/09/28 23:31:11 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbitaldata/control/php-lib/modules/validator.php,v $
#
######################################################################################



class formValidator {


    // Define the following
	var $_errorList;   // List of all errors occurred during form validation


    // Object constructor
	function formValidator() {
		$this->resetErrorList();
	}

    //
	// _getValue() - Function to get the value of a variable (field)
    // Input:  String containing value of form field
    // Output: Returns the field globalized
	function _getValue($field) {
		return $_POST[$field];
	}

    //
	// isEmpty() - Check whether input is empty
    // Input:  $field - The form field value
    //         $msg   - Message to return if field is empty
    // Output: Returns false if field is empty and puts missing field into error list. Returns true otherwise
	function isEmpty($field, $msg) {
		$value = $this->_getValue($field);

		if (trim($value) == "") {
			$this->_errorList[] = array("field" => $field, "value" => $value, "msg" => $msg, "type" => "fields_empty");
			return false;
		}
		else {
			return true;
		}
	}

    //
	// isString() - Check whether input is a string
    // Input:  $field - The form field value
    //         $msg   - Message to return if field is not a string
    // Output: Returns false if field is not a string and puts field into error list. Returns true otherwise
	function isString($field, $msg) {
		$value = $this->_getValue($field);

		if(!is_string($value)) {
			$this->_errorList[] = array("field" => $field, "value" => $value, "msg" => $msg, "type" => "fields_not_string");
			return false;
		}
		else {
			return true;
		}
	}

    //
	// isNumber() - Check whether input is a number
    // Input:  $field - The form field value
    //         $msg   - Message to return if field is not a number
    // Output: Returns false if field is not a number and puts field into error list. Returns true otherwise
	function isNumber($field, $msg) {
		$value = $this->_getValue($field);

		if(!is_numeric($value)) {
			$this->_errorList[] = array("field" => $field, "value" => $value, "msg" => $msg, "type" => "fields_not_numeric");
			return false;
		}
		else {
			return true;
		}
	}

    //
	// isInteger() - Check whether input is an integer
    // Input:  $field - The form field value
    //         $msg   - Message to return if field is not an integer
    // Output: Returns false if field is not an integer and puts field into error list. Returns true otherwise
	function isInteger($field, $msg) {
		$value = $this->_getValue($field);

		if(!is_integer($value)) {
			$this->_errorList[] = array("field" => $field, "value" => $value, "msg" => $msg, "type" => "fields_not_integer");
			return false;
		}
		else {
			return true;
		}
	}

    //
	// isFloat() - Check whether input is a float
    // Input:  $field - The form field value
    //         $msg   - Message to return if field is not a floating number
    // Output: Returns false if field is not a floating number and puts field into error list. Returns true otherwise
	function isFloat($field, $msg) {
		$value = $this->_getValue($field);

		if(!is_float($value)) {
			$this->_errorList[] = array("field" => $field, "value" => $value, "msg" => $msg, "type" => "fields_not_float");
			return false;
		}
		else {
			return true;
		}
	}

    //
	// isWithinRange() - Check whether input is within a valid numeric range
    // Input:  $field - The form field value
    //         $msg   - Message to return if field is not within the range specified (between min and max values)
    //         $min   - Minimum range value
    //         $max   - Maximum range value
    // Output: Returns false if field is not within the range specified and puts field into error list. Returns true otherwise
	function isWithinRange($field, $msg, $min, $max) {
		$value = $this->_getValue($field);

		if(!is_numeric($value) || $value < $min || $value > $max) {
			$this->_errorList[] = array("field" => $field, "value" => $value, "msg" => $msg, "type" => "fields_out_range");
			return false;
		}
		else {
			return true;
		}
	}

    //
    // isValidDateRange() - Checks whether the given start date is not greater than the end date
    // Input:  $field_smon  - The start month
    //         $field_sday  - The start day
    //         $field_syear - The start year
    //         $field_emon  - The end month
    //         $field_eday  - The end day
    //         $field_eyear - The end year
    //         $msg         - Message to return if fields are not a valid date range
    // Output: Returns false if the start date is greater than the end date and puts the fields into an error list. Returns true otherwise
    function isValidDateRange($field_smon, $field_sday, $field_syear, $field_emon, $field_eday, $field_eyear, $msg) {
        $startMonth = $this->_getValue($field_smon);
        $startDay   = $this->_getValue($field_sday);
        $startYear  = $this->_getValue($field_syear);
        $endMonth   = $this->_getValue($field_emon);
        $endDay     = $this->_getValue($field_eday);
        $endYear    = $this->_getValue($field_eyear);
        
        if (!is_numeric($startMonth)) {
			$this->_errorList[] = array("field" => $field_smon, "value" => $startMonth, "msg" => $msg, "type" => "fields_not_date");
			return false;
        }
        if (!is_numeric($startDay)) {
            $this->_errorList[] = array("field" => $field_sday, "value" => $startDay, "msg" => $msg, "type" => "fields_not_date");
			return false;
        }
        if (!is_numeric($startYear)) {
            $this->_errorList[] = array("field" => $field_syear, "value" => $startYear, "msg" => $msg, "type" => "fields_not_date");
			return false;
        }
        if (!is_numeric($endMonth)) {
            $this->_errorList[] = array("field" => $field_emon, "value" => $endMonth, "msg" => $msg, "type" => "fields_not_date");
			return false;
        }
        if (!is_numeric($endDay)) {
            $this->_errorList[] = array("field" => $field_eday, "value" => $endDay, "msg" => $msg, "type" => "fields_not_date");
			return false;
        }
        if (!is_numeric($endYear)) {
            $this->_errorList[] = array("field" => $field_eyear, "value" => $endYear, "msg" => $msg, "type" => "fields_not_date");
			return false;
        }
        
        // Make sure the start year is less than the end year
        if ($startYear > $endYear) {
            $this->_errorList[] = array("field" => $field_syear, "value" => $startYear, "msg" => $msg, "type" => "fields_not_date");
            return false;
        }
        else if ($startYear == $endYear) {
            // Make sure the start month is less than or equal to the end month
            if ($startMonth > $endMonth) {
                $this->_errorList[] = array("field" => $field_smonth, "value" => $startMonth, "msg" => $msg, "type" => "fields_not_date");
                return false;
            }
            else if ($startMonth == $endMonth) {
                // Make sure the start day is less than or equal to the end day
                if ($startDay > $endDay) {
                    $this->_errorList[] = array("field" => $field_sday, "value" => $startDay, "msg" => $msg, "type" => "fields_not_date");
                    return false;
                }
            }
        }
        
        return true;
    }
    
    //
	// isAlpha() - Check whether input is alphabetic
    // Input:  $field - The form field value
    //         $msg   - Message to return if field is not alphabetic
    // Output: Returns true if field is alphabetic. False on failure
	function isAlpha($field, $msg) {
		$value = $this->_getValue($field);
		$pattern = "/^[a-zA-Z]+$/";

		if(preg_match($pattern, $value)) {
			return true;
		}
		else {
			$this->_errorList[] = array("field" => $field, "value" => $value, "msg" => $msg, "type" => "fields_not_alpha");
			return false;
		}
	}

    //
	// isEmailAddress() - Check whether input is a valid email address
    // Input:  $field - The form field value
    //         $msg   - Message to return if field is not a valid email address
    // Output: Returns true if valid email address. False on failure
	function isEmailAddress($field, $msg) {
		$value = $this->_getValue($field);
		$pattern = "/^([a-zA-Z0-9])+([\.a-zA-Z0-9_-])*@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-]+)+/";

		if(preg_match($pattern, $value)) {
			return true;
		}
		else {
			$this->_errorList[] = array("field" => $field, "value" => $value, "msg" => $msg, "type" => "fields_not_email");
			return false;
		}
	}

    //
	// isError() - Check whether any errors have occurred in validation
    // Input:  Nothing
    // Output: Returns Boolean. True on errors, false otherwise
	function isError() {
		if (sizeof($this->_errorList) > 0) {
			return true;
		}
		else {
			return false;
		}
	}

    //
	// getErrorList() - Return the current list of errors
    // Input:  Nothing
    // Output: List of errors that occurred on form validation
	function getErrorList() {
		return $this->_errorList;
	}

    //
	// resetErrorList() - Reset the error list
    // Input:  Class array
    // Output: Nothing
	function resetErrorList() {
		$this->_errorList = array();
	}

    //
    // displayErrorList() - Returns and HTML formatted string with our errors
    // Input:  Class error list
    // Output: Returns an HTML formatted string with our errors
    function displayErrorList() {
        $errorList = $this->getErrorList();
        
        $html = "\n<ul>\n";
        foreach ($errorList as $error) {
            $html .= "\t<li class=\"error\">".$error['msg']."</li>\n";
        }
        $html .= "</ul>\n";
        
        return $html;
    }

    //
    // getErrorString() - Return a concatenated string of all error form fields (used as a query string)
    // Input:  Class error list
    // Output: String containing all error form fields ready for query string use
    function getErrorString() {
        $errorList = $this->getErrorList();
        
        foreach ($errorList as $error) {
            $errorString .= $error['field'] . "+";
        }
        
        return rtrim($errorString, "+");
    }

    //
    // displayErrorString() - Return an HTML formatted string containing our form field errors
    // Input:  $errorString - String containing our error fields
    // Output: Returns an HTML formatted string with our errors
    function displayErrorString($errorString) {
        if (preg_match("/\+/", $errorString)) {
            $errorList = preg_split("/\+/", $errorString);
        }
        else {
            $errorList = preg_split("/\s+/", $errorString);
        }
        
        $html = "\n<ul>\n";
        for ($i=0; $i < sizeof($errorList); $i++) {
            $html .= "\t<li class=\"error\">".$errorList[$i]."</li>\n";
        }
        $html .= "</ul>\n";
        
        return $html;
    }

}

    $myForm = &new formValidator();

?>
