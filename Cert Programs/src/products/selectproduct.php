<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	$titleString = "Product Select";
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
		<? include("productfunctions.php"); ?>
        <br>
		
	  		<div align="center">
			
			<?php //GenerateCertList(); ?>
			
			<div align="center">
				<div class="greyboxheader" align=left>
					<b>Select which product you would like tested </b>
				</div>		
			
			    <div class="toplessgreybox">
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td width="25%"><strong>Name</strong></td>
                  <td width="15%"><strong>Version</strong></td>
                  <td width="45%"><strong>Comments</strong></td>
                  <td width="15%"><div align="center"></div></td>
                </tr>
			<?
				$products = GetCompanyProducts($_SESSION["company_id"]);
				if (is_array($products)) {
					foreach($products as $value) {
					    printf("<tr><td>%s</td><td>%s</td><td>%s</td>
									<td align=center><a href=\"certinfo.php?pid=%d&cid=%d\">Select</a></td></tr>",
								$value["name"], $value["version"], $value["comment"], $value["id"], $_SESSION["company_id"]);

					}
				} else {
				    print("<tr class=listnone><td colspan=4 class=listnone><br><br>You must have one or more products in the system before you can schedule testing.  <br> Please add your product first.<br><br><a href='productslist.php'>You may add products here.</a> </td></tr>");
				}
			?>
              </table>
              <p>&nbsp;</p>
			</div>
		  </div>

		  <p>&nbsp;</p>				
		  </div>

	  </div>
    </div>
  </div>
</body>
</html>
