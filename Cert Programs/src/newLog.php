<?
	include_once("session.php");
	include_once("cert_functions.php");

	if (!isset($_GET["ppl"]) || !isset($_SESSION["Certs"][$_GET["ppl"]]) || !isset($_SESSION["Permissions"]["KeyLabs"]))
	    header("location: index.php");
	
	if (isset($_POST["comment"])) {
	    AddLog($_GET["ppl"], $_POST["comment"], $_POST["subject"]);
		header("location: certLog.php?ppl=".$_GET["ppl"]);
	}

	$fields = GetCert($_GET["ppl"]);
	$subjects = GetLogSubjects();
	$subjectscnt = count($subjects);

	$titleString = "Add Log Entry for ".$fields[0]["certName"];
	$activetab = "testing";
  
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>KeyLabs Certification System</title>
  <link rel="stylesheet" href="graphics/main.css" type="text/css">
  <link rel="stylesheet" href="graphics/menuExpandable3.css" type="text/css">
  <script src="graphics/menuExpandable3.js"></script>
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
			<form name="addCommentForm" action="" method="post">
		    <input type=hidden name=user_id value="<? echo $_SESSION[id]; ?>">
		    <input type=hidden name=ppl value="<?=$_GET["ppl"]?>">		
		<div align="center">
		<div align=left class="greyboxheader">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
		    <tr>
          <td><strong>New Log Entry for <? echo $fields[0]["certName"]; ?></strong></td>
          <td align=right><?include("certMenu.php");?></td>
        </tr>
      </table>
    </div>		
		
		<div class="greybox">
			<table width="100%"  border="0" cellspacing="2" cellpadding="2">
			  <tr>
				<td width="20%"><div align="right">Subject: </div></td>
				<td width="80%">
							<select name=subject>
							   <?
								for($x=0;$x<$subjectscnt;$x++)
								 printf("<option value=%d>%s", $subjects[$x]["id"], $subjects[$x]["subject"]);
							   ?>
							</select>		
				</td>
			  </tr>
			  <tr>
				<td valign="top"><div align="right">Log Entry: </div></td>
				<td><textarea name=comment rows=15 cols=60></textarea></td>
			  </tr>
			</table>
		</div>
		<div align=right class="greyboxheader"><div align="right"><input type=submit name=submit value="Add Comment to Log"></div></div>
		</div>
		
	</form>	
	<br>			  
		  
		  
		  
      </div>
    </div>
  </div>
</body>
</html>
