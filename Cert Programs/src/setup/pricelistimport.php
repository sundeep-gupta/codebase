<?
	include("functions.php");

	function pDoSQL($query, $type=SQL_SELECT, $count=1, $debug=false) {
	    if ($count <= 0)
	        return false;

		global $Config;

		if ($type == SQL_UPDATE) {
			$username = $Config["update_username"];
			$password = $Config["update_password"];
		} else {
			$username = $Config["select_username"];
			$password = $Config["select_username"];
		}

		$db = @mysql_connect($Config["hostname"], $username, $password);
		@mysql_select_db("certs3-dev2", $db);

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
	
	$file = fopen("pricelist.csv", "r");
	$currentProgram = 0;
	if ($file) {
	    while (($line = fgetcsv($file, 500))) {
	        if ($line[0] == "") {
	            //create a new program
				$SQL = "INSERT INTO program SET programName='".trim($line[1])."', active='1'";
				$currentProgram = pDoSQL($SQL, SQL_UPDATE);
				continue;
	        }
	        
			$SQL = "INSERT INTO priceList SET program_id=$currentProgram, SKU='".trim($line[0])."', price='".trim($line[2])."', description='".trim($line[1])."'";
			pDoSQL($SQL, SQL_UPDATE, 1, false);
	    }
	}
	echo "done";
?>
