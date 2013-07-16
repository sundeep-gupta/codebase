<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");
  $activetab = "admin";

  if (isset($_POST["newPrefix"])) {
    $SQL = "insert into prefix (prefix,number) values('$_POST[newPrefix]','100')";
    $response = DoSQL($SQL, SQL_UPDATE);
    $SQL = "insert into permission set permission='prefix-$response',description='Permission for $_POST[newPrefix]'";
    $newPerm = DoSQL($SQL, SQL_UPDATE);
    
    $SQL = "INSERT INTO status SET prefix_id='$response', name='Registered', orderIndex='1', active='1'";
    DoSQL($SQL, SQL_UPDATE);
  }

  if (isset($_POST["Update"])) {
    foreach($_POST["comment"] as $key => $value) {
      $SQL = "update resource set comment='$value' where id='$key'";
      DoSQL($SQL, SQL_UPDATE);
    }
    foreach($_POST["name"] as $key => $value) {
      $SQL = "update resource set name='$value' where id='$key'";
      DoSQL($SQL, SQL_UPDATE);
    }
  }

  if (isset($_GET["t"])) {
    $resourceType = $_GET["t"];
  }
  if ($resourceType=="ip") {
    $resourceTitle = "IP Address";
    $subnet = $_GET["id"];
    $SQL = "SELECT * FROM resource WHERE name like '%$subnet%' and resourceType_id='2' order by name";
  }
  if ($resourceType=="ipsubnet") {
    $resourceTitle = "Subnets";
    $SQL = "SELECT * FROM resource WHERE resourceType_id='1' order by name";
  }
  if ($resourceType=="rack") {
    $resourceTitle = "Rack Label";
    $SQL = "SELECT * FROM resource WHERE resourceType_id='3' order by name";
  }
  if ($resourceType=="host") {
    $resourceTitle = "Host Label";
    $SQL = "SELECT * FROM resource WHERE resourceType_id='4' order by name";
  }
  if ($resourceType=="other") {
    $resourceTitle = "Other Label";
    $SQL = "SELECT * FROM resource WHERE resourceType_id='5' order by name";
  }
  $resources = DoSQL($SQL, SQL_SELECT);
  $titleString = "Resource Maintenance";
  $resourceCount = count($resources);
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
  <link rel="stylesheet" href="../graphics/ie6.css" type="text/css">
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
        <div align=center>
          <div class=greyboxheader align=left>
            <table width=100% border=0 cellspacing=0 cellpadding=0>
              <tr>
                <td><b><?=$titleString?></td><td align=right><input type=submit name="Update" value="Update"></td>
              </tr>
            </table>
          </div>
        </div>
        <div align=center>
          <div class=greybox>
            <table width=100% cellspacing=0 cellpadding=1 border=0>
              <tr>
                <td><b><?=$resourceTitle?>&nbsp;&nbsp;&nbsp;</b></td>
                <td><b>&nbsp;Comment</b></td>
              </tr>
<?
        for ($i=0; $i<$resourceCount; $i++) {
?>        
              <tr>
<?
        if ($resourceType == "ip" or $resourceType == "ipsubnet") {
?>
                  <td><input type=text name=name[<?=$resources[$i]["id"];?>] size=50 maxlength=50 value="<?=$resources[$i]["name"]; ?>" READONLY></td>
<?
        }
?>
<?
        if ($resourceType == "rack" or $resourceType == "host" or $resourceType == "other") {
?>
                  <td><input type=text name=name[<?=$resources[$i]["id"];?>] size=50 maxlength=50 value="<?=$resources[$i]["name"]; ?>"></td>
<?
        }
?>
                  <td><input type=text name=comment[<?=$resources[$i]["id"];?>] size=50 maxlength=50 value="<?=$resources[$i]["comment"]; ?>"></td>
              </tr>
<? } ?>
            </table>
          </div>
          </div>
          <div align=center>
          <div class="greyboxfooter" align=left>
            <table width=100% border=0 cellspacing=0 cellpadding=0>
              <tr>
                <td><b>Update Comments</td><td align=right><input type=submit name="Update" value="Update"></td>
              </tr>
            </table>
          </div>
          </form>
<br>
      </div>
    </div>
  </div>
</div>
</body>
</html>
