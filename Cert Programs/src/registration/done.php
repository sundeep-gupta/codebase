<?
  $NOTPROTECTEDPAGE = 1;
  
	include_once("session.php");
	include_once("cert_functions.php");

	if ($_POST["poster"]=="1"){
		if (!isset($_SESSION["registration"]["companyID"])) {
			$cid = NewCompany($_SESSION["registration"]["companyName"], $_SESSION["registration"]["address1"], $_SESSION["registration"]["address2"], $_SESSION["registration"]["city"], $_SESSION["registration"]["state"], $_SESSION["registration"]["zip"]);
		} else {
			$cid = $_SESSION["registration"]["companyID"];
		}
		NewUser($cid, $_SESSION["registration"]["fullname"], $_SESSION["registration"]["email"], $_SESSION["registration"]["phone"], '', $_SESSION["registration"]["password"]);
		header("Location: ../index.php");
	}

	$titleString = "KeyLabs: Registration";	
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>Untitled</title>
 
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

		<div align="center">
			<div class="greyboxheader" align=left>
				<b>Registration Confirmation</b>
			</div>		
		</div>
		
		<div align="center">
			<div class="greybox">
				<div align="left">
				  <div class="whitebox">
				    Please confirm the information below.<br><br>If you need to correct the information use the "Back" button below.<b></b>
				  </div>
				</div>
				<p>
        <form action="" method="post" name="form1">
				<table width="100%"  border="0" cellspacing="2" cellpadding="0">
				  <tr>
				    <td>&nbsp; </td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
			      </tr>
				  <tr>
					<td width="30%"><div align="right"><strong>Full Name: </strong></div></td>
					<td width="2%">&nbsp;</td>
					<td width="68%"><input name="fullname" type="text" size="35" value="<?=stripslashes($_SESSION["registration"]["fullname"])?>" READONLY></td>
				  </tr>
				  <tr>
					<td><div align="right"></div></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				  </tr>
				  <tr>
                    <td><div align="right"><strong>Email Address: </strong></div></td>
                    <td>&nbsp;</td>
                    <td><input name="email" type="text" size="30" value="<?=stripslashes($_SESSION["registration"]["email"])?>" READONLY></td>
			      </tr>
				  <tr>
                    <td><div align="right"><strong>Password: </strong></div></td>
                    <td>&nbsp;</td>
                    <td><input name="password" type="password" size="20" value="<?=stripslashes($_SESSION["registration"]["password"])?>" READONLY></td>
			      </tr>
				  <tr>
                    <td><div align="right"><strong>Confirm Password: </strong></div></td>
                    <td>&nbsp;</td>
                    <td><input name="password2" type="password" size="20" value="<?=stripslashes($_SESSION["registration"]["password"])?>" READONLY></td>
			      </tr>
				  <tr>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
			      </tr>
				  <tr>
  					<td><div align="right"><strong>Phone: </strong></div></td>
  					<td>&nbsp;</td>
  					<td><input name="phone" type="text" size="25" value="<?=stripslashes($_SESSION["registration"]["phone"])?>" READONLY></td>
				  </tr>
				  <tr>
				    <td>&nbsp; </td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
			    </tr>
				  <tr>
					<td width="30%"><div align="right"><strong>Company Name: </strong></div></td>
					<td width="2%">&nbsp;</td>
					<td width="68%"><input name="companyName" type="text" size="35" value="<?=stripslashes($_SESSION["registration"]["companyName"])?>" READONLY></td>
				  </tr>
				  <tr>
					<td><div align="right"></div></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>Address 1: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="address1" type="text" size="35"  value="<?=stripslashes($_SESSION["registration"]["address1"])?>" READONLY></td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>Address 2: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="address2" type="text" size="35"  value="<?=stripslashes($_SESSION["registration"]["address2"])?>" READONLY></td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>City: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="city" type="text" size="30"  value="<?=stripslashes($_SESSION["registration"]["city"])?>" READONLY></td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>State: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="state" type="text" size="30"  value="<?=stripslashes($_SESSION["registration"]["state"])?>" READONLY></td>
				  </tr>
				  <tr>
					<td><div align="right"><strong>Zip: </strong></div></td>
					<td>&nbsp;</td>
					<td><input name="zip" type="text" size="20"  value="<?=stripslashes($_SESSION["registration"]["zip"])?>" READONLY></td>
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
				<td><div align="left"></div><input type="button" name="Submit" value="Back" onclick="window.location.href='company.php'"></td>
				<td><div align="right"><input type="submit" name="Submit" value="Submit">
				</div></td>
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
