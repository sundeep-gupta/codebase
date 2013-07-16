<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	if (isset($_POST["number"]) && $_POST["number"] != "" && $_POST["prefix"] != "") {
        $SQL = "INSERT INTO prefix SET prefix='".strtoupper($_POST["prefix"])."', number='".$_POST["number"]."'";
		DoSQL($SQL, SQL_UPDATE, 1, false);
		header("location: prefixMaint.php");
	}

	$titleString = "Add a Prefix Page";
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
					<form action="?plid=<?=$_GET["plid"]?>" method="post" name="form1">
						<div align="center">
							<div align=left class="greyboxheader"><strong>Add a Prefix</strong></div>
						</div>

						<div align="center">
							<div class="greybox">
								<div align="left">
									<div class="whitebox">"Add a New Prefix: Allows you to add a new Prefix to the system.</div>
								</div>
								<p>
								<table width="100%"  border="0" cellspacing="2" cellpadding="0">
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="20%"><div align="right"><strong>Prefix:</strong></div></td>
										<td width="80%"><input type="text" maxlength=5 name="prefix" value=""></td>
									</tr>
									<tr>
										<td><div align="right"><strong>Start Number:</strong></div></td>
										<td><input name="number" type="text" value="100"></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
								</table>
								</p>
							</div>
						</div>

						<div align=center>
							<div class="greyboxfooter" align=left>
								<table width="100%"  border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
											<div align="left">
												<input name="Cancel" type="button" onClick="MM_goToURL('parent','prefixMaint.php');return document.MM_returnValue" value="Cancel">
											</div>
										</td>
										<td>
											<div align="right">
												<input type="submit" name="Submit" value="Add Prefix -&gt;">
											</div>
										</td>
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
