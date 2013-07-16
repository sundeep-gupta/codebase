<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	$titleString = "Product Page";
	$activetab = "products";
	
	//$user = GetUser($_SESSION["id"]);
	$products = GetCompanyProducts($_SESSION["company_id"]);
	
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
  <link rel="stylesheet" href="/graphics/ie6.css" type="text/css">
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
		<table width="100%" border="0" cellspacing="10" cellpadding="5">
          <tr>
            <td width="50%" valign="top">
			<div style="height:100%">
			<div class="greyboxheader" style="height:100%">
              <p><strong>1) Register Your Products </strong></p>
              <p>Register your products </p>
              <p>&nbsp;</p>
              <p>&nbsp;</p>
              <p>Currently Registered Products: <?=count($products)?></p>
              <p>&nbsp;</p>
              <p align="center">
                <input name="Button" type="button" onClick="MM_goToURL('parent','productslist.php');return document.MM_returnValue" value="Product Maintenance">
              </p>
              <br><br>
                <a href="productsedit.php?cid=<?=$_SESSION["company_id"]?>">Add Product to System</a>
            </div>
			</div></td>
            <td width="50%" valign="top">
			<div style="height:100%">
			<div class="greyboxheader" style="height:100%">
              <p><strong>2) Initiate Testing </strong></p>
              <p>KeyLabs offers the following certification testing and verification services</p>
              <ul>
                <li> Cisco Technology Developer Program, CCX, ICM testing, etc</li>
                <li> Linux Tested</li>
                <li>Novell YES</li>
                <li>Solaris Ready </li>
                <li>Microsoft WHQL Pre-Testing</li>
                <li>RealSystem Compatible Testing</li>
              </ul>
              <p>&nbsp;</p>
              <p align="center">
                <input name="Button" type="button" onClick="MM_goToURL('parent','selectproduct.php');return document.MM_returnValue" value="Initiate Testing">
              </p>
            </div></div></td>
          </tr>
        </table>
		</div>
      </div>
    </div>
  </div>
</div>  
</body>
</html>
