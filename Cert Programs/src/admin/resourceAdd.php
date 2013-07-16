<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");
  $activetab = "admin";

  if (isset($_POST["Add"])) {
    $resourceType_id = $_POST["resourceType_id"];
    $name = $_POST["name"];
    $comment = $_POST["comment"];
    $SQL = "insert into resource set resourceType_id='$resourceType_id', name='$name', comment='$comment'";
    $response = DoSQL($SQL, SQL_UPDATE);
    $SQL = "select type from resourceType where id='$resourceType_id'";
    $type = DoSQL($SQL, SQL_SELECT);
    if ($resourceType_id == "1") {
      $subnet = substr($name,0,strlen($name)-2);
      for ($j=1;$j<255;$j++) {
        if ($j<10) {
          $digit="00$j";
        } elseif ($j<100) {
          $digit="0$j";
        } else {
          $digit="$j";
        }
        $ip = "$subnet.$digit";
        $SQL = "INSERT into resource set resourceType_id='2', name='$ip', comment=''";
        $result = DoSQL($SQL, SQL_UPDATE);
        # echo "$SQL. $result<br>";
      }
    }
    $typename = $type[0]["type"];
    if ($type == "ip") {
      $extra = "&id=216.119.192";
    }
    header("location: resourceList.php?t=$typename$extra");
  }

  $titleString = "Add Resource";
  $SQL = "select id,type from resourceType ORDER by type";
  $resourceTypes = DoSQL($SQL, SQL_SELECT);
  $resourceTypesCnt = count($resourceTypes);
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
        <div align=center>
          <div class=greyboxheader align=left>
            <b><?=$titleString?></b>
          </div>
        </div>
        <div align=center>
          <div class=greybox>
          <div class=whitebox>
          Add a resource.<br><br>
          If you add a subnet, ADD CLASS C NETWORK ONLY (A.B.C.0) .  All IP addresses will be added as resources also.<br><br>
          All subnets must end in ".0".
          </div>
<br>
            <table width=100% cellspacing=0 cellpadding=5 border=0>
              <tr>
                <td><b>Resource Type: </b></td>
                <td>
                  <select name=resourceType_id>
<?
  for ($i=0;$i<$resourceTypesCnt;$i++) {
?>
                    <option value="<?=$resourceTypes[$i]["id"]?>"><?=$resourceTypes[$i]["type"]?>
<? } ?>
                  </select>
                </td>
              </tr>
              <tr>
                <td><b>Name: </b></td>
                <td><input type=text name=name size=50></td>
              </tr>
              <tr>
                <td><b>Comment: </b></td>
                <td><input type=text name=comment size=100></td>
              </tr>
            </table>
          </div>
          </div>
          <div align=center>
          <div class="greyboxfooter" align=left>
            <table width=100% border=0 cellspacing=0 cellpadding=0>
              <tr>
                <td><b>Add Resource</td><td align=right><input type=submit name="Add" value="Add Resource"></td>
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
