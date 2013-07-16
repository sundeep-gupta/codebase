<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td>Hello <b><?php $user =& JFactory::getUser(); echo $user->name; ?></b></td>
</tr>
<tr>
<td>Your Account Balance is <b><?php echo $this->balance; ?></b></td>
</tr>
<tr>
<td>Your current food Choice : <b><?php echo $this->food; ?></b></td></tr>
</table>