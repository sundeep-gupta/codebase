<?
	include("functions.php");
	include("cert_functions.php");
	include("products/productfunctions.php");
	include("ciscoarray.php");
//  include("header.php");

	//first thing to do is to be sure that this is a complete post and not something else
	if (!isset($_POST["Solution_ID"]) ||
	    !isset($_POST["Solution_Desc"]) ||
	    !isset($_POST["Category_ID"]) ||
	    !isset($_POST["Category_Desc"]) ||
	    !isset($_POST["Product_Cisco_IDS"]) ||
		!isset($_POST["Partner_Managers"]) ||
		!isset($_POST["CPO_Office_Alias"]) ||
		!isset($_POST["Contact_Company_Name"]) ||
		!isset($_POST["Contact_Address1"]) ||
		!isset($_POST["Contact_Address2"]) ||
		!isset($_POST["Contact_City"]) ||
		!isset($_POST["Contact_State"]) ||
		!isset($_POST["Contact_Zip"]) ||
		!isset($_POST["Contact_Country"]) ||
		!isset($_POST["Company_URL"]) ||
		!isset($_POST["Product_Submit"]) ||
		!isset($_POST["Product_Cisco_Coexist"]) ||
		!isset($_POST["Product_Rev"]) ||
		!isset($_POST["Cisco_First_Name"]) ||
		!isset($_POST["Cisco_Last_Name"]) ||
		!isset($_POST["Cisco_Title"]) ||
		!isset($_POST["Cisco_Phone"]) ||
		!isset($_POST["Cisco_Fax"]) ||
		!isset($_POST["Cisco_Email"]) ||
		!isset($_POST["Project_ID"])
	) {
	    $outputMessage = "An incomplete variable list was posted.";
	    $projectid = $_POST["Project_ID"];
	    $poststatus="N";
      include("postForm2.php");
      exit;
	}
//dumpvar($_POST, "Posted Variables"); exit;

$projectid = $_POST["Project_ID"];
$poststatus = "Y";	
	//find the priceList id
	$priceListID = $ciscoArray[$_POST["Solution_Desc"]][$_POST["Category_ID"]];
	if ($priceListID == 0) {
	    $outputMessage = "The testing information you attempted to send was not submitted because this Solution (Category) is not set up for testing at KeyLabs.  Please contact KeyLabs (certinfo@keylabs.com) to setup the new Solution (Category).<br><br>";
	    $outputMessage = $outputMessage . "<a href=\"http://wwwin.cisco.com/cgi-bin/it/marketing/avvid/index.cgi\">Return to PRM Home</a>";
	    $poststatus="N";
      include("postForm2.php"); 
      exit;
	} 
	//find the prefix id
	$SQL = "SELECT * FROM priceList WHERE id='$priceListID'";
	$pl = DoSQL($SQL);
	
	if (count($pl) <= 0) {
	    $outputMessage = "The testing information you attempted to send was not submitted because this Solution (Category) is not set up for testing at KeyLabs.  Please contact KeyLabs (certinfo@keylabs.com) to setup the new Solution (Category).<br><br>";
	    $outputMessage = $outputMessage . "<a href=\"http://wwwin.cisco.com/cgi-bin/it/marketing/avvid/index.cgi\">Return to PRM Home</a>";
	    $poststatus="N";
      include("postForm2.php"); 
	    exit;
	}
	
	//find the company
	//must do shortCompanyName because Contact_Company_Name could be longer than the field length (25)
	$shortCompanyName = substr($_POST["Contact_Company_Name"],0,25);
	$SQL = "SELECT id FROM company WHERE name = '$shortCompanyName'";
	$company = DoSQL($SQL);
	if (count($company) <= 0) {
	    //create a new company
	    $companyID = NewCompany($_POST["Contact_Company_Name"], $_POST["Contact_Address1"], $_POST["Contact_Address2"],
					$_POST["Contact_City"], $_POST["Contact_State"], $_POST["Contact_Zip"]);
	} else {
	    $companyID = $company[0][0];
	}
	
	//add the vendor user
	$userID = NewUser($companyID, $_POST["Cisco_First_Name"]." ".$_POST["Cisco_Last_Name"], $_POST["Cisco_Email"], $_POST["Cisco_Phone"]);
	
	//look for the product
	//SELECT id FROM product WHERE company_id='6' AND name='Rel5.7update cco test product' AND version='9.0'
	$SQL = "SELECT id FROM product WHERE company_id='$companyID' AND name='".$_POST["Product_Submit"]."' AND version='".$_POST["Product_Rev"]."'";
	$product = DoSQL($SQL);
	if (count($product) <= 0) {
	    $SQL = "INSERT INTO product SET company_id='$companyID', name='".$_POST["Product_Submit"]."',
				version='".$_POST["Product_Rev"]."', createDate=NOW()";
		$productID = DoSQL($SQL, SQL_UPDATE);
	} else {
	    $productID = $product[0][0];
	}
	
	//find the payment id
	$SQL = "SELECT id FROM payment WHERE method='Other'";
	$payment = DoSQL($SQL);
	
	//find the status id
	$SQL = "SELECT id FROM status WHERE prefix_id='".$pl[0]["prefix_id"]."' AND name='Registered'";
	$status = DoSQL($SQL);
	
	//find timeframe id
	$SQL = "SELECT id FROM timeframe WHERE name='Other'";
	$timeframe = DoSQL($SQL);
	
	//get a new number
	$number = prefixNumberInc($priceListID);
	
	$SQL = "INSERT INTO productPriceList SET payment_id='".$payment[0][0]."', status_id='".$status[0][0]."', technical_id='$userID',
			submission_id='$userID', engineer_id='0', product_id='$productID', priceList_id='$priceListID',
			timeframe_id='".$timeframe[0][0]."', registeredDate=NOW(), number='".$number."'";
	$newProductPriceList = DoSQL($SQL, SQL_UPDATE);
	
	$tempCert = GetCert($newProductPriceList);
	
	//find cisco's company id
	$SQL = "SELECT id FROM company WHERE name='Cisco'";
	$ciscoCompanyID = DoSQL($SQL);
	if (!isset($ciscoCompanyID))
	    $ciscoCompanyID[0][0] = 1;
	    
	$partnerManangerIDs = array();
	//now search for any user in the
	//add partner managers
	$managers = explode(";", $_POST["Partner_Managers"]);
	$cnt = count($managers);
	for($x=0;$x<$cnt;$x++) {
	    $partnerManagerIDs[] = NewUser($ciscoCompanyID[0][0], 'Cisco Partner Manager', $managers[$x], '', 'Cisco Partner Manager');
	}
	
	//make sure and get the cpo office alias in the prefixUser table and added to the userproductpricelist
	$CPOID = NewUser($ciscoCompanyID[0][0], 'CPO Office', $_POST["CPO_Office_Alias"], '');
	$partnerManagerIDs[] = $CPOID;
	$SQL="SELECT * FROM prefixUser WHERE user_id='$CPOID' AND prefix_id='".$pl[0]["prefix_id"]."'";
	$res = DoSQL($SQL, SQL_SELECT);
	if (!isset($res)) {
		$SQL = "INSERT INTO prefixUser SET user_id=$CPOID, prefix_id='".$pl[0]["prefix_id"]."', mandatory=1";
		DoSQL($SQL, SQL_UPDATE);
	}
	
	//now add rights to this cert for each partner manager
 	$cnt = count($partnerManagerIDs);
	$SQL = "INSERT INTO userProductPriceList(user_id, productPriceList_id, mandatory) VALUES ";
	for($x=0;$x<$cnt;$x++) {
		$SQL .= "(".$partnerManagerIDs[$x].", ".$newProductPriceList.", 1),";
	}
	DoSQL(substr($SQL, 0, -1), SQL_UPDATE);

//send email to partner manager, submission contact, and KeyLabs
	$headers["Subject"] = $_POST["Contact_Company_Name"] . " New Product Registered at KeyLabs - Cisco Technology Developer Program";
	$headers["From"] = FROM_ADDRESS;
  $to = $_POST["Cisco_Email"].",certinfo@keylabs.com";

	$body="The following product has been registered for testing at KeyLabs in association with the Cisco Technology Developer Program.  Details of the registration are listed below:\r\n\r\n" .

        $_POST["Solution_Desc"] . "\r\n\r\n" .
        
        "KeyLabs Cert ID: " . $tempCert[0]["certName"] . "\r\n\r\n" .

        "Partner Manager(s): ". $_POST["Partner_Managers"] . " \r\n" .
        "Solution Description: ". $_POST["Solution_Desc"] . " \r\n" .
        "Category Description: ". $_POST["Category_Desc"] . " \r\n" .
        "Submission Company: ". stripslashes($_POST["Contact_Company_Name"]) . " \r\n" .
        "Submission Company Address 1: ". $_POST["Contact_Address1"] . " \r\n" .
        "Submission Company Address 2: ". $_POST["Contact_Address2"] . " \r\n" .
        "Submission Company City: ". $_POST["Contact_City"] . " \r\n" .
        "Submission Company State: ". $_POST["Contact_State"] . " \r\n" .
        "Submission Company Zip: ". $_POST["Contact_Zip"] . " \r\n" .
        "Submission Company Country: ". $_POST["Contact_Country"] . " \r\n" .
        "Submission Company URL: ". $_POST["Company_URL"] . " \r\n" .
        "Submission Contact: ". $_POST["Cisco_First_Name"] . " " . $_POST["Cisco_Last_Name"] . " \r\n" .
        "Submission Title: ". $_POST["Cisco_Title"] . " \r\n" .
        "Submission Phone: ". $_POST["Cisco_Phone"] . " \r\n" .
        "Submission Fax: ". $_POST["Cisco_Fax"] . " \r\n" .
        "Submission Email: ". $_POST["Cisco_Email"] . " \r\n" .
        "Product Name: ". stripslashes($_POST["Product_Submit"]) . " \r\n" .
        "Product Version: ". $_POST["Product_Rev"] . " \r\n" . 
        "Cisco Products: ". $_POST["Product_Cisco_Coexist"] . "\r\n\r\n" .
        "Please follow-up with your Cisco Partner Manager and with KeyLabs at certinfo@keylabs.com for corrections to this information.\r\n\r\n" .
        "Payment of the testing fee is required before testing may be scheduled.  KeyLabs accepts the following forms of payment:\r\n\r\n" .
        "-	Purchase Order (US partners only)\r\n" .
        "-	Wire Transfer\r\n" .
        "-	Company Check\r\n" .
        "-	Visa\r\n" .
        "-	MasterCard\r\n" .
        "-	American Express\r\n\r\n" .
        "Please reply to ONLY certinfo@keylabs.com with your preferred form of payment and KeyLabs will provide payment instructions.\r\n\r\n" .
        "Also, prior to testing, please review the terms of testing at KeyLabs in the KeyLabs Master Testing Agreement at http://www.keylabs.com/CertPrograms/keylabsmta.php.  You must be logged in to the certification system to access the link to the testing agreement.\r\n\r\n" .
        "To check on your product's status at KeyLabs login to http://www.keylabs.com/CertPrograms/.  The Testing tab at the top shows the status for the product(s) you currently have registered for testing at KeyLabs.  The navigation tree on the left shows the product(s) registered for testing by solution type and current status.\r\n\r\n" .
        "If you have forgotten your password, go to the URL above and click on the ‘I forgot my password’ link, follow the instructions, and you will receive an email with your account information.  Once you login, you may change your password.\r\n\r\n" .
        "KeyLabs will contact you with additional instructions shortly after you specify your preferred payment type.\r\n\r\n" .
        "Thank you for your support of KeyLabs and the Cisco Technology Developer Program.\r\n\r\n" .
        "Cisco Certification Team at KeyLabs\r\n" .
        "385 South 520 West\r\n" .
        "Lindon, UT  84042\r\n" .
        "t. 801-852-9500\r\n" .
        "f. 801-852-9501\r\n" .
        "e. certinfo@keylabs.com\r\n" .
        "http://www.keylabs.com/cisco/";

  SendMail($to, $headers, $body);	

//send email to 
	$headers["Subject"] = "FYI: " . $headers["Subject"];
	$headers["From"] = FROM_ADDRESS;
  $to = str_replace(";",",",$_POST["Partner_Managers"]).",".$_POST["CPO_Office_Alias"];
	$body="THIS IS A COPY OF WHAT THE CISCO TECHNOLOGY DEVELOPER PROGRAM PARTICIPANT HAS RECEIVED AND IS FOR YOUR INFORMATION ONLY.  NO ACTION IS REQUIRED.\r\n============================================\r\n".
        "\r\n".$body;

  SendMail($to, $headers, $body);	
  
//Make log entry for cert
  AddLog($newProductPriceList,"Registered via post from Cisco.",3);
//Make log entry for Cisco Products Tested
  AddLog($newProductPriceList,"CISCO PRODUCTS TO BE TESTED WITH: ".$_POST["Product_Cisco_Coexist"],3);
//Make log entry for Cisco Solution Category
  AddLog($newProductPriceList,"CISCO SOLUTION CATEGORY: ".$_POST["Category_Desc"],3);

  if ($outputMessage == "") {
    $outputMessage = "Product successfully registered for testing at KeyLabs.<br><br><a href=\"http://wwwin.cisco.com/cgi-bin/it/marketing/avvid/index.cgi\">Return to PRM Home</a>";
  }
 
  include("postForm2.php");
?>
