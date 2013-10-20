<?php 
/*
MediQnA v1.1 : DisplayQList.php
Lists the questions this user has already 
added to the system.

Original code (c) Famous Websites 2008
Latest Update: 10-December-2008
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );

//admin.mediqna.php has already checked to see
//if there questions to be listed.
//====----
$MyListing;
$MyAddQLink = "<a href='index.php?option=com_mediqna&amp;task=AddQPrep&amp;id=".$id."' target='_self'><img src='".$MyIconsPath."plus.jpg' title='Add a question to this set' alt='Add a question to this set' width='23' height='19' align='absmiddle'></a>";
//====----
foreach($rows as $row){
	$MyStatusIcon = "pwron.jpg";
	$MyStatusHint = "Click to switch off";
	$MyNextAction = "d";
	
	if($row->Status == "off"){
		$MyStatusIcon = "pwroff.jpg";
		$MyStatusHint = "Click to switch on";
		$MyNextAction = "u";
	}
	
	$MyEditLink = "<a href='index.php?option=com_mediqna&task=EditQPrep&qid=".$row->RecID."&id=".$id."' target='_self'><img src='".$MyIconsPath."edit.jpg' title='Edit this question' alt='Edit this question' width='23' height='19'></a>";
	$MySetStatusLink = "<a href='index.php?option=com_mediqna&task=SwitchQ&pwr=".$MyNextAction."&qid=".$row->RecID."&id=".$id." ' target='_self'><img src='".$MyIconsPath.$MyStatusIcon."' title='".$MyStatusHint."' alt='".$MyStatusHint."' width='23' height='19'></a>";
	//====----

	$MyListing .= "<tr>
					<td width='10' height='76'>&nbsp;</td>
					<td width='378' valign='top'>
					<span class='ListHLite'>Name:</span><b>".$row->QAlias."</b>
					<br><span class='ListHLite'>Status: </span>".$row->Status." : <span class='ListHLite'>Added on: </span>".$row->DateAdded."
					<br><br>
					".$MySetStatusLink.$MyEditLink."
					</td>
				  </tr>

				  <tr>
					<td width='10'>&nbsp;</td>
					<td><hr size='1' noshade color='#66CCFF'></td>
				  </tr>
				  ";
}
?>

<html>
<style type="text/css">
<!--
.ListHLite {
	color: #3366CC;
}
-->
</style>

<script>
function ConfRem(QNum){
	if(confirm("Sure, remove this question?")){
		if(confirm("LAST CHANCE! The question will be deleted!")){
			location = "index.php?option=com_mediqna&amp;task=RemQ&amp;qid="+QNum;
		}
	}
}
</script>

<body bgcolor="#FFFFFF">
<table width="655" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="23">&nbsp;</td>
    <td valign="top"><img src="<?php print $MyIconsPath; ?>MediQnA-Logo.jpg" title="Medi-QnA" alt="Medi-QnA" width="194" height="132"><br>
      <h1>Questions in set: <?php print $SetName[0]->SetName; ?></h1></td>
  </tr>
  <tr>
    <td width="9" height="23">&nbsp;</td>
    <td width="646" valign="top"><h3><?php print $MyAddQLink; ?> Add a new question to set: <?php print $SetName[0]->SetName; ?>?</h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><hr size="1" noshade color='#66CCFF'></td>
  </tr>

<?php print $MyListing; ?>

  <tr>
    <td>&nbsp;</td>
    <td><a href="index.php?option=com_mediqna" target="_self"><img src="<?php print $MyIconsPath; ?>left.jpg" alt="Go back" width="23" height="19" border="0" align="absmiddle" title="Go back"></a> Back to Medi-QnA Start Page?</td>
  </tr>
</table>
</body></html>