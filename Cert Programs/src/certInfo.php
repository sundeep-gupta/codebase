<?
	include_once("session.php");
	include_once("cert_functions.php");

  if (!isset($_GET["ppl"])) {
  	header("location: index.php");
  }
  $fields = GetCert($_GET["ppl"]);
  
  $titleString = "Cert Info Page for ".$fields[0]["certName"];
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
          <td><strong>Cert Info for <? echo $fields[0]["certName"]; ?></strong></td>
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
		
		<table width="100%" cellpadding="0" cellspacing="0" bgcolor="#f9f9f9">
			<tr bgcolor="#E4E4E4">
				<td>




    	<table width="100%" cellpadding="4" cellspacing="0">
    	  <tr>
            <td class=list colspan=2><b>Basic Information</b></td>
          </tr>
    	  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
            <td class=list width=300px>Cert Name</td>
            <td class=list><?= $fields[0]["certName"] ?></td>
          </tr>
    	  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
            <td class=list>Registration Date/Time</td>
            <td class=list><?= $fields[0]["registeredDate"]; ?></td>
          </tr>
    	  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Company</td>
    				<td class=list><?= $fields[0]["company"]; ?></td>
          </tr>
    			<tr>
    			   <td class=list colspan=2><b>Submission Contact</b></td>
    			</tr>
    	  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Submission Contact Name</td>
					  <td class=list id="Submission Name"><?php echo $fields[0]["subName"]; ?></td>
          </tr>
					<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
						<td class=list>Submission Contact Email</td>
						<td class=list id="Submission Email"><?php echo $fields[0]["subEmail"]; ?></td>
          </tr>
					<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
						<td class=list>Submission Contact Phone</td>
            <td class=list id="Submission Phone"><?php echo $fields[0]["subPhone"]; ?></td>
          </tr>
    			<tr>
    				<td class=list colspan=2><b>Technical Contact</b></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Technical Contact Name</td>
            <td class=list id="Technical Contact Name"><?= $fields[0]["techName"]; ?></td>
          </tr>
					<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
						<td class=list>Technical Contact Email</td>
						<td class=list><?= $fields[0]["techEmail"]; ?></td>
					</tr>
					<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
						<td class=list>Technical Contact Phone</td>
						<td class=list id="Submission Phone"><?= $fields[0]["techPhone"]; ?></td>
          </tr>
    			<tr>
    				<td class=list colspan=2><b>Miscellaneous</b></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>KeyLabs SKU</td>
    				<td class=list><?= $fields[0]["description"]; ?></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Payment Method</td>
    				<td class=list><?= $fields[0]["method"]; ?></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Product Name</td>
    				<td class=list><?= $fields[0]["productName"]; ?></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Product Version</td>
    				<td class=list><?= $fields[0]["productVersion"]; ?></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Timeframe</td>
    				<td class=list><?= $fields[0]["timeframe"]; ?></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Status</td>
    				<td class=list><?= $fields[0]["status"]; ?></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Comments</td>
    				<td class=list><?= $fields[0]["comment"]; ?></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Engineer Name</td>
    				<td class=list><?= $fields[0]["engName"]; ?></td>
    			</tr>
    			<tr  onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Scheduled Start Date <font size=-2>(yyyy-mm-dd)</font></td>
    				<td class=list><?= $fields[0]["schedStartDate"]; ?></td>
    			</tr>
    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
    				<td class=list>Estimated Duration <font size=-2>(in Days)</font></td>
    				<td class=list><?= $fields[0]["estDuration"]; ?></td>
    			</tr>
    			<tr>
    			    <td class=list colspan=2><b>Platforms</b></td>
				</tr>
				<tr class=list>
					<td class=list colspan=2  style="padding: 0px; margin: 0px">
						<table class=list style="width: 100%;" cellpadding="4" cellspacing="0">
						<?
						    $platforms = GetPPLPlatforms($_GET["ppl"]);
						    $platformscnt = count($platforms);
						    if ($platformscnt > 0) {
						        print("");
						        for($x=0;$x<$platformscnt;$x++)
						            printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\"><td class=list style=\"text-align: left\">%s</td></tr>",
						                    $platforms[$x]["name"].", ".$platforms[$x]["version"]);
						    } else {
						        print("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\"><td class=listnone>None</td></tr>");
						    }
						?>
						</table>
					</td>
				</tr>
			<tr>
				<td class=list colspan=2><b>Files</b></td>
			</tr>
			<tr>
			    <td colspan=2 style="padding: 0px; margin: 0px">
			        <table class=list id=fileTable style="width: 100%" cellpadding="4" cellspacing="0">
					<?
						$files = GetPPLFiles($fields[0]["id"]);
						$filescnt = count($files);
						if ($filescnt > 0) {
						    for($x=0;$x<$filescnt;$x++)
					            printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\"><td class=list style=\"text-align: left\"><a href=getFile.php?ppl=%d&getid=%d>%s</a></td></tr>",
										$_GET["ppl"], $files[$x]["id"], $files[$x]["description"]);
						} else {
						    print("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\"><td class=listnone colspan=2>None</td></tr>");
						}
					?>
					</table>
				</td>
			</tr>

    			</form>
    			</table>
    			</center>
    		</table>


		  
		  
		    </td>
		  </tr>
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
