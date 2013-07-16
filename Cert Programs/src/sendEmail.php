<?
	include_once("session.php");
	include_once("cert_functions.php");

	if (!isset($_GET["ppl"]) || !isset($_GET["eid"]) ||
	    !isset($_SESSION["Certs"][$_GET["ppl"]]) || !isset($_SESSION["Permissions"]["KeyLabs"]))
	    header("location: index.php");

	if (isset($_POST["eid"])) {
	    $Headers["Subject"] = $_POST["subject"];
	    $Headers["From"] = FROM_ADDRESS;
	    //generate the to string
	    $to = '';
	    foreach($_POST["email"] as $key => $value) {
	        $to.=$key.",";
	    }
	    SendMail(substr($to, 0, -1), $Headers, $_POST["body"], 0, 0);

// Determine which program the cert is for
    $SQL = "select program.id
            from program, productPriceList,priceList
            where productPriceList.id='".$_GET["ppl"]."'
            and productPriceList.priceList_id=priceList.id
            and priceList.program_id=program.id";
    $programID = DoSQL($SQL);

// Only for Cisco
// Send email to the Cisco Partner Managers and so forth...ugggh
   $SQL = "select program.sponsorCompany_id
           from program,priceList,productPriceList
           where productPriceList.priceList_id = priceList.id
           and priceList.program_id = program.id
           and productPriceList.id = '".$_GET["ppl"]."'";
    $sponsorCompanyID = DoSQL($SQL);
  //Check to see if this is for a cert from a Cisco program
  //Cisco company ID from sponsorCompany table is 1
  //Check to see if the program is CCX or ICM
  //CCX is program 6 and ICM is program 9
    if ($sponsorCompanyID[0]["sponsorCompany_id"] == '1' and $programID[0][id] != '6' and $programID[0][id] != '9') {
      //Get partnermanager emails
      $SQL="SELECT email FROM user, userProductPriceList WHERE user.id=userProductPriceList.user_id
    	 AND user.name='Cisco Partner Manager' AND userProductPriceList.productPriceList_id='".
    	 $_GET["ppl"]."'";
    
    		$res = DoSQL($SQL);
    		if (count($res)>0 ){
          $rescnt = count($res);
      		$partnermanagers = array();
      		for($x=0;$x<$rescnt;$x++) {
      			$partnermanagers[] = $res[$x]["email"];
      		}
          $partnerManagersEmails = implode(",", $partnermanagers) . ",";
        }
      //Get cisco tech alias for the program
      //gotta get prefix first:
      $SQL = "select priceList.prefix_id
              from productPriceList,priceList
              where productPriceList.id='".$_GET["ppl"]."' AND productPriceList.priceList_id=priceList.id";
      $tempPrefix = DoSQL($SQL);
              
      $SQL = "SELECT email 
              FROM user,userPermission,permission 
              WHERE userPermission.permission_id=permission.id 
              AND userPermission.user_id=user.id 
              AND permission.permission='prefix-".$tempPrefix[0]["prefix_id"]."' AND name = 'Cisco Tech Alias'";
      $techAlias = DoSQL($SQL);
      $to = $partnerManagersEmails . $techAlias[0]["email"] . ",ctd_program_coordinator@cisco.com";
//      $to = "rich@keylabs.com,dcoombs@keylabs.com,trichards@keylabs.com";
      $Headers["Subject"] = "FYI: " . $_POST["subject"];
      $body = "THIS IS A COPY OF WHAT THE CISCO TECHNOLOGY DEVELOPER PROGRAM PARTICIPANT HAS RECEIVED AND IS FOR YOUR INFORMATION ONLY.  NO ACTION IS REQUIRED.\r\n============================================\r\n" .
              $_POST["body"];

	    SendMail($to, $Headers, $body, 0, 0);
    }
		AddLog($_GET["ppl"], "Subject: ".$_POST["subject"]." was sent to ".substr($to,0,-1));
		header("location: certLog.php?ppl=".$_GET["ppl"]);
    }

	$cert = GetCert($_GET["ppl"]);
	$email = GetEmail($_GET["eid"]);

	$titleString = "Send Email ".$cert[0]["certName"];
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
  
<script type="text/javascript">
	//this function's sole purpose is to enable the disabled checkboxes so that the
	//  browser will send them through.  firefox won't send checkboxes that are disabled
	//  so we enable them here
	function formsubmit() {
		frm = window.document.forms[0];
		frmlen = frm.elements.length;
		for(var x=0;x<frmlen;x++) {
		    if (frm.elements[x].disabled)
		        frm.elements[x].disabled = false;
		}
		return true;
	}
</script>
  
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
      	<form name="sendEmailForm" action="" method="post" onsubmit="return formsubmit();">
		    <input type=hidden name=eid value="<?=$_GET["eid"]?>">
		<div align="center">
		<div align=left class="greyboxheader">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
				<tr>
			  <td><strong>Send Email for <span class="list"><b>
			    <?= $cert[0]["certName"] ?>
			  </b></span></strong></td>
			  <td align=right><?include("certMenu.php");?></td>
			</tr>
		  </table>      
    	</div> <!-- Close Grey Box Header -->
    <div class="greybox">
    
	<table width=100% border=0 cellspacing=0 cellpadding=0>
    <tr>
      <td bgcolor="#f9f9f9">
	  
	  <table width="100%"  border="0" cellspacing="1" cellpadding="0">
        <tr>
		  <td>
    

    		    <input type=hidden name=productID value=<?=$cert[0]["productID"]?>>
	    		
		<table width="100%" cellpadding="0" cellspacing="0" bgcolor="#f9f9f9">
			<tr bgcolor="#E4E4E4">
				<td>				
				<!-- NEED TO RETRIEVE ALL THE INTERESTING POTENTIAL RECIPIENTS FOR SPECIFIC PPL -->
				<?
					//first find the main contacts for the cert
					$main = GetMainContacts($_GET["ppl"]);
					
					//next find any prefixUsers
					$prefixusers = GetPrefixUsers($cert[0]["prefixID"]);
          $prefixusercnt = count($prefixusers);

					//last find any other misc users
					//$miscusers = GetMiscUsers($_GET["ppl"]);
					
					//$rest = array_merge($progusers, $miscusers);
					$rest = GetMiscUser($_GET["ppl"]);
					$restcnt = count($rest);
				?>				
					<table cellpadding="4" cellspacing="0" width="100%">
					  <tr>
						<td class=list colspan=2 width=300><b>Testing Recipients</b></td>
					  </tr>
					  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
						<td class=list width=300>Submission Contact</td>
						<td class=list><input type=checkbox name=email[<?=$main[0]["submissionEmail"]?>]><?=$main[0]["submissionName"]?>&nbsp;(<?=$main[0]["submissionEmail"]?>)</td>
					  </tr>
					  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
						<td class=list>Technical Contact</td>
						<td class=list><input type=checkbox name=email[<?=$main[0]["technicalEmail"]?>]><?=$main[0]["technicalName"]?>&nbsp;(<?=$main[0]["technicalEmail"]?>)</td>
					  </tr>
					  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
						<td class=list>Engineer Contact</td>
						<td class=list><input type=checkbox name=email[<?=$main[0]["engineerEmail"]?>]><?=$main[0]["engineerName"]?>&nbsp;(<?=$main[0]["engineerEmail"]?>)</td>
					  </tr>
					  <tr>
						<td class=list colspan=2 width=300><b>Additional Program Recipients</b></td>
					  </tr>
						<?
						    if ($prefixusercnt > 0) {
  								//now print out the rest of the users in pairs
  								for($x=0;$x<$prefixusercnt;$x+=2) {
  									printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\">");
  									if (isset($prefixusers[$x]["email"])) {
  								    printf("<td class=list><input type=checkbox name=email[%s]>%s&nbsp;(%s)</td>", 
  											$prefixusers[$x]["email"], $prefixusers[$x]["name"], $prefixusers[$x]["email"]);
                    } else { echo "<td>&nbsp;</td>"; }
                    if (isset($prefixusers[$x+1]["email"])) {
                      printf("<td class=list><input type=checkbox name=email[%s]>%s&nbsp;(%s)</td></tr>",
  											$prefixusers[$x+1]["email"], $prefixusers[$x+1]["name"], $prefixusers[$x+1]["email"]);
  								  } else { echo "<td>&nbsp;</td></tr>";}
  								}
//   								if ($x!=$prefixusercnt) {
//   									printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\">
//   												<td class=list><input type=checkbox name=email[%s]%s>%s&nbsp;(%s)</td>
//   												<td class=list>&nbsp;</td>
//   											</tr>",
//   											$rest[$x]["email"], ($rest[$x]["mandatory"] == 1) ? " checked disabled" : "", $rest[$x]["name"], $rest[$x]["email"]);
//   								}
						    }
						?>
						<?
						    if ($restcnt > 0) {
  								//now print out the rest of the users in pairs
  								echo "<tr><td><b>Other Recipients</b></td><td>&nbsp;</td></tr>";
  								for($x=0;$x<$restcnt;$x+=2) {
  									printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\">");
  									if (isset($rest[$x]["email"])) {
  								    printf("<td class=list><input type=checkbox name=email[%s]>%s&nbsp;(%s)</td>", 
  											$rest[$x]["email"], $rest[$x]["name"], $rest[$x]["email"]);
                    } else { echo "<td>&nbsp;</td>"; }
                    if (isset($rest[$x+1]["email"])) {
                      printf("<td class=list><input type=checkbox name=email[%s]>%s&nbsp;(%s)</td></tr>",
  											$rest[$x+1]["email"], $rest[$x+1]["name"], $rest[$x+1]["email"]);
  								  } else { echo "<td>&nbsp;</td></tr>";}
  								}
						    }
						?>
	    			</table>
					<table cellpadding="4" cellspacing="0" width="100%">
					  <tr>
						<td width=300 colspan=2 class=list><strong>Message Information</strong></td>
					  </tr>
					  <tr bgcolor="#f9f9f9">
						<td class=list width=300 align=right><b>Subject:</b></td>
						<td class=list><input type=text name=subject size=60 value="<?= ParseEmail($cert[0], $email[0]["subject"]); ?>"></td>
					  </tr>
					  <tr bgcolor="#f9f9f9">
						<td valign="top" class=list align=right><b>Body:</b></td>
						<td class=list><textarea name=body rows=15 cols=60><?= ParseEmail($cert[0], $email[0]["body"]) ?></textarea></td>
					  </tr>
	    			</table>				
				
					
		  
		    </td>
		  </tr> 
		</table>			
					
	    	  </td>
			</tr>
    	  </table>
		</td>
	  </tr>
	</table>
	   </div> <!-- Close Topless Grey Box-->
  
		<div align=left class="greyboxfooter">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
		    <tr>
          	  <td><input name="Cancel" type="button" onclick="window.history.go(-1)" value="Cancel"></td>
          	  <td align=right><input type="submit" name="Submit" value="Send Email"></td>
        	</tr>
      	  </table>      
    	</div>		

	  </form>
      
   <br>		  
		  
		  
		  
		  
      </div>
    </div>
  </div>
</body>
</html>
