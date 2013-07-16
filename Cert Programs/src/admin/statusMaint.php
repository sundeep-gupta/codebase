<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");
  $activetab = "admin";

  if (isset($_GET["p"])) {
    $prefix = GetPrefix($_GET["p"]); $p=$_GET["p"];
  } else {
    if (isset($_POST["p"])) {
      $prefix = GetPrefix($_POST["p"]); $p=$_POST["p"];
    }
  }

  if (isset($_POST["newStatus"])) {
    $SQL = "insert into status (prefix_id,name,active) values('$p','$_POST[newStatus]','1')";
    $response = DoSQL($SQL, SQL_UPDATE);
  }

  if (isset($_POST["Update"])) {
    foreach($_POST["status"] as $key => $value) {
      if ($_POST["active"][$key] == "on") { $active='1';} else {$active='0';}
      $SQL = "update status set name='$value',active='$active' where id='$key'";
      DoSQL($SQL, SQL_UPDATE);
    }
  }

  $program = $prefix[0]["prefix"];
  $statuses2 = GetAllPrefixStatuses($_GET["p"]);
  $statusCnt = count($statuses2);
  $titleString = "Status Maintenance for $program";
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
        <form name="editStatusForm" action="" method="post">
        <input type=hidden name=p value="<?=$prefix?>">
        <div align=center>
          <div class=greyboxheader align=left>
            <b>Status Maintenance for <?=$program?></b>
          </div>
        </div>
        <div align=center>
          <div class=greybox>
            <table width=100% cellspacing=0 cellpadding=5 border=0>
              <tr>
                <td><b>Status</b></td>
                <td align=center><b>Active</b></td>
              </tr>
<?
        for ($i=0; $i<$statusCnt; $i++) {
?>        
              <tr>
                  <td><input type=text name=status[<?=$statuses2[$i]["id"]?>] size=50 maxlength=50 value="<?=$statuses2[$i]["name"]; ?>"></td>
                  <td align=center><input type=checkbox name=active[<?=$statuses2[$i]["id"]?>] <?if ($statuses2[$i]["active"] == 1) { echo " checked"; } ?>></td>
              </tr>
<? } ?>
            </table>
          </div>
          </div>
          <div align=center>
          <div class="greyboxfooter" align=left>
            <table width=100% border=0 cellspacing=0 cellpadding=0>
              <tr>
                <td><b>Update Statuses</td><td align=right><input type=submit name="Update" value="Update"></td>
              </tr>
            </table>
          </div>
          </form>
<br>
        <form name="addStatusForm" action="" method="post">
        <input type=hidden name=p value="<?=$prefix?>">
        <div class=greyboxfooter>
          <table width=100% border=0 cellspacing=0 cellpadding=0>
            <tr>
              <td><b>Add New Status: </b><input type=text size=50 maxlength=50 name=newStatus value=""></td>
                <td align=right><input type=submit name=submit value="Add"></td>
            </tr>
          </table>
        </div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>
