<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");

  if (!isset($_GET["st"])) {
    $_GET["st"]="A";
    $_GET["ed"]="H";
  }

  if (!isset($_GET["m"]) and !isset($_POST["m"]))  {
    header("location: MRCmaint.php?st=".$_GET["st"]."&ed=".$_GET["ed"]);
  }

  if (isset($_GET["m"])) { $m = $_GET["m"]; } else {$m = $_POST["m"];}

  if (isset($_POST["submit"])){
    $SQL = "insert into bucketLog set dateTime=now(),description='".$_POST["description"]."',amount='".$_POST["debcred"].$_POST["amount"]."',bucket_id='$m'";
    $insert = DoSQL($SQL, SQL_UPDATE);
    $SQL = "update bucket set balance=balance".$_POST["debcred"].$_POST["amount"]." where id=$m";
    $update = DoSQL($SQL, SQL_UPDATE);
  }

  $SQL = "select * from company left join bucket on (bucket.company_id=company.id) left join bucketLog on (bucketLog.bucket_id=bucket.id) where bucket.id='$m'";
  $bucketLog = DoSQL($SQL, SQL_SELECT);
//  dumpvar($bucketLog); exit;
  $bucketLogCnt = count($bucketLog);
  if ($bucketLogCnt == 0) {
    $SQL = "SELECT company.balance from bucket,company where bucket.id=$m and where bucket.company_id=company.id";
    $balance = DoSQL($SQL,SQL_SELECT);
  }

  $activetab = "admin";
  $titleString = "Account Log Page for ".$bucketLog[0]["name"]. " (Acct-".$m.")";

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
      <div id=right style="height:100%;">
        <form name=addEntry action="" method=post>
        <input type=hidden name="m" value="<?=$m?>">
        <table width=100% cellspacing=10 cellpadding=5>
          <tr>
            <td valign="top">
              <div align=center>
              <div class=greyboxheader>
                <table cellpadding=0 cellspacing=0 border=0 width=100%>
                  <tr>
                    <td><b><?=$titleString?></b></td>
                    <td align=right><b>BALANCE: $<?=$bucketLog[0]["balance"]?></b></td>
                  </tr>
                </table>
              </div>
              <div class=toplessgreybox align=left>
                <table width=100% cellspacing=0 cellpadding=5 border=0>
                  <tr>
                    <td><b>Date</b></td>
                    <td><b>Description</b></td>
                    <td><b>Amount</b></td>
                  </tr>
<?
  for ($i=0;$i<$bucketLogCnt;$i++){
?>
                  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
                    <td><?=$bucketLog[$i]["dateTime"]?></td>
                    <td><?=$bucketLog[$i]["description"]?></td>
                    <td><? if ($bucketLog[$i]["amount"] != null) { if ($bucketLog[$i]["amount"]<0) { printf("($%d)",abs($bucketLog[$i]["amount"])); } else { echo "$".$bucketLog[$i]["amount"]; }} ?></td>
                  </tr>
  
<? } ?>
                </table>
              </div>
              </div>
            </td>
          </tr>
          <tr>
            <td valign="top" align=center>
              <div class=greyboxfooter>
                <table width="100%" border="0" cellspacing="5" cellpadding="0">
                  <tr>
                    <td>
                      <select name="debcred">
                        <option value="+">Credit
                        <option value="-">Debit
                      </select>
                    </td>
                    <td>
                      <b>Description: </b>
                      <input type=text name=description size=50>
                    </td>
                    <td>
                      <b>Amount: </b><input type=text name=amount size=10>
                    </td>
                    <td align=right>
                     <input type=submit name=submit value="Add Log Entry">
                    </td>
        	       </tr>
                </table>
            </td>
          </tr>
        </table>

        </form>
      </div>
    </div>
  </div>
</body>
</html>




