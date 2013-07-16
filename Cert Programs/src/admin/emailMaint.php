<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");
  $activetab = "admin";
  if (isset($_GET[a])) {
  	$SQL = "UPDATE email set active=1 where id='".$_GET[a]."'";
  	$return = DoSQL($SQL, SQL_UPDATE);
  }
  if (isset($_GET[d])) {
  	$SQL = "UPDATE email set active=0 where id='".$_GET[d]."'";
  	$return = DoSQL($SQL, SQL_UPDATE);
  }

  if (!isset($_GET[p])) {
  	header("location: index.php");
  }
  if (isset($_GET[p])) {
    $p = $_GET[p];
  } else {
    if (isset($_POST[p])) {
      $p = $_POST[p];
    }
  }
  if (isset($_POST))
  if (isset($_POST["submit"])) {
	$SQL = "INSERT email ";
  }
  if ($p==0){ $prefix[0]["prefix"]="System"; } else { $prefix = GetPrefix($p); }
  $titleString = "Email Maintenance for ".$prefix[0]["prefix"];
  $SQL = "select email.* 
          from email, emailPrefix
          where emailPrefix.prefix_id='$p'
          and emailPrefix.email_id=email.id";

//  $SQL = "SELECT email.*,priceList.id as pid FROM email,emailPriceList,priceList WHERE email.id=emailPriceList.email_id AND priceList.prefix_id='$p' AND emailPriceList.priceList_id=priceList.id";
  $emails = DoSQL($SQL,SQL_SELECT);
  $emailsCnt = count($emails);
  if ($emailsCnt==0) {
  	$SQL = "SELECT priceList.id as pid from priceList where prefix_id='$p'";
  	$emails = DoSQL($SQL, SQL_SELECT);
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
        <form name=addEmail action="emailEdit.php" method=post>
        <input type=hidden name=p value="<?=$p?>">
        <input type=hidden name=e value="0">
        <input type=hidden name=pid value="<?=$emails[0][pid]?>">
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
                    <td><b>Subject</b></td>
                    <td><b>Body</b></td>
                    <td><b>Description</b></td>
                    <td align="center"><b>Active</b></td>
                    <td><b>Options</b></td>
                  </tr>
<?
	for ($i=0;$i<$emailsCnt;$i++) {
?>
                  <tr>
                    <td><?=$emails[$i]["subject"] ?></td>
                    <td><?=substr($emails[$i]["body"],0,50)."..." ?></td>
                    <td><?=substr($emails[$i]["description"],0,25)."..." ?></td>
					<td align="center"><input type="checkbox" name="active" <?=($emails[$i]["active"]==1)?" CHECKED" : ""?>></td>
					<? if ($emails[$i]["active"] == 1) {
						$func = "d";
						$funcString = "Deactivate";
					} else {
						$func = "a";
						$funcString = "Activate";
					}
					?>
                    <td><a href="emailEdit.php?e=<?=$emails[$i][id]?>&p=<?=$p?>">Edit</a>&nbsp;|&nbsp;<a href="emailMaint.php?<?=$func?>=<?=$emails[$i]["id"] ?>&p=<?=$p?>"><?=$funcString?></a></td>
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
                  	<td valign=top>
                  	 <b>Add New Email</b>
                  	</td>
                  	<td align=right>
                     <input type=submit name=add value="Add New Email">
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




