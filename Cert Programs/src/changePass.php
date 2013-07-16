<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	$referer = $_SERVER["HTTP_REFERER"];
	
	$activetab = "testing";
	$titleString = "Change Password Page";

  if (isset($_GET["u"])) {
    $u = $_GET["u"];
  }

  if (isset($_POST["submit"])) {
    $u = $_POST["u"];
    $SQL = "select pass from user where id='$u'";
    $pass = DoSQL($SQL, SQL_SELECT);
    $oldPass = $pass[0]["pass"];
    if ($_POST["newPass"] == $_POST["confPass"] and $_POST["newPass"] != "" and $_POST[oldPass] == $oldPass) {
      $SQL = "update user set pass='$_POST[newPass]' where id='$u' and pass='$_POST[oldPass]'";
      $result = DoSQL($SQL, SQL_UPDATE);
      header("location: ".$_POST["referer"]);
    } else {
        $message = "<font color=red> - Password not changed.</font>";
        $referer = $_POST["referer"];
    }
  }

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title><?=$titleString?></title>
 
  <link rel="stylesheet" href="/graphics/main.css" type="text/css">
  <link rel="stylesheet" href="/graphics/menuExpandable3.css" type="text/css">
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
      <? include("header.php"); ?>
    </div>
  </div>
  <div id=middle>
    <div id=middle2>
      <div id=left>
        <? include("menu.php"); ?>
      </div>
      <div id=right>
		<!-- content should be in <p> tags to prevent the ie 3 pixel bug described on http://www.positioniseverything.net/explorer/threepxtest.html -->
		<? // i think for the index page i'll show every cert that the current user has access to ?>
        <br>
		<div align="center">
		<div align=left class="greyboxheader"><strong>
		  <?=$titleString.$message?>
		</strong></div>		
		<form name=changePass action="" method="POST">
		<input type=hidden name="u" value="<?=$u?>">
    <input type=hidden name="referer" value="<?=$referer?>">
		<div class="greybox">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td bgcolor="#2f6fab">
          <table width="100%"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td bgcolor="#f9f9f9">
              	<table width="100%" cellpadding="4" cellspacing="0" bgcolor="#f9f9f9">
                  <tr>
                    <td align=right>Old Password:</td><td><input type=password name=oldPass value="<?=$_POST["oldPass"]?>"></td>
                  </tr>
                  <tr>
                    <td align=right>New Password:</td><td><input type=password name=newPass value="<?=$_POST["newPass"]?>"></td>
                  </tr>
                  <tr>
                    <td align=right>Confirm Password:</td><td><input type=password name=confPass value="<?=$_POST["confPass"]?>"></td>
                  </tr>
            		</table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>		
		</div>
    <div class="greyboxfooter" align=left>
      <table width=100% border=0 cellspacing=0 cellpadding=0>
        <tr>
          <td><b>Change Password</td><td align=right><input type=submit name="submit" value="Save"></td>
        </tr>
      </table>
    </div>
    </form>
		<br>
		</div>
	  <br>	
    </div>
    </div>
  </div>
</body>
</html>
