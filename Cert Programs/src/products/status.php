<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	$titleString = "Testing Initiated";
	$activetab = "products";

  if (!isset($_GET["pplid"]))
		header("location: index.php");
		
  $pplid = $_GET["pplid"];
  
  $fields = GetCert($pplid);

  $SQL = "select program.id
          from program, productPriceList,priceList
          where productPriceList.id='$pplid'
          and productPriceList.priceList_id=priceList.id
          and priceList.program_id=program.id";
  $programID = DoSQL($SQL);

	$headers["Subject"] = "New Cert Product Registered for Testing at KeyLabs";
	$headers["From"] = FROM_ADDRESS;
  $to = $fields[0][subEmail]. ",".$fields[0][techEmail].",certinfo@keylabs.com";
  if ($programID[0][id] == '17') {
    $to .= ",solarisready@sun.com,jamal.arif@sun.com,david.andrew@sun.com";
  }
	$body="The following product was registered for testing at KeyLabs:\r\n\r\n" .
         "KeyLabs Cert ID: " . $fields[0]["certName"] . "\r\n\r\n" .
    		 "Product Name: " . $fields[0]["productName"] . "\r\n" .
    		 "Product Version: " . $fields[0]["productVersion"] . "\r\n\r\n" .
    		 "Company: " . $fields[0]["company"] . "\r\n" . 
    		 "Address1: " . $fields[0]["companyAdd1"] . "\r\n" .
    		 "Address2: " . $fields[0]["companyAdd2"] . "\r\n" .
    		 "City: " . $fields[0]["city"] . "\r\n" .
    		 "State: " . $fields[0]["companyState"] . "\r\n" .
    		 "Zip: " . $fields[0]["companyZip"] . "\r\n" .
    		 "Country: " . $fields[0]["companyCountry"] . "\r\n\r\n" .
         "Submission Contact:\r\n" .
				 $fields[0]["subName"] . "\r\n" . 
				 $fields[0]["subEmail"] . "\r\n" . 
         $fields[0]["subPhone"] . "\r\n\r\n" . 
         "Technical Contact:\r\n" .
         $fields[0]["techName"] . "\r\n" .
				 $fields[0]["techEmail"] . "\r\n" .
				 $fields[0]["techPhone"] . "\r\n\r\n" .
    		 "KeyLabs SKU: " . $fields[0]["SKU"] . "\r\n" .
    		 "KeyLabs SKU Description: " . $fields[0]["description"] . "\r\n" .
    		 "Payment Method: " . $fields[0]["method"] . "\r\n";

  SendMail($to, $headers, $body);	

	//$user = GetUser($_SESSION["id"]);
	//$products = GetCompanyProducts($_SESSION["company_id"]);
	
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>KeyLabs Certification System</title>
 
  <link rel="stylesheet" href="../graphics/main.css" type="text/css">
  <link rel="stylesheet" href="../graphics/menuExpandable3.css" type="text/css">
  <script src="../graphics/menuExpandable3.js"></script>
  <!-- this needs to be the last css loaded -->
  <!--[if IE 6]>
  <link rel="stylesheet" href="/graphics/ie6.css" type="text/css">
  <![endif]-->
  <!-- this needs to be the last css loaded -->
</head>
<body>
  <div id=leftfullheight>&nbsp;</div>
  <div id=top>
    <div id=header>
      <? include("header.php"); ?>
    </div>
  </div>
  <div id=middle style="width:100%">
    <div id=middle2>
      <div id=left>
        <? include("productmenu.php"); ?>
      </div>
      <div id=right>
		<!-- content should be in <p> tags to prevent the ie 3 pixel bug described on http://www.positioniseverything.net/explorer/threepxtest.html -->
		<? // i think for the index page i'll show every cert that the current user has access to ?>
        <br>
		<div style="height:100%">
      <b>The following registration was successfully entered in to the system:</b><br><br>
    	<table width="100%" cellpadding="4" cellspacing="0">
    	  <tr>
            <td class=list colspan=2><b>Basic Information</b></td>
          </tr>
    	  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
            <td class=list width=300px>Cert Name</td>
            <td class=list><?= $fields[0]["certName"] ?></td>
          </tr>
    	  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
            <td class=list>Registration Date/Time</td>
            <td class=list><?= $fields[0]["registeredDate"]; ?></td>
          </tr>
    	  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Company</td>
    				<td class=list><?= $fields[0]["company"]; ?></td>
          </tr>
    			<tr>
    			   <td class=list colspan=2><b>Submission Contact</b></td>
    			</tr>
    	  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Submission Contact Name</td>
					  <td class=list id="Submission Name"><?php echo $fields[0]["subName"]; ?></td>
          </tr>
					<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
						<td class=list>Submission Contact Email</td>
						<td class=list id="Submission Email"><?php echo $fields[0]["subEmail"]; ?></td>
          </tr>
					<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
						<td class=list>Submission Contact Phone</td>
            <td class=list id="Submission Phone"><?php echo $fields[0]["subPhone"]; ?></td>
          </tr>
    			<tr>
    				<td class=list colspan=2><b>Technical Contact</b></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Technical Contact Name</td>
            <td class=list id="Technical Contact Name"><?= $fields[0]["techName"]; ?></td>
          </tr>
					<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
						<td class=list>Technical Contact Email</td>
						<td class=list><?= $fields[0]["techEmail"]; ?></td>
					</tr>
					<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
						<td class=list>Technical Contact Phone</td>
						<td class=list id="Submission Phone"><?= $fields[0]["techPhone"]; ?></td>
          </tr>
    			<tr>
    				<td class=list colspan=2><b>Miscellaneous</b></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>KeyLabs SKU</td>
    				<td class=list><?= $fields[0]["description"]; ?></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Payment Method</td>
    				<td class=list><?= $fields[0]["method"]; ?></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Product Name</td>
    				<td class=list><?= $fields[0]["productName"]; ?></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Product Version</td>
    				<td class=list><?= $fields[0]["productVersion"]; ?></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Timeframe</td>
    				<td class=list><?= $fields[0]["timeframe"]; ?></td>
    			</tr>
    		</table>
		</div>
      </div>
    </div>
  </div>
</div>  
</body>
</html>
