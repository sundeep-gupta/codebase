<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	if (!isset($_GET["ppl"])|| !isset($_SESSION["Certs"][$_GET["ppl"]]) || !isset($_SESSION["Permissions"]["KeyLabs"])) {
	    header("location: index.php");
	}

	if (isset($_POST["oldstate"])) {
	    $updated = false;
	    //create a newstate array
	    $newstate = array();
	    if (isset($_POST["steps"])) {
		    foreach($_POST["steps"] as $key => $value)
		        $newstate[] = $key;
	    }

	    $oldstate = ($_POST["oldstate"] == "") ? array() : explode(",", $_POST["oldstate"]);
	    $added = array_diff($newstate, $oldstate);
	    $removed = array_diff($oldstate, $newstate);

		//first remove any that need to be removed
		if (count($removed) > 0) {
		    $WHERE = "";
		    foreach($removed as $value)
		        $WHERE .= " step_id='".$value."' OR";

			$SQL = "DELETE FROM productPriceListStep WHERE productPriceList_id='".$_GET["ppl"]."' AND (".substr($WHERE, 0, -3).")";
			DoSQL($SQL, SQL_UPDATE);
			$updated = true;
		}

		//now add any back that need to be added
		if (count($added) > 0) {
		    $VALUES = "";
		    foreach($added as $value)
		        $VALUES .= "('".$_GET["ppl"]."', '".$value."', NOW()),";

			$SQL = "INSERT INTO productPriceListStep(productPriceList_id, step_id, whenMet) VALUES ".substr($VALUES, 0, -1);
			DoSQL($SQL, SQL_UPDATE);
			$updated = true;
		}
		
		//make sure to save the current status back out to ppl
		if ($_POST["oldstatus"] != $_POST["status"]) {
			$SQL = "UPDATE productPriceList SET status_id='".$_POST["status"]."' WHERE id='".$_GET["ppl"]."'";
			DoSQL($SQL, SQL_UPDATE);
			$updated = true;
		}
		
		//Add a log entry
		if ($updated)
			AddLog($_GET["ppl"], "The status was changed or a step was marked completed");
			
		header("location: certStatus.php?ppl=".$_GET["ppl"]);
	}
	
	$cert = GetCert($_GET["ppl"]);
	
	$pfx = GetPrefixStatuses($cert[0]["prefixID"]);
	$pfxcnt = count($pfx);
	$certsteps = GetCertSteps($_GET["ppl"]);
	
	//reorganize certsteps to make searching easier
	$s = $certsteps;
	$ar = array();
	$certsteps = array();
	if (is_array($s)) {
		foreach($s as $value) {
			$certsteps[$value["step_id"]] = $value;
			$ar[] = $value["step_id"];
		}
	}
	$oldstate = implode(",", $ar);
	unset($ar);

	$titleString = "Cert Status for".$cert[0]["certName"];
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
		<br>
		<form name=updateForm method=post action="?ppl=<?=$_GET["ppl"]?>">
		    <input type=hidden name=oldstate value="<?=$oldstate?>">
		    <input type=hidden name=oldstatus value="<?=$cert[0]["statusID"]?>">
			
		<div align="center">			
		<div align=left class="greyboxheader">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
		    <tr>
          <td><strong>Log Entries for <? echo $fields[0]["certName"]; ?></strong></td>
          <td align=right><?include("certMenu.php");?></td>
        </tr>
      </table>
    </div>		
		
		<div class="greybox">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td><table width="100%"  border="0" cellspacing="1" cellpadding="0">
				  <tr>
					<td bgcolor="#f9f9f9">
					

		<table width="100%" cellpadding="0" cellspacing="0" bgcolor="#f9f9f9">
			<tr bgcolor="#E4E4E4">
				<td>			

			<table width="100%" cellpadding="4" cellspacing="0">
				<tr>
					<td class=list colspan=2 width=300px><b>Cert Info</b></td>
				</tr>
				<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
					<td class=list width=300px>Cert Name</td>
					<td class=list><?=$cert[0]["certName"]?></td>
				</tr>
				<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
				    <td class=list>Current Status</td>
				    <td class=list>
				    <?if ($pfxcnt > 0) {?>
				        <select name=status>
				        <?
							for($x=0;$x<$pfxcnt;$x++)
							    printf("<option value=%d%s>%s</option>",
							            $pfx[$x]["id"],
							            ($pfx[$x]["id"] == $cert[0]["statusID"]) ? " selected" : "",
							            $pfx[$x]["name"]);
				        ?>
				        </select>
					<? } else { ?>
					    <p class=rotextnone>No statuses have been defined</p>
					<? } ?>
				    </td>
				</tr>
				<tr><td class=list colspan=2><b>Steps and Statuses</b></td></tr>
			</table>
			
			<table width="100%" cellpadding="4" cellspacing="0">
				<?
		            //for every status get its steps, create a span and fill it out, setting the current status to true
		            // this section could be re-engineered to hit the db once
		            for($x=0;$x<$pfxcnt;$x++) {
		                printf("<tr><td colspan=2 class=list><b>%s</b></td></tr>", $pfx[$x]["name"]);
		                $steps = GetStatusSteps($pfx[$x]["id"]);
		                $stepscnt = count($steps);
		                if ($stepscnt > 0) {
		                    //print the steps out in pairs
			                for($y=0;$y+2<=$stepscnt;$y+=2) {
			                    printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\">
											<td class=list style=\"width: 50%%\"><input type=checkbox name=steps[%d]%s>%s%s</td>
											<td class=list><input type=checkbox name=steps[%d]%s>%s%s</td>
										</tr>",
										$steps[$y]["id"], (isset($certsteps[$steps[$y]["id"]])) ? " checked" : "",
										$steps[$y]["name"], (isset($certsteps[$steps[$y]["id"]])) ? " (".$certsteps[$steps[$y]["id"]]["whenMet"].")" : "",
										$steps[$y+1]["id"], (isset($certsteps[$steps[$y+1]["id"]])) ? " checked" : "",
										$steps[$y+1]["name"], (isset($certsteps[$steps[$y+1]["id"]])) ? " (".$certsteps[$steps[$y+1]["id"]]["whenMet"].")" : "");
			                }
			                if ($y!=$stepscnt) {
			                    printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\">
											<td class=list style=\"width: 50%%\"><input type=checkbox name=steps[%d]%s>%s%s</td>
											<td class=list>&nbsp;</td>
										</tr>",
										$steps[$y]["id"], (isset($certsteps[$steps[$y]["id"]])) ? " checked" : "",
										$steps[$y]["name"], (isset($certsteps[$steps[$y]["id"]])) ? " (".$certsteps[$steps[$y]["id"]]["whenMet"].")" : "");
			                }
		                } else {
		                    print("<tr><td><p class=rotextnone>No steps have been created for this status</p></td>");
		                }
		            }
				?>
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
		</div>
		
			
		<div align=left class="greyboxfooter">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
		    <tr>
          	  <td><input name="Cancel" type="button" onclick="location.reload()" value="Cancel"></td>
          	  <td align=right><input type="submit" name="Submit" value="Save Changes"></td>
        	</tr>
      	  </table>      
    	</div>					
		<br>			
			

		</form>
      </div>
    </div>
  </div>
  <!--<div id=bottom>
    <div id=footer>
      bottom content
    </div>	 
  </div> -->
</body>
</html>
