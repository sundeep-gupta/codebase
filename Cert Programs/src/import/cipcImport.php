<?php
	//include_once("cert_functions.php");
	//include_once("products/productfunctions.php");
	include("ccxFunction.php");
	include("cipcFunction.php");
	include("cmcFunction.php");
	include("csaFunction.php");
	include("cwnFunction.php");
	include("ebayFunction.php");
	include("hpuxFunction.php");
	include("jdbcFunction.php");
	include("lnxFunction.php");
	include("rnFunction.php");
	include("srFunction.php");
	include("stFunction.php");
	include("whqlFunction.php");
	include("yesFunction.php");
	
  //start out by connecting to both dbs that we will need
  $kdb = @mysql_connect("192.168.58.50", "root", "sn0wsn0w");
  $patrocks = mysql_connect("localhost", "root", "");
  $newDBName = "certs3-devImport";
  
  function DoSQL($dbHandle, $database, $query, $type=SQL_SELECT, $debug=false) {
  		@mysql_select_db($database, $dbHandle);
  		
		$resource = mysql_query($query, $dbHandle);
		if ($debug || !$resource) {
		    $err = mysql_errno();
			$er2 = mysql_error();
			dumpvar($resource, "resource:");
			dumpvar($query, "query:");
			dumpvar($err, "mysql_errno:");
			dumpvar($er2, "mysql_error:");
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

	function dumpvar($var, $str="") {
		print("<hr>$str<pre>");
		var_dump($var);
		print("</pre><hr>");
	}
	
	function NewUser($companyID, $name, $email, $phone, $pass="", $sendEmail=true) {
	    global $patrocks;
	    global $newDBName;
	    
	    if ($email == '')
	        return 0;
	    //first check to be sure there isn't already a user with that email address
	    $email2 = strtolower($email);
	    $SQL = "SELECT id FROM user WHERE email='$email2'";
	    $res = DoSQL($patrocks, $newDBName, $SQL, SQL_SELECT);
	    if (!isset($res)) { //[0][0] <= 0) {
			if ($pass=="") {
		    	$pass=GeneratePassword();
		   	}
			$sql =	"INSERT INTO user SET ".
			          "company_id='$companyID',".
		            "name='".addslashes($name)."',".
		            "initials='',".
		            "email='$email2',".
		            "phone='".addslashes($phone)."',".
		            "pass='$pass',".
	              "active='1'";
			$submissionID = DoSQL($patrocks, $newDBName, $sql, SQL_UPDATE);

			$headers["Subject"] = "KeyLabs.com Certification Username and Password";
			$headers["From"] = FROM_ADDRESS;
			$body =
"$name,
  A new user has been created on KeyLabs.com for you to track your certification process.
  Your new username is: $email
  Your new password id: $pass

You can see the status of your products in test at the following address
  http://www.keylabs.com/CertPrograms/

Any email originating from the KeyLabs Certification System will be sent to you via this email address.";

			if ($sendEmail) {
	    		SendMail($email, $headers, $body);
			}
	    } else {
	        $submissionID = $res[0][0];
	    }
		return $submissionID;
	}
	
	function GeneratePassword() {
		//come up with a semi-random password
		$str =str_shuffle("abcefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVQXYZ");
		return substr($str,1,8);
	}
	
	function prefixNumberInc($plid) {  // Pass in the ID of the priceList item, it looks up the prefix number for that, incs it, stores the new value, and returns it.
	    global $patrocks;
	    global $newDBName;
		$id = getPrefixID ($plid);

		// Pass This the priceList:prefix_id
		$sql = "SELECT number FROM prefix WHERE id = $id";
		$result = DoSQL($patrocks, $newDBName, $sql, SQL_SELECT, false);
		$number = $result[0]["number"]+1;
		$usql = "UPDATE prefix SET number = $number WHERE id = $id";
		$uresult = DoSQL($patrocks, $newDBName, $usql, SQL_UPDATE);
		return $number;
	}
	
	function getPrefixID ($plid) {  // Pass in the Price List ID of the item you are working with, and it will give you the prefix_id in the prefix table.
	    global $patrocks;
	    global $newDBName;
	    
		$sql = "SELECT prefix_id FROM priceList WHERE id = $plid";
		$result = DoSQL($patrocks, $newDBName, $sql, SQL_SELECT, false);

		return $result[0]["prefix_id"];
	}
	
//this really needs to be done all at the same time
$sql = "SELECT * FROM company WHERE com_id=useCom_id";
$companies = DoSQL($kdb, "java", $sql);
$companiesCnt = count($companies);
$newCompanies = array();
//now insert the companies one by one
for ($x=0;$x<$companiesCnt;$x++) {
	$sql = "INSERT INTO company SET name='".addslashes($companies[$x]["name"])."', address1='".addslashes($companies[$x]["adrs1"])."', address2='".addslashes($companies[$x]["adrs2"])."',
			city='".$companies[$x]["city"]."', state='".$companies[$x]["state"]."', zip='".$companies[$x]["zip"]."',
			country='".$companies[$x]["country"]."', active=1";
	$newCompanies[$companies[$x]["com_id"]] = DoSQL($patrocks, $newDBName, $sql, SQL_UPDATE);
}

echo "companies have been imported<br>";

//re-run the query without the and so that i can find all the company ids that have tested so i can get the user ids
$sql = "SELECT com_id, useCom_id FROM company WHERE useCom_id != '' ORDER BY useCom_id ASC, com_id ASC";
$allCompanies = DoSQL($kdb, "java", $sql);
$allCompaniesCnt = count($allCompanies);
$oldCompanies = array();
for ($x=0;$x<$allCompaniesCnt;$x++) {
	$oldCompanies[$allCompanies[$x]["com_id"]] = $allCompanies[$x]["useCom_id"];
}

$sql = "SELECT * FROM contact";
$allContacts = DoSQL($kdb, "java", $sql);
$allContactsCnt = count($allContacts);
$Users = array();
$UsersEmails = array();
for($x=0;$x<$allContactsCnt;$x++) {
	$Users[$allContacts[$x]["con_id"]] = $x;
	$UsersEmails[strtolower($allContacts[$x]["email"])] = $x;
}

echo "formatted the users<br>";

flush();
DoCCX();
flush();
DoCIPC();
flush();
DoCMC();
flush();
DoCSA();
flush();
DoCWN();
flush();
DoEBAY();
flush();
DoHPUX();
flush();
DoJDBC();
flush();
DoLNX();
flush();
DoRN();
flush();
DoSR();
flush();
DoST();
flush();
DoWHQL();
flush();
DoYES();
flush();
?>
