<?
	include_once("session.php");
	include_once("cert_functions.php");

 	if (isset($_GET["delete"])) {
	    $SQL = "UPDATE company SET active=0 WHERE id='".$_GET["pid"]."'";
	    DoSQL($SQL, SQL_UPDATE);

		header("location: companyList.php?st=" .$_GET["st"] ."&ed=" .$_GET["ed"]);
		exit;
	}
	
	$titleString = "Company List: ".strtoupper($_GET["st"])."-".strtoupper($_GET["ed"]);
	$activetab = "admin";
	
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>KeyLabs Certification System</title>
 
  <link rel="stylesheet" href="../graphics/main.css" type="text/css">
  <link rel="stylesheet" href="../graphics/menuExpandable3.css" type="text/css">
  <script src="../graphics/menuExpandable3.js"></script>
  <script type="text/javascript">
  cookieName = 'adminopenMenus';
  </script>
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
        <? include("../inc/adminMenu.php"); ?>
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
					<b><?=$titleString?></b>
				</div>		
			
			    <div class="toplessgreybox">
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td width="25%"><strong>Company</strong></td>
                  <td width="25%"><strong>City</strong></td>				  
                  <td width="20%"><strong>State</strong></td>
                  <td width="10%"><strong>Zip</strong></td>
                  <td width="20%"><div align="center"></div></td>
                </tr>
			<?
				$sql = "SELECT * FROM company WHERE active = 1 and left(name,1) >='".$_GET["st"]."' AND left(name,1) <='".$_GET["ed"]."' ORDER BY name";
				$users = DoSQL($sql);
				if (is_array($users)) {
					foreach($users as $value) {
						if ($value["active"] == 1) { $active = "Yes"; } else { $active = "No"; }
					    printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\">
									<td>%s</td>
									<td>%s</td>
									<td>%s</td>
									<td>%s</td>
									<td align=center><a href=\"companyEdit.php?pid=%d&edit=1&st=%s&ed=%s\">Edit</a> |
										<a href=\"?delete=1&pid=%d&st=%s&ed=%s\" onClick=\"return confirmDelete()\">Delete</a></td>
								</tr>",
								$value["name"], $value["city"], $value["state"], $value["zip"], $value["id"], $_GET["st"],$_GET["ed"], $value["id"], $_GET["st"],$_GET["ed"]);

					}
				} else {
				    print("<tr class=listnone><td colspan=4 class=listnone>No companies are in the system</td></tr>");
				}
			?>
              </table>
			  </div>
			</div>
		  </div>
		  </td>
          </tr>
          <tr align="center">
            <td valign="top"><div class="greyboxheader">
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td width="25%"><strong>Add New Company</strong></td>
                  <td width="15%"><div align="right">
                    <input name="Button" type="button" onClick="MM_goToURL('parent','companyEdit.php?f=add&cid=<?=$_SESSION["company_id"]?>&st=<?=$_GET["st"]?>&ed=<?=$_GET["ed"]?>');return document.MM_returnValue" value="Add Company">
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
