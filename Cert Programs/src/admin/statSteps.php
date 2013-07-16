<?
  include_once("../inc/session.php");
  include_once("../cert_functions.php");
  $activetab = "admin";

  if (!isset($_GET[p]) and !isset($_POST[p])) {
        header("location: index.php");
  }

  if (isset($_GET[p])) {
    $p=$_GET[p];
  } else {
    $p=$_POST[p];
  }
  if (isset($_GET[s])) {
    $s=$_GET[s];
  } else {
    $s=$_POST[s];
  }
  
  if (isset($_POST["Save"])) {
    $stepIDs = split(":",$_POST["VAL"]);
    for ($i=0;$i<count($stepIDs)-1;$i++) {
      $j = $i+1;
      $SQL = "update step set orderIndex='$j' where id='$stepIDs[$i]'";
      DoSQL($SQL, SQL_UPDATE);
    }
    
    $SQL = "delete from statusSet where status_id='$s'";
    DoSQL($SQL,$SQL_UPDATE);

    for($i=0;$i<count($stepIDs)-1;$i++) {
      $SQL = "insert into statusSet set id='$s',step_id='$stepIDs[$i]',status_id='$s'";
      DoSQL($SQL, SQL_UPDATE);
    }
  }

  $prefix = GetPrefix($p);
  $program = $prefix[0]["prefix"];
  $statusSteps = GetStatusSteps($s);
  $statusStepsCnt = count($statusSteps);
  $otherStatusSteps = GetOtherStatusSteps($s, $p);
  $otherStatusStepsCnt = count($otherStatusSteps);
  $status = GetStatus($s);
  $titleString = "Status Steps for $program - ".$status[0]["name"];

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
  <head>
    <link rel="stylesheet" href="/graphics/main.css" type="text/css">
    <link rel="stylesheet" href="/graphics/menuExpandable3.css" type="text/css">
    <script type="text/javascript" src="../inc/listFunctions.js"></script>
    <script type="text/javascript">
    cookieName = 'adminopenMenus';
    </script>
    <script type="text/javascript" src="/graphics/menuExpandable3.js">
    </script>
    <!-- this needs to be the last css loaded -->
    <!--[if IE 6]>
          <link rel="stylesheet" href="graphics/ie6.css" type="text/css">
          <![endif]-->
    <!-- this needs to be the last css loaded -->
    </head>
  <body>
    <div id="leftfullheight">
      &nbsp;
    </div>
    <div id="top">
      <div id="header">
        <? include("../inc/header.php"); ?>
      </div>
    </div>
    <div id="middle">
      <div id="middle2">
        <div id="left">
          <? include("../inc/adminMenu.php"); ?>
        </div>
        <div id="right">
          <br>
          <form name="theForm" action="" method="post">
          <input type=hidden name=VAL value="">
          <input type=hidden name=p value="<?=$p?>">
          <input type=hidden name=s value="<?=$s?>">
            <div align="center">
              <div class=greyboxheader align=left>
                <b><?=$titleString?>
                </b>
              </div>
            </div>
            <div align="center">
              <div class="greybox">
                <table width="100%" cellspacing="0" cellpadding="5" border="0">
                  <tr>
                    <td align="center">
                      <select name="selectedSteps" size="10" style="width:100%;" multiple ondblclick="removeStepFromGroup()">
<?
                        for ($i=0; $i<$statusStepsCnt; $i++) {
?>
                        <option value="<?=$statusSteps[$i]["id"]?>">
                          <?=$statusSteps[$i]["name"]?>
                        </option>
<? } ?>
                      </select>
                    </td>
                    <td align="left">
                      <a href="javascript:moveSelectedItemUp(document.theForm.selectedSteps);" style="text-decoration:none;">&nbsp;<img src="/graphics/ASC.gif" border=0>&nbsp;</a><br><br>
                      <a href="javascript:moveSelectedItemDown(document.theForm.selectedSteps);" style="text-decoration:none;">&nbsp;<img src="/graphics/DESC.gif" border=0>&nbsp;</a>
                    </td>
                  </tr>
                  <tr>
                    <td align="center">
                      <a href="javascript:addStepToGroup();" style="text-decoration:none;">&nbsp;<img src="/graphics/ASC.gif" border=0>&nbsp;</a>&nbsp;&nbsp;
                      <a href="javascript:removeStepFromGroup();" style="text-decoration:none;">&nbsp;<img src="/graphics/DESC.gif" border=0>&nbsp;</a>
                    </td>
                    <td>
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td align="center">
                      <select name="availableSteps" size="10" style="width:100%;" multiple ondblclick="addStepToGroup()">
<?
                        for ($i=0; $i<$otherStatusStepsCnt; $i++) {
?>
                        <option value="<?=$otherStatusSteps[$i]["id"]?>">
                          <?=$otherStatusSteps[$i]["name"]?>
                        </option>
<? } ?>
                      </select>
                    </td>
                    <td>
                      &nbsp;
                    </td>
                  </tr>
                </table>
              </div>
            </div>
            <div align="center">
              <div class=greyboxfooter align="left">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td><b>Save Changes</b></td>
                    <td align="right"><input type="submit" name="Save" value="Save Status Steps" onclick="return selectEverything();">     </td>
                  </tr>
                </table>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </body>
</html>
