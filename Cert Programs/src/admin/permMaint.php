<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");
  $activetab = "admin";

  if (isset($_GET["d"])) {
    $SQL = "update logSubject set active='0' where id='$_GET[d]'";
    $response = DoSQL($SQL, SQL_UPDATE);
  }

  if (isset($_POST["newPermission"])) {
    $SQL = "insert into permission (permission,description) values('$_POST[newPermission]','$_POST[newDescription]')";
    $response = DoSQL($SQL, SQL_UPDATE, true);
  }

  if (isset($_POST["Update"])) {
    foreach($_POST["permission"] as $key => $value) {
//      if ($_POST["active"][$key] == "on") { $active='1';} else {$active='0';}
      $SQL = "update permission set permission='$value',description='".$_POST["description"][$key]."' where id='$key'";
      DoSQL($SQL, SQL_UPDATE);
    }
  }

  $titleString = "Permissions Maintenance";
  $SQL = "select * from permission ORDER by permission";
  $permissions = DoSQL($SQL, SQL_SELECT);
  $permissionsCnt = count($permissions);
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
        <form name="editPermissionsForm" action="" method="post">
        <div align=center>
          <div class=greyboxheader align=left>
            <b><?=$titleString?></b>
          </div>
        </div>
        <div align=center>
          <div class=greybox>
            <table width=100% cellspacing=0 cellpadding=5 border=0>
              <tr>
                <td><b>Permission</b></td>
                <td><b>Description</b></td>
              </tr>
<?
        for ($i=0; $i<$permissionsCnt; $i++) {
?>        
              <tr>
                  <td><input type=text name=permission[<?=$permissions[$i]["id"];?>] size=50 maxlength=100 value="<?=$permissions[$i]["permission"]; ?>"></td>
                  <td><input type=text name=description[<?=$permissions[$i]["id"]?>] size=50 maxlength=100 value="<?=$permissions[$i]["description"]; ?>"></td>
              </tr>
<? } ?>
            </table>
          </div>
          </div>
          <div align=center>
          <div class="greyboxfooter" align=left>
            <table width=100% border=0 cellspacing=0 cellpadding=0>
              <tr>
                <td><b>Update Permissions</td><td align=right><input type=submit name="Update" value="Update"></td>
              </tr>
            </table>
          </div>
          </form>
<br>
        <form name="addPermissionForm" action="" method="post">
        <div class=greyboxfooter>
          <table width=100% border=0 cellspacing=0 cellpadding=5>
            <tr>
              <td colspan=2><b>NEW PERMISSION:</b></td>
            </tr>
            <tr>
              <td><b>Permission:</b></td>
              <td><input type=text size=50 maxlength=100 name=newPermission value=""></td>
            </tr>
            <tr>
              <td><b>Description:</b></td>
              <td><input type=text size=50 maxlength=100 name=newDescription value=""></td>
            </tr>
            <tr>
              <td colspan=2><input type=submit name=submit value="Add"></td>
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
