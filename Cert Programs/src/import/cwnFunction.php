<?
function DoCWN() {
	global $kdb;
	global $certs;
	global $newCompanies;
	global $oldCompanies;
	global $patrocks;
	global $newDBName;
	global $allContacts;
	global $UsersEmails;
	//let's do the programs now one at a time.
	//cwn
	$submission = 249;
	$technical = 247;
	$fees = array();

	$fees["Required Test - $5,000"] = 5;
	$fees["Required Test - $5,500"] = 5;

	$statuses = array();
	$statuses["Testing Complete"] = 28;
	$statuses["Cancelled / Long Term Hold"] = 29;
	$statuses["Testing Failure"] = 30;
	$statuses["Payment Verified"] = 31;
	$statuses["Registration"] = 4;

	//get all the certs in the table along with the ids of the users
	$sql = "SELECT java.contact.email, java.project_contact.contype, cwn.product.*
			FROM java.project_contact, java.contact, cwn.product
			WHERE cwn.product.pro_id=java.project_contact.project AND java.contact.con_id=java.project_contact.contact
	 		AND (contype=$submission OR contype=$technical) ORDER BY pro_id ASC, contype ASC";
	$certs = DoSQL($kdb, "java", $sql, SQL_SELECT, false);
	//for every cert add it in the ppl table
	$certsCnt = count($certs);
	for($x=0;$x<$certsCnt;$x+=2) {
		//skip it if there is no pl entry for it
		if (!isset($fees[$certs[$x]["fee"]])) {
			echo "continuing on ".$certs[$x]["pro_id"];
		    continue;
		}

		$companyID = $newCompanies[$oldCompanies[$certs[$x]["company"]]];
		if ($companyID == 0)
		    $companyID = 1;
		//find the product if it is there
		$sql = "SELECT id FROM product WHERE company_id='$companyID' AND lower(name)='".strtolower($certs[$x]["name"])."'";
		$product = DoSQL($patrocks, $newDBName, $sql);
		if (!isset($product)) {
		    $sql = "INSERT INTO product SET company_id='$companyID', name='".$certs[$x]["name"]."', version='".$certs[$x]["revision"]."',
					comment='Imported from old system', createDate=NOW(), active=1";
		    $productID = DoSQL($patrocks, $newDBName, $sql, SQL_UPDATE, false);
		} else {
		    $productID = $product[0][0];
		}

		//insert the technical_id user if they aren' there\
		$t = $allContacts[$UsersEmails[strtolower($certs[$x]["email"])]];
		$technicalID = NewUser($companyID, $t["name"], strtolower($t["email"]), $t["phone"], "", false);

		$t = $allContacts[$UsersEmails[strtolower($certs[$x+1]["email"])]];
		$submissionID = NewUser($companyID, $t["name"], strtolower($t["email"]), $t["phone"], "", false);

		$plID = $fees[$certs[$x]["fee"]];

		//now add it to the ppl table
		$sql = "INSERT INTO productPriceList SET payment_id=1, status_id='".$statuses[$certs[$x]["cur_status"]]."', technical_id='$technicalID', submission_id='$submissionID',
				product_id=$productID, priceList_id='$plID', timeframe_id=1, registeredDate=NOW(), number='".prefixNumberInc($plID)."'";
		$newPPL = DoSQL($patrocks, $newDBName, $sql, SQL_UPDATE, false);

		//now add all the cwn logs for this entry
		$sql = "SELECT cwn.product_comment.* FROM cwn.product_comment WHERE product='".$certs[$x]["pro_id"]."' ORDER BY cr_date";
		$comments = DoSQL($kdb, "java", $sql, SQL_SELECT, false);
		$commentsCnt = count($comments);
		$sql = "INSERT INTO logEntry(productPriceList_id, logSubject_id, user_id, entryTime, comment) VALUES ";
		$comm = array();
		for($y=0;$y<$commentsCnt;$y++) {
		    $comm[] = "('$newPPL', 1, 0, '".$comments[$y]["cr_date"]."', '".addslashes($comments[$y]["bcom"])."')";
		}
		if (count($comm)>0) {
		    DoSQL($patrocks, $newDBName, $sql.implode(',', $comm), SQL_UPDATE, false);
		}
	}
	echo "cwn done!<br>";
}
?>
