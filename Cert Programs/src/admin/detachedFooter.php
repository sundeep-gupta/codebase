<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");
  $activetab = "admin";
  $titleString = "TitleString";
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
      <br>
      <div id=right align=center>
        <div class=greyboxheader align=left>
          <b><?=$titleString?></b>
        </div>
        <div align=center>
          <div class=toplessgreybox>
            <table width=100% cellspacing=0 cellpadding=5 border=0>
              <tr>
                <td align=center>Content</td>
              </tr>
            </table>
          </div><br>
          <div class=greyboxfooter>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width=25%><b>Footer</b></td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
