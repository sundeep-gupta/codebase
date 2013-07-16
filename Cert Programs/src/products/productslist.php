<?
	include_once("session.php");
	include_once("cert_functions.php");

 	if (isset($_GET["delete"])) {
	    $SQL = "UPDATE product SET active=0 WHERE company_id=".$_SESSION["company_id"]." AND id='".$_GET["pid"]."'";
	    DoSQL($SQL, SQL_UPDATE);
	    
		header("location: productslist.php");
		exit;
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
  <link rel="stylesheet" href="/graphics/ie6.css" type="text/css">
  <![endif]-->
  <!-- this needs to be the last css loaded -->
  <script language="JavaScript" type="text/JavaScript">
<!--
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}

function confirmDelete()
{
var agree=confirm("Are you sure you want to delete this record?");
if (agree)
	return true ;
else
	return false ;
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

			<div align="center">
				<div class="greyboxheader" align=left>
					<b>Your Current Products </b>
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
					    printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\"><td>%s</td><td>%s</td><td>%s</td>
									<td align=center><a href=\"productsedit.php?pid=%d&cid=%d\">Edit</a> |
										<a href=\"?delete=1&pid=%d\" onClick=\"return confirmDelete()\">Delete</a> | 
                    <a href=\"certinfo.php?pid=%d&cid=%d\">Initiate</a></td></tr>",
								$value["name"], $value["version"], $value["comment"], $value["id"], $_SESSION["company_id"], $value["id"],$value["id"], $_SESSION["company_id"]);

					}
				} else {
				    print("<tr class=listnone><td colspan=4 class=listnone>No products are in the system</td></tr>");
				}
			?>
              </table>
			  </div>
              <p>&nbsp;</p>
			</div>
		  </div>
		  </td>
          </tr>
          <tr align="center">
            <td valign="top"><div class="greyboxheader">
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td width="25%"><strong>Add New Product</strong></td>
                  <td width="15%"><div align="right">
                    <input name="Button" type="button" onClick="MM_goToURL('parent','productsedit.php?cid=<?=$_SESSION["company_id"]?>');return document.MM_returnValue" value="Add Product">
                  </div></td>
                </tr>
              </table>
              </div></td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</body>
</html>
