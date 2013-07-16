<?php 
// no direct access
defined('_JEXEC') or die('Restricted access'); ?>
<h3>Question Sets... </h3>
Here are the question sets we currently have available...
<br><br>
<table width="400" border="0" cellspacing="0" cellpadding="0">
<?php 
	//Print the sets
	if($this->MyFoundSets){
		foreach($this->MyFoundSets as $j=>$k){
			print "<tr>
					<td width='150' align='right' valign='top'>Set Name:</td>
					<td width='12'>&nbsp;</td>
					<td><b>".$k['SetName']."</b></td>
				  </tr>
				  <tr>
					<td width='150' align='right' valign='top'>Set Description:</td>
					<td width='12'>&nbsp;</td>
					<td>".$k['SetDesc']."</td>
				  </tr>
				  <tr>
					<td width='150' align='right' valign='top'>No. Questions:</td>
					<td width='12'>&nbsp;</td>
					<td>".$k['SetNumQs']."</td>
				  </tr>
				  <tr>
					<td width='150' align='right' valign='top'>View:</td>
					<td width='12'>&nbsp;</td>
					<td>Click <a href = 'index.php?option=com_mediqna&view=mediqna&sid=".$k['RecID']."' target = '_self'>HERE</a> to try this question set.</td>
				  </tr>
				  <tr>
					<td width='150'>&nbsp;</td>
					<td width='12'>&nbsp;</td>
					<td><hr size='1' noshade='noshade'></td>
				  </tr>
				  ";
		}
	}else{
		print "Sorry, we do not have any question sets available right now.";
	}
?>  
  <tr>
    <td width="150">&nbsp;</td>
    <td width="12">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>