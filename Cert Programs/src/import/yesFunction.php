<?
function DoYES() {
	global $kdb;
	global $certs;
	global $newCompanies;
	global $oldCompanies;
	global $patrocks;
	global $newDBName;
	global $allContacts;
	global $UsersEmails;
	//let's do the programs now one at a time.
	//yes
	$submission = 30;
	$technical = 23;
	$fees = array();

	$fees["Client Testing $600"] = 78;
	$fees["Client Testing on NetWare 5.x Only (no charge)"] = 78;
	$fees["Controller with NetWare v4.x NPA driver $1,900"] = 83;
	$fees["Java Testing (no charge)"] = 79;
	$fees["KVM Testing $600"] = 80;
	$fees["32 bit ODI driver only (NetWare 4 & 5) $2,800"] = 78;
	$fees["Custom Quote"] = 94;
	$fees["NetWare v5.x NPA device interface $2,000"] = 83;
	$fees["NetWare v4.x & v5.x NPA device interface $4,000"] = 83;
	$fees["Workstation Only (4.x & 5.x) $3,200"] = 86;

    $fees["File Server Only (4.x & 5.x) $3,000"] = 85;
	$fees["Workstation Only (4.x & 5.x) $1,000"] = 86;
	$fees["32 bit LAN driver (NetWare 4 & 5) $2,800"] = 78;
	$fees["Controller with NetWare v4.x NPA driver $2,000"] = 83;
	$fees["File Server and Workstation (4.x & 5.x) $4,000"] = 84;
	$fees["Network Printer/Print Server $4,800"] = 91;
	$fees["Client Testing on NetWare 5.x Only $600"] = 78;
	$fees["Client Testing on NetWare 4.x, 5.x $1200"] = 78;
	$fees["Java Testing $600"] = 79;
	$fees["Client Testing on NetWare 3.x, 4.x, 5.x $1200"] = 78;
	
	$fees["Controller with NetWare v5.x NPA driver $2,000"] = 83;
	$fees["Controller with v4.x & v5.x NPA driver $4,000"] = 83;
	$fees["Workstation with Two Add'l Processors $2,000"] = 88;
	$fees["Client Testing on NetWare 4.x, 5.x $900"] = 78;
	$fees["Workstation with One Add'l Processor $1,500"] = 87;
	$fees["Workstation Only (5.x & 6.x) $1,200"] = 86;
	$fees["File Server Only (5.x & 6.x) $3,000"] = 85;
	$fees["NetWare v5.x & v6.x NPA device interface $4,400"] = 83;
	$fees["Client Testing on NetWare 5.x Only $800"] = 78;
	$fees["Workstation with One Add'l Processor $1,700"] = 87;
	
	$fees["Controller with v5.x & v6.x NPA driver $4,400"] = 83;
	$fees["Controller with NetWare v6.x NPA driver $2,200"] = 83;
	$fees["Controller with NetWare v5.x NPA driver $2,200"] = 83;
	$fees["File Server and Workstation (5.x & 6.x) $4,000"] = 84;
	$fees["KVM Testing $800"] = 80;
	$fees["NetWare v6.x NPA device interface $2,200"] = 83;
	$fees["Custom Test - Please Call for Quote"] = 94;

	$statuses = array();
	$statuses["Certification Complete"] = 71;
	$statuses["Cancelled / Long-Term Hold"] = 72;
	$statuses["Failed Certification"] = 73;
	$statuses["Registration Process"] = 70;

	//get all the certs in the table along with the ids of the users
	$sql = "SELECT java.contact.email, java.project_contact.contype, yes.product.*
			FROM java.project_contact, java.contact, yes.product
			WHERE yes.product.pro_id=java.project_contact.project AND java.contact.con_id=java.project_contact.contact
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
		$sql = "SELECT id FROM product WHERE company_id='$companyID' AND lower(name)='".addslashes(strtolower($certs[$x]["name"]))."'";
		$product = DoSQL($patrocks, $newDBName, $sql);
		if (!isset($product)) {
		    $sql = "INSERT INTO product SET company_id='$companyID', name='".addslashes($certs[$x]["name"])."', version='".addslashes($certs[$x]["revision"])."',
					comment='Imported from old system', createDate=NOW(), active=1";
		    $productID = DoSQL($patrocks, $newDBName, $sql, SQL_UPDATE, false);
		} else {
		    $productID = $product[0][0];
		}

		//insert the technical_id user if they aren' there\
		$t = $allContacts[$UsersEmails[strtolower($certs[$x+1]["email"])]];
		$technicalID = NewUser($companyID, $t["name"], strtolower($t["email"]), $t["phone"], "", false);

		$t = $allContacts[$UsersEmails[strtolower($certs[$x+2]["email"])]];
		$submissionID = NewUser($companyID, $t["name"], strtolower($t["email"]), $t["phone"], "", false);

		$plID = $fees[$certs[$x]["fee"]];

		//now add it to the ppl table
		$sql = "INSERT INTO productPriceList SET payment_id=1, status_id='".addslashes($statuses[$certs[$x]["cur_status"]])."', technical_id='$technicalID', submission_id='$submissionID',
				product_id=$productID, priceList_id='$plID', timeframe_id=1, registeredDate=NOW(), number='".prefixNumberInc($plID)."'";
		$newPPL = DoSQL($patrocks, $newDBName, $sql, SQL_UPDATE, false);

		//now add all the yes logs for this entry
		$sql = "SELECT yes.product_comment.* FROM yes.product_comment WHERE product='".$certs[$x]["pro_id"]."' ORDER BY cr_date";
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
	echo "yes done!<br>";
}
?>
