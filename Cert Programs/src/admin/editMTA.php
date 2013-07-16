<?
	include_once("session.php");
	include_once("../cert_functions.php");

 	if (!isset($_SESSION["Permissions"]["KeyLabs"])) {
 	    header("location: ../index.php");
 	}
 	
	if (!isset($_GET["pid"])) {
		header("location: programMaint.php");
	}

	if (isset($_POST["Submit"])) {
	    if ($_GET["pid"]!=0) {
	        $SQL = "UPDATE programMTA set mtaText='".$_POST["mtaText"]."' WHERE id='".$_GET["pid"]."'";
	        $update = DoSQL($SQL, SQL_UPDATE);
      		header("location: programMaint.php");
      }
	}

	$activetab = "admin";
	if ($_GET["pid"]<>0) {
	  $SQL = "select * from programMTA where id='".$_GET["pid"]."'";
	  $MTA = DoSQL($SQL);
		$programInfo = GetProgramInfo($_GET["pid"]);
		$titleString = "MTA Edit Page for ".$programInfo[0]["programName"];
	}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>KeyLabs Certification System</title>
 
  <link rel="stylesheet" href="/graphics/main.css" type="text/css">
  <link rel="stylesheet" href="/graphics/menuExpandable3.css" type="text/css">
  <script type="text/javascript">
  cookieName = 'adminopenMenus';
  </script>
  <script src="/graphics/menuExpandable3.js"></script>
  <!-- this needs to be the last css loaded -->
  <!--[if IE 6]>
  <link rel="stylesheet" href="graphics/ie6.css" type="text/css">
  <![endif]-->
  <!-- this needs to be the last css loaded -->
</head>
<body>
  <div id=leftfullheight>&nbsp;</div>
  <div id=top>
    <div id=header>
      <? include("../inc/header.php"); ?>
    </div>
  </div>
  <div id=middle>
    <div id=middle2>
      <div id=left>
        <? include("../inc/adminMenu.php"); ?>
      </div>
      <div id=right>
      <br>
      <form name="editMTAForm" action="?pid=<?=$_GET["pid"]?>" method="post">
      <div align=center>
        <div class=greyboxheader align=left>
          <b><?=$titleString?></b>
        </div>
      </div>
      <div align=center>
      <div class=greybox>
        <table width=100% cellspacing=0 cellpadding=5 border=0>
          <tr>
            <td><textarea rows=40 cols=80 name="mtaText"><?=$MTA[0]["mtaText"]?></textarea></td>
          </tr>
        </table>
      </div>
      </div>
    	<div align=center>
        <div class="greyboxfooter" align=left>
    			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
    			  <tr>
      				<td>
                <div align="left">
                  <b>Update MTA</b>
    				    </div>
              </td>
    				  <td>
                <div align="right">
                  <input type="submit" name="Submit" value="Update">
                </div>
              </td>
    			  </tr>
    			</table>
        </div>
	 	   </div>
          </form>

      </div>
    </div>
  </div>
</body>
</html>
