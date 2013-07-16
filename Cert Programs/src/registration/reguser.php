<?
  $NOTPROTECTEDPAGE = 1;
  
	include_once("session.php");
	include_once("cert_functions.php");
	
	$titleString = "KeyLabs: Registration";
	
	if ($_POST["poster"] == 2) {
	    //this came from the company page
		    $_SESSION["registration"]["companyName"] = $_POST["companyName"];
		    $_SESSION["registration"]["address1"] = $_POST["address1"];
		    $_SESSION["registration"]["address2"] = $_POST["address2"];
		    $_SESSION["registration"]["city"] = $_POST["city"];
		    $_SESSION["registration"]["state"] = $_POST["state"];
		    $_SESSION["registration"]["zip"] = $_POST["zip"];
	}
	
	if ($_POST["poster"] == 1) {
	    //this came from the user page
		$_SESSION["registration"]["fullname"]=$_POST["fullname"];
		$_SESSION["registration"]["email"]=$_POST["email"];
		$_SESSION["registration"]["password"]=$_POST["password"];
		$_SESSION["registration"]["phone"]=$_POST["phone"];
		$_SESSION["registration"]["companyFound"]="0";
		header("Location: company.php");
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
  <script language="JavaScript" type="text/JavaScript">
<!--
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}

function verifyForm() {
	var form=document.getElementById('form1');
	var pass1=document.getElementById('pass1');
	var pass2=document.getElementById('pass2');
	var email=document.getElementById('email');
	
	if (pass1.value == '') {
	    alert('The password must not be empty');
	    return false;
	}
	
	if (pass1.value != pass2.value) {
	    alert('The passwords do not match');
	    return false;
	}
	
	if (email.value == '') {
	    alert('The email field must not be empty');
	    return false;
	}
	
	return true;
}
//-->
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
				<b>Step 1: Create a New User </b>
			</div>		
		</div>
		
		<div align="center">
			<div class="greybox">
				<div align="left">
				  <div class="whitebox">
				    Step 1: Let's create a user account for you.<br>
				    <br>
				    Please Note: Your email address will be your username when you login.
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
					<td width="30%"><div align="right"><strong>Full Name: </strong></div></td>
					<td width="2%">&nbsp;</td>
					<td width="68%"><input name="fullname" type="text" size="35" value="<?=stripslashes($_SESSION["registration"]["fullname"])?>"></td>
				  </tr>
				  <tr>
					<td><div align="right"></div></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				  </tr>
				  <tr>
                    <td><div align="right"><strong>Email Address: </strong></div></td>
                    <td>&nbsp;</td>
                    <td><input name="email" id=email type="text" size="30" value="<?=stripslashes($_SESSION["registration"]["email"])?>"></td>
			    </tr>
				  <tr>
                    <td><div align="right"><strong>Password: </strong></div></td>
                    <td>&nbsp;</td>
                    <td><input name="password" id=pass1 type="password" size="20" value="<?=stripslashes($_SESSION["registration"]["password"])?>"></td>
			    </tr>
				  <tr>
                    <td><div align="right"><strong>Confirm Password: </strong></div></td>
                    <td>&nbsp;</td>
                    <td><input name="password2" id=pass2 type="password" size="20" value="<?=stripslashes($_SESSION["registration"]["password"])?>"></td>
			    </tr>
				  <tr>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
			      </tr>
				  <tr>
  					<td><div align="right"><strong>Phone: </strong></div></td>
  					<td>&nbsp;</td>
  					<td><input name="phone" type="text" size="25" value="<?=stripslashes($_SESSION["registration"]["phone"])?>"></td>
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
				<td><div align="left">
				<!-- <input name="Back" type="button" onClick="MM_goToURL('parent','index.php');return document.MM_returnValue" value="&lt;- Back"> -->
				</div></td>
				<td><div align="right"><input type="submit" name="Submit" value="Step 2 -&gt;">
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
