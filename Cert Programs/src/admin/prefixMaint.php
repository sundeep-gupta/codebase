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
    foreach($_POST["prefix"] as $key => $value) {
      $SQL = "update prefix set prefix='$value' where id='$key'";
      DoSQL($SQL, SQL_UPDATE);
      $SQL = "update permission set description='Permission for $value' where substring(permission,8)='$key'";
      DoSQL($SQL, SQL_UPDATE);
    }
  }

  $titleString = "Prefix Maintenance";
  $SQL = "select distinct prefix.id,prefix.prefix,prefix.number,program.programName from prefix left join priceList on (prefix.id=priceList.prefix_id) left join program on (priceList.program_id=program.id) order by programName";
  $prefixes2 = DoSQL($SQL, SQL_SELECT);
  $prefixes2cnt = count($prefixes2);
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
                <td><b>Prefix</b></td>
                <td><b>Program Name</b></td>
                <td><b>Count</b></td>
              </tr>
<?
        for ($i=0; $i<$prefixes2cnt; $i++) {
?>        
              <tr>
                  <td><input type=text name=prefix[<?=$prefixes2[$i]["id"];?>] size=50 maxlength=50 value="<?=$prefixes2[$i]["prefix"]; ?>"></td>
                  <td><? if ($prefixes2[$i]["programName"]=="") { echo "* not assigned to an SKU"; } else {echo $prefixes2[$i]["programName"];}?></td>
                  <td><?=$prefixes2[$i]["number"]?></td>
              </tr>
<? } ?>
            </table>
          </div>
          </div>
          <div align=center>
          <div class="greyboxfooter" align=left>
            <table width=100% border=0 cellspacing=0 cellpadding=0>
              <tr>
                <td><b>Update Prefixes</td><td align=right><input type=submit name="Update" value="Update"></td>
              </tr>
            </table>
          </div>
          </form>
<br>
        <form name="addStatusForm" action="" method="post">
        <div class=greyboxfooter>
          <table width=100% border=0 cellspacing=0 cellpadding=0>
            <tr>
              <td><b>Add New Prefix:&nbsp;&nbsp;</b><input type=text size=50 maxlength=50 name=newPrefix value=""></td>
              <td align=right><input type=submit name=submit value="Add"></td>
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
