<?
	//this page isn't wanted.  i don't know why it is here.  this will skip it though.
	header("location: reguser.php");
	exit;
	
  $NOTPROTECTEDPAGE = 1;

	include_once("session.php");
	include_once("cert_functions.php");

	$titleString = "KeyLabs: Registration";
	
	
	if ($_POST["poster"] == 1) {
		//save out the company info
		$_SESSION["registration"]["companyname"] = $_POST["companyName"];
		$_SESSION["registration"]["companyaddr1"] = $_POST["addr1"];
		$_SESSION["registration"]["companyaddr2"] = $_POST["addr2"];
		$_SESSION["registration"]["companycity"] = $_POST["city"];
		$_SESSION["registration"]["companystate"] = $_POST["state"];
		$_SESSION["registration"]["companyzip"] = $_POST["zip"];

		header("location: reguser.php");
	} // end form post code
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
		<form action="" method="post" name="form1">
		<div align="center">
			<div class="greyboxheader" align=left>
				<b>Step 1: Create a New Company </b>
			</div>		
		</div>
		
		<div align="center">
			<div class="greybox">
				<div align="left">
				  <div class="whitebox">
				  	Step 1: First tell us a little about your company.<br>
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
					<td width="68%"><input name="companyName" type="text" size="35" value="<?=stripslashes($_SESSION["registration"]["companyname"])?>"></td>
				  </tr>
				  <tr>
					<td><div align="right"></div></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>Address 1: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="addr1" type="text" size="35" value="<?=stripslashes($_SESSION["registration"]["companyaddr1"])?>"></td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>Address 2: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="addr2" type="text" size="35" value="<?=stripslashes($_SESSION["registration"]["companyaddr2"])?>"></td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>City: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="city" type="text" size="30" value="<?=stripslashes($_SESSION["registration"]["companycity"])?>"></td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>State: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="state" type="text" size="30" value="<?=stripslashes($_SESSION["registration"]["companystate"])?>"></td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>Zip: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="zip" type="text" size="20" value="<?=stripslashes($_SESSION["registration"]["companyzip"])?>"></td>
				  </tr>
				  <tr>
				    <td>&nbsp; </td>
				    <td>&nbsp;</td>
				    <td><input name="poster" type="hidden" id="poster" value="1"></td>
			      </tr>
				</table>				
				</p>				
			</div>		
		</div>
		
		<div align=center>
        <div class="greyboxfooter" align=left>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td><div align="left"><input type="button" name="Cancel" value="Cancel">
				</div></td>
				<td><div align="right"><input type="submit" name="Submit" value="Step 2 -&gt;"></div></td>
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
