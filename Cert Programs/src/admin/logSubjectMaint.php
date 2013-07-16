<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");
  $activetab = "admin";

  if (isset($_GET["d"])) {
    $SQL = "update logSubject set active='0' where id='$_GET[d]'";
    $response = DoSQL($SQL, SQL_UPDATE);
  }

  if (isset($_POST["newSubject"])) {
    $SQL = "insert into logSubject (subject,active) values('$_POST[newSubject]','1')";
    $response = DoSQL($SQL, SQL_UPDATE, true);
  }

  if (isset($_POST["Update"])) {
    foreach($_POST["subject"] as $key => $value) {
      if ($_POST["active"][$key] == "on") { $active='1';} else {$active='0';}
      $SQL = "update logSubject set subject='$value',active='$active' where id='$key'";
      DoSQL($SQL, SQL_UPDATE);
    }
  }

  $titleString = "Log Subject Maintenance";
  $SQL = "select * from logSubject ORDER by subject";
  $subjects = DoSQL($SQL, SQL_SELECT);
  $subjectsCnt = count($subjects);
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
            <table width=100% cellspacing=0 cellpadding=5 border=0>
              <tr>
                <td><b>Status</b></td>
                <td align=center><b>Active</b></td>
                <td><b>Options</b></td>
              </tr>
<?
        for ($i=0; $i<$subjectsCnt; $i++) {
?>        
              <tr>
                  <td><input type=text name=subject[<?=$subjects[$i]["id"];?>] size=50 maxlength=50 value="<?=$subjects[$i]["subject"]; ?>"></td>
                  <td align=center><input type=checkbox name=active[<?=$subjects[$i]["id"]?>] <?if ($subjects[$i]["active"] == 1) { echo " checked"; } ?>></td>
                  <td><a href="logSubjectMaint.php?d=<?=$subjects[$i]["id"]?>">Del</a></td>
              </tr>
<? } ?>
            </table>
          </div>
          </div>
          <div align=center>
          <div class="greyboxfooter" align=left>
            <table width=100% border=0 cellspacing=0 cellpadding=0>
              <tr>
                <td><b>Update Subjects</td><td align=right><input type=submit name="Update" value="Update"></td>
              </tr>
            </table>
          </div>
          </form>
<br>
        <form name="addStatusForm" action="" method="post">
        <div class=greyboxfooter>
          <table width=100% border=0 cellspacing=0 cellpadding=0>
            <tr>
              <td><b>Add New Subject:&nbsp;&nbsp;</b><input type=text size=50 maxlength=50 name=newSubject value=""></td>
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
