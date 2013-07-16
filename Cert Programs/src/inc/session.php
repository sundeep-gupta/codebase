<?
	include_once("functions.php");

	session_start();

	//double negative prevents me from having to edit every page
	//  this pretty much is exclusively for register.php right now
	if (!$NOTPROTECTEDPAGE) {
	    //unset the registration stuff if it is set
		if (isset($_GET["logout"]) || isset($_POST["logout"])) {
			session_unset();
			session_destroy();
      setcookie("openMenus","",1);
      setcookie("adminopenMenus","",1);
      $_COOKIE["openMenus"] = "";
      $_COOKIE["adminopenMenus"] = "";
			header("location: index.php");
		}

		//if $_POST["username"] and $_POST["password" are set the user is trying to log into the system
		if (isset($_POST["username"]) && isset($_POST["password"])) {
		    unset($_SESSION["registration"]);
		    //null passwords are not allowed for login
			if ($_POST["password"] != '' && $result = Authenticate($_POST["username"], $_POST["password"])) {
			    BuildSessionVar($result["id"], $_POST["username"], $_POST["password"]);
			    //crappy thing to do here....
			    $_SESSION["company_id"] = $result["company_id"];
				header("location: ".$_SERVER["REQUEST_URI"]);
				$loginMessage = "";
			} else {
				$loginMessage = "Login Failed";
				include("loginform.php");
				exit;
			}
		}

		if (!isset($_SESSION["username"])) {
			include("loginform.php");
			exit;
		}

		// if supervisor mode was set, rebuild then redirect
		if (isset($_GET["supervisorMode"])) {
		    $_SESSION["supervisorMode"] = 1 ;
		    header("location: ".$_SERVER["SCRIPT_NAME"]);
		}
		
		if (isset($_GET["testerMode"])) {
		    unset($_SESSION["supervisorMode"]);
		    header("location: ".$_SERVER["SCRIPT_NAME"]);
		}

		//rebuild the list of certs the user can access
		if (!isset($_SESSION["supervisorMode"]))
			$_SESSION["Certs"] = BuildAvailableCerts($_SESSION["id"]);
		else
			$_SESSION["Certs"] = BuildAvailableCerts($_SESSION["id"], true);
	}
	
	//might not be the best way to implement this, but it gets around another issue
	function BuildSessionVar($id, $username="", $password="") {
		session_unset();
	    if ($username=="") {
	        //we just registered.  i need to pull the data from the db since it may not be available
	        //  from the registration process.
	        $user = GetUserInfo($id);
	        $username = $user["email"];
	        $password = $user["pass"];
	    }
		$_SESSION["username"] = $username;
		$_SESSION["password"] = $password;
		$_SESSION["id"] = $id;

		$_SESSION["Permissions"] = BuildPermissions($_SESSION["id"]);
	}
	
	//finds all the permission strings that the given user has access to
	function BuildPermissions($id, $orderByPermission=false) {
	    if (!isset($id) || $id == 0)
	        return BuildAllPermissions($orderByPermission);
	        
		$orderbystring = ($orderByPermission) ? " ORDER BY permission.permission" : "";
		$wherestring = " WHERE userPermission.permission_id=permission.id AND userPermission.user_id='$id'";
	    $SQL = "SELECT permission.permission, permission.id, permission.description FROM userPermission, permission".$wherestring.$orderbystring;
	    $Permissions = DoSQL($SQL, SQL_SELECT);
	    $cnt = count($Permissions);
	    $return = array();
	    for ($x=0;$x<$cnt;$x++) {
	        $return[$Permissions[$x]["permission"]]["id"] = $Permissions[$x]["id"];
	        $return[$Permissions[$x]["permission"]]["description"] = $Permissions[$x]["description"];
	        //if this permission is a program permission i should have all prefix permissions added by default
	        if (substr($Permissions[$x]["permission"], 0, 6) == "prefix")
				$return["isSupervisor"] = 1;
	    }
	    return $return;
	}

	function BuildAllPermissions($orderByPermission) {
		$orderbystring = ($orderByPermission) ? " ORDER BY permission.permission" : "";
	    $SQL = "SELECT permission.permission, permission.id, permission.description FROM permission".$orderbystring;
	    $Permissions = DoSQL($SQL, SQL_SELECT);
	    $cnt = count($Permissions);
	    $return = array();
	    for ($x=0;$x<$cnt;$x++) {
	        $return[$Permissions[$x]["permission"]]["id"] = $Permissions[$x]["id"];
	        $return[$Permissions[$x]["permission"]]["description"] = $Permissions[$x]["description"];
	    }
	    return $return;
	}

	//finds all the the certs that the given user can access
	function BuildAvailableCerts($id, $supervisorMode=false) {
	    $return = array();
	    
		// first get the certs that i have direct access to
		$SQL = "SELECT id FROM productPriceList WHERE technical_id='$id' OR submission_id='$id' OR engineer_id='$id'";
		$res = DoSQL($SQL, SQL_SELECT);
		if (is_array($res)) {
			$cnt = count($res);
			for ($x=0;$x<$cnt;$x++) {
			    $return[$res[$x]["id"]] = 1;
			}
		}

		//now get any that i have rights to from the userProductPriceList table
		$SQL = "SELECT productPriceList.id FROM userProductPriceList, productPriceList WHERE productPriceList.id = userProductPriceList.productPriceList_id AND user_id='$id'";
		$res = DoSQL($SQL, SQL_SELECT);
		if (is_array($res)) {
			$cnt = count($res);
			for ($x=0;$x<$cnt;$x++) {
			    $return[$res[$x]["id"]] = 1;
			}
		}

		//only do this if supervisor mode is enabled
		if ($supervisorMode == true) {
			//now get any certs belonging to programs that i have access to
			//  first get a list of program permissions that we have
			$perm = isset($_SESSION["Permissions"]) ? $_SESSION["Permissions"] : BuildPermissions($id);

/*
			//  now build a where clause of the program ids
			$WHERE = "";
			foreach($perm as $key => $value) {
			    $ar = split("-", $key);
			    if ($ar[0] == "program") {
			        $WHERE .= "program_id='".$ar[1]."' OR ";
			    }
			}
			if (strlen($WHERE) >0) {
			    $WHERE = "AND (".substr($WHERE, 0, -4).")";

				$SQL = "SELECT productPriceList.id FROM productPriceList, priceList WHERE productPriceList.priceList_id=priceList.id ".$WHERE;
				$res = DoSQL($SQL, SQL_SELECT);
				if (is_array($res)) {
					$cnt = count($res);
					for ($x=0;$x<$cnt;$x++) {
					    $return[$res[$x]["id"]] = 1;
					}
				}
			}
*/
			//  now build a where clause of the program ids
			$WHERE = "";
			foreach($perm as $key => $value) {
			    $ar = split("-", $key);
			    if ($ar[0] == "prefix") {
			        $WHERE .= "priceList.prefix_id='".$ar[1]."' OR ";
			    }
			}
			if (strlen($WHERE) >0) {
			    $WHERE = "AND (".substr($WHERE, 0, -4).")";

				$SQL = "SELECT productPriceList.id FROM productPriceList, priceList WHERE productPriceList.priceList_id=priceList.id ".$WHERE;
				$res = DoSQL($SQL, SQL_SELECT);
				if (is_array($res)) {
					$cnt = count($res);
					for ($x=0;$x<$cnt;$x++) {
					    $return[$res[$x]["id"]] = 1;
					}
				}
			}
		}
		//dumpvar($return);
		//exit;
	    return $return;
	}
/*
	not sure if i need this function so i'll just comment it out
	function BuildProgramsAndStatuses($ar) {
	    $SQL = "DROP TABLE IF EXISTS statuscounts;;
				CREATE TEMPORARY TABLE statuscounts ( id INT UNSIGNED PRIMARY KEY, cnt INT UNSIGNED );;
				INSERT INTO statuscounts (id, cnt) SELECT status.id, count(ppl.id) FROM status
					LEFT JOIN  productPriceList AS ppl ON ppl.status_id=status.id GROUP BY status.id;;
				SELECT pl.program_id, status.name, cnt, prefix.prefix FROM priceList as pl, status, statuscounts, prefix WHERE
					status.program_id=pl.program_id	AND status.active=1	AND statuscounts.id=status.id AND pl.prefix_id=prefix.id
					ORDER BY pl.program_id ASC, status.orderIndex ASC";
				
		return DoSQL($SQL, SQL_SELECT, 4);
	}
*/

	function Authenticate($username, $password) {
		if (stristr($username, "@keylabs.com")) {
		    return AuthenticateInternal($username, $password);
		} else {
			return AuthenticateExternal($username, $password);
		}
	}

	function AuthenticateExternal($username, $password) {
		//see if the user exists
		$SQL = "SELECT id, company_id FROM user WHERE email='".strtolower($username)."' AND pass='$password'";
		$results = DoSQL($SQL, SQL_SELECT);
		if ((isset($results)) && (count($results) > 0)) {
			$sql = "update user set lastLogin=now() where email='".strtolower($username)."'";
			DoSQL($sql, SQL_UPDATE);
			return $results[0];
		}
		return false;
	}

	//eventually this function will authenticate via ldap
	function AuthenticateInternal($username, $password) {
	    return AuthenticateExternal($username, $password);
	}
?>
