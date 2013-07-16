<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	if (isset($_GET["edit"])) {
	    $sql = "SELECT * FROM resource WHERE id =" .$_GET["pid"];
		$company = DoSQL($sql);
	}
	

	if ($_POST["function"] == 1) { // Add
	   // $sql = "INSERT INTO user(company_id,name,initials,email,phone,pass,active) VALUES(" .$_POST["company"] .",'" .$_POST["name"] ."','" .$_POST["initials"] ."','" .$_POST["email"] ."','" .$_POST["phone"] ."','" .$_POST["password"] ."',1)";
		$sql = "INSERT INTO company SET name = '" .$_POST["name"] ."', address1 = '" .$_POST["addr1"] .
				"', address2 = '" .$_POST["addr2"] ."', city = '" .$_POST["city"] ."', state = '" .
				$_POST["state"] ."', zip = '" .$_POST["zip"] ."', country='".
				$_POST["country"]."', active = 1";
		$add = DoSQL($sql, SQL_UPDATE, 1, false);
		
		header("location: companyList.php?st=" .$_GET["st"] ."&ed=" .$_GET["ed"]);
		exit;
	}		
	
	if ($_POST["function"] == 2) { // Add
	   // $sql = "INSERT INTO user(company_id,name,initials,email,phone,pass,active) VALUES(" .$_POST["company"] .",'" .$_POST["name"] ."','" .$_POST["initials"] ."','" .$_POST["email"] ."','" .$_POST["phone"] ."','" .$_POST["password"] ."',1)";
		$sql = "UPDATE company SET name = '" .$_POST["name"] ."', address1 = '" .$_POST["addr1"] .
				"', address2 = '" .$_POST["addr2"] ."', city = '" .$_POST["city"] ."', state = '" .
				$_POST["state"] ."', zip = '" .$_POST["zip"] ."', country='".
				$_POST["country"]."', active = 1 WHERE  id = " .$_POST["pid"];
		$add = DoSQL($sql, SQL_UPDATE, 1, false);
		
		header("location: companyList.php?st=" .$_GET["st"] ."&ed=" .$_GET["ed"]);
		exit;
	}		

	$titleString = "New Company";
	$activetab = "admin";
	
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>KeyLabs Certification System</title>
 
  <link rel="stylesheet" href="../graphics/main.css" type="text/css">
  <link rel="stylesheet" href="../graphics/menuExpandable3.css" type="text/css">
  <script src="../graphics/menuExpandable3.js"></script>
  <script type="text/javascript">
  cookieName = 'adminopenMenus';
  </script>
  <!-- this needs to be the last css loaded -->
  <!--[if IE 6]>
  <link rel="stylesheet" href="/graphics/ie6.css" type="text/css">
  <![endif]-->
  <!-- this needs to be the last css loaded -->
  <script language="JavaScript" type="text/JavaScript">
<!--
function MM_goToURL() { //v3.0
	  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
	  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
	}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_validateForm() { //v4.0
  var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
  for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
    if (val) { nm=val.name; if ((val=val.value)!="") {
      if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
      } else if (test!='R') { num = parseFloat(val);
        if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
          min=test.substring(8,p); max=test.substring(p+1);
          if (num<min || max<num) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
    } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; }
  } if (errors) alert('The following error(s) occurred:\n'+errors);
  document.MM_returnValue = (errors == '');
}
//-->
</script>
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
        <? include("../inc/adminMenu.php"); ?>
      </div>
      <div id=right>
		<!-- content should be in <p> tags to prevent the ie 3 pixel bug described on http://www.positioniseverything.net/explorer/threepxtest.html -->
		<? // i think for the index page i'll show every cert that the current user has access to ?>
        <br>
		<div align="center">
<form action="" method="post" name="form1">
				<div class="greyboxheader" align=left>
					<b><?php if (isset($_GET["edit"])) { echo "Edit "; } else { echo "Add "; }  ?> Company</b>
				</div>		
			<div class="greybox">
		      <table width="100%"  border="0" cellspacing="0" cellpadding="4">
                <tr>
                  <td width="20%"><div align="right"><strong>Company:</strong></div></td>
                  <td width="80%"><input name="name" type="text" id="name" value="<?php if (isset($_GET["edit"])) { echo $company[0]["name"]; } ?>" size="35"></td>				  
                  </tr>
                <tr>
                  <td><div align="right"><strong>Address 1:</strong></div></td>
                  <td><input name="addr1" type="text" id="addr1" value="<?php if (isset($_GET["edit"])) { echo $company[0]["address1"]; } ?>" size="35"></td>
                </tr>
                <tr>
                  <td><div align="right"><strong>Address 2:</strong></div></td>
                  <td><input name="addr2" type="text" id="addr2" value="<?php if (isset($_GET["edit"])) { echo $company[0]["address2"]; } ?>" size="35"></td>
                </tr>
                <tr>
                  <td><div align="right"><strong>City:</strong></div></td>
                  <td><input name="city" type="text" id="city" value="<?php if (isset($_GET["edit"])) { echo $company[0]["city"]; } ?>" size="35"></td>
                </tr>
                <tr>
                  <td><div align="right"><strong>State:</strong></div></td>
                  <td><input name="state" type="text" id="state" value="<?php if (isset($_GET["edit"])) { echo $company[0]["state"]; } ?>" size="35"></td>
                </tr>
                <tr>
                  <td><div align="right"><strong>Zip:</strong></div></td>
                  <td><input name="zip" type="text" id="zip" value="<?php if (isset($_GET["edit"])) { echo $company[0]["zip"]; } ?>" size="15"></td>
                </tr>
                <tr>
                  <td><div align="right"><strong>Country:</strong></div></td>
                  <td><input name="country" type="text" id="country" value="<?php if (isset($_GET["edit"])) { echo $company[0]["country"]; } ?>" size="15"></td>
                </tr>
              </table>
			</div>
		<div class="greyboxfooter">
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td width="25%"><input name="Button" type="button" onClick="MM_goToURL('parent','companyList.php?st=<?=$_GET["st"]?>&ed=<?=$_GET["ed"]?>');return document.MM_returnValue" value="Cancel"></td>
                  <td width="15%"><div align="right">
                    <input name="pid" type="hidden" id="pid" value="<?php if($_GET["pid"] != "") { echo $_GET["pid"]; } ?>">
                    <input name="function" type="hidden" id="function" value="<?php if($_GET["f"] == "add") { echo "1"; }  else { echo "2"; }?>">
                    <input name="Submit" type="submit" onClick="MM_validateForm('name','','R');return document.MM_returnValue" value="<?php if (isset($_GET["edit"])) { echo "Save Changes"; } else { echo "Add Company"; } ?>">
                  </div></td>
                </tr>
              </table>
        </div>
		
       </div>
	   </form>
	  </div>
    </div>
  </div>
</body>
</html>
