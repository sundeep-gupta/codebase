<?php 
/*
MediQnA v1.1 : EditQSet.php
Allows administrator to edit a set

Original code (c) Famous Websites 2008
Latest Update: 01-December-2008
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );
//====----
$dbh =& JFactory::getDBO();	
$sql = "SELECT * FROM qna_QuestionSets WHERE RecID = ".$id;
$dbh->setQuery($sql);

$SetVars = array();
$SetVars = $dbh->loadObjectList();
if (!$result = $dbh->query()) {
	Dropout($dbh->stderr(),"index.php");
}
//There must be at least two questions assigned to this
//set for the user to set it to 'on'

$sql = "SELECT count(RecID) as NumQs FROM qna_Questions WHERE AssignedSet = ".$id." AND Status = 'on'";
$dbh->setQuery($sql);
$Ques = $dbh->loadObjectList();

$MyStatus = "<tr>
				<td valign='top' align='right'>Status</td>
				<td>&nbsp;</td>
				<td>A question set with less than two questions is automatically set to 'off'. You can not set the status to 'on' until the set has at least two questions added to it.</td>
		    </tr>";

$MyStatusSwitch = "<input name='Status' value='off' type='hidden'>";
$MyRemSetLink = "<a href='JavaScript:ConfRem(".$id.")'><img src='".$MyIconsPath."minus.jpg' align='absmiddle' title='Remove this set' alt='Remove this set' width='23' height='19'>";

if($Ques[0]->NumQs > 1){
	//There's at least two questions
	//the user can switch it on if they wish
	$MyStatus = CheckStatus($SetVars[0]->Status);
	unset($MyStatusSwitch);
}

//====----
//Whether or not to show the user the status settings
function CheckStatus($FoundStatus){
$HTMLFrag = "<tr>
    <td align='right'>Set Status:</td>
    <td width='12'>&nbsp;</td>
    <td><input name='Status' type='radio' value='on' ".RadioState('on',$FoundStatus).">on 
        <input name='Status' type='radio' value='off' ".RadioState("off",$FoundStatus).">off</td></tr>";

	//Don't need to pass a hidden var anymore
	$MyStatusSwitch = "";
	return $HTMLFrag;
}
//====----
//If we're showing the stus settings, set the radio
function RadioState($Radio,$DBSetting){
	if($Radio == $DBSetting){
		return "CHECKED";
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
			document.EditSet.RemQSet.value = "yes";
			document.EditSet.submit();
		}
	}
}
</script>

<body bgcolor="#FFFFFF">
<form name="EditSet" method="post" action="">
<table width="519" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="3"><img src="<?php print $MyIconsPath; ?>MediQnA-Logo.jpg" title="Medi-QnA" alt="Medi-QnA" width="194" height="132"><br>
     <h1>Edit this question set</h1></td>
  </tr>
  <tr>
    <td colspan="3"><hr size="1" noshade color='#66CCFF'></td>
  </tr>
  <tr>
    <td width="136">&nbsp;</td>
    <td width="12">&nbsp;</td>
    <td width="263">&nbsp;</td>
  </tr>
  <tr>
    <td height="28" align="right">Set name:</td>
    <td width="12" height="28">&nbsp;</td>
    <td height="28"><input name="SetName" type="text" id="Setname" size="38" maxlength="32" value = "<?php print $SetVars[0]->SetName; ?>"></td>
  </tr>
  <tr>
    <td height="28" align="right">Set Description:</td>
    <td width="12" height="28">&nbsp;</td>
    <td height="28"><input name="SetDesc" type="text" id="SetDesc" size="38" maxlength="64" value = "<?php print $SetVars[0]->SetDesc; ?>"></td>
  </tr>
<?php print $MyStatus; ?>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><hr size="1" noshade color='#66CCFF'></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="Update Set"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="28" align="right">Back:</td>
    <td height="28">&nbsp;</td>
    <td height="28"><a href="index.php?option=com_mediqna" target="_self"><img src="<?php print $MyIconsPath; ?>left.jpg" alt="Go back" width="23" height="19" border="0" align="absmiddle" title="Go back"></a> Back to Medi-QnA Start Page?</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><hr size="1" noshade color='#66CCFF'></td>
  </tr>
    <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>Below: Click the minus icon to remove this set. <br>
      <strong>Caution</strong>, all questions associated with this set will also be removed. This can not be undone! </td>
  </tr>
  <tr>
    <td height="28" align="right">Option:</td>
    <td height="28">&nbsp;</td>
    <td height="28"><?php print $MyRemSetLink; ?> Remove this set?</td>
  </tr>
</table>
	<input name="option" value="com_mediqna" type="hidden">
	<input name="id" value="<?php print $id;?>" type="hidden">
	<input name="task" value="EditQSetProc" type="hidden">
	<input name="setname" value="<?php print $SetVars[0]->SetName; ?>" type="hidden">
	<input name="RemQSet" value="no" type="hidden">
	<!--Set name hidden var just saves us bothering the DB if the user wants to add a question-->
	<?php print $MyStatusSwitch; ?>
</form>
</body></html>