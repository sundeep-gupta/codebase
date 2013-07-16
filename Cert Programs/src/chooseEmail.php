<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	if (!isset($_GET["ppl"]) || !isset($_SESSION["Certs"][$_GET["ppl"]]) || !isset($_SESSION["Permissions"]["KeyLabs"])) {
	    header("location: index.php");
	}
	
	$certName = GetCert($_GET["ppl"]);
	$ppl = $_GET["ppl"];

  $SQL = "select prefix.id from prefix, priceList, productPriceList where productPriceList.id='$ppl' and productPriceList.priceList_id=priceList.id and priceList.prefix_id=prefix.id";
  $prefixID = DoSQL($SQL, SQL_SELECT);
  $SQL = "select email.* 
          from email, emailPrefix
          where emailPrefix.prefix_id='" . $prefixID[0]["id"] . "'
          and emailPrefix.email_id=email.id";

  $fields = DoSQL($SQL, SQL_SELECT);
  $emailCnt = count($fields);

	$titleString = "Send Email Page for ".$certName[0]["certName"];
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
		<div align="center">
		<div align=left class="greyboxheader">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
		    <tr>
          <td><strong>Choose Email for <? echo $certName[0]["certName"]; ?></strong></td>
          <td align=right><?include("certMenu.php");?></td>
        </tr>
      </table>
    </div>		
		
		<div class="toplessgreybox">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#f9f9f9"><table width="100%"  border="0" cellspacing="1" cellpadding="0">
      <tr>
        <td bgcolor="#f9f9f9">
		
		<table width="100%" cellpadding="4" cellspacing="0" bgcolor="#f9f9f9">
			<tr bgcolor="#E4E4E4">
				<td class=list><b>Subject</b></td>
				<td><b>Description</b></td>
				<td class=list><b>Option</b></td>
			</tr>

          <? if ($emailCnt > 0) {
					   for($x=0;$x<$emailCnt;$x++)
					    printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\"><td class=list>%s</td><td class=list>%s</td><td class=list><a href=\"sendEmail.php?ppl=" .$_GET["ppl"] ."&eid=%s\">Send</a></td></tr>", $fields[$x]["subject"], $fields[$x]["description"], $fields[$x]["id"]);
    				} else {
		  		    	printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\"><td class=listnone colspan=3>None</td></tr>");
				    }
          ?>
		</table>
		
</td>
      </tr>
    </table></td>
  </tr>
</table>		

		
		</div>
		<br>
		</div>
	<br>		  
	  
	  
	  </div>
    </div>
  </div>
</body>
</html>
