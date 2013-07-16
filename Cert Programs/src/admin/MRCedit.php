<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	if (isset($_POST["Save"])) { // Update
	   // $sql = "INSERT INTO user(company_id,name,initials,email,phone,pass,active) VALUES(" .$_POST["company"] .",'" .$_POST["name"] ."','" .$_POST["initials"] ."','" .$_POST["email"] ."','" .$_POST["phone"] ."','" .$_POST["password"] ."',1)";
		$sql = "UPDATE bucket SET hourlyRate = '" .$_POST["hourlyRate"] ."', description = '" .$_POST["description"] ."', comment = '" .$_POST["comment"] ."' WHERE  id = " .$_POST["m"];
		$update = DoSQL($sql, SQL_UPDATE, 1, false);
		
		header("location: MRCmaint.php?m=".$_POST["m"]."&c=".$_POST["c"]."&st=".$_POST["st"]."&ed=".$_POST["ed"]);
		exit;
	}		

	if (isset($_GET["m"])) {
	  $sql = "SELECT bucket.*,company.name FROM bucket,company WHERE bucket.id ='".$_GET["m"]."'";
		$bucket = DoSQL($sql);
		$c = $_GET["c"];
		$m = $_GET["m"];
		$st = $_GET["st"];
		$ed = $_GET["ed"];
	} else {
    header("location: MRCmaint.php");
  }

	$titleString = "Account Maintenance";
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

				<div class="greyboxheader" align=left>
					<b><?=$titleString?></b>
				</div>		
			
			<form action="" method="post" name="form1">
			<div class="greybox">
			     <form name="MRCform" action="" method="POST">
			     <input type=hidden name="m" value="<?=$m?>">
			     <input type=hidden name="c" value="<?=$c?>">
			     <input type=hidden name="st" value="<?=$st?>">
			     <input type=hidden name="ed" value="<?=$ed?>">
		      <table width="100%"  border="0" cellspacing="0" cellpadding="4">
                <tr>
                  <td><div align="right"></div></td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td width="20%"><div align="right"><strong>Company:</strong></div></td>
                  <td width="80%"><?=$bucket[0]["name"]; ?></td>				  
                  </tr>
                <tr>
                  <td><div align="right"><strong>Balance:</strong></div></td>
                  <td>$<?=$bucket[0]["balance"]?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* to change balance make an entry</td>
                </tr>
                <tr>
                  <td><div align="right"><strong>Hourly Rate ($):</strong></div></td>
                  <td><input name="hourlyRate" type="text" id="hourlyRate" value="<?=$bucket[0]["hourlyRate"]; ?>" size="35"></td>
                </tr>
                <tr>
                  <td><div align="right"><strong>Description:</strong></div></td>
                  <td><input name="description" type="text" id="description" value="<?=$bucket[0]["description"]; ?>" size="75"></td>
                </tr>
                <tr>
                  <td><div align="right"><strong>Comment:</strong></div></td>
                  <td><input name="comment" type="text" id="comment" value="<?=$bucket[0]["comment"] ?>" size="75"></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              </table>
			</div>

		<div class="greyboxfooter">
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td width="25%"><input name="button" type="button" onClick="MM_goToURL('parent','MRCmaint.php')" value="Cancel"></td>
                  <td width="15%"><div align="right">
                    <input name="Save" type="submit" value="Save Changes">
                  </div></td>
                </tr>
              </table>
              </form>
        </div>
		
       </div>
	   </form>
	  </div>
    </div>
  </div>
</body>
</html>
