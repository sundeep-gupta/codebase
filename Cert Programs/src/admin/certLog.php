<?
	include_once("session.php");
	include_once("cert_functions.php");
	

  if (isset($_GET[ppl])) { $ppl = $_GET[ppl];}
	$logs = GetCertLogs2($ppl);
	$logscnt = count($logs);
  $SQL = "SELECT CONCAT(prefix.prefix, '-', productPriceList.number) AS certName 
          FROM 
          prefix, 
          productPriceList, 
          priceList 
          WHERE 
          productPriceList.id='$ppl' 
          AND productPriceList.priceList_id=priceList.id 
          AND priceList.prefix_id=prefix.id";
  $fields = DoSQL($SQL, SQL_SELECT);

	$titleString = "Cert System Log";
	$activetab = "admin";

	$SQL = "SELECT bucket.* from bucket,productPriceList,product where productPriceList.id='$ppl' and productPriceList.product_id=product.id and product.company_id=bucket.company_id and bucket.active='1' order by bucket.id";
	$buckets = DoSQL($SQL, SQL_SELECT);
	$bucketsCnt = count($buckets);
  
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>KeyLabs Certification System</title>
 
  <link rel="stylesheet" href="/graphics/main.css" type="text/css">
  <link rel="stylesheet" href="/graphics/menuExpandable3.css" type="text/css">
  <script src="/graphics/menuExpandable3.js"></script>
  <script type="text/javascript">
  cookieName = 'adminopenMenus';
  </script>
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
        <? include("../inc/adminMenu.php"); ?>
      </div>
      <div id=right>
		<!-- content should be in <p> tags to prevent the ie 3 pixel bug described on http://www.positioniseverything.net/explorer/threepxtest.html -->
		<? // i think for the index page i'll show every cert that the current user has access to ?>
    <br>
		<div align="center">
		<div align=left class="greyboxheader">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
		    <tr>
          <td><strong>System Log</strong></td>
          <td align=right>&nbsp;</td>
        </tr>
      </table>
      
    </div>		
		
		<div class="toplessgreybox">
<?	if ($bucketsCnt>0) { ?>
		<table width="100%" border=0 cellspacing="0" cellpadding="3">
			  <tr bgcolor="#E4E4E4">
			  	<td><b>Acct #</b></td><td><b>Description</b></td><td><b>Balance</b></td>
			  </tr>
<? 		for ($i=0;$i<$bucketsCnt;$i++) { ?>
			  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#E4E7DD'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
			  	<td>Acct-<?=$buckets[$i]["id"]?></td>
			  	<td><?=$buckets[$i]["description"]?></td>
			  	<td>$&nbsp;&nbsp;<?=$buckets[$i]["balance"]?></td>
		  	  </tr>
<? 		} ?>
		</table> 
<?	}?>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td><table width="100%"  border="0" cellspacing="1" cellpadding="0">
				  <tr>
					<td bgcolor="#f9f9f9">
					
					<table width="100%" cellpadding="4" cellspacing="0" bgcolor="#f9f9f9">
			
					  <? if ($logscnt > 0) {
								   for($x=0;$x<$logscnt;$x++)
  									printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\"><td class=list colspan=2><pre><u>Subject:</u> %s</pre><p>%s</p><pre><i>Entry by %s on %s</i></pre></td></tr>", $logs[$x]["subject"], $logs[$x]["comment"], $logs[$x]["name"], $logs[$x]["entryTime"]);
								} else {
									printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\"><td class=listnone colspan=2>None</td></tr>");
								}
								
/*
								   for($x=0;$x<$logscnt;$x++)
									printf("<tr class=list><td class=list colspan=2><pre><u>Subject:</u> %s<br>%s<br><i>Entry by %s on %s</i></pre></td></tr>", $logs[$x]["subject"], $logs[$x]["comment"], $logs[$x]["name"], $logs[$x]["entryTime"]);
								} else {
									printf("<tr class=list><td class=listnone colspan=2>None</td></tr>");
								}
*/								
								
					  ?>
<!--					  
<tr height="100%" onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#ffff00'" onMouseOut="this.bgColor=this.oldbgcolor" onClick="ClickPort(this)" bgcolor="#ffffff"> 					  
-->					  
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
