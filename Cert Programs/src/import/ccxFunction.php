<?
function DoCCX() {
	global $kdb;
	global $certs;
	global $newCompanies;
	global $oldCompanies;
	global $patrocks;
	global $newDBName;
	global $allContacts;
	global $UsersEmails;
	//let's do the programs now one at a time.
	//CCX
	$submission = 253;
	$technical = 251;
	$fees = array();
	$fees["CCX 1.0 - Two OS Platforms $5,500"] = 23;
	$fees["CCX 1.0 - Up to Two OS Platforms $5,500"] = 23;
	$fees["CCX 1.0 - Three OS Platforms - $7,000"] = 24;
	$fees["CCX 1.0 - Three OS Platforms $7,000"] = 24;
	$fees["CCX 1.0 - Four OS Platforms $8,500"] = 25;
	$fees["CCX 1.0 - Five OS Platforms $10,000"] = 26;
	$fees["CCX 2.0 - 1 Application Specific Device (ASD)$5,500"] = 27;
	$fees["CCX 2.0 - 2 ASDs -or- Operating Systems $6,500"] = 28;
	$fees["CCX 2.0 - 3 ASDs -or- Operating Systems $8,000"] = 29;
	$fees["CCX 2.0 - 4 ASDs -or- Operating Systems $9,500"] = 30;
	$fees["CCX 2.0 - 5 ASDs -or- Operating Systems $11,000"] = 31;
	$fees["CCX 1.0 - Required Test $5,500"] = 23;
	$fees["CCX 1.0 - Additional Configurations $1,500 per configuration"] = 23;
	$fees["CCX 2.0 - 1 ASD Configuration $8,500"] = 23;
	$fees["CCX 2.0 - Required Test $11,500"] = 23;
	$fees["CCX 2.0 - Additional Configurations $3,000 per configuration"] = 23;
	$fees["CCX 3.0 - 1 Application Specific Device (ASD)	$7,500"] = 32;
	$fees["CCX 3.0 - 1 Application Specific Device (ASD) $7,500"] = 32;
	$fees["CCX 3.0 - 2 ASDs -or- Operating Systems $8,500"] = 33;
	$fees["CCX 3.0	- 2 ASDs -or- Operating Systems	$8,500"] = 33;
	$fees["CCX 3.0	- 3 ASDs -or- Operating Systems	$10,000"] = 34;
	$fees["CCX 3.0	- 4 ASDs -or- Operating Systems	$11,500"] = 35;
	$fees["CCX 3.0 - 4 ASDs -or- Operating Systems $11,500"] = 35;
	$fees["CCX 3.0	- 5 ASDs -or- Operating Systems	$13,000"] = 36;
	$statuses = array();
	$statuses["Testing Complete"] = 6;
	$statuses["Testing Failure"] = 7;
	$statuses["Cancelled / Long Term Hold"] = 8;
	$statuses["Waiting on WECA / WHQL Certification"] = 9;
	$statuses["Registration"] = 5;
	$statuses["Payment Verified"] = 10;
	$statuses["Testing Begins"] = 11;

	//get all the certs in the table along with the ids of the users
	$sql = "SELECT java.contact.email, java.project_contact.contype, ccx.product.*
			FROM java.project_contact, java.contact, ccx.product
			WHERE ccx.product.pro_id=java.project_contact.project AND java.contact.con_id=java.project_contact.contact
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

		//now add all the ccx logs for this entry
		$sql = "SELECT ccx.product_comment.* FROM ccx.product_comment WHERE product='".$certs[$x]["pro_id"]."' ORDER BY cr_date";
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
	echo "ccx done!<br>";
}
?>
