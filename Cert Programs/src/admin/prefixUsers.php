<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");
  $activetab = "admin";

  if (isset($_POST["Update"])) {
    $pfx = $_POST["pfx"];
    $SQL = "delete from prefixUser where prefix_id='$pfx'";
    $deleted = DoSQL($SQL, SQL_UPDATE);
    foreach($_POST["checkbox"] as $key => $value) {
      $SQL = "insert into prefixUser set prefix_id='$pfx',user_id='$key'";
      DoSQL($SQL, SQL_UPDATE);
    }
  }

  if (isset($_GET["pfx"])) {
    $pfx = $_GET["pfx"];
  }
  $SQL = "select user.*,prefixUser.prefix_id from  user cross join prefix left join prefixUser ON (prefix.id=prefixUser.prefix_id AND prefixUser.user_id=user.id) WHERE   prefix.id='$pfx'";
//  $SQL = "SELECT user.*,prefixUser.prefix_id from user left join prefixUser on (user.id=prefixUser.user_id) where (prefix_id='$pfx' or prefix_id IS NULL) order by email";
  $users = DoSQL($SQL,SQL_SELECT);
  $usercnt = count($users);
  $SQL = "select prefix from prefix where id='$pfx'";
  $prefix = DoSQL($SQL,SQL_SELECT);

  $titleString = "Prefix Users Maintenance for ".$prefix[0]["prefix"];
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
        <form name="prefixUsers" action="" method="POST">
        <input type=hidden name="pfx" value="<?=$pfx?>">
        <div align=center>
          <div class=greyboxheader align=left>
            <b><?=$titleString?></b>
          </div>
        </div>
        <div align=center>
          <div class=greybox>
            <table width=100% cellspacing=0 cellpadding=5 border=0>
              <tr>
                <td>&nbsp;</td>
                <td><b>Login, (Name)</b></td>
                <td><b>&nbsp;</b></td>
                <td><b>Login, (Name)</b></td>
              </tr>
<?
        for ($i=0; $i<$usercnt; $i=$i+2) {
?>        
              <tr>
                  <td align=right><input type=checkbox name=checkbox[<?=$users[$i]["id"];?>] <? if ($users[$i]["prefix_id"]==$pfx) { echo " CHECKED"; } ?>></td>
                  <td><?=$users[$i]["email"].", (".$users[$i]["name"].")"; ?></td>
                <? if ($i+1 < $usercnt) { ?>
                  <td align=right>
                  <input type=checkbox name=checkbox[<?=$users[$i+1]["id"];?>] <? if ($users[$i+1]["prefix_id"]==$pfx) { echo " CHECKED"; } ?>></td>
                  <td><?=$users[$i+1]["email"].", (".$users[$i+1]["name"].")"; ?></td>
                <? } else {
                    echo "<td>&nbsp;</td><td>&nbsp</td>";
                  }
                ?>
              </tr>
<? } ?>
            </table>
          </div>
          </div>
          <div align=center>
          <div class="greyboxfooter" align=left>
            <table width=100% border=0 cellspacing=0 cellpadding=0>
              <tr>
                <td><b>Update Prefix Users</td><td align=right><input type=submit name="Update" value="Update"></td>
              </tr>
            </table>
          </div>
          </form>
        <br>
      </div>
    </div>
  </div>
</body>
</html>
