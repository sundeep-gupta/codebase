<?
	include_once("session.php");
	include_once("cert_functions.php");
    include("productfunctions.php"); 
	
	$titleString = "Product Page";
	$activetab = "products";
	
	if (!isset($_SESSION["mta"])) {
    header("location: certinfo.php?pid=".$_SESSION["pid"]."&cid=".$_SESSION["cid"]."#");
    exit;
  }
	
	if ($_POST["poster"] == 1) {
		//dumpvar($_POST);
		
		foreach ($_POST["sku"] as $key => $value) {
			$number = prefixNumberInc($key);
			$status = getStatusID($key);
			if (!isset($_SESSION["tid"]) or $_SESSION["tid"] == "") {
        $_SESSION["tid"] = $_SESSION["id"];
      }
			$sql = "INSERT INTO productPriceList (payment_id, status_id, technical_id, submission_id, product_id, priceList_id, timeframe_id, registeredDate, number, comment) 
							VALUES(" .$_SESSION["paymentMethod"] .",$status," .$_SESSION["tid"] ."," .$_SESSION["id"] ."," .$_SESSION["pid"] .",$key," .$_SESSION["tfid"] .",NOW(),$number, '" .$_SESSION["comment"] ."')";
			$result = DoSQL($sql, SQL_UPDATE, 1, false);
		}
		header("location: status.php?pplid=$result");
		exit;
	}
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
<script language="javascript">
var arrow_up = new Image();
  arrow_up.src = '../graphics/arrow-up.gif';
var arrow_down = new Image();
  arrow_down.src = '../graphics/arrow-down.gif';  

function show_div(div_id) {
	// show the requested div
	document.getElementById(div_id).style.display = 'block';
} 

function hide_div(div_id) {
	document.getElementById(div_id).style.display = 'none';
}

function div_toggle(div_id) {
	if (document.getElementById(div_id).style.display == 'none') {
		document.getElementById(div_id).style.display = 'block';
		document["Arrow"+div_id].src = arrow_up.src;
	}
	else {
		document.getElementById(div_id).style.display = 'none';		
		document["Arrow"+div_id].src = arrow_down.src;
	}
}

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

        <br>
			<form action="" method="post" name="form1">
	  		<div align="center">
			
			<?php GenerateCertList(); ?>

			<p>&nbsp;</p>
			<div class="greyboxfooter" align="right">
			  <input name="pid" type="hidden" id="pid" value="<?=$_GET["pid"]; ?>">
				<input name="submit" value="Initiate Testing" type="submit">
			</div>					  
			  <br>
		  </div>
		  <input name="poster" type="hidden" value="1">
		  </form>
	  </div>
    </div>
  </div>
</body>
</html>
