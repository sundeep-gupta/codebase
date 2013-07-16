<?
	$NOTPROTECTEDPAGE = 1;

	include_once("session.php");
	include_once("cert_functions.php");

	//do the post code
	if ($_POST["poster"] == 2) {
		$_SESSION["registration"]["companyName"]=$_POST["companyName"];
		$_SESSION["registration"]["address1"]=$_POST["address1"];
		$_SESSION["registration"]["address2"]=$_POST["address2"];
		$_SESSION["registration"]["city"]=$_POST["city"];
		$_SESSION["registration"]["state"]=$_POST["state"];
		$_SESSION["registration"]["zip"]=$_POST["zip"];
		$_SESSION["registration"]["country"]=$_POST["country"];

		header("location: done.php");
		exit;
	} // end form post code

	if (isset($_GET["selfEntry"])) {
	    unset($_SESSION["registration"]["companyName"]);
	    unset($_SESSION["registration"]["address1"]);
	    unset($_SESSION["registration"]["address2"]);
	    unset($_SESSION["registration"]["city"]);
	    unset($_SESSION["registration"]["state"]);
	    unset($_SESSION["registration"]["zip"]);
	    unset($_SESSION["registration"]["country"]);
	    unset($_SESSION["registration"]["companyID"]);
	} else if (!isset($_SESSION["registration"]["companyName"])){
		$domain=substr($_SESSION["registration"]["email"],strpos($_SESSION["registration"]["email"],"@")+1);
		$SQL = "SELECT DISTINCT user.email, company.* FROM user, company WHERE email LIKE '%$domain%' and user.company_id=company.id LIMIT 1";
		$company = DoSQL($SQL);

		if (count($company)==1){
		    $_SESSION["registration"]["companyName"] = $company[0]["name"];
		    $_SESSION["registration"]["address1"] = $company[0]["address1"];
		    $_SESSION["registration"]["address2"] = $company[0]["address2"];
		    $_SESSION["registration"]["city"] = $company[0]["city"];
		    $_SESSION["registration"]["state"] = $company[0]["state"];
		    $_SESSION["registration"]["zip"] = $company[0]["zip"];
		    $_SESSION["registration"]["country"] = $company[0]["country"];
			$_SESSION["registration"]["companyID"]=$company[0]["id"];
			$cf=1;
		}
	}

	$titleString = "KeyLabs: Registration";
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
  <link rel="stylesheet" href="graphics/ie6.css" type="text/css">
  <![endif]-->
  <!-- this needs to be the last css loaded -->
  
  <script type="text/javascript">
  function hitback() {
		var form=document.getElementById('form1');
		form.action = 'reguser.php';
		form.submit();
  }
  
  function verifyForm() {
    var company=document.getElementById('company');
	var addr1=document.getElementById('addr1');
	var city=document.getElementById('city');
	var state=document.getElementById('state');
	var zip=document.getElementById('zip');
	var country=document.getElementById('country');

	if (company.value=='') {
	    alert('The company name must not be empty');
		return false;
	}
	if (addr1.value=='') {
	    alert('The Address 1 field must not be empty');
		return false;
	}
	if (city.value=='') {
	    alert('The city must not be empty');
		return false;
	}
	if (state.value=='') {
	    alert('The state must not be empty');
		return false;
	}
	if (zip.value=='') {
	    alert('The zip must not be empty');
		return false;
	}
	if (country.value=='') {
	    alert('The country must not be empty');
		return false;
	}
	
	return true;
  }
  </script>
</head>
<body>
  <div id=top>
    <div id=header>
      <? include("header.php"); ?>
    </div>
  </div>
  <div id=middlelogin>
		<!-- content should be in <p> tags to prevent the ie 3 pixel bug described on http://www.positioniseverything.net/explorer/threepxtest.html -->
        <p>&nbsp;</p>
		<form action="" method="post" id="form1" name="form1" onsubmit="return verifyForm()">
		<div align="center">
			<div class="greyboxheader" align=left>
				<b>Step 2: <? if (isset($_SESSION["registration"]["companyID"])) { echo "Is this your company?";} else { echo "Company Information";} ?></b>
			</div>		
		</div>
		
		<div align="center">
			<div class="greybox">
				<div align="left">
				  <div class="whitebox">
				  	<?
					  	if (isset($_SESSION["registration"]["companyName"]) && !isset($_SESSION["registration"]["companyID"])) {
						  	echo "This is information you provided us previously.";
						} else if (isset($_SESSION["registration"]["companyID"])) {
						  	echo "This company was selected from our database as a possible match for you based on your e-mail address.<br><br>
			    				 If this is your company but you have a different billing address or this is NOT your company, please click 'No' to enter your information now.";
						} else {
								echo "Please enter your company information now.";
						}
					?>
				  </div>
				</div>
				<p>
				<table width="100%"  border="0" cellspacing="2" cellpadding="0">
				  <tr>
				    <td>&nbsp; </td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
			      </tr>
				  <tr>
					<td width="30%"><div align="right"><strong>Company Name: </strong></div></td>
					<td width="2%">&nbsp;</td>
					<td width="68%"><input name="companyName" id=company type="text" size="35" value="<?=stripslashes($_SESSION["registration"]["companyName"])?>"<?=(isset($_SESSION["registration"]["companyID"]))? " READONLY" :""?>></td>
				  </tr>
				  <tr>
					<td><div align="right"></div></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>Address 1: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="address1" id=addr1 type="text" size="35" value="<?=stripslashes($_SESSION["registration"]["address1"])?>"<?=(isset($_SESSION["registration"]["companyID"]))? " READONLY" :""?>></td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>Address 2: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="address2" type="text" size="35" value="<?=stripslashes($_SESSION["registration"]["address2"])?>"<?=(isset($_SESSION["registration"]["companyID"]))? " READONLY" :""?>></td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>City: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="city" id=city type="text" size="30" value="<?=stripslashes($_SESSION["registration"]["city"])?>"<?=(isset($_SESSION["registration"]["companyID"]))? " READONLY" :""?>></td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>State: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="state" id=state type="text" size="30" value="<?=stripslashes($_SESSION["registration"]["state"])?>"<?=(isset($_SESSION["registration"]["companyID"]))? " READONLY" :""?>></td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>Zip: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="zip" id=zip type="text" size="20" value="<?=stripslashes($_SESSION["registration"]["zip"])?>"<?=(isset($_SESSION["registration"]["companyID"]))? " READONLY" :""?>></td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>Country: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="country" id=country type="text" size="20" value="<?=stripslashes($_SESSION["registration"]["country"])?>"<?=(isset($_SESSION["registration"]["companyID"]))? " READONLY" :""?>></td>
				  </tr>
				  <tr>
				    <td>&nbsp; </td>
				    <td>&nbsp;</td>
				    <td><input name="poster" type="hidden" id="poster" value="2"></td>
			      </tr>
				</table>				
				</p>
			</div>		
		</div>
		
		<div align=center>
        <div class="greyboxfooter" align=left>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td><div align="left"><input type=button name=back value=Back onclick="hitback()"></div></td>
				<td><div align="center"><input type="button" name="no" value="<?=(isset($_SESSION["registration"]["companyID"]))? "No, let me enter my company information." : "Clear Form"?>" onclick="window.location.href='?selfEntry=1'">
				</div></td>
				<td><div align="right"><input type="submit" name="yes" value="<?=(isset($_SESSION["registration"]["companyID"]))? "Yes" : "Next -&gt;"?>"></div></td>
			  </tr>
			</table>
		</div>
        </div>		
		</form>
	</div>
<p>&nbsp;</p>
<p>&nbsp;</p>

</body>
</html>
