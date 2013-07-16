<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	//plid is the price list id
	if (!isset($_GET["plid"]))
	    header("location: skuMaint.php");

	if (isset($_POST["SKU"]) && $_POST["SKU"] != "" && $_POST["description"] != "" && $_POST["price"] != "") {
	    if ($_GET["plid"]!=0) {
	    	$registerable = (isset($_POST["registerable"])) ? "1" : "0";
	        $SQL = "UPDATE priceList SET program_id='".$_POST["program_id"]."', SKU='".$_POST["SKU"]."', price='".$_POST["price"]."', description='".$_POST["description"]."', registerable='$registerable' WHERE id='".$_GET["plid"]."'";
	    } else {
	        $SQL = "INSERT INTO priceList SET program_id='".$_POST["program_id"]."', SKU='".$_POST["SKU"]."',
					price='".$_POST["price"]."', description='".$_POST["description"]."', prefix_id='".$_POST["prefix_id"]."'";
	    }
	    
		DoSQL($SQL, SQL_UPDATE, 1, false);
		header("location: skuMaint.php");
	}
	
	if ($_GET["plid"] != "0") {
		$fun = "Update";
		$priceList = GetPriceListItem($_GET["plid"]);
	} else {
	    $fun = "Add";
	    $priceList = array();
	}
	$titleString = $fun." SKU Page";
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
							<div align=left class="greyboxheader"><strong><?=$fun?> an SKU</strong></div>
						</div>

						<div align="center">
							<div class="greybox">
								<div align="left">
									<div class="whitebox"><?=($fun == "Add") ? "Add a New SKU: Allows you to add a new SKU to the system." : "Edit a SKU: Allows you to edit a SKU's information."?></div>
								</div>
								<p>
								<table width="100%"  border="0" cellspacing="2" cellpadding="0">
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="20%"><div align="right"><strong>SKU:</strong></div></td>
										<td width="80%"><input type="text" name="SKU" value="<?=$priceList[0]["SKU"]?>"></td>
									</tr>
									<tr>
										<td><div align="right"><strong>Description:</strong></div></td>
										<td><input name="description" type="text" size="70" value="<?=$priceList[0]["description"]?>"></td>
									</tr>
									<tr>
										<td><div align="right"><strong>Price:</strong></div></td>
										<td><input name="price" type="text" size="70" value="<?=$priceList[0]["price"]?>"></td>
									</tr>
									<tr>
										<td><div align="right"><strong>Program:</strong></div></td>
										<td>
											<select name=program_id style="width: 444px">
									    <?
									        $programs = GetPrograms();
									        $programscnt = count($programs);
									        for($x=0;$x<$programscnt;$x++)
									            printf("<option value=%d%s>%s</option>",
														$programs[$x]["id"],
														($programs[$x]["id"]==$priceList[0]["program_id"]) ? " selected" : "",
														$programs[$x]["programName"]);
									    ?>
										    </select>
										</td>
									</tr>
									<tr>
										<td><div align="right"><strong>Prefix:</strong></div></td>
										<td>
											<select name=prefix_id style="width: 444px"<?=($fun=="Update")?" disabled" : ""?>>
											<?
											    $prefixes = GetPrefixes();
											    $prefixescnt = count($prefixes);
											    for($x=0;$x<$prefixescnt;$x++)
											        printf("<option value=%d%s>%s</option>",
											            $prefixes[$x]["id"],
														($prefixes[$x]["id"]==$priceList[0]["prefix_id"]) ? " selected" : "",
														$prefixes[$x]["prefix"]);
											?>
											</select>
										</td>
									</tr>
									<tr>
										<td><div align="right"><strong>Registerable by Customer:</strong></div></td>
										<td><input type="checkbox" name="registerable" <? if ($priceList[0]["registerable"]==1) { echo " CHECKED"; } ?>></td>
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
												<input name="Cancel" type="button" onClick="MM_goToURL('parent','skuMaint.php');return document.MM_returnValue" value="Cancel">
											</div>
										</td>
										<td>
											<div align="right">
												<input type="submit" name="Submit" value="<?=$fun?> SKU">
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
