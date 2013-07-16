<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");
  $activetab = "admin";

  if (!isset($_GET[e]) and !isset($_POST[e])) {
  	header("location: index.php");
  }
  if (isset($_GET[e])) {
    $e = $_GET[e];
    $p = $_GET[p];
  } else {
    if (isset($_POST[e])) {
      $e = $_POST[e];
	  $p = $_POST[p];
	  $pid = $_POST[pid];
    }
  }
  if (isset($_POST[submit])) {
  	if ($_POST[e]!=0) {
  		$SQL = "UPDATE email set body='".$_POST[body]."',subject='".$_POST[subject]."',description='".$_POST[description]."' WHERE id='$e'";
	  	$results = DoSQL($SQL, SQL_UPDATE);
  	} else {
  		$SQL = "INSERT into email set body='".$_POST[body]."',subject='".$_POST[subject]."',description='".$_POST[description]."',active='1'";
  		$insert = DoSQL($SQL, SQL_UPDATE);
  		$SQL = "INSERT into emailPrefix set prefix_id='$p',email_id='$insert'";
  		$insert2 = DoSQL($SQL, SQL_UPDATE);
  	}
  	header("location: emailMaint.php?p=$p");
  }
  if ($p==0){ $prefix[0]["prefix"]="System"; } else { $prefix = GetPrefix($p); }
  if ($e!=0) {
    $titleString = "Edit Email for ".$prefix[0]["prefix"];    
    $footString = "Save Email";
  	$SQL = "SELECT * FROM email WHERE id='$e'";
	$email = DoSQL($SQL,SQL_SELECT);
  } else {
  	$titleString = "Add Email for ".$prefix[0]["prefix"];
  	$footString = "Add Email";
  }
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
      <div id=right>
      	<br>
        <form name=addEmail action="" method=post>
        <input type=hidden name=e value="<?=$e?>">
        <input type=hidden name=p value="<?=$p?>">
        <input type=hidden name=pid value="<?=$pid?>">
      <div align=center>
      <div class=greyboxheader>
        <b><?=$titleString?></b>
      </div>
      </div>
      <div align=center>
	      <div class=greybox align=left>
	        <table width=100% cellspacing=0 cellpadding=5 border=0>
	          	<td valign=top>
	             <b>Subject:</b><br>
	             <input type=text name=subject value="<?=$email[0][subject]?>" size=50><br><br>
	          	 <b>Body:</b><br>
	             <textarea name=body cols=75 rows=15><?=$email[0][body]?></textarea><br><br>
	          	 <b>Description:</b><br>
	             <textarea name=description cols=75 rows=3><?=$email[0][description]?></textarea><br><br>
	            </td>
		       </tr>
	        </table>
	      </div>
      </div>
      <div class=greyboxfooter>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          	<td>
          		<b><?= $footString;?></b>
      		</td>
          	<td align=right>
             <input type=submit name=submit value="<?=$footString?>">
            </td>
	       </tr>
        </table>
      </div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>
