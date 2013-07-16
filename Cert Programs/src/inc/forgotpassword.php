<?php
  include_once("config.php");
	include_once("cert_functions.php");
	include_once("functions.php");
	
	if (isset($_POST["username"])) {
	  $user = GetUserInfoByEmail($_POST["username"]);
		$headers["Subject"] = "KeyLabs Password Request";
		$headers["From"] = FROM_ADDRESS;
		$body =
"Someone, possibly you, requested that your KeyLabs certification system password be sent to your address.

Username=".$user[0]["email"]."
Password=".$user[0]["pass"]."

Please contact the certification program administrator at KeyLabs if this does not work.

Thank you,

KeyLabs";

		SendMail($user[0]["email"],$headers,$body);
		header("location: ../index.php");
	}

	$titleString = "KeyLabs Certification System";
	$titleCenter = true;
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
				<b>Password Reset Request</b>
			</div>
		</div>
		<div align="center">
			<div class="greybox">
				<div align="left">
				  <div class="whitebox">Enter your username (email address) in the space provided below and your password will be sent to you by email.<br>
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
					<td width="30%"><div align="right"><strong>Username (email address): </strong></div></td>
					<td width="2%">&nbsp;</td>
					<td width="68%"><input name="username" type="text" size="50"></td>
				  </tr>
				  <tr>
					<td><div align="right"></div></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
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
				<td><div align="center"><input type="submit" name="Submit" value="Request Password"></div></td>
			  </tr>
			</table>
        </div>
		</div>
		</form>
<? include_once("footer.php"); ?>
	</div>

<p>&nbsp;</p>
<p>&nbsp;</p>
<script>
		window.document.getElementById('username').focus();
</script>

</body>
</html>
