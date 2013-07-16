<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");

  if (!isset($_GET["st"])) {
    $_GET["st"]="A";
    $_GET["ed"]="H";
  }
  
  $activetab = "admin";
  $titleString = "Account Maintenance Page ".strtoupper($_GET["st"])."-".strtoupper($_GET["ed"]);
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
  <link rel="stylesheet" href="/graphics/ie6.css" type="text/css">
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
      <div id=right style="height:100%;">
<?
  $SQL = "select bucket.*,company.name from bucket, company where bucket.company_id=company.id AND left(company.name,1) >='".$_GET["st"]."' AND left(company.name,1) <='".$_GET["ed"]."' ORDER BY company.name";
  $buckets = DoSQL($SQL, SQL_SELECT);
//  dumpvar($buckets); exit;
  $bucketCnt = count($buckets);
?>
        <form name=addEmail action="addEmail.php" method=post>
        <table width=100% cellspacing=10 cellpadding=5>
          <tr>
            <td valign="top">
              <div align=center>
              <div class=greyboxheader>
                <b><?=$titleString?></b>
              </div>
              <div class=toplessgreybox align=left>
                <table width=100% cellspacing=0 cellpadding=5 border=0>
                  <tr>
                    <td><b>Company</b></td>
                    <td><b>Balance</b></td>
                    <td><b>Hourly Rate</b></td>
                    <td><b>Description</b></td>
                    <td align=center><b>Active</b></td>
                    <td><b>Options</b></td>
                  </tr>
<?
  for ($i=0;$i<$bucketCnt;$i++){
?>
                  <tr>
                    <td><?=$buckets[$i]["name"]?></td>
                    <td>$<?=$buckets[$i]["balance"]?></td>
                    <td>$<?=$buckets[$i]["hourlyRate"]?>/hr</td>
                    <td><?=$buckets[$i]["description"]?></td>
                    <td align=center><input type=checkbox name=checkbox1 <? if ($buckets[$i]["active"]) { echo " CHECKED"; } ?> DISABLED></td>
                    <td class=list valign=top>
                      <a href="MRCedit.php?m=<?=$buckets[$i]["id"] ?>&c=<?=$buckets[$i]["company_id"]?>&st=<?=$_GET["st"]?>&ed=<?=$_GET["ed"]?>">Edit</a>&nbsp;|&nbsp;
                      <a href="MRCdeactivate.php?m=<?=$buckets[$i]["id"] ?>&st=<?=$_GET["st"]?>&ed=<?=$_GET["ed"]?>&a=<?=$buckets[$i]["active"]?>"><? if ($buckets[$i]["active"] == "1") { echo "Deactivate";} else {echo "Activate"; } ?></a>&nbsp;|&nbsp;
                      <a href="MRClog.php?m=<?=$buckets[$i]["id"] ?>">Log and Entry</a>
                    </td>
                  </tr>
<? } ?>
                </table>
              </div>
              </div>
            </td>
          </tr>
          <tr>
            <td valign="top" align=center>
              <div class=greyboxfooter>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                  	<td>
                  	 <b>Add New Account</b>
                    </td>
                    <td align=right>
                     <a href="MRCadd.php?st=<?=$_GET["st"]?>&ed=<?=$_GET["ed"]?>"><input type=submit name=submit value="Add New Account"></a>
                    </td>
        	       </tr>
                </table>
            </td>
          </tr>
        </table>
        </form>
      </div>
    </div>
  </div>
</body>
</html>




