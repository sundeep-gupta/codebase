<?
	include_once("session.php");
	include_once("cert_functions.php");
	
 	if (isset($_POST["schedStartDate"])) {
 	  if (isset($_POST["e"])) {
      $SQL = "UPDATE event SET schedStartDate='".$_POST["schedStartDate"]."',estDuration='".$_POST["estDuration"]."',description='".$_POST["description"]."' where id='".$_POST["e"]."'"; 
    } else {
      $SQL = "INSERT into event SET schedStartDate='".$_POST["schedStartDate"]."',estDuration='".$_POST["estDuration"]."',description='".$_POST["description"]."'";
    }
 		DoSQL($SQL, SQL_UPDATE, 1, false);
 		header("location: ".$_POST["referer"]);
 	}
	
	if (!isset($_GET["e"])) {
		$func = "Add";
	} else {
	    $func = "Edit";
	    $e = $_GET["e"];
	    $SQL = "select * from event where id='$e'";
	    $event = DoSQL($SQL, SQL_SELECT);
	}
	$titleString = $func." Event Page";
	$activetab = "admin";
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>KeyLabs Certification System</title>
 
  <link rel="stylesheet" href="../graphics/main.css" type="text/css">
  <link rel="stylesheet" href="../graphics/menuExpandable3.css" type="text/css">
  <script type="text/javascript">
  cookieName = 'adminopenMenus';
  </script>
  <SCRIPT LANGUAGE="JavaScript">
<!-- Start Hiding the Script

function telluser() {
  if (document.form.schedStartDate.value.length == 10 && document.form.estDuration.value.length > 0 && document.form.description.value.length > 0) {
        return true;
  }
  else {
        alert("Please complete all fields.");
        return false;
  }
}

// Stop Hiding script --->
</SCRIPT>
  <script src="../graphics/menuExpandable3.js"></script>
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
  <div id=middle style="width:100%">
    <div id=middle2>
      <div id=left>
        <? include("adminMenu.php"); ?>
      </div>
	<div id=right>
		<!-- content should be in <p> tags to prevent the ie 3 pixel bug described on http://www.positioniseverything.net/explorer/threepxtest.html -->
		<br>
		<table width="100%"  border="0" cellspacing="10" cellpadding="5">
			<tr>
				<td width="50%" valign="top">
					<form action="" method="post" name="form" onSubmit="return telluser();">
					<? if (isset($e)) { echo "<input type=hidden name=e value=$e>"; } ?> 
					<input type=hidden name=referer value="<?=$_SERVER["HTTP_REFERER"]?>">
						<div align="center">
							<div align=left class="greyboxheader"><strong><?=$titleString?></strong></div>
						</div>

						<div align="center">
							<div class="greybox">
								<div align="left">
									<div class="whitebox"><?=($func == "Add") ? "Add a new event: Allows you to add a new event to the calendar system." : "Edit an event: Allows you to edit an event."?></div>
								</div>
								<p>
								<table width="100%"  border="0" cellspacing="2" cellpadding="0">
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="20%"><div align="right"><strong>Start Date:</strong></div></td>
										<td width="80%"><input type="text" name="schedStartDate" value="<?=$event[0]["schedStartDate"]?>"> (YYYY-MM-DD)</td>
									</tr>
									<tr>
										<td><div align="right"><strong>Duration:</strong></div></td>
										<td><input name="estDuration" type="text" value="<?=$event[0]["estDuration"]?>"> (days)</td>
									</tr>
									<tr>
										<td><div align="right"><strong>Description:</strong></div></td>
										<td><input name="description" type="text" size="70" value="<?=$event[0]["description"]?>"></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
								</table>
								</p>
							</div>
						</div>

						<div align=center>
							<div class="greyboxfooter" align=left>
								<table width="100%"  border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
											<div align="left">
												<input name="Cancel" type="submit" value="Cancel">
											</div>
										</td>
										<td>
											<div align="right">
												<input type="submit" name="submit" value="Save Event">
											</div>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</form>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
