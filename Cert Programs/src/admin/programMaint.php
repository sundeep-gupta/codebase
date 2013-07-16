<?
	include_once("session.php");
	include_once("../cert_functions.php");
  $activetab = "admin";
  $titleString = "Program Maintenance";
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
  <link rel="stylesheet" href="/graphics/ie6.css" type="text/css">
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
      <div id=right>
      <?
			$programs = GetAllProgramsInfo();
			$programsCnt = count($programs);
      ?>
        <table width=100% cellspacing=10 cellpadding=5>
          <tr>
            <td valign="top">
              <div align=center>
              <div class=greyboxheader align=left>
                <b>Program Maintenance</b>
              </div>
              <div class=toplessgreybox>
                <table width=100% cellspacing=0 cellpadding=5 border=0>
                  <tr>
                    <td align=center><b>Active</b></td>
                    <td><b>Description</b></td>
                    <td><b>Options</b></td>
                  </tr>
          <?
                for ($i=0;$i<$programsCnt;$i++){
          ?>
                  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
                    <td align=center><input type=checkbox <? if ($programs[$i]["active"]==1) { echo "CHECKED ";} ?> disabled></td>
                    <td><?=$programs[$i]["programName"]?></td>
                    <td valign=top><a href="editProg.php?pid=<?=$programs[$i]["id"]?>">Edit</a>&nbsp;|&nbsp;<a href="editMTA.php?pid=<?=$programs[$i]["id"]?>">MTA</a></td>
                  </tr>
          <? } ?>
                </table>
              </div>
              </div>
            </td>
          </tr>
          <tr>
            <td valign="top" align=center>
              <div class=greyboxheader>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width=25%><strong>Add New Program</strong></td>
                    <td width=15%>
                      <div align="right">
                        <input name="Button" type="button" onClick="window.location.href='editProg.php?pid=0'" value="Add Program">
                      </div>
                    </td>
                  </tr>
                </table>
            </td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</body>
</html>
