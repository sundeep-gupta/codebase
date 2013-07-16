<?php
class Utils {


    public static function is_null($value) {
	if (is_array($value) and sizeof($value) > 0) {
		return true;
	} elseif (($value != '') && (strtolower($value) != 'null') && (strlen(trim($value)) > 0)) {
	    return true;
	}
	return false;
    }

    public static function translate_quote($string) {
	return strtr(trim($string),'"','&quot;');
    }


}
?>