<?
function DoRN() {
	global $kdb;
	global $certs;
	global $newCompanies;
	global $oldCompanies;
	global $patrocks;
	global $newDBName;
	global $allContacts;
	global $UsersEmails;
	//let's do the programs now one at a time.
	//rn
	$submission = 97;
	$technical = 95;
	$fees = array();
	
	$fees["Standard $5,500"] = 95;
	$fees["Re-Certification with multiple players - Call fo"] = 104;
	$fees["Re-Certification $2,400"] = 96;
	$fees["Standard test - $5,500"] = 95;
	$fees["Standard test plus 1 player - $8,000"] = 97;
	$fees["Standard test plus 2 players - $10,500"] = 99;
	$fees["Re-Certification $2,500"] = 96;
	$fees["Standard (Required) test - $10,000"] = 95;
	$fees["Standard test plus 1 server - $15,000"] = 98;
	$fees["Re-Certification within 1 year - $6,000"] = 96;
	$fees["Standard (Required) test - $7,500"] = 95;
	$fees["Re-Certification within 1 year - $5,500"] = 96;
	$fees["Standard test plus 1 player - $12,500"] = 98;
	$fees["Standard test plus 1 server and 5 players - $37,"] = 102;

	$statuses = array();
	$statuses["Certification Complete"] = 47;
	$statuses["Certification Failed"] = 48;
	$statuses["Cancelled / Long-Term Hold"] = 49;

	//get all the certs in the table along with the ids of the users
	$sql = "SELECT java.contact.email, java.project_contact.contype, rn.product.*
			FROM java.project_contact, java.contact, rn.product
			WHERE rn.product.pro_id=java.project_contact.project AND java.contact.con_id=java.project_contact.contact
	 		AND (contype=$submission OR contype=$technical) ORDER BY pro_id ASC, contype ASC";
	$certs = DoSQL($kdb, "java", $sql, SQL_SELECT, false);
	//for every cert add it in the ppl table
	$certsCnt = count($certs);
	for($x=0;$x<$certsCnt;$x+=2) {
		$companyID = $newCompanies[$oldCompanies[$certs[$x]["company"]]];
		if ($companyID == 0)
		    $companyID = 1;
		//find the product if it is there
		$sql = "SELECT id FROM product WHERE company_id='$companyID' AND lower(name)='".addslashes((strtolower($certs[$x]["name"])))."'";
		$product = DoSQL($patrocks, $newDBName, $sql);
		if (!isset($product)) {
		    $sql = "INSERT INTO product SET company_id='$companyID', name='".addslashes($certs[$x]["name"])."', version='".addslashes($certs[$x]["revision"])."',
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

		//skip it if there is no pl entry for it
		if (!isset($fees[$certs[$x]["fee"]])) {
		    $plID = 104;
		} else {
			$plID = $fees[$certs[$x]["fee"]];
		}

		//now add it to the ppl table
		$sql = "INSERT INTO productPriceList SET payment_id=1, status_id='".$statuses[$certs[$x]["cur_status"]]."', technical_id='$technicalID', submission_id='$submissionID',
				product_id=$productID, priceList_id='$plID', timeframe_id=1, registeredDate=NOW(), number='".prefixNumberInc($plID)."'";
		$newPPL = DoSQL($patrocks, $newDBName, $sql, SQL_UPDATE, false);

		//now add all the rn logs for this entry
		$sql = "SELECT rn.product_comment.* FROM rn.product_comment WHERE product='".$certs[$x]["pro_id"]."' ORDER BY cr_date";
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
	echo "rn done!<br>";
}
?>