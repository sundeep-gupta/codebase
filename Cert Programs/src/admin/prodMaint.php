<?
	include_once("session.php");
	include_once("cert_functions.php");
  $activetab = "admin";

	if (!isset($_GET["pid"])) {
	    header("location: index.php");
	}
	
 	if (isset($_GET["delete"])) {
	    $SQL = "UPDATE platform SET active=0 WHERE priceList_id='".$_GET["plid"]."' AND id='".$_GET["plaid"]."'";
	    DoSQL($SQL, SQL_UPDATE);
	    header("location: prodMaint.php?pid=".$_GET["pid"]);
	}
	
	$titleString = "Platform Page";
	$activetab = "admin";
	$prefix = GetPrefix($_GET["pid"]);
	$titleString = "Platform Maintenance for ".$prefix[0]["prefix"];
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

var arrow_up = new Image();
  arrow_up.src = '/graphics/arrow-up.gif';
var arrow_down = new Image();
  arrow_down.src = '/graphics/arrow-down.gif';

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
        <div align=center>
		<!-- content should be in <p> tags to prevent the ie 3 pixel bug described on http://www.positioniseverything.net/explorer/threepxtest.html -->
		<? // i think for the index page i'll show every cert that the current user has access to ?>
		<br>
		<?
		    $SQL = "SELECT description AS skuDescription, priceList.id AS plid, platform.name AS platformName, platform.version AS platformVersion, platform.id AS plaid
					FROM priceList LEFT JOIN platform ON (priceList.id=platform.priceList_id)
					WHERE priceList.prefix_id='".$_GET["pid"]."' AND (platform.active=1 OR isnull(platform.active))
					ORDER BY priceList.SKU ASC, name ASC";
      
			$skus = DoSQL($SQL, SQL_SELECT);
			if (is_array($skus)) {
				foreach ($skus as $sku)	{
					if ($previous != $sku["plid"]) {
						if ($previous != "") { // Footing before a header
								printf("<tr><td>&nbsp;</td></tr><tr><td>&nbsp</td><td>&nbsp;<td><b>
										<a href=prodEdit.php?pid=%d&plid=%d>New Platform</a></b></tr></table></div><p>&nbsp;</p>",
										$_GET["pid"], $previous);
						}

						// Do our header
						?>
							<div class="greyboxheader" align=left onclick="div_toggle('<?=$sku["plid"]; ?>'); return false;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								  <tr>
									<td width="50%"><b><?=$sku["skuDescription"]; ?></b></td>
									<td width="50%"><div align="right"><img name="Arrow<?=$sku["plid"]; ?>" src="/graphics/arrow-down.gif"></div></td>
								  </tr>
								</table>
							</div>
							<div class="toplessgreybox" id="<?=$sku["plid"]; ?>" style="display:none">
							  <table width="100%"  border="0" cellspacing="0" cellpadding="5">
								<tr>
									<td width="50%"><strong>Name</strong></td>
									<td width="35%"><strong>Version</strong></td>
									<td width="15%">&nbsp;</td>
								</tr>
						<?
						$previous = $sku["plid"];
					}
					if (isset($sku["platformName"])) {
					    printf("<tr>
									<td>%s</td>
									<td>%s</td>
									<td>
										<a href=\"prodEdit.php?pid=%d&plaid=%d&plid=%d\">Edit</a> |
										<a href=\"?delete=1&pid=%d&plaid=%d&plid=%d\">Delete</a>
									</td>
								</tr>",
								$sku["platformName"], $sku["platformVersion"],
								$_GET["pid"], $sku["plaid"], $sku["plid"],
								$_GET["pid"], $sku["plaid"], $sku["plid"]);
					} else {
						printf("<tr><td colspan=3><p class=none>No platforms have been created for this SKU.</p></td></tr>");
					}
				} // end of foreach loop
								printf("<tr><td>&nbsp;</td></tr><tr><td>&nbsp</td><td>&nbsp;<td><b>
										<a href=prodEdit.php?pid=%d&plid=%d>New Platform</a></b></tr></table></div><p>&nbsp;</p>",
										$_GET["pid"], $previous);
			} else {
			    //no skus defined
			    print("<div class=greyboxheader align=left><table width=100% border=0 cellspacing=0 cellpadding=0><tr><td><p class=none>No skus belong to this prefix.  Please add one.</p></td></tr></table></div>");
			}
?>
<!--
			<?
  /*
			    $platforms = GetPrefixPlatforms($_GET["pid"]);
				if (is_array($platforms)) {
					foreach($platforms as $value) {
					    printf("<tr><td>%s</td><td>%s</td>
									<td align=center>
										<a href=\"prodEdit.php?pid=%d&plaid=%d&plid=%d\">Edit</a> |
										<a href=\"?delete=1&pid=%d&plaid=%d&plid=%d\">Delete</a>
									</td>
								</tr>",
								$value["name"], $value["version"],
								$_GET["pid"], $value["id"], $value["priceList_id"],
								$_GET["pid"], $value["id"], $value["priceList_id"]);

					}
				} else {
				    print("<tr class=listnone><td colspan=4 class=listnone>No platforms are in the system</td></tr>");
				}
	*/
			?>
              </table>
              <p>&nbsp;</p>
			</div>
		  </div>
		  </td>
          </tr>
          <tr>
            <td valign="top"><div class="greyboxheader">
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td width="25%"><strong>Add New Platform</strong></td>
                  <td width="15%"><div align="right">
                    <input name="Button" type="button" onClick="MM_goToURL('parent','prodEdit.php?pid=<?=$_GET["pid"]?>&plid=<?=?>');return document.MM_returnValue" value="Add Product">
                  </div></td>
                </tr>
              </table>
              </div></td>
          </tr>
        </table> -->
      </div>
    </div>
  </div>
</body>
</html>
