<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");
  $activetab = "admin";

  if (isset($_POST["Add"])) {
    $resource_id = $_POST["resource_id"];
    $startDate = $_POST["startDate"];
    $endDate = $_POST["endDate"];
    $comment = $_POST["comment"];
    $SQL = "insert into reservation set resource_id='$resource_id', startDate='$startDate', endDate='$endDate', comment='$comment'";
    $response = DoSQL($SQL, SQL_UPDATE);
    header("location: reservations.php");
  }


  $titleString = "Add Resource Reservation";
  $SQL = "select id,name from resource where resourceType_id='3' or resourceType_id='4' or resourceType_id='5' ORDER by name";
  $resources = DoSQL($SQL, SQL_SELECT);
  $resourcesCnt = count($resources);
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
          Add a resource reservation.<br><br>
          Be careful of date format!
          </div>
<br>
            <table width=100% cellspacing=0 cellpadding=5 border=0>
              <tr>
                <td><b>Resource: </b></td>
                <td>
                  <select name=resource_id>
<?
  for ($i=0;$i<$resourcesCnt;$i++) {
?>
                    <option value="<?=$resources[$i]["id"]?>"><?=$resources[$i]["name"]?>
<? } ?>
                  </select>
                </td>
              </tr>
              <tr>
                <td><b>Start Date (YYYY-MM-DD): </b></td>
                <td><input type=text name=startDate size=10></td>
              </tr>
              <tr>
                <td><b>End Date (YYYY-MM-DD): </b></td>
                <td><input type=text name=endDate size=10></td>
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
                <td><b>Add Resource Reservation</td><td align=right><input type=submit name="Add" value="Add Resource Reservation"></td>
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
