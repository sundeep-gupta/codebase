<?
	include_once("session.php");
	include_once("../cert_functions.php");
	
	$program = $_GET["p"];

  $SQL = "select * from programMTA where id='$program'";
  $MTA = DoSQL($SQL);	

	$titleString = "KeyLabs Master Test Agreement";
	$NOTABS = 1;
?>



<div id=head style="height: 65px">
	<? include("header.php") ?>
</div>
<link rel="stylesheet" href="../graphics/mainstyle.css" type="text/css">
<link rel="stylesheet" href="../graphics/boxes.css" type="text/css">
<script>
	contactsarr = new Array();
	<?
	    for($x=0;$x<$contactscnt;$x++) {
	        printf("contactsarr[%d] = new Array('%s', '%s', '%s');\n", $contacts[$x]["id"], $contacts[$x]["name"], $contacts[$x]["phone"], $contacts[$x]["email"]);
	    }
	?>
	function getSelectedRadio(buttonGroup) {
	   // returns the array number of the selected radio button or -1 if no button is selected
	   if (buttonGroup[0]) { // if the button group is an array (one button is not an array)
	      for (var i=0; i<buttonGroup.length; i++) {
	         if (buttonGroup[i].checked) {
	            return i
	         }
	      }
	   } else {
	      if (buttonGroup.checked) { return 0; } // if the one button is checked, return zero
	   }
	   // if we get to this point, no radio button is selected
	   return -1;
	} // Ends the "getSelectedRadio" function

	function getSelectedRadioValue(buttonGroup) {
	   // returns the value of the selected radio button or "" if no button is selected
	   var i = getSelectedRadio(buttonGroup);
	   if (i == -1) {
	      return "";
	   } else {
	      if (buttonGroup[i]) { // Make sure the button group is an array (not just one button)
	         return buttonGroup[i].value;
	      } else { // The button group is just the one button, and it is checked
	         return buttonGroup.value;
	      }
	   }
	} // Ends the "getSelectedRadioValue" function

	function btnclick() {
		var sel = getSelectedRadioValue(document.forms[0].contact);

		var name, phone, email, contactid;
		var funtype = window.document.forms[0].elements[0];
		if (funtype.value=='Submission') {
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
		
		contactid.value = sel;
		if (contactsarr[sel][0] == '') {
			name.innerHTML = 'None';
			name.className = 'rotextnone';
		} else {
		    name.innerHTML = contactsarr[sel][0];
		    name.className = 'rotext';
		}
		if (contactsarr[sel][1] == '') {
			phone.innerHTML = 'None';
			phone.className = 'rotextnone';
		} else {
		    phone.innerHTML = contactsarr[sel][1];
		    phone.className = 'rotext';
		}
		if (contactsarr[sel][2] == '') {
		    email.innerHTML = 'None';
		    email.className = 'rotextnone';
		} else {
		    email.innerHTML = contactsarr[sel][2];
		    email.className = 'rotext';
		}
		window.close();
	}
	
	function cancelclick() {
	    window.close();
	}
	
	function newclick() {
	    window.location='newContact.php?type=<?=$_GET["type"]?>&companyID=<?=$_GET["companyID"]?>&id=<?=$_GET["id"]?>';
	}
	
	function editclick() {
	    var sel = getSelectedRadioValue(document.forms[0].contact);
	    if (sel != "")
	    	window.location='newContact.php?type=<?=$_GET["type"]?>&id=<?=$_GET["id"]?>&companyID=<?=$_GET["companyID"]?>&userID='+sel;
	}
</script>
	<hr>
	<form name=h>
		<input type=hidden name=type value=<?=$_GET["type"]?>>
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
      <?=$MTA[0]["mtaText"]?>
		</div>
		
		<div align=left class="greyboxfooter">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
		    <tr>
			  <td>&nbsp;</td>
			  <td align=right><input type="submit" name="Submit" value="Close Window" onclick="cancelclick()"></td>
			</tr>
		  </table>
		</div>
		</div>
	<br>		  

	 </form>
<? include("footer.php"); ?>
