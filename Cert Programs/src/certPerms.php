<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	if (isset($_GET["ppl"])) {
	  $sql = "SELECT * FROM user WHERE id =" .$_GET["pid"];
		$user = DoSQL($sql);
		$tempTitle = "Edit ";		
	}

	if ($_POST["function"] == 1) { // Add
		$sql = "INSERT INTO user SET company_id = " .$_POST["company"] .", name = '" .$_POST["name"] ."', initials = '" .$_POST["initials"] ."', email = '" .$_POST["email"] ."', phone = '" .$_POST["phone"] ."', pass = '" .$_POST["password"] ."', active = 1";
		$add = DoSQL($sql, SQL_UPDATE, 1, false);
		foreach($_POST["checkbox"] as $key => $value) {
	        $SQL = "INSERT INTO userPermission set user_id='$add',permission_id='$key'";
	        $update = DoSQL($SQL,SQL_UPDATE, 1, false);
	    }
				
		$tempTitle = "Add ";
		header("location: userList.php?st=" .$_GET["st"] ."&ed=" .$_GET["ed"]);
		exit;
	}		
	
	if ($_POST["function"] == 2) { // Update
		$sql = "UPDATE user SET company_id = " .$_POST["company"] .", name = '" .$_POST["name"] ."', initials = '" .$_POST["initials"] ."', email = '" .$_POST["email"] ."', phone = '" .$_POST["phone"] ."', pass = '" .$_POST["password"] ."', active = 1 WHERE id = " .$_POST["pid"];
		$update = DoSQL($sql, SQL_UPDATE, 1, false);
		$SQL = "DELETE from userPermission where user_id=".$_POST[pid];
		$update2 = DoSQL($SQL, SQL_UPDATE, 1, false);
		if (isset($_POST["checkbox"])) {
	    foreach($_POST["checkbox"] as $key => $value) {
	        $SQL = "INSERT INTO userPermission set user_id='$_POST[pid]',permission_id='$key'";
	        $update = DoSQL($SQL,SQL_UPDATE, 1, false);
	    }
	  }
		header("location: userList.php?st=" .$_GET["st"] ."&ed=" .$_GET["ed"]);
		exit;
	}		

	if (isset($_GET[pid])) {
		$and = "and userPermission.user_id=".$_GET[pid];
	} else {
		$and = "";
	}
	if ($_GET["f"]=="add") {
    $SQL = "select * from permission";
  } else {
	 $SQL = "select * from permission left join userPermission on (userPermission.permission_id=permission.id $and) order by permission.description";
  }
	$userPermissions = DoSQL($SQL,SQL_SELECT);
	$userPermissionsCnt = count($userPermissions);
	
function GenerateCompanyMenu($name,$set) {
	$sql = "SELECT id,name FROM company ORDER BY name";
	$user = DoSQL($sql);

	echo '<select name="' .$name .'">';
	foreach ($user as $value) {
		echo '<option value="' .$value["id"] .'"'; if ($set == $value["id"]) { echo ' selected'; } echo '>' .$value["name"] .'</option>';
	}
	echo '</select>';
}  // GenerateCompanyMenu($name)

if ($tempTitle == "") { $tempTitle = "Add "; }
	
	$titleString = "$tempTitle User";
	$activetab = "admin";
	
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>KeyLabs Certification System</title>
 
  <link rel="stylesheet" href="../graphics/main.css" type="text/css">
  <link rel="stylesheet" href="../graphics/menuExpandable3.css" type="text/css">
  <script type="text/javascript">
  cookieName = 'adminopenMenus';
  </script>
  <script src="../graphics/menuExpandable3.js"></script>
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
					<b><?php if (isset($_GET["edit"])) { echo "Edit "; } else { echo "Add "; }  ?>  User </b>
				</div>		
			<div class="greybox">
		      <table width="100%"  border="0" cellspacing="0" cellpadding="4">
                <tr>
                  <td><div align="right"><strong>Company:</strong></div></td>
                  <td><?php if (isset($_GET["edit"])) { $set = $user[0]["company_id"]; } ?><?php GenerateCompanyMenu("company",$set); ?></td>
                </tr>
                <tr>
                  <td><div align="right"></div></td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td width="20%"><div align="right"><strong>Login/Email:</strong></div></td>
                  <td width="80%"><input name="email" type="text" id="email" value="<?php if (isset($_GET["edit"])) { echo $user[0]["email"]; } ?>" size="35"></td>				  
                  </tr>
                <tr>
                  <td><div align="right"><strong>Password:</strong></div></td>
                  <td><input name="password" type="text" id="password" value="<?php if (isset($_GET["edit"])) { echo $user[0]["pass"]; } ?>"></td>
                </tr>
                <tr>
                  <td><div align="right"></div></td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td><div align="right"><strong>Name:</strong></div></td>
                  <td><input name="name" type="text" id="name" value="<?php if (isset($_GET["edit"])) { echo $user[0]["name"]; } ?>" size="35"></td>
                </tr>
                <tr>
                  <td><div align="right"><strong>Initials:</strong></div></td>
                  <td><input name="initials" type="text" id="initials" value="<?php if (isset($_GET["edit"])) { echo $user[0]["initials"]; } ?>" size="15"></td>
                </tr>
                <tr>
                  <td><div align="right"><strong>Phone:</strong></div></td>
                  <td><input name="phone" type="text" id="phone" value="<?php if (isset($_GET["edit"])) { echo $user[0]["phone"]; } ?>"></td>
                </tr>
				<tr>
					<td colspan=2>&nbsp;</td>
				</tr>
                <tr>
                  <td valign="top"><div align="right"><strong>Permissions:</strong></div></td>
                  <td>
                  	<table cellspacing=0 cellpadding=0 border=0 width=100%>
<?
	for ($i=0;$i<$userPermissionsCnt; $i=$i+2) {
?>
                  		<tr>
                  			<td>
	                  			<input type=checkbox name=checkbox[<?=$userPermissions[$i][id]?>] 
	                  			<? if ($userPermissions[$i][permission_id]==$userPermissions[$i][id] and $_POST["function"]!='1') { echo " CHECKED"; }?>>
	                  			<?=$userPermissions[$i]["description"]?>
                  			</td>
                  			<td>
                  				<? if ($i+1<$userPermissionsCnt) { ?>
                  				<input type=checkbox name=checkbox[<?=$userPermissions[$i+1][id]?>] 
                  				<?	if ($userPermissions[$i+1][permission_id]==$userPermissions[$i+1][id] and $_POST["function"]!='1') { echo " CHECKED"; }?>>
                  				<? echo $userPermissions[$i+1]["description"]; } ?>
              				</td>
              			</tr>
<? } ?>
          			</table>
                  </td>
                </tr>
              </table>
			</div>

		<div class="greyboxfooter">
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td width="25%"><input name="Button" type="button" onClick="MM_goToURL('parent','userList.php?st=<?=$_GET["st"]?>&ed=<?=$_GET["ed"]?>');return document.MM_returnValue" value="Cancel"></td>
                  <td width="15%"><div align="right">
                    <input name="pid" type="hidden" id="pid" value="<?php if($_GET["pid"] != "") { echo $_GET["pid"]; } ?>">
                    <input name="function" type="hidden" id="function" value="<?php if($_GET["f"] == "add") { echo "1"; }  else { echo "2"; }?>">
                    <input name="Submit" type="submit" onClick="MM_validateForm('email','','R','password','','R');return document.MM_returnValue" value="<?php if (isset($_GET["edit"])) { echo "Save Changes"; } else { echo "Add User"; } ?>">
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
