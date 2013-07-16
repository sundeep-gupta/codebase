<?
function DoCSA() {
	global $kdb;
	global $certs;
	global $newCompanies;
	global $oldCompanies;
	global $patrocks;
	global $newDBName;
	global $allContacts;
	global $UsersEmails;
	//let's do the programs now one at a time.
	//CSA
	$submission = 109;
	$technical = 107;
	$fees = array();
	$fees["Content Filtering - $4,000"] = 6;
	$fees["Authentication - $4,000"] = 	8;
	$fees["Management/Reporting - $4,000"] = 16;
	$fees["PKI/Certificate Authority - $5,000"] = 10;
	$fees["Authentication - $6,000"] = 8;
	$fees["Content Filtering - $6,000"] = 6;
	$fees["Management/Reporting - $6,000"] = 16;
	$fees["Management/Reporting, Re-cert - $3,000"] = 17;
	$fees["Content Filtering, Re-cert - $3,000"] = 6;
	$fees["VPN Solutions - $7,000"] = 14;
	$fees["VPN Solutions, Re-cert - $3,500"] = 15;
	$fees["Identity - PKI / Certification Authority - $8000"] = 10;
	$fees["Perimeter Security - $6,000"] = 12;
	$fees["Application Security - $6,000"] = 6;
	$fees["Security Management and Monitoring - $6000"] = 16;
	$fees["Security Connectivity - $7,000"] = 14;
	$fees["Identity - PKI / Cert Authority, Re-cert - $4000"] = 11;
	$fees["Security Management & Monitoring Re-cert - $3000"] = 17;
	$fees["Identity - $6,000"] = 8;
	$fees["Annual Subscription Service - Call for Quote"] = 6;
	$fees["Security Connectivity, Re-cert - $3,500"] = 15;
	$fees["Security Connectivity (VPN Product) - $7000"] = 14;
	$fees["Application Security, Re-cert - $3,000"] = 7;
	$fees[" Security Management and Monitoring - $6,750"] = 16;
	$fees["Security Management and Monitoring - $6,750"] = 16;
	$fees["Security Connectivity (VPN Product) - $7,750"] = 14;
	$fees["Perimeter Security - $6,750"] = 12;
	$fees["Application Security - $6,750"] = 6;
	$fees["Service Partner Verification - $2,000"] = 6;
	$fees["Security Connectivity, Re-cert - $4,250"] = 15;
	$fees["Service Partner Verification - $3,500"] = 6;
	$fees["Perimeter Security, Re-cert - $3,750"] = 13;
	$fees["Identity - PKI / Certification Authority - $8,75"] = 10;
	$fees["Security Management and Monitoring - $6,750"] = 16;
	$fees["Identity - PKI / Cert Authority, Re-cert - $4,75"] = 11;
	$fees["Security Management & Monitoring Re-cert - $3,75"] = 17;
	$fees["Security Management & Monitoring Re-cert - $3,75"] = 17;

	$statuses = array();
	$statuses["Cancelled / Long-Term Hold"] = 24;
	$statuses["Testing Complete"] = 25;
	$statuses["Payment Received"] = 26;
	$statuses["Registration Process"] = 3;
	$statuses["Testing Begins"] = 27;

	//get all the certs in the table along with the ids of the users
	$sql = "SELECT java.contact.email, java.project_contact.contype, csa.product.*
			FROM java.project_contact, java.contact, csa.product
			WHERE csa.product.pro_id=java.project_contact.project AND java.contact.con_id=java.project_contact.contact
	 		AND (contype=$submission OR contype=$technical) ORDER BY pro_id ASC, contype ASC";
	$certs = DoSQL($kdb, "java", $sql, SQL_SELECT, false);
	//for every cert add it in the ppl table
	$certsCnt = count($certs);
	for($x=0;$x<$certsCnt;$x+=2) {
		//skip it if there is no pl entry for it
		if (!isset($fees[$certs[$x]["fee"]])) {
			echo "continuing on ".$certs[$x]["pro_id"]."<br>";
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
		
		//now add all the csa logs for this entry
		$sql = "SELECT csa.product_comment.* FROM csa.product_comment WHERE product='".$certs[$x]["pro_id"]."' ORDER BY cr_date";
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
	echo "csa done!<br>";
}
?>
