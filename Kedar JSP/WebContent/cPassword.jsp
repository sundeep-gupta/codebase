<%
if(((String)session.getAttribute("user")).equals("admin")){
%>

<html>

<head>
<link href="css/styles.css" rel="stylesheet" type="text/css">
</head>

<body>
<table bgcolor="#AC5CEE" border="0" width="100%" height="100%">
<tr>
<td>

<table border="0" width="100%" height="100%" bgcolor="white">
<tr align="center" valign="middle">
	<td>

<table border="0" width="350" height="150" align="center" bgcolor="">
<form name="cPasswd" action="/kndn/acSettings.jsp">
<input type="hidden" name="message" value="cPasswd" />

<tr  valign="bottom">
	<th colspan="3" class="greenHeadSmall" align="center"> <b> Change Password </b> </th>
</tr>

<tr height="15">
	<td>  </td>
</tr>

<tr>
	<td align="left" width="45%" class="blackdata"> Old Password </td>
	<td> <b> : </b> </td>
	<td align="right"> <input type="password" name="oldPasswd" /> </td>
</tr>

<tr>
	<td align="left" class="blackdata"> New Password </td>
	<td> <b> : </b> </td>
	<td align="right"> <input type="password" name="newPasswd" /> </td>
</tr>

<tr>
	<td align="left" class="blackdata"> Retype New Password </td>
	<td> <b> : </b> </td>
	<td align="right"> <input type="password" name="newPasswd2" /> </td>
</tr>

<tr height="15">
	<td>  </td>
</tr>

<tr>
	<td colspan="3" align="center">	<input type="submit" value="Change" />	</td>
</tr>

</form>
</table>

</td>
</tr>
</table>
</td>
</tr>
</table>

</body>

</html>

<%
}
%>