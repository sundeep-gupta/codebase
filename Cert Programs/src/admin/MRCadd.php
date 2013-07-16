<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");
  $activetab = "admin";

  if (isset($_POST["Add"])) {
    $SQL = "insert into bucket (company_id,balance,hourlyRate,description,comment,active) values('$_POST[company_id]','0','$_POST[hourlyRate]','$_POST[description]','$_POST[comment]','1')";
    $response = DoSQL($SQL, SQL_UPDATE);
    header("location: MRCmaint.php?st=".$_POST["st"]."&ed=".$_POST["ed"]);
  }


  $titleString = "Add Account";
  $SQL = "select id,name from company ORDER by name";
  $company = DoSQL($SQL, SQL_SELECT);
  $companyCnt = count($company);
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
        <input type=hidden name=st value="<?=$_GET["st"]?>">
        <input type=hidden name=ed value="<?=$_GET["ed"]?>">
        <div align=center>
          <div class=greyboxheader align=left>
            <b><?=$titleString?></b>
          </div>
        </div>
        <div align=center>
          <div class=greybox>
          <div class=whitebox>
          The company must first exist.<br><br>
          After creating the account you will need to make an initial credit/deposit.
          </div>
<br>
            <table width=100% cellspacing=0 cellpadding=5 border=0>
              <tr>
                <td><b>Company: </b></td>
                <td>
                  <select name=company_id>
<?
  for ($i=0;$i<$companyCnt;$i++) {
?>
                    <option value="<?=$company[$i]["id"]?>"><?=$company[$i]["name"]?>
<? } ?>
                  </select>
                </td>
              </tr>
              <tr>
                <td><b>Hourly Rate: </b></td>
                <td><input type=text name=hourlyRate size=10></td>
              </tr>
              <tr>
                <td><b>Description</b></td>
                <td><input type=text name=description size=50></td>
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
                <td><b>Add Account</td><td align=right><input type=submit name="Add" value="Add MRC"></td>
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
