<?
	include_once("session.php");
	include_once("cert_functions.php");

	if (isset($_POST["type"])) {
		//only do this if there is all fields are set
		if (isset($_POST["Name"]) && isset($_POST["Email"]) && isset($_POST["Phone"])) {
		    $newID = (isset($_POST["id"])) ?
		            EditUser($_POST["id"], $_POST["Name"], $_POST["Email"], $_POST["Phone"]) :
		    		NewUser($_POST["companyID"],$_POST["Name"], $_POST["Email"], $_POST["Phone"]);
		}
	}

	$fun = (isset($_GET["userID"])) ? "Edit" : "Add";
	$user = (isset($_GET["userID"])) ? GetUser($_GET["userID"]) : array();
	$titleString = "$fun a new contact";
	$NOTABS = 1;
?>
<div id=head style="height: 65px">
	<? include("header.php") ?>
</div>
<link rel="stylesheet" href="graphics/mainstyle.css" type="text/css">
<link rel="stylesheet" href="graphics/boxes.css" type="text/css">
<script>
	function cancelclick() {
		window.location='changeContact.php?type=<?=$_GET["type"]?>&companyID=<?=$_GET["companyID"]?>&id=<?=$_GET["id"]?>';
	}
	<?
	    if (isset($newID)) {
	?>
		var name, phone, email, contactid;
		var funtype = '<?=$_POST["type"]?>';
		if (funtype.value=='submission') {
		    contactid = opener.document.getElementById('SubmissionID');

			phone = opener.document.getElementById('Submission Phone');
			email = opener.document.getElementById('Submission Email');
			name = opener.document.getElementById('Submission Name');
		} else {
		    contactid = opener.document.getElementById('TechnicalID');

			name = opener.document.getElementById('Technical Name');
			phone = opener.document.getElementById('Technical Phone');
			email = opener.document.getElementById('Technical Email');
		}

		contactid.value = '<?=$newID?>';
		name.innerHTML = '<?=($_POST["Name"] == '') ? '<font color=#ff1111>None</font>' : $_POST["Name"]?>';
		phone.innerHTML = '<?=($_POST["Phone"] == '') ? '<font color=#ff1111>None</font>' : $_POST["Phone"]?>';
		email.innerHTML = '<?=($_POST["Email"] == '') ? '<font color=#ff1111>None</font>' : $_POST["Email"]?>';
		window.close();
<?
	}
?>
</script>
	<hr>
	<form name=h action="" method="post">
		<input type=hidden name=type value=<?=$_GET["type"]?>>
		<input type=hidden name=companyID value=<?=$_GET["companyID"]?>>


		 
    <br>
		<div align="center">
		<div align=left class="greyboxheader">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
		    <tr>
			  <td><strong><?=$fun?> Contact Information</strong></td>
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
					  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
					  	<td width="20%">Name:</td>
						<td width="80%"><input type=text size=25 name="Name" value="<?=$user[0]["name"]?>"></td>
					  </tr>
					  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
					  	<td width="20%">Email:</td>
						<td width="80%"><input type=text size=30 name="Email" value="<?=$user[0]["email"]?>"></td>
					  </tr>
					  <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
					  	<td width="20%">Phone:</td>
						<td width="80%"><input type=text size=20 name="Phone" value="<?=$user[0]["phone"]?>"></td>
					  </tr>					  					  
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
			  	<? if (isset($_GET["userID"])) { ?>
					<input type=hidden name=id value=<?=$_GET["userID"]?>>
					<input type="submit" name="Submit" value="Save Changes">
				<? } else { ?>
					<input type="submit" name="Submit" value="Add Contact">
				<? } ?>			  
			  </td>
			</tr>
		  </table>
		</div>
		</div>
	<br>		  
		 
		 
	 </form>
<? include("footer.php"); ?>
