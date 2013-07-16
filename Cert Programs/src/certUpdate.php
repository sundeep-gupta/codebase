<?
	include_once("session.php");
	include_once("cert_functions.php");

	if (!isset($_GET["ppl"]) || !isset($_SESSION["Certs"][$_GET["ppl"]]) || !isset($_SESSION["Permissions"]["KeyLabs"])) {
	    header("location: index.php");
	}
	
	if (isset($_GET["platid"])) {
	    $SQL = "DELETE FROM productPriceListPlatform WHERE productPriceList_id='".$_GET["ppl"]."' AND platform_id='".$_GET["platid"]."'";
	    DoSQL($SQL, SQL_UPDATE);
	    //make sure to get rid of the delete so we don't do it again
	    header("location: certUpdate.php?ppl=".$_GET["ppl"]);
	}
	
	if (isset($_GET["fileid"])) {
		//first delete the file off the filesystem
		$file = GetFile($_GET["fileid"]);
		unlink($file[0]["path"]);
		
		//now remove the db entry for it
		$SQL = "DELETE FROM file WHERE id='".$_GET["fileid"]."'";
		DoSQL($SQL, SQL_UPDATE);
		
		header("location: certUpdate.php?ppl=".$_GET["ppl"]);
	}
	
	//now i get to update the cert and save new info out to the ppl table -- among others
	if (isset($_POST["SubmissionID"])) {
	    //first update the ppl table
	    $SQL = "UPDATE productPriceList SET
	            submission_id='".$_POST["SubmissionID"]."',
	            technical_id='".$_POST["TechnicalID"]."',
	            payment_id='".$_POST["paymentMethod"]."',
	            timeframe_id='".$_POST["timeframe"]."',
	            engineer_id='".$_POST["engineer"]."',
	            priceList_id='".$_POST["pricelistID"]."',
	            schedStartDate='".$_POST["schedStartDate"]."',
	            estDuration='".$_POST["estDuration"]."'
				WHERE id='".$_GET["ppl"]."'";
		DoSQL($SQL, SQL_UPDATE);

		$SQL = "UPDATE product SET
		        name='".$_POST["productName"]."',
		        version='".$_POST["productVersion"]."',
		        comment='".$_POST["comment"]."'
		        WHERE id='".$_POST["productID"]."'";
		DoSQL($SQL, SQL_UPDATE);
		header("location: certUpdate.php?ppl=".$_GET["ppl"]);
	}
	
	$cert = GetCert($_GET["ppl"]);
	$titleString = "Cert Update Page";
	$activetab = "testing";
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>KeyLabs Certification System</title>
 
  <link rel="stylesheet" href="graphics/main.css" type="text/css">
  <link rel="stylesheet" href="graphics/menuExpandable3.css" type="text/css">
  <script src="graphics/menuExpandable3.js" type="text/javascript"></script>
  <!-- this needs to be the last css loaded -->
  <!--[if IE 6]>
  <link rel="stylesheet" href="graphics/ie6.css" type="text/css">
  <![endif]-->
  <!-- this needs to be the last css loaded -->
<script type="text/javascript">
	function changeContact(type) {
        var contact;

        url = "changeContact.php";
        //find the correct item's id field and get the value from it
        if (type=='submission') {
            contact = document.getElementById('SubmissionID').value;
            url = url + "?type=Submission&companyID=<?=$cert[0]["companyID"]?>&id=" + contact;
        } else {
            contact = document.getElementById('TechnicalID').value;
			url = url + "?type=Technical&companyID=<?=$cert[0]["companyID"]?>&id=" + contact;
        }
        contact = window.open(url, "contactWindow", "dependent,hotkeys=no,menubar=no,personalbar=no,scrollbars=yes,status=no,titlebar=no,toolbar=no,height=480,width=640");
        //contact = window.open(url, "contactWindow", "hotkeys=no,menubar=yes,personalbar=no,scrollbars=yes,status=yes,titlebar=no,toolbar=no");
    }
    
    function addPlatform() {
        url = "addPlatform.php?ppl=<?=$_GET["ppl"]?>"
        platform = window.open(url, "PlatformWindow", "dependent,hotkeys=no,menubar=no,personalbar=no,scrollbars=yes,status=no,titlebar=no,toolbar=no,height=480,width=640");
    }
    
    function addFile() {
        url = "addFile.php?ppl=<?=$_GET["ppl"]?>"
        filewin = window.open(url, "FileWindow", "dependent,hotkeys=no,menubar=no,personalbar=no,scrollbars=yes,status=no,titlebar=no,toolbar=no,height=480,width=640");
    }
    
    function editFile(id) {
        url = "addFile.php?ppl=<?=$_GET["ppl"]?>&fileID="+id;
        filewin = window.open(url, "FileWindow", "dependent,hotkeys=no,menubar=no,personalbar=no,scrollbars=yes,status=no,titlebar=no,toolbar=no,height=480,width=640");
    }
	
function confirmDelete()
{
	var agree=confirm("Are you sure you want to delete this record?");
	if (agree)
		return true ;
	else
		return false ;
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
		<div align="center">
		<form name=updateForm method=post action="?ppl=<?=$_GET["ppl"]?>">
		<div align=left class="greyboxheader">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
				<tr>
			  <td><strong>Cert Update for <? echo $fields[0]["certName"]; ?></strong></td>
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
				
<table cellpadding="4" cellspacing="0" width="100%">
	    		  <tr>
	            	<td class=list colspan=2 width=300px><b>Cert Info</b></td>
	          	  </tr>
	    		  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
	            	<td class=list width=300px>Cert Name</td>
	            	<td class=list><?=$cert[0]["certName"]?></td>
	          	  </tr>
	    		  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
	            	<td class=list>Registration Date/Time</td>
	            	<td class=list><?=$cert[0]["registeredDate"]?></td>
	          	  </tr>
				  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
					<td class=list>Company</td>
					<td class=list><?=$cert[0]["company"]?></td>
				  </tr>
	<!-------------------------------------------------------->
				<tr>
					<td class=list colspan=2>
						<table width=100% cellpadding=0 cellspacing=0>
							<tr>
								<td width=20%><b>Submission Contact</b></td>
								<td><img class=cimglink src=graphics/change.gif onclick="changeContact('submission')"></td>
							</tr>
						</table>
						<input type=hidden id=SubmissionID name=SubmissionID value=<?=$cert[0]["subID"]?>>
					</td>
				</tr>
				<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
					<td class=list>Submission Contact Name</td>
					<td class=list><p class=<?=($cert[0]["subName"]=="")?"rotextnone":"rotext"?> id="Submission Name">
						<?=($cert[0]["subName"]=="")? "None" : $cert[0]["subName"]?>
					</p></td>
				</tr>
				<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
					<td class=list>Submission Contact Email</td>
					<td class=list><p class=<?=($cert[0]["subEmail"]=="")?"rotextnone":"rotext"?> id="Submission Email">
						<?=($cert[0]["subEmail"]=="")? "None" : $cert[0]["subEmail"]?>
					</p></td>
				</tr>
				<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
					<td class=list>Submission Contact Phone</td>
					<td class=list><p class=<?=($cert[0]["subPhone"]=="")?"rotextnone":"rotext"?> id="Submission Phone">
						<?=($cert[0]["subPhone"]=="")? "None" : $cert[0]["subPhone"]?>
					</p></td>
				</tr>
	<!-------------------------------------------------------->
				<tr>
					<td class=list colspan=2>
						<table width=100% cellpadding=0 cellspacing=0>
							<tr>
								<td width=20%><b>Technical Contact</b></td>
								<td><img class=cimglink src=graphics/change.gif onclick="changeContact('technical')"></td>
							</tr>
						</table>
						<input type=hidden id=TechnicalID name=TechnicalID value=<?=$cert[0]["techID"]?>>
					</td>
				</tr>
				<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
					<td class=list>Technical Contact Name</td>
					<td class=list><p class=<?=($cert[0]["techName"]=="")?"rotextnone":"rotext"?> id="Technical Name">
						<?=($cert[0]["techName"]=="")? "None" : $cert[0]["techName"]?></p>
					</td>
				</tr>
				<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
					<td class=list>Technical Contact Email</td>
					<td class=list><p class=<?=($cert[0]["techEmail"]=="")?"rotextnone":"rotext"?> id="Technical Email">
						<?=($cert[0]["techEmail"]=="")? "None" : $cert[0]["techEmail"]?>
					</p></td>
				</tr>
				<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
					<td class=list>Technical Contact Phone</td>
					<td class=list><p class=<?=($cert[0]["techPhone"]=="")?"rotextnone":"rotext"?> id="Technical Phone">
						<?=($cert[0]["techPhone"]=="")? "None" : $cert[0]["techPhone"]?>
					</p></td>
				</tr>
	<!-------------------------------------------------------->
	    			<tr>
	    				<td class=list colspan=2><b>Miscellaneous</b></td>
	    			</tr>
				<tr class=list>
					<td class=list>KeyLabs SKU</td>
					<td class=list>
						<select name="pricelistID" style="width: 323px">
						<?
							$SKU = GetSKUs($cert[0][prefixID]);
							$SKUcnt = count($SKU);
					    for($x=0;$x<$SKUcnt;$x++)
					        printf("<option value=%d%s>%s</option>",
					                $SKU[$x]["id"],
					                ($SKU[$x]["id"] == $cert[0]["priceList_id"]) ? " selected" : "",
					                $SKU[$x]["description"]);
						?>
						</select>
					</td>
				</tr>
	  
				<tr class=list>
					<td class=list>Payment Method</td>
					<td class=list>
						<select name="paymentMethod" style="width: 323px">
						<?
							$payment = GetPayments();
							$paymentcnt = count($payment);
						    for($x=0;$x<$paymentcnt;$x++)
						        printf("<option value=%d%s>%s</option>",
						                $payment[$x]["id"],
						                ($payment[$x]["method"] == $cert[0]["method"]) ? " selected" : "",
						                $payment[$x]["method"]);
						?>
						</select>
					</td>
				</tr>
	    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
	    				<td class=list>Product Name</td>
	    				<td class=list><input type=text name="productName" value="<?=$cert[0]["productName"]?>" size=50></td>
	    			</tr>
	    			<tr class=list>
	    				<td class=list>Product Version</td>
	    				<td class=list><input type=text name="productVersion" value="<?=$cert[0]["productVersion"]?>" size=50></td>
	    			</tr>
				<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
					<td class=list>Timeframe</td>
					<td class=list>
						<select name="timeframe" style="width: 323px">
						<?
						    $timeframe = GetTimeframes();
						    $timeframecnt = count($timeframe);
						    for($x=0;$x<$timeframecnt;$x++)
						        printf("<option value=%d%s>%s</option>",
						                $timeframe[$x]["id"],
						                ($timeframe[$x]["name"] == $cert[0]["timeframe"]) ? " selected" : "",
						                $timeframe[$x]["name"]);
						?>
						</select>
					</td>
				</tr>
	    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
	    				<td class=list>Comments</td>
	    				<td class=list><input type=text name="comment" value="<?=$cert[0]["comment"]?>" size=50></td>
	    			</tr>
	    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
	    				<td class=list>Status</td>
	    				<td class=list><?=$cert[0]["status"]?></td>
	    			</tr>
				<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
					<td class=list>Engineer</td>
					<td class=list>
						<select name="engineer" style="width: 323px">
						<?
						    $engineers = GetEngineers();
						    $engineerscnt = count($engineers);
						    for($x=0;$x<$engineerscnt;$x++)
						        printf("<option value=%d%s>%s</option>",
						                $engineers[$x]["id"],
						                ($engineers[$x]["name"] == $cert[0]["engName"]) ? " selected" : "",
						                $engineers[$x]["name"]);
						?>
						</select>
					</td>
				</tr>
	    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
	    				<td class=list>Scheduled Start Date <font size=-2>(yyyy-mm-dd)</font></td>
	    				<td class=list><input type=text name="schedStartDate" value="<?=$cert[0]["schedStartDate"]?>" size=50></td>
	    			</tr>
	    			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
	    				<td class=list>Estimated Duration <font size=-2>(in Days)</font></td>
	    				<td class=list><input type=text name=estDuration value="<?=$cert[0]["estDuration"]?>" size=50></td>
	    			</tr>
				<tr>
					<td class=list colspan=2>
						<table width=100% cellpadding=0 cellspacing=0>
							<tr>
								<td width=20%><b>Platforms</b></td>
								<td><img class=cimglink src=graphics/add.gif onclick="addPlatform()"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan=2 style="padding: 0px; margin: 0px">
						<table id=platformTable cellspacing="0" cellpadding="4" style="width: 100%">
						<?
						    $platforms = GetPPLPlatforms($_GET["ppl"]);
						    $platformscnt = count($platforms);
						    if ($platformscnt > 0) {
						        for($x=0;$x<$platformscnt;$x++)
						            printf("<tr class=list><td >%s</td><td style=\"width: 20%%; text-align: center\"><a href=?ppl=%d&platid=%d onClick=\"return confirmDelete()\">Remove</a></td></tr>",
						                    $platforms[$x]["name"].", ".$platforms[$x]["version"],
											$_GET["ppl"],
											$platforms[$x]["id"]);
						    } else {
						        print("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\"><td class=listnone>None</td></tr>");
						    }
						?>
						</table>
					</td>
				</tr>
				<tr>
					<td class=list colspan=2>
						<table width=100% cellpadding=0 cellspacing=0>
							<tr>
								<td width=20%><b>Files</b></td>
								<td><img class=cimglink src=graphics/add.gif onclick="addFile()"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				    <td colspan=2 style="padding: 0px; margin: 0px">
				        <table id=fileTable cellspacing="0" cellpadding="4" style="width: 100%">
						<?
							$files = GetPPLFiles($cert[0]["id"]);
							$filescnt = count($files);
							if ($filescnt > 0) {
							    for($x=0;$x<$filescnt;$x++)
						            printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\">
												<td><a href=javascript:editFile(%d)>%s</a></td>
												<td style=\"width: 20%%; text-align: center\"><a href=?ppl=%d&fileid=%d onClick=\"return confirmDelete()\">Remove</a></td>
											</tr>",
											$files[$x]["id"], $files[$x]["description"],
											$_GET["ppl"], $files[$x]["id"]);
							} else {
							    print("<tr class=list><td class=listnone colspan=2>None</td></tr>");
							}
						?>
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
		</td>
	  </tr>
	</table>
	   </div> <!-- Close Topless Grey Box-->
  
		<div align=left class="greyboxfooter">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
		    <tr>
          	  <td><input name="Cancel" type="button" onclick="location.reload()" value="Cancel"></td>
          	  <td align=right><input type="submit" name="Submit" value="Save Changes"></td>
        	</tr>
      	  </table>      
    	</div>		

	  </form>
      
   <br>
	</div> <!-- Close Center -->
  	</div> <!-- Close Right -->
    </div> <!-- Close middle2 -->
	</div> <!-- Close middle -->
</body>
</html>
