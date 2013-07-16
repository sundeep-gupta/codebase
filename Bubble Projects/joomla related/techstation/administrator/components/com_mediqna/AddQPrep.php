<?php 
/*
MediQnA v1.1 : AddQPrep.php
Allows administrator to add a question to a set

Original code (c) Famous Websites 2008
Latest Update: 10-December-2008
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );

//Get the name of the set we're adding too.
$dbh =& JFactory::getDBO();	
$sql = "SELECT SetName FROM qna_QuestionSets WHERE RecID = ".$id;
$dbh->setQuery($sql);
$rows = $dbh->loadObjectList();
$editor =& JFactory::getEditor();
?>

<html>
<style type="text/css">
<!--
.ListHLite {
	color: #3366CC;
}
-->
</style>

<body bgcolor="#FFFFFF">
<form action="" method="post" enctype="multipart/form-data" name="AddQSet">
<table width="519" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="3"><img src="<?php print $MyIconsPath; ?>QnA-AddQuestion.jpg" title="Add a question" alt="Add a question"></td>
  </tr>
  <tr>
    <td colspan="3"><h1>Part of  set: <?php print $rows[0]->SetName; ?></h1></td>
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
    <td height="28" align="right">Title:</td>
    <td height="28">&nbsp;</td>
    <td height="28"><input name="QAlias" type="text" id="QAlias" size="38" maxlength="32"></td>
  </tr>
  <tr>
    <td height="28">&nbsp;</td>
    <td height="28">&nbsp;</td>
    <td height="28">The title is just a reference you can use to recognise questions within your listing. It will not be published on the website. </td>
  </tr>
  <tr>
    <td height="28"></td>
    <td height="28"></td>
    <td height="28"><hr size="1" noshade color='#66CCFF'></td>
  </tr>
  <tr>
    <td height="28" align="right" valign="top">Question:</td>
    <td width="12" height="28">&nbsp;</td>
    <td height="28"><?php print $editor->display( 'Question',  $field_value, '550', '300', '60', '20', true ); ?></td>
  </tr>
  <tr>
    <td height="28"></td>
    <td height="28"></td>
    <td height="28"></td>
  </tr>
    <tr>
    <td colspan="3"><img src="<?php print $MyIconsPath; ?>QnA-AddAnswer.jpg" title="Add an answer" alt="Add an answer"></td>
  </tr>
      <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr>
    <td height="28" align="right" valign="top">Answer:</td>
    <td width="12" height="28">&nbsp;</td>
    <td height="28"><?php print $editor->display( 'Answer',  $field_value, '550', '300', '60', '20', true ); ?></td>
  </tr>
  <tr>
    <td height="28"></td>
    <td height="28"></td>
    <td height="28">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" valign="top">Status:</td>
    <td width="12">&nbsp;</td>
    <td>New questions are set to 'on' by default. Adding to question set:<?php print $rows[0]->SetName; ?></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><hr size="1" noshade color='#66CCFF'></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="Add Question and its Answer"></td>
  </tr>
</table>
	<input name="option" value="com_mediqna" type="hidden">
	<input name="id" value="<?php print $id; ?>" type="hidden">
	<input name="task" value="AddQProc" type="hidden">
</form>
</body></html>