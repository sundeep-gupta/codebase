<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	if (!isset($_GET["pid"]))
	    header("location: programMaint.php");
	    
	if (isset($_POST["companyName"]) && $_POST["companyName"] != "") {
	    $SQL = "INSERT INTO sponsorCompany SET CompanyName='".$_POST["companyName"]."'";
		DoSQL($SQL, SQL_UPDATE, 1, false);
		header("location: editProg.php?pid=".$_GET["pid"]);
	}
	
	$titleString = "Add Sponsor Company Page";
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
  <link rel="stylesheet" href="graphics/ie6.css" type="text/css">
  <![endif]-->
  <!-- this needs to be the last css loaded -->
  <script language="JavaScript" type="text/JavaScript">
<!--
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
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
        <? include("adminMenu.php"); ?>
      </div>
	<div id=right>
		<!-- content should be in <p> tags to prevent the ie 3 pixel bug described on http://www.positioniseverything.net/explorer/threepxtest.html -->
		<br>
		<table width="100%"  border="0" cellspacing="10" cellpadding="5">
			<tr>
				<td width="50%" valign="top">
					<form action="?pid=<?=$_GET["pid"]?>" method="post" name="form1">
						<div align="center">
							<div class="greyboxheader" align=left>
								<b>Add a Sponsor Company</b>
							</div>
						</div>

						<div align="center">
							<div class="greybox">
								<div align="left">
								  <div class="whitebox">
								    Use this page to create a new company to be used as a sponsor company.  Please be sure the company you are wanting does not really exist.
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
									<td width="68%"><input name="companyName" type="text" size="35" <? if (isset($_SESSION["registration"]["companyName"])) { echo "value=\"".$_SESSION["registration"]["companyName"]."\"";} else {if ($cf) {echo "value=\"".$company[0]["name"]."\""; ?>" <?= " READONLY";}} ?>></td>
								  </tr>
								  <tr>
								    <td>&nbsp; </td>
								    <td>&nbsp;</td>
								    <td></td>
							      </tr>
								</table>
								</p>
							</div>
						</div>

						<div align=center>
					        <div class="greyboxfooter" align=left>
								<table width="100%"  border="0" cellspacing="0" cellpadding="0">
								  <tr>
									<td><div align="left"><input type="button" name="cancel" value="Cancel" onclick="window.location.href='editProg.php?pid=<?=$_GET["pid"]?>'">
									</div></td>
									<td><div align="right"><input type="submit" name="yes" value="Add -&gt;"></div></td>
								  </tr>
								</table>
							</div>
				        </div>
					</form>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
