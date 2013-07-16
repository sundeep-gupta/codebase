<?
	include_once("session.php");
	include_once("cert_functions.php");

	if (!isset($_GET["ppl"]) || !isset($_SESSION["Certs"][$_GET["ppl"]]) || !isset($_SESSION["Permissions"]["KeyLabs"])) {
		print("<html><script>window.close();</script></html>");
		exit;
	}
	
	if (isset($_POST["description"])) {
	    if (!isset($_POST["id"])) {
	        //we are adding a new file
	        if ($_FILES["file"]["tmp_name"] != "") {
			    global $Config;

			    $ar = explode("/", $_FILES["file"]["tmp_name"]);
			    $filename = tempnam($Config["filesdir"], "");
				move_uploaded_file($_FILES["file"]["tmp_name"], $filename);

				$cert = GetCert($_GET["ppl"]);
				//now add a link in the file table
				$SQL = "INSERT INTO file SET productPriceList_id='".$cert[0]["id"]."', description='".$_POST["description"].
						"', path='$filename', type='".$_FILES["file"]["type"]."', name='".$_FILES["file"]["name"]."'";
				DoSQL($SQL, SQL_UPDATE);
	        }
	    } else {
	        //we are just modifying the description of a file
	        $SQL = "UPDATE file SET description='".$_POST["description"]."' WHERE id='".$_POST["id"]."'";
	        DoSQL($SQL, SQL_UPDATE);
	    }
		
		print("<html><script>opener.location.reload(); window.close();</script></html>");
		exit;
	}
	
	$fun = (isset($_GET["fileID"])) ? "Edit" : "Add";
	$file = (isset($_GET["fileID"])) ? GetFile($_GET["fileID"]) : array();

	$titleString = $fun." a file";
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
</script>
	<hr>
	<form name=h action="?ppl=<?=$_GET["ppl"]?>" method="post" enctype="multipart/form-data">
		<input type=hidden name=ppl value=<?=$_GET["ppl"]?>>
		 
    <br>
		<div align="center">
		<div align=left class="greyboxheader">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
		    <tr>
			  <td><strong>New File Information</strong></td>
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
		    <tr class=list>
		        <td class=list style="width: 20%">Description</td>
		        <td class=list><input type=text size=50 name="description" value="<?=$file[0]["description"]?>"></td>
			</tr>
	<? if (!isset($_GET["fileID"])) { ?>
		    <tr class=list>
		        <td class=list style="width: 20%">File</td>
		        <td class=list><input type=file size=50 name="file"></td>
			</tr>
	<? } ?>
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
			  <td align=right>  
					<? if (isset($_GET["fileID"])) { ?>
						<input type=hidden name=id value=<?=$_GET["fileID"]?>>
						<input type="submit" name="Submit" value="Save Changes">
					<? } else { ?>
						<input type="submit" name="Submit" value="Add File">
					<? } ?>			  
				</td>  
			  
			</tr>
		  </table>
		</div>
		</div>
	<br>		  
		 
		 
		 
		 
	 </form>
<? include("footer.php"); ?>
