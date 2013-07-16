<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	//pid is the prefix id
	//plaid is the platform id
	//plid is the price list id
	if (!isset($_GET["pid"]))
	    header("location: index.php");
	    
	if (!isset($_GET["plid"])) {
	    header("location: prodMaint.php?pid=".$_GET["pid"]);
	}
	    
	if (isset($_POST["name"])) {
	    if (isset($_POST["plaid"])) {
	        $SQL = "UPDATE platform SET ";
	        $where = " WHERE id='".$_POST["plaid"]."' AND priceList_id='".$_GET["plid"]."'";
	    } else {
	        $SQL = "INSERT INTO platform SET ";
	        $where = ", active=1, priceList_id='".$_GET["plid"]."'"; //misuse of this var, but i needed to set this somehow
	    }
	    
	    $SQL .= "name='".$_POST["name"]."',
	            version='".$_POST["version"]."'$where";
		DoSQL($SQL, SQL_UPDATE);
		header("location: prodMaint.php?pid=".$_GET["pid"]);
	}
	
	if (isset($_GET["plaid"])) {
		$fun = "Edit";
		$platform = GetPlatform($_GET["plaid"]);
	} else {
	    $fun = "Add";
	    $platform = array();
	    $platform[] = array();
	}
	$titleString = "Platform Page";
	$activetab = "products";

	
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
        <? include("productmenu.php"); ?>
      </div>
	<div id=right>
		<!-- content should be in <p> tags to prevent the ie 3 pixel bug described on http://www.positioniseverything.net/explorer/threepxtest.html -->
		<? // i think for the index page i'll show every cert that the current user has access to ?>
		<br>
		<table width="100%"  border="0" cellspacing="10" cellpadding="5">
			<tr>
				<td width="50%" valign="top">
					<form action="?pid=<?=$_GET["pid"]?>&plid=<?=$_GET["plid"]?>" method="post" name="form1">
					    <? if (isset($_GET["plaid"])) { ?>
					    <input type=hidden name=plaid value=<?=$_GET["plaid"]?>
					    <? } ?>
						<div align="center">
							<div align=left class="greyboxheader"><strong><?=$fun?> a Platform </strong></div>
						</div>

						<div align="center">
							<div class="greybox">
								<div align="left">
									<div class="whitebox"><?=($fun == "Add") ? "Add a New Platform: Allows you to add a new platform to the system." : "Edit a platform: Allows you to edit a platform's information."?> You can then schedual testing for the porduct.</div>
								</div>
								<p>
								<table width="100%"  border="0" cellspacing="2" cellpadding="0">
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="20%"><div align="right"><strong>Name:</strong></div></td>
										<td width="80%"><input type="text" name="name" value="<?=$platform[0]["name"]?>"></td>
									</tr>
									<tr>
										<td><div align="right"><strong>Version:</strong></div></td>
										<td><input name="version" type="text" size="10" value="<?=$platform[0]["version"]?>"></td>
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
												<input name="Cancel" type="button" onClick="MM_goToURL('parent','prodMaint.php?pid=<?=$_GET["pid"]?>');return document.MM_returnValue" value="Cancel">
											</div>
										</td>
										<td>
											<div align="right">
												<input type="submit" name="Submit" value="<?=$fun?> Platform -&gt;">
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
