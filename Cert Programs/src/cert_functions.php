<?
	define("FROM_ADDRESS", "KeyLabs Cert System < no-reply@keylabs.com >");
	
	function GetCert($id) {
		$SQL = "SELECT productPriceList.id, CONCAT(prefix.prefix, '-', productPriceList.number) AS certName,
        company.id as companyID, company.name as company, company.address1 as companyAdd1, company.address2 as companyAdd2,company.city as companyCity, company.state as companyState, company.zip as companyZip, company.country as companyCountry,
        product.name as productName, product.id as productID,
				product.comment as comment,	product.version as productVersion, status.name as status, status.id AS statusID, productPriceList.registeredDate as registeredDate,
				productPriceList.schedStartDate as schedStartDate, productPriceList.estDuration as estDuration, timeframe.name as timeframe,
				sub.name AS subName, sub.email AS subEmail, sub.phone AS subPhone, sub.id AS subID, tech.name AS techName, tech.email AS techEmail,
				tech.phone AS techPhone, tech.id AS techID, eng.name AS engName, payment.method AS method, productPriceList.priceList_id, priceList.description, priceList.SKU, prefix.id AS prefixID
				FROM prefix, productPriceList, priceList, company, product, status, user as sub, user as tech, user as eng, timeframe, payment WHERE
				productPriceList.id='$id' AND productPriceList.priceList_id=priceList.id AND priceList.prefix_id=prefix.id
				AND status.id=productPriceList.status_id AND productPriceList.submission_id=sub.id AND productPriceList.technical_id=tech.id
				AND productPriceList.engineer_id=eng.id AND timeframe.id=productPriceList.timeframe_id AND payment.id=productPriceList.payment_id
				AND productPriceList.product_id=product.id AND company.id=product.company_id AND priceList.id=productPriceList.priceList_id";
		return DoSQL($SQL);
	}
	
	function GetCerts($prefixID, $statusID=0, $orderby="") {
	    $prefixes = "";
	    foreach($_SESSION["Permissions"] as $key => $value) {
	        $t = explode('-', $key);
	        if ($t[0]=='prefix') {
	            $prefixes .= " prefix.id='".$t[1]."' OR ";
	        }
	    }
	    if (strlen($prefixes)>0) {
	        $prefixes = substr($prefixes, 0, -4);
	    }

	    //now find any certs that i have specific rights granted to me -- this should no be too great
	    $SQL = "SELECT id FROM productPriceList WHERE submission_id='".$_SESSION["id"]."' OR technical_id='".$_SESSION["id"]."' OR engineer_id='".$_SESSION["id"]."'";
	    $t = DoSQL($SQL);
		$cnt = count($t);
		$direct = "";
		for($x=0;$x<$cnt;$x++) {
		    $direct .= " ppl.id=".$t[$x]["id"]." OR ";
		}
//		if (strlen($direct) > 0)
//		    $direct = substr($direct, 0, -4);

	    //find any that i have uppl rights to
	    $SQL = "SELECT productPriceList.id FROM productPriceList, userProductPriceList WHERE productPriceList.id=userProductPriceList.productPriceList_id
				AND userProductPriceList.user_id='".$_SESSION["id"]."'";
		$t = DoSQL($SQL);
		$cnt = count($t);
		$indirect = "";
		for($x=0;$x<$cnt;$x++) {
		    $indirect .= " ppl.id=".$t[$x]["id"]." OR ";
		}
		if (strlen($indirect) > 0)
		    $indirect = substr($indirect, 0, -4);
		if (strlen($indirect) <= 0)
		    $direct = substr($direct, 0, -4);

	    //now build the where clause with the combination of all of them
	    if (!isset($_SESSION["supervisorMode"])) {
	        $WHERE = " AND ($str $direct $indirect)";
	    }

      if ($statusID==0) {
        $statusString = "";
      } else {
        $statusString = " AND status.id='$statusID' ";
      }
      

	    if (strlen($prefixes)>0 || strlen($direct)>0 || strlen($indirect)>0) {
			$SQL = "SELECT pfx.id AS prefixID, ppl.id AS id, CONCAT(pfx.prefix, '-', ppl.number) AS ID, pfx.prefix AS Prefix, com.name AS CompanyName, CONCAT(pdc.name, ', ', pdc.version) AS ProductName,
					status.name AS Status, user.initials AS Initials, CONCAT(ppl.schedStartDate, ', ', ppl.estDuration) AS Date FROM productPriceList AS ppl,
					priceList AS pl, prefix AS pfx, product AS pdc, company AS com, status, user WHERE pfx.id='$prefixID' $statusString AND pfx.id=pl.prefix_id AND pl.id=ppl.priceList_id
					AND ppl.product_id=pdc.id AND pdc.company_id=com.id AND ppl.status_id=status.id AND ppl.engineer_id=user.id $WHERE $orderby";

			return DoSQL($SQL, SQL_SELECT, 1, false);
		}
		return array();
	}

  function GetCompletionDate($id) {
    $SQL = "select * from step, productPriceListStep where productPriceListStep.step_id=step.id and step.name='Testing Complete' and productPriceList_id='$id'";
    return DoSQL($SQL, SQL_SELECT, 1, false);
  }
	
	function GetCertsMenu() {
	    $prefixes = "";
	    foreach($_SESSION["Permissions"] as $key => $value) {
	        $t = explode('-', $key);
	        if ($t[0]=='prefix') {
	            $prefixes .= " prefix.id='".$t[1]."' OR ";
	        }
	    }
	    if (strlen($prefixes)>0) {
	        $prefixes = substr($prefixes, 0, -4);
	    }
	    
	    //now find any certs that i have specific rights granted to me -- this should no be too great
	    $SQL = "SELECT id FROM productPriceList WHERE submission_id='".$_SESSION["id"]."' OR technical_id='".$_SESSION["id"]."' OR engineer_id='".$_SESSION["id"]."'";

	    $t = DoSQL($SQL);
		$cnt = count($t);
		$direct = "";
		for($x=0;$x<$cnt;$x++) {
		    $direct .= " ppl.id=".$t[$x]["id"]." OR ";
		}
//		if (strlen($direct) > 0)
//		    $direct = substr($direct, 0, -4);
	    
	    //find any that i have uppl rights to
	    $SQL = "SELECT productPriceList.id FROM productPriceList, userProductPriceList WHERE productPriceList.id=userProductPriceList.productPriceList_id
				AND userProductPriceList.user_id='".$_SESSION["id"]."'";
		$t = DoSQL($SQL);
		$cnt = count($t);
		$indirect = "";
		for($x=0;$x<$cnt;$x++) {
		    $indirect .= " ppl.id=".$t[$x]["id"]." OR ";
		}
		if (strlen($indirect) > 0)
		    $indirect = substr($indirect, 0, -4);
		if (strlen($indirect) <= 0)
		    $direct = substr($direct, 0, -4);
    if ((strlen($direct) > 0 or strlen($indirect) > 0) and (strlen($prefixes) > 0))
        $prefixes = $prefixes . " OR ";

	    //now build the where clause with the combination of all of them
	    if (!isset($_SESSION["supervisorMode"])) {
			//if there is no str, direct, or indirect then just dump nothing
			if (strlen($direct)==0 && strlen($indirect)==0) {
			    $result = array();
			    return $result;
			}
	    	$WHERE = "WHERE ".$direct.$indirect;
	    } else {
      			//if there is no str, direct, or indirect then just dump nothing
			if (strlen($prefixes)==0 && strlen($direct)==0 && strlen($indirect)==0) {
			    $result = array();
			    return $result;
			}
	    	$WHERE = "WHERE ".$prefixes.$direct.$indirect;
	    }

	    
	    $SQL = "SELECT count(*) as cnt, status.id AS statusID, prefix.id AS prefixID FROM productPriceList AS ppl INNER JOIN priceList ON (priceList.id=ppl.priceList_id)
				INNER JOIN prefix ON (priceList.prefix_id=prefix.id) INNER JOIN status ON (ppl.status_id=status.id) $WHERE GROUP BY status.id ORDER BY
				prefix.prefix ASC, status.orderIndex ASC";

		$t = DoSQL($SQL, SQL_SELECT, 1, false);
		
		//now i want to reformat this to make searching easier later
		$cnt = count($t);
		$result = array();
		for($x=0;$x<$cnt;$x++) {
		    $result[$t[$x]["prefixID"]][$t[$x]["statusID"]] = $t[$x]["cnt"];
		    $result[$t[$x]["prefixID"]]["count"] += $t[$x]["cnt"];
		}
		return $result;
	}

  function GetProgramInfo($id) {
    $SQL = "SELECT program.*, sponsorCompany.id AS sponsorCompanyID, sponsorCompany.companyName
			FROM program, sponsorCompany WHERE program.sponsorCompany_id=sponsorCompany.id AND program.id='$id'";
    return DoSQL($SQL, SQL_SELECT, 1, false);
  }

	function GetAllProgramsInfo(){
		$SQL = "SELECT program.id, program.programName, program.active FROM program ORDER BY programName";
		return DoSQL($SQL, SQL_SELECT, 1, false);
	}
  
	function GetAllProgramsInfoMenu($onlyActive=true) {
	    $onlyActive=($onlyActive) ? " AND active='1' " : "";
//		$SQL = "SELECT prefix.prefix, prefix.id AS prefix_id, program.id, program.programName, program.active FROM priceList, prefix, program
//				WHERE priceList.program_id=program.id AND priceList.prefix_id=prefix.id$onlyActive
//				GROUP BY prefix.id ORDER BY program.id ASC, prefix.prefix ASC";
		$SQL = "SELECT prefix.prefix, prefix.id AS prefix_id, program.id, program.programName, program.active FROM priceList, prefix, program
				WHERE priceList.program_id=program.id AND priceList.prefix_id=prefix.id$onlyActive
				GROUP BY prefix.id ORDER BY prefix.prefix ASC";

		return DoSQL($SQL, SQL_SELECT, 1, false);
	}
	
	function GetPrograms() {
	    $SQL = "SELECT programName, id, active FROM program";
	    return DoSQL($SQL);
	}

  function GetPrefix($id) {
    $SQL = "SELECT * from prefix where id='$id'";
    return DoSQL($SQL);
  }

	function GetPrefixes() {
	    $SQL = "SELECT id, prefix, number FROM prefix ORDER BY prefix";
		return DoSQL($SQL);
	}
	
	function GetPrefixesAndStatuses() {
	    $SQL = "SELECT prefix.prefix, prefix.id AS prefixID, status.id AS statusID, status.name FROM prefix
				LEFT JOIN status ON prefix.id=status.prefix_id ORDER BY prefix.prefix ASC, status.orderIndex ASC";
		return DoSQL($SQL, SQL_SELECT, 1, false);
 }
	
	function GetAllSponsorCompanies() {
	    $SQL = "SELECT id, CompanyName as name FROM sponsorCompany ORDER BY name";
	    return DoSQL($SQL);
	}
	
	function GetAllContacts($companyID="1",$orderBy=""){
		if ($orderBy == "")
		    $orderBy = " ORDER BY name ASC";
	    $sql = "SELECT u1.* FROM user AS u1 WHERE u1.company_id='$companyID' AND u1.initials='' AND u1.active=1$orderBy";
		return DoSQL($sql, SQL_SELECT);
	}

	function GeneratePassword() {
		//come up with a semi-random password
		$str =str_shuffle("abcefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVQXYZ");
		return substr($str,1,8);
	}
	
	function EditUser($id, $name, $email, $phone, $setLoginTime=false) {
	    $logintime = ($setLoginTime) ? ", lastLoginTime=NOW()" : "";
		$pass = GeneratePassword();

		$sql =	"UPDATE user SET ".
	            "name='$name',".
	            "email='".strtolower($email)."',".
	            "phone='$phone'$logintime".
				" WHERE id='$id'";
		DoSQL($sql, SQL_UPDATE);
		return $id;
	}
	
	function GetUser($id) {
		$sql = "SELECT id, name, phone, email, lastLogin, pass, company_id FROM user WHERE id='$id'";
		return DoSQL($sql, SQL_SELECT);
	}

  function GetUserInfoByEmail($email) {
    $sql = "SELECT email,pass from user where email='$email'";
    $temp = DoSQL($sql, SQL_SELECT);
    return $temp;
//    return DoSQL($sql, SQL_SELECT);
  }	

	function NewUser($companyID, $name, $email, $phone, $title="", $pass="", $sendEmail=true) {
	    //first check to be sure there isn't already a user with that email address
	    $email2 = strtolower($email);
	    $SQL = "SELECT id FROM user WHERE email='$email2'";
	    $res = DoSQL($SQL, SQL_SELECT, 1, false);
	    if (!isset($res)) { //[0][0] <= 0) {
			if ($pass=="") {
		    	$pass=GeneratePassword();
		   	}
			$sql =	"INSERT INTO user SET ".
			          "company_id='$companyID',".
		            "name='$name',".
		            "initials='',".
		            "email='$email2',".
		            "phone='$phone',".
		            "pass='$pass',".
	              "active='1'";
			$submissionID = DoSQL($sql, SQL_UPDATE);

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
      		if (isset($title)) {
      			$sql = "UPDATE user set title='$title' where email='$email'";
      			$update = DoSQL($sql, SQL_UPDATE);
      		}
	        $submissionID = $res[0][0];
	    }
		return $submissionID;
  }

	function NewCompany($companyName, $address1, $address2, $city, $state, $zip, $country="usa") {
		$sql =	"INSERT INTO company SET ".
	            "name='$companyName',".
	            "address1='$address1',".
	            "address2='$address2',".
	            "city='$city',".
	            "state='$state',".
	            "zip='$zip',".
				"country='$country', active=1";
		$companyID = DoSQL($sql, SQL_UPDATE);

		return $companyID;
	}

	
	function GetPayments() {
	    $SQL = "SELECT id, method FROM payment WHERE active=1 ORDER BY method ASC";
		return DoSQL($SQL);
	}
	
	function GetSKUs($prefixID) {
    $SQL = "SELECT id,description from priceList WHERE prefix_id='$prefixID'";
    return DoSQL($SQL);
  }
	
	function GetTimeframes() {
	    $SQL = "SELECT id, name FROM timeframe WHERE active=1 ORDER BY name ASC";
	    return DoSQL($SQL);
	}
	
	function GetEngineers() {
	    $SQL = "SELECT id, name FROM user WHERE active=1 AND initials!='' ORDER BY name ASC";
	    return DoSQL($SQL);
	}
	
	function GetPPLPlatforms($id) {
	    $SQL = "SELECT platform.id, platform.name, platform.version FROM productPriceListPlatform AS pplp, platform WHERE
				pplp.platform_id=platform.id AND pplp.productPriceList_id='$id' ORDER BY platform.name ASC, platform.version ASC";
		return DoSQL($SQL);
	}

	function GetPPLFiles($id) {
	    $SQL = "SELECT * FROM file where productPriceList_id=$id order by name ASC";
		return DoSQL($SQL);
	}
	
	function GetPrefixPlatforms($id) {
	    $SQL = "SELECT platform.id, platform.name, platform.version, platform.priceList_id FROM priceList, platform WHERE platform.priceList_id=priceList.id AND priceList.prefix_id='$id' AND active=1";
		return DoSQL($SQL, SQL_SELECT);
	}

	function GetCertLogs($id) {
	    $sql = "select user.name, logEntry.entryTime, logEntry.comment,logSubject.subject from logEntry, logSubject, user where logEntry.productPriceList_id='$id' AND logSubject.id=logEntry.logSubject_id AND user.id=logEntry.user_id ";
		return DoSQL($sql, SQL_SELECT);
	}
	function GetCertLogs2($id) {
	    $sql = "select user.name, logEntry.entryTime, logEntry.comment,logSubject.subject from logEntry, logSubject, user where logEntry.productPriceList_id='$id' AND logSubject.id=logEntry.logSubject_id AND user.id=logEntry.user_id order by logEntry.entryTime DESC";
		return DoSQL($sql, SQL_SELECT);
	}

	function GetLogSubjects($useWhere=true) {
	    if ($useWhere)
	        $WHERE = " WHERE active=1";
	    $sql = "SELECT id, subject, active FROM logSubject $WHERE ORDER BY subject";
	    return DoSQL($sql, SQL_SELECT);
	}
	
	function GetPlatform($id) {
	    $SQL = "SELECT * FROM platform WHERE id='$id'";
	    return DoSQL($SQL);
	}
	
	function GetPlatforms($id) {
	    $SQL = "SELECT platform.id, platform.name, platform.version FROM platform WHERE priceList_id='$id' AND active=1";
	 	return DoSQL($SQL);
	}
	
	function GetProductFiles($id) {
	    $SQL = "SELECT id, description, path FROM file WHERE product_id='$id'";
	    return DoSQL($SQL);
	}
	
	function GetProduct($id) {
	    $SQL = "SELECT id, company_id, name, version, comment, createDate FROM product WHERE id='$id'";
	    return DoSQL($SQL);
	}
	
	function GetFile($id) {
	    $SQL = "SELECT id, type, description, path, name FROM file WHERE id='$id'";
		return DoSQL($SQL);
	}
	
	function GetAllPrefixStatuses($id) {
	    $SQL = "SELECT id, name, active FROM status WHERE prefix_id='$id' ORDER BY name";
	    return DoSQL($SQL, SQL_SELECT);
	}
	
	
	function GetPrefixStatuses($id) {
	    $SQL = "SELECT id, name, active FROM status WHERE prefix_id='$id' AND active=1 ORDER BY orderIndex";
	    return DoSQL($SQL, SQL_SELECT);
	}
	
	function GetPrefixSteps($id) {
    $SQL = "SELECT * from step where prefix_id='$id'";
    return DoSQL($SQL, SQL_SELECT);
  }
  
	function GetPriceList($orderby="") {
	    $SQL = "SELECT SKU, description, price, id FROM priceList $orderby";
	    return DoSQL($SQL);
	}
	
	function GetPriceListItem($id) {
	    $SQL = "SELECT * FROM priceList WHERE id='$id'";
	    return DoSQL($SQL);
	}

  function GetStatus($id) {
    $SQL = "SELECT name from status where id='$id'";
    return DoSQL($SQL, SQL_SELECT);
  }
	
	function GetStatusSteps($id) {
	    $SQL = "SELECT step.id, step.name FROM statusSet, step WHERE statusSet.status_id='$id' AND statusSet.step_id=step.id AND step.active=1
				ORDER BY step.orderIndex";
	    return DoSQL($SQL, SQL_SELECT);
	}

	function GetOtherStatusSteps($id, $prefixid) {
	    $SQL = "SELECT step.id, step.name FROM step LEFT OUTER JOIN statusSet on (statusSet.step_id=step.id)
              WHERE (statusSet.status_id!='$id'
              or (isnull(statusSet.id))) and step.prefix_id=$prefixid AND step.active=1
              ORDER BY step.name";
	    return DoSQL($SQL, SQL_SELECT);
	}
	
	function GetCertSteps($id) {
	    $SQL = "SELECT step_id, whenMet FROM productPriceListStep WHERE productPriceList_id='$id'";
	    return DoSQL($SQL, SQL_SELECT);
	}
	
	function GetMainContacts($id) {
		$SQL = "SELECT subm.email AS submissionEmail, subm.id AS submissionID, subm.name AS submissionName, tech.email AS technicalEmail,
		 		tech.id AS technicalID, tech.name AS technicalName, eng.email AS engineerEmail, eng.id AS engineerID, eng.name AS engineerName
				FROM productPriceList AS ppl, user AS subm, user AS tech, user AS eng WHERE ppl.id='$id' AND ppl.submission_id=subm.id
				AND ppl.technical_id=tech.id AND ppl.engineer_id=eng.id";
		return DoSQL($SQL);
	}
	
	function GetPrefixUsers($id) {
//	    $SQL = "SELECT email, id, name, mandatory FROM prefixUser, user WHERE user.id=prefixUser.user_id AND prefixUser.prefix_id='$id'";
    $SQL="SELECT * FROM user,userPermission,permission WHERE userPermission.permission_id=permission.id AND userPermission.user_id=user.id AND permission.permission='prefix-".$id."'";
//dumpvar($SQL); exit;
		return DoSQL($SQL);
	}
	
//	function GetMiscUsers($id) {
//		$SQL = "SELECT email, user.id, name, mandatory FROM userProductPriceList AS uppl, user WHERE uppl.productPriceList_id='$id' AND uppl.user_id=user.id";
//		return DoSQL($SQL);
//	}
	
	function GetMiscUser($id) {
	    $SQL = "SELECT user.name, user.email, user.id, userProductPriceList.mandatory FROM userProductPriceList, user
				WHERE userProductPriceList.user_id=user.id AND userProductPriceList.productPriceList_id='$id' AND user.active=1
				ORDER BY user.email";
		return DoSQL($SQL);
	}
	
	function GetMonthsCerts($date, $id=0) {
	    if ($id != 0)
	        $WHERE = " WHERE prefix.id='$id'";

	    $secondsInADay = "86400";
	    $ar = explode("-", date("m-t-Y", $date));
	    $monthEndStamp = mktime(0, 0, 0, $ar[0], $ar[1], $ar[2]);
	    $sql = "SELECT CONCAT(prefix.prefix, '-', productPriceList.number) AS certName,user.initials,
				productPriceList.id, UNIX_TIMESTAMP(productPriceList.schedStartDate) AS schedStartDate,
				UNIX_TIMESTAMP(DATE_ADD(schedStartDate, INTERVAL -DAYOFWEEK(schedStartDate) + 1 + (FLOOR((estDuration + DAYOFWEEK(schedStartDate) - 3) / 5) * 7) +
				(estDuration + DAYOFWEEK(schedStartDate) - 3) % 5 + 1 DAY)) AS schedEndDate
				FROM productPriceList INNER JOIN priceList ON (productPriceList.priceList_id=priceList.id)
				INNER JOIN prefix ON (priceList.prefix_id=prefix.id)
				INNER JOIN user ON (productPriceList.engineer_id=user.id)
				$WHERE HAVING (schedStartDate BETWEEN '$date' AND '$monthEndStamp') OR (schedEndDate BETWEEN '$date' AND '$monthEndStamp')";
//	    $sql = "SELECT CONCAT(program.prefix, '-', certs.certNumber) AS certName, company.companyName, user.initials, certs.id, UNIX_TIMESTAMP(certs.schedStartDate) AS schedStartDate,
//  				UNIX_TIMESTAMP(DATE_ADD(schedStartDate, INTERVAL -DAYOFWEEK(schedStartDate) + 1 + (FLOOR((estDuration + DAYOFWEEK(schedStartDate) - 3) / 5) * 7) +
//				  (estDuration + DAYOFWEEK(schedStartDate) - 3) % 5 + 1 DAY)) AS schedEndDate
//                FROM certs INNER JOIN program ON program.id=certs.program_id INNER JOIN company ON company.id=certs.company_id
//				INNER JOIN user ON user.id=certs.engineer_id$WHERE HAVING
//  				(schedStartDate BETWEEN '$date' AND '$monthEndStamp') OR (schedEndDate BETWEEN '$date' AND '$monthEndStamp')";
		$res = DoSQL($sql, SQL_SELECT, 1, false);
		$return["res"] = $res;
		//reformat the return data to an associative array $array[day] = array("event1", "event2" ...);
		// this will make searching it easier
		$rescnt = count($res);
		$return["days"] = Array();
		for($x=0;$x<$rescnt;$x++) {
		// startDay may need to be converted to strtotime like in GetMonthsEvents
		    $startDay = $res[$x]["schedStartDate"];
		    $endDay = $res[$x]["schedEndDate"];

		    //make sure we are in the current month
		    if ($startDay < $date) {
		        $startDay = $date;
		    }

		    //make sure we don't go out of the month
		    if ($endDay > $monthEndStamp) {
		        $endDay = $monthEndStamp;
		    }

		    while ($startDay <= $endDay+3600) {
		        $return["days"][date("j", $startDay)][] = $x;
		        $startDay += $secondsInADay;
		    }
		}
		return $return;
	}
function GetMonthsEvents($date) {

	    $secondsInADay = "86400";
	    $ar = explode("-", date("m-t-Y", $date));
	    $monthEndStamp = mktime(0, 0, 0, $ar[0], $ar[1], $ar[2]);
	    $sql = "SELECT event.*,
        UNIX_TIMESTAMP(DATE_ADD(schedStartDate, INTERVAL -DAYOFWEEK(schedStartDate) + 1 + (FLOOR((estDuration + DAYOFWEEK(schedStartDate) - 3) / 5) * 7) +
				(estDuration + DAYOFWEEK(schedStartDate) - 3) % 5 + 1 DAY)) AS schedEndDate
        FROM event 
				HAVING (schedStartDate BETWEEN '$date' AND '$monthEndStamp') OR (schedEndDate BETWEEN '$date' AND '$monthEndStamp')";
//				dumpvar($sql); exit;
		$res = DoSQL($sql, SQL_SELECT);
		$return["res"] = $res;
		//reformat the return data to an associative array $array[day] = array("event1", "event2" ...);
		// this will make searching it easier
		$rescnt = count($res);
		$return["days"] = Array();
		for($x=0;$x<$rescnt;$x++) {
		    $startDay = strtotime($res[$x]["schedStartDate"]);
		    $endDay = $res[$x]["schedEndDate"];

// there seems to be some inconsistency in the schedEndDate returned by the sql stm above...4/1 with dur of 3 returns 4/5, 4/4 with dur of 3 returns 4/6

//echo "date=$date,sd=$startDay,".$res[$x][schedStartDate2].",ed=$endDay,mes=".date("U",$monthEndStamp)."<br>";
  	    //make sure we are in the current month
		    if ($startDay < $date) {
		        $startDay = $date;
		    }

		    //make sure we don't go out of the month
		    if ($endDay > $monthEndStamp) {
		        $endDay = $monthEndStamp;
		    }
		    while ($startDay <= $endDay+3600) {
		        $return["days"][date("j",$startDay)][] = $x;
//		    echo "sd=$startDay,ed=$endDay,".date("j",$startDay).",$x<br>";
		        $startDay += $secondsInADay;
		    }
		}
		return $return;
	}
  	
	function GetEmail($id){
		$SQL="select email.subject, email.body from email where email.id = '$id'";
		return DoSQL($SQL);
	}
	
	function AddLog($id, $comment, $statusid=0, $status="Comment Only") {
	    if ($statusid == 0) { //then we want to search for a string
	  		$SQL = "SELECT * from logSubject WHERE subject = '$status'";
	  		$ret = DoSQL($SQL, SQL_SELECT, 1, false);
	  		$statusid = (isset($ret)) ? $ret[0][0] : 0;
	    }
	    
		$SQL = "INSERT INTO logEntry SET
				logSubject_id='$statusid',
				productPriceList_id='$id',
				user_id='".$_SESSION["id"]."',
				entryTime=NOW(),
				comment='$comment'";
		return DoSQL($SQL, SQL_UDPATE, 1, false);
	}

	function ParseEmail($certinfo, $haystack) {
	    //find all the contacts on the current cert with 'Cisco Partner Manager'
	    $SQL="SELECT email FROM user, userProductPriceList WHERE user.id=userProductPriceList.user_id
			 AND (user.name='Cisco Partner Manager' or user.title='Cisco Partner Manager') AND userProductPriceList.productPriceList_id='".
			 $certinfo["id"]."'";

		$res = DoSQL($SQL);
		$rescnt = count($res);
		$partnermanagers = array();
		for($x=0;$x<$rescnt;$x++) {
			$partnermanagers[] = $res[$x]["email"];
		}
		
	    $patterns[] = "/%CERTNAME%/";
	    $patterns[] = "/%COMPANY%/";
	    $patterns[] = "/%PRODUCTNAME%/";
	    $patterns[] = "/%COMMENT%/";
	    $patterns[] = "/%PRODUCTVERSION%/";
	    $patterns[] = "/%STATUS%/";
	    $patterns[] = "/%REGISTEREDDATE%/";
	    $patterns[] = "/%SCHEDSTARTDATE%/";
	    $patterns[] = "/%ESTIMATEDDURATION%/";
	    $patterns[] = "/%TIMEFRAME%/";
	    $patterns[] = "/%SUBMISSIONNAME%/";
	    $patterns[] = "/%SUBMISSIONPHONE%/";
	    $patterns[] = "/%SUBMISSIONEMAIL%/";
	    $patterns[] = "/%TECHNICALNAME%/";
	    $patterns[] = "/%TECHNICALPHONE%/";
	    $patterns[] = "/%TECHNICALEMAIL%/";
	    $patterns[] = "/%ENGINEERNAME%/";
	    $patterns[] = "/%PAYMENTMETHOD%/";
	    $patterns[] = "/%CISCOPARTNERMANAGER%/";
	    
	    $replacements[] = $certinfo["certName"];
	    $replacements[] = $certinfo["company"];
	    $replacements[] = $certinfo["productName"];
	    $replacements[] = $certinfo["comment"];
	    $replacements[] = $certinfo["productVersion"];
	    $replacements[] = $certinfo["status"];
	    $replacements[] = $certinfo["registeredDate"];
	    $replacements[] = $certinfo["schedStartDate"];
	    $replacements[] = $certinfo["estDuration"];
	    $replacements[] = $certinfo["timeframe"];
	    $replacements[] = $certinfo["subName"];
	    $replacements[] = $certinfo["subPhone"];
	    $replacements[] = $certinfo["subEmail"];
	    $replacements[] = $certinfo["techName"];
	    $replacements[] = $certinfo["techPhone"];
	    $replacements[] = $certinfo["techEmail"];
	    $replacements[] = $certinfo["engName"];
	    $replacements[] = $certinfo["method"];
	    $replacements[] = implode(",", $partnermanagers);

		return preg_replace($patterns, $replacements, $haystack);
	}
	
	function GetCompanyProducts($id) {
	    $SQL = "SELECT product.name, product.version, product.comment, product.id FROM product WHERE product.company_id='$id' AND active=1
				ORDER BY createDate ASC, id ASC";
	    return DoSQL($SQL);
	}

  function GetCompanyForID($id) {
      $SQL = "select company.name from company,productPriceList,product where productPriceList.id = $id and productPriceList.product_id=product.id and product.company_id = company.id";
      return DoSQL($SQL);
  }

?>
