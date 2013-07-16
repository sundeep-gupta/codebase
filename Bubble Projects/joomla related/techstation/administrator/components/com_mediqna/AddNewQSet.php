<?php 
/*
MediQnA v1.1 : AddNewQSet.php
Allows administrator to add a set

Original code (c) Famous Websites 2008
Latest Update: 10-December-2008
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );
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
    <td height="53" colspan="3"><img src="<?php print $MyIconsPath; ?>QnA-AddSet.jpg" title="Add a set" alt="Add a set"></td>
  </tr>
  <tr>
    <td colspan="3"><hr size="1" noshade color='#66CCFF'></td>
  </tr>
  
  <tr>
    <td width="136" height="28" align="right">Set name:</td>
    <td width="12" height="28">&nbsp;</td>
    <td width="263" height="28"><input name="SetName" type="text" id="Setname" size="38" maxlength="32" value = "<?php print $SetVars[0]->SetName; ?>"></td>
  </tr>
  <tr>
    <td height="28" align="right">Set description </td>
    <td width="12" height="28">&nbsp;</td>
    <td height="28"><input name="SetDesc" type="text" id="SetDesc" size="38" maxlength="64" value = "<?php print $SetVars[0]->SetDesc; ?>"></td>
  </tr>
  <tr>
    <td align="right" valign="top">Set status:</td>
    <td width="12">&nbsp;</td>
    <td>When adding a new set the status is automatically set to 'off'. You can not set the status to 'on' until the set has at least two questions added to it. </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><hr size="1" noshade color='#66CCFF'></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="Add Set"></td>
  </tr>
</table>
	<input name="option" value="com_mediqna" type="hidden">
	<input name="id" value="0" type="hidden">
	<input name="task" value="MediQnAAddSet" type="hidden">
</form>
</body></html>