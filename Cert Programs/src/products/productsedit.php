<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	if (!isset($_GET["cid"]))
	    header("location: productslist.php");
	    
	if (isset($_POST["comment"])) {
	    if (isset($_POST["pid"])) {
	        $SQL = "UPDATE product SET ";
	        $where = " WHERE id='".$_POST["pid"]."' AND company_id='".$_GET["cid"]."'";
	        $add = 0;
	    } else {
	        $add = 1;
	        $SQL = "INSERT INTO product SET ";
	        $where = ", active=1, createDate=NOW(), company_id='".$_GET["cid"]."'"; //misuse of this var, but i needed to set this somehow
	    }
	    
	    $SQL .= "name='".$_POST["name"]."',
	            version='".$_POST["version"]."',
	            comment='".$_POST["comment"]."'$where";
		$result = DoSQL($SQL, SQL_UPDATE);
		if ($add == 1) {
      header("location: certinfo.php?pid=".$result."&cid=".$_GET["cid"]);
    }
    if ($add == 0) {
  		header("location: productslist.php");
    }
	}
	
	if (isset($_GET["pid"])) {
		$fun = "Save Changes";
		$product = GetProduct($_GET["pid"]);
	} else {
	    $fun = "Add Product";
	    $product = array();
	    $product[] = array();
	}
	$titleString = "Product Page";
	$activetab = "products";

	
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
		<div style="height:100%">
		<table width="100%"  border="0" cellspacing="10" cellpadding="5">
			<tr>
				<td width="50%" valign="top">
					<form action="?cid=<?=$_GET["cid"]?>" method="post" name="form1">
					    <? if (isset($_GET["pid"])) { ?>
					    <input type=hidden name=pid value=<?=$_GET["pid"]?>
					    <? } ?>
						<div align="center">
							<div align=left class="greyboxheader"><strong><?=$fun?> a Product </strong></div>
						</div>

						<div align="center">
							<div class="greybox">
								<div align="left">
									<div class="whitebox"><?=($fun == "Add") ? "Add a New Product: Allows you to add a new product to the system." : "Edit a product: Allows you to edit a product's information."?> You can then schedule testing for the product.</div>
								</div>
								<p>
								<table width="100%"  border="0" cellspacing="2" cellpadding="0">
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="20%"><div align="right"><strong>Name:</strong></div></td>
										<td width="80%"><div align="left">
										  <input type="text" name="name" value="<?=$product[0]["name"]?>">
										  </div></td>
									</tr>
									<tr>
										<td><div align="right"><strong>Version:</strong></div></td>
										<td><div align="left">
										  <input name="version" type="text" size="10" value="<?=$product[0]["version"]?>">
										  </div></td>
									</tr>
									<tr>
										<td valign="top"><div align="right"><strong>Comments:</strong></div></td>
										<td valign="top"><div align="left">
										  <textarea name="comment" cols="40" rows="3"><?=$product[0]["comment"]?></textarea>
										  </div></td>
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
												<input name="Cancel" type="button" onClick="MM_goToURL('parent','productslist.php');return document.MM_returnValue" value="Cancel">
											</div>
										</td>
										<td>
											<div align="right">
												<input type="submit" name="Submit" value="<?=$fun?>">
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
		<div style="height:100%">
	</div>
</body>
</html>
