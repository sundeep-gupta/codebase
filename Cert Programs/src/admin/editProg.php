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
	        $SQL = "UPDATE program ";
	        $WHERE = " WHERE id='".$_GET["pid"]."'";
	    } else {
	        $SQL = "INSERT INTO program ";
	        $WHERE = "";
	    }
	    
	    $active=(isset($_POST["active"]))? "1" : "0";
		$SQL .= "SET sponsorCompany_id='".$_POST["companyID"]."', programName='".$_POST["programName"]."',
				active='$active'$WHERE";
		$progid = DoSQL($SQL, SQL_UPDATE, 1, false);
		header("location: programMaint.php");
	}

	$activetab = "admin";
	if ($_GET["pid"]==0) {
		$programInfo = array();
		$titleString = "Add a new program";
		$function = "Add";
	} else {
		$programInfo = GetProgramInfo($_GET["pid"]);
		$titleString = "Program Edit Page for ".$programInfo[0]["programName"];
		$function = "Update";
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
      <form name="editProgramForm" action="?pid=<?=$_GET["pid"]?>" method="post">
      <div align=center>
        <div class=greyboxheader align=left>
          <b><?=$titleString?></b>
        </div>
      </div>
      <div align=center>
      <div class=greybox>
        <table width=100% cellspacing=0 cellpadding=5 border=0>
          <tr>
            <td><b>Sponsor Company</b></td>
            <td>
                <select name=companyID style="width: 323px">
                    <?
                        $companies = GetAllSponsorCompanies();
                        $companiescnt = count($companies);
                        for($x=0;$x<$companiescnt;$x++) {
                            printf("<option value=%d%s>%s</option>",
                                $companies[$x]["id"],
                                ($companies[$x]["id"]==$programInfo[0]["sponsorCompanyID"]) ? " selected" : "",
                                $companies[$x]["name"]);
                        }
                    ?>
                </select>&nbsp;<input type=button name=addcomp value="Add Company" onclick="window.location.href='sponsorCompany.php?pid=<?=$_GET["pid"]?>'">
			</td>
          </tr>
          <tr>
            <td><b>Program Name</b></td>
            <td><input type="text" name="programName" value="<?=$programInfo[0]["programName"]?>" size="50"></td>
          </tr>
          <tr>
            <td><b>Active?</b></td>
            <td><input type="checkbox" name="active"<?=($programInfo[0]["active"]==1)?" checked" :""?>></td>
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
                  <b>Update Program Information</b>
    				    </div>
              </td>
    				  <td>
                <div align="right">
                  <input type="submit" name="Submit" value="<?=$function?>">
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
