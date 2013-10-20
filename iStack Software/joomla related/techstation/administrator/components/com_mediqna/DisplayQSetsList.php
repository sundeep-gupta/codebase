<?php 
/*
MediQnA v1.1 : DisplayQSetsList.php
Lists the question sets this user has already 
added to the system.

Original code (c) Famous Websites 2008
Latest Update: 11-December-2008
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );
$MyListing;

$dbh =& JFactory::getDBO();	
$sql = "SELECT * FROM qna_QuestionSets ORDER BY RecID DESC";
$dbh->setQuery($sql);
//Get a conx to check the number of questions
//remember, if less than 2 they can't switch it on
$NumQs =& JFactory::getDBO();
//====----
if (!$result = $dbh->query()) {
	Dropout($dbh->stderr(),"index.php");
}else{
	$rows = $dbh->loadObjectList();

	foreach($rows as $row){
		$MyStatusIcon = "pwron.jpg";
		$MyStatusHint = "Switch this set off";
		$MyNextAction = "d";
		//====----
		if($row->Status == "off"){
			$MyStatusIcon = "pwroff.jpg";
			$MyStatusHint = "Switch this set on";
			$MyNextAction = "u";
		}
		//====----
		$MyQListLink = "<a href='index.php?option=com_mediqna&task=ViewQList&id=".$row->RecID."' target='_self'><img src='".$MyIconsPath."yes.jpg' title='View question list for this set' alt='View question list for this set' width='23' height='19' border='0'></a>";
		$MyEditLink = "<a href='index.php?option=com_mediqna&amp;task=EditQSetPrep&amp;id=".$row->RecID."' target='_self'><img src='".$MyIconsPath."edit.jpg' title='Edit this set' alt='Edit this set' width='23' height='19'></a>";
		$MySetStatusLink = "<a href='index.php?option=com_mediqna&amp;task=EditQSetProc&amp;pwr=".$MyNextAction."&amp;id=".$row->RecID."' target='_self'><img src='".$MyIconsPath.$MyStatusIcon."' title='".$MyStatusHint."' alt='".$MyStatusHint."' width='23' height='19'></a>";

		//How many questions?
		$SQLQues = "SELECT count(RecID) as NumQsFound FROM qna_Questions WHERE Status LIKE 'on' AND AssignedSet = ".$row->RecID;
		$NumQs->setQuery($SQLQues);
		$Rtns = $NumQs->loadObjectList();
		$TotalOn = $Rtns[0]->NumQsFound;
		
		$SQLQues = "SELECT count(RecID) as NumQsFound FROM qna_Questions WHERE Status LIKE 'off' AND AssignedSet = ".$row->RecID;
		$NumQs->setQuery($SQLQues);
		$Rtns = $NumQs->loadObjectList();
		$TotalOff = $Rtns[0]->NumQsFound;
		$TotalQs = ($TotalOff+$TotalOn);
		//====----
		if($TotalOn < 2){
			$MyStatusIcon = "pwroff.jpg";
			$MyStatusHint = "You need to add some questions!";
			$MySetStatusLink = "<a href='JavaScript:alert(\"Please add at least two active questions.\")' ><img src='".$MyIconsPath.$MyStatusIcon."' title='".$MyStatusHint."' alt='".$MyStatusHint."' width='23' height='19'></a>";
		}
		//====----
		$MyListing .= " <span class='ListHLite'>Name:</span><b>".$row->SetName."</b>
						<br><span class='ListHLite'>Description:</span>".$row->SetDesc."
						<br><span class='ListHLite'>Status:</span>".$row->Status." With ".$TotalQs." questions added, ".$TotalOn." on and ".$TotalOff." switched off.
						<br><span class='ListHLite'>Added on:</span>".$row->DateAdded."
						<br><br>
						".$MySetStatusLink.$MyEditLink.$MyQListLink."
  						<hr size='1' noshade color='#66CCFF'>\n";
	}
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
function ConfRem(SetNum){
	if(confirm("Sure, remove this set? All its questions will be deleted too!")){
		if(confirm("LAST CHANCE! The set AND all its questions will be deleted too!")){
			location = "index.php?option=com_mediqna&amp;task=remove&amp;id="+SetNum;
		}
	}
}
</script>

<body bgcolor="#FFFFFF">

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="600" valign="top"><a href="index.php?option=com_mediqna&act=newset" target="_self"><img src="<?php print $MyIconsPath; ?>QnA-QSets.jpg" alt="Add a set" width="358" height="84" border="0" title="Add a set"></a>
      <h3><a href="index.php?option=com_mediqna&act=newset" target="_self"><img src="<?php print $MyIconsPath; ?>plus.jpg" title="Add a new set?" alt="Add a new set?" width="23" height="19" border="0" align="absmiddle"></a> Add a new question-set to the listing?</h3>
      <hr size="1" noshade color='#66CCFF'>
	  
<?php print $MyListing; ?>    </td>
    <td width="12" valign="top">&nbsp;</td>
    <td width="378" rowspan="3" valign="top"><img src="<?php print $MyIconsPath; ?>MediQnA-Logo.jpg" title="Medi-QnA" alt="Medi-QnA" width="194" height="132" border="0"><br>
      <br>
      <h3>New installation?<br>
      Begin by adding <img src="<?php print $MyIconsPath; ?>plus.jpg" title="Add Set" alt="Add Set" width="23" height="19" align="absmiddle"> your first question set. </h3>
    <ul>
        <li>You can have as many sets as you need.</li>
        <li>Each set can have as many questions as you want.</li>
        <li>Sets can be switched 'on' and 'off' meaning, if you switch a set 'off' it will not appear on the public part of your website.</li>
        <li>New sets are 'off' by default because until they have some questions added there is nothing to publish. So a set must have at least two questions <em>(you can't really call one question a 'set' )</em> before it can be switched 'on', both questions must also be set to 'on'.</li>
        <li>Questions can be switched 'on' or 'off' as needed.</li>
        <li>New questions are 'on'  by default.</li>
        <li>Switching a set 'off' also switches its questions off. </li>
      </ul>
	  
	  <p>Once you've added your first set you can add questions to it. Click the <img src="<?php print $MyIconsPath; ?>yes.jpg" title="Add Questions" alt="Add Questions" width="23" height="19" align="absmiddle"> icon to see the questions page. </p>
	  <p>If you want to edit your set just click the <img src="<?php print $MyIconsPath; ?>edit.jpg" title="Edit Set" alt="Edit Set" width="23" height="19" align="absmiddle"> icon to go to the edit page.</p>
	  <p>If you want to switch your set 'off  ' just click the icon <img src="<?php print $MyIconsPath; ?>pwroff.jpg" title="Switch off" alt="Switch off" width="23" height="19" align="absmiddle"> to change its status immediately. Likwise, clicking the <img src="<?php print $MyIconsPath; ?>pwron.jpg" title="Switch on" alt="Switch on" width="23" height="19" align="absmiddle"> icon switches it on but only if it has at least two questions that are also switched on. </p>
	  	  <h3>Your Readers...</h3>
	  <p>Use the Joomla! menu manager to add a link to the MediQnA default page, Visitors to your website will then be taken to the latest added and published set. If you prefer you can link the menu to the listing page. </p>
	  </td>
  </tr>
</table>
</body></html>