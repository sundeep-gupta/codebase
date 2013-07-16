<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	if (!isset($_GET["ppl"]) || !isset($_SESSION["Certs"][$_GET["ppl"]]) || !isset($_SESSION["Permissions"]["KeyLabs"])) {
		print("<html><script>window.close();</script></html>");
		exit;
	}
	
	if (isset($_POST["ppl"])) {
	    if (count($_POST["contact"]) > 0) {
		    //first add a new entry in the db for the new product for every checked item
		    $SQL = "INSERT INTO productPriceListPlatform VALUES ";
		    $cnt = 0;
		    $out = array();
		    foreach($_POST["contact"] as $value)
		        $out[] = "('".$_POST["ppl"]."', '".$value."')";

		    DoSQL($SQL.implode(",", $out), SQL_UPDATE);

			$newID = 1;
	    } else {
   			print("<html><script>window.close();</script></html>");
			exit;
	    }
	} else {
		//could probably re-do this in sql....  but i'm lazy
		$cert = GetCert($_GET["ppl"]);
		$platforms = GetPlatforms($cert[0]["priceList_id"]);
		$platformscnt = count($platforms);

		$currentplatforms = GetPPLPlatforms($_GET["ppl"]);
		//reorganize to make searching easier
		if (count($currentplatforms)>0) {
			$in = $currentplatforms;
			$currentplatforms = array();
			foreach($in as $value) {
			    $currentplatforms[$value["id"]] = 1;
			}
		}
	}
	$titleString = "Add platforms";
	$NOTABS = 1;
?>
<div id=head style="height: 65px">
	<? include("header.php") ?>
</div>
<link rel="stylesheet" href="graphics/mainstyle.css" type="text/css">
<link rel="stylesheet" href="graphics/boxes.css" type="text/css">
<script>
	function cancelclick() {
	    window.close();
	}
	<?
	    if (isset($newID)) {
	?>
	
	opener.location.reload();
	window.close();
<?
	}
?>
</script>
	<hr>
	<form name=h method=post action="?ppl=<?=$_GET["ppl"]?>">
	    <input type=hidden name=ppl value=<?=$_GET["ppl"]?>>
		 
    <br>
		<div align="center">
		<div align=left class="greyboxheader">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
		    <tr>
			  <td><strong><?=$titleString; ?></strong></td>
			  <td align=right>&nbsp;</td>
			</tr>
		  </table>
		</div>		
		
		<div class="greybox">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td><table width="100%"  border="0" cellspacing="1" cellpadding="0">
				  <tr>
					<td bgcolor="#f9f9f9">
					
					<table width="100%" cellpadding="4" cellspacing="0" bgcolor="#f9f9f9">
					<?
						for($x=0,$cnt=0;$x<$platformscnt;$x++) {
							if (!isset($currentplatforms[$platforms[$x]["id"]])) {
								$cnt++;
								printf("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\"><td><input type=checkbox name=contact[] value=%d>%s</td></tr>",
										$platforms[$x]["id"], $platforms[$x]["name"].", ".$platforms[$x]["version"]);
							}
						}
					 ?>
					</table>
					
					</td>
				  </tr>
				</table></td>
			  </tr>
			</table>		
		</div>
		
		<div align=left class="greyboxfooter">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
		    <tr>
			  <td><input type="button" name="Button" value="Cancel" onclick="cancelclick()"></td>
			  <td align=right><input type="submit" name="Submit" value="Add Platforms"></td>
			</tr>
		  </table>
		</div>
		</div>
	<br>		  
		 
	 </form>
<? include("footer.php"); ?>
