<?php 
/*
MediQnA v1.1 : AddQPrep.php
Allows administrator to add a question to a set

Original code (c) Famous Websites 2008
Latest Update: 01-December-2008
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );

//Get the name of the set we're adding too.
$dbh =& JFactory::getDBO();	
$sql = "SELECT SetName FROM qna_QuestionSets WHERE RecID = ".$id;
$dbh->setQuery($sql);
$rows = $dbh->loadObjectList();
$SetName = $rows[0]->SetName;
$MyRemSetLink = "<a href='JavaScript:ConfRem(".$qid.")'><img src='".$MyIconsPath."minus.jpg' align='absmiddle' title='Remove this question' alt='Remove this question' width='23' height='19'>";
//====----
//Now get the stored QnA data
$sql = "SELECT * FROM qna_Questions WHERE RecID = ".$qid;
$dbh->setQuery($sql);
$QnA = $dbh->loadObjectList();
//====----
$editor =& JFactory::getEditor();

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
	if(confirm("Sure, remove this question?")){
		if(confirm("LAST CHANCE! The will be deleted for ever!")){
			document.EdQ.RemQOpt.value = "yes";
			document.EdQ.submit();
		}
	}
}
</script>
<body bgcolor="#FFFFFF">
<form action="" method="post" enctype="multipart/form-data" name="EdQ">
<table width="519" border="0" cellspacing="0" cellpadding="0">
  
  <tr>
    <td colspan="3"><img src="<?php print $MyIconsPath; ?>MediQnA-Logo.jpg" title="Medi-QnA" alt="Medi-QnA" width="194" height="132"><br>
      <h1>Edit a Question in: <?php print $SetName; ?></h1></td>
  </tr>
  <tr>
    <td colspan="3"><hr size="1" noshade color='#66CCFF'></td>
  </tr>
  <tr>
    <td colspan="3">&nbsp;</td>
    </tr>
  <tr>
    <td width="136" height="28" align="right">Title:</td>
    <td height="28">&nbsp;</td>
    <td width="263" height="28"><input name="QAlias" type="text" id="QAlias" size="38" maxlength="32" value = "<?php print $QnA[0]->QAlias; ?>"></td>
  </tr>
  <tr>
    <td height="28">&nbsp;</td>
    <td height="28">&nbsp;</td>
    <td height="28">The title is just a reference you can use to recognise questions within your listing. It will not be published on the website. </td>
  </tr>
  <tr>
    <td height="28">&nbsp;</td>
    <td height="28">&nbsp;</td>
    <td height="28"><hr size="1" noshade color='#66CCFF'></td>
  </tr>
  <tr>
    <td height="28" align="right" valign="top">Question:</td>
    <td width="12" height="28">&nbsp;</td>
    <td height="28"><?php print $editor->display( 'Question',  $QnA[0]->Question, '550', '300', '60', '20', true ); ?></td>
  </tr>
  <tr>
    <td height="28"></td>
    <td height="28"></td>
    <td height="28">&nbsp;</td>
  </tr>
  <tr>
    <td height="28" align="right" valign="top">Answer: </td>
    <td width="12" height="28">&nbsp;</td>
    <td height="28"><?php print $editor->display( 'Answer',  $QnA[0]->Answer, '550', '300', '60', '20', true ); ?></td>
  </tr>
  <tr>
    <td height="28"></td>
    <td height="28"></td>
    <td height="28">&nbsp;</td>
  </tr>
<tr>
    <td align='right'>Status:</td>
    <td width='12'>&nbsp;</td>
    <td><input name='Status' type='radio' value='on' <?php print RadioState('on',$QnA[0]->Status); ?>>on 
        <input name='Status' type='radio' value='off' <?php print RadioState('off',$QnA[0]->Status); ?>>off</td></tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><hr size="1" noshade color='#66CCFF'></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="Update Question"></td>
  </tr>
  <tr>
    <td colspan="3">&nbsp;</td>
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
    <td>Below: Click the minus icon to remove this question. <br>
      <strong>Caution</strong>, this can not be undone!</td>
  </tr>
  <tr>
    <td height="28" align="right">Option:</td>
    <td height="28">&nbsp;</td>
    <td height="28"><?php print $MyRemSetLink; ?> Remove this question?</td>
  </tr>
</table>
	<input name="option" value="com_mediqna" type="hidden">
	<input name="id" value="<?php print $id; ?>" type="hidden">
	<input name="qid" value="<?php print $qid; ?>" type="hidden">
	<input name="RemQOpt" value="no" type="hidden">
	<input name="task" value="UDQProc" type="hidden">
</form>
</body></html>