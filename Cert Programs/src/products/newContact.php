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
<script>
	function cancelclick() {
	    window.close();
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
	<? if (isset($_GET["userID"])) { ?>
		<input type=hidden name=id value=<?=$_GET["userID"]?>>
		<input class=cimglink type=image src="../graphics/edit.gif" name=submit>
	<? } else { ?>
		<input class=cimglink type=image src="../graphics/add.gif" name=submit>
	<? } ?>
		<input class=cimglink type=image src="../graphics/cancel.gif" name=cancel onclick="cancelclick()"><br><br> <!--value="Change <?=$_GET["type"]?> contact" onclick="btnclick()"><br><br>-->
		<center><table class=list>
		    <tr class=listhf><td class=list colspan=2><b><?=$fun?> Contact Information</b></td></tr>
		    <tr class=list>
		        <td class=list style="width: 20%">Name:</td>
		        <td class=list><input type=text size=25 name="Name" value="<?=$user[0]["name"]?>"></td>
			</tr>
		    <tr class=list>
		        <td class=list style="width:20%">Email:</td>
		        <td class=list><input type=text size=30 name="Email" value="<?=$user[0]["email"]?>"></td>
			</tr>
		    <tr class=list>
		        <td class=list style="width: 20%">Phone:</td>
		        <td class=list><input type=text size=20 name="Phone" value="<?=$user[0]["phone"]?>"></td>
			</tr>
			<tr class=listhf><td align=center colspan=2>&nbsp;</td></tr>
		 </table></center>
	 </form>
<? include("footer.php"); ?>
