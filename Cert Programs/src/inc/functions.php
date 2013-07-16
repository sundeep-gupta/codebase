<?php
	include_once("config.php");
	
	define("SQL_SELECT", 1);
	define("SQL_UPDATE", 2);

	function DoSQL($query, $type=SQL_SELECT, $count=1, $debug=false) {
	    if ($count <= 0)
	        return false;
	        
		global $Config;
		
		if ($type == SQL_UPDATE) {
			$username = $Config["update_username"];
			$password = $Config["update_password"];
		} else {
			$username = $Config["select_username"];
			$password = $Config["select_password"];
		}
		
		$db = @mysql_connect($Config["hostname"], $username, $password);
		@mysql_select_db($Config["database"], $db);
		
		$queries = ($count > 1) ? explode(";;", $query) : array($query);
		for($x=0;$x<$count;$x++) {
			$resource = mysql_query($queries[$x]);
			if ($debug) {
			    $err = mysql_errno();
				$er2 = mysql_error();
				dumpvar($resource, "resource:");
				dumpvar($queries[$x], "query:");
				dumpvar($err, "mysql_errno:");
				dumpvar($er2, "mysql_error:");
			}
		}

		if ($type == SQL_SELECT) {
			while ($arr = mysql_fetch_array($resource)) {
				$results[] = $arr;
			}
			return $results;
		} else {
			return @mysql_insert_id();
		}
	}
 
    //$headers should be an associative array of key value pairs
    //  only Subject, and From Need to be set
    function SendMail($to, $headers, $body) {
        //first get the headers in the right format
//dumpvar($headers); exit;
//$headers["From"] = "KeyLabs Cert System < " . $headers["From"] . " >";
        if (!is_array($headers))
           exit;
           
        $fheaders = '';
        foreach($headers as $field => $value) {
            //i don't want the subject in the headers because of how mail() works
            if (strcasecmp("subject", $field) == 0) {
               $subject = $value;
               continue;
            }
            $fheaders .= $field.": ".$value."\r\n";
        }
        mail($to, stripslashes($subject), stripslashes($body), $fheaders); //"From: no-reply@keylabs.com\r\nReturn-Path: no-reply@keylabs.com");
    }

	function dumpvar($var, $str="") {
		print("<hr>$str<pre>");
		var_dump($var);
		print("</pre><hr>");
	}
?>
