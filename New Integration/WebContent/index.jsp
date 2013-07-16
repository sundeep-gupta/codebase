<html>
<head>
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="cache-control" content="no-store">
<meta http-equiv="cache-control" content="private">
<meta http-equiv="cache-control" content="max-age=0, must-revalidate">
<meta http-equiv="expires" content="now-1">
<meta http-equiv="pragma" content="no-cache">
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<STYLE>
.text {
color:blue;
font-family:Verdana, Helvetica, sans-serif;
font-size:12px
}
.bigtext {
color:red;
font-family:Verdana, Helvetica, sans-serif;
font-size:15px
}

</STYLE>     
<script>
function checkOnSubmit(form)
{

if(form.txtUserID.value=="")
    {
    alert("UserName Should not be NULL"); 
	form.txtUserID.focus();
	return false;
	}

if(form.txtPassword.value=="")
    {
    alert("Password Should not be NULL"); 
	form.txtPassword.focus();
	return false;
	}

}
</script>

<body bgcolor="#EFF4F9" onload="" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" height=127 cellpadding="0" cellspacing="0" background="images/CFP_top_bar.gif">
<tr>
<td>
<table width="100%" height="60" border="0" cellpadding="0" cellspacing="0" >
              <tr> 
                <td width="50%"><p>&nbsp;</p>
                  <p>&nbsp;</p></td>
                <td width="50%" align="right"><p><img src="images/applogo.gif" width="166" height="54"></p>
                  <p>&nbsp;</p></td>
				<tr><tr><td></td>
				<td width="50%" align="right"></b></a>&nbsp;&nbsp;&nbsp;</td>
				</tr></tr>
              </tr>
 </table>
 </td>
</tr>
</table>
<table border=0 cellspacing=0 cellpadding=0 valign=top width="100%">
<tr><td>&nbsp</td></tr>
<tr><td>&nbsp</td></tr>
<tr><td>&nbsp</td></tr>
<tr><td>&nbsp</td></tr>
<tr><td align=center background="images/dot_bg.gif">
<form name=f1 onSubmit="return checkOnSubmit(f1);" action="login.jsp" method="post">
<table border=0 cellspacing=2 cellpadding=2 valign=top align=center>
<tr><td width=10>&nbsp</td><td colspan=2 height=50 align=center><h5><font color=gray>LOGIN 		</font></h5></td></tr>
<tr>
<td width=18>&nbsp</td><td class="fieldnames">USER ID</td>
<td><input size=35 name=txtUserID value="Enter User Id" class="textfield" onfocus="this.value=''"></td>
</tr>
<tr>
<td width=18>&nbsp </td><td class="fieldnames">PASSWORD</td>
<td><input type=password size=35 name=txtPassword class="textfield"></td>
</tr>
<tr><td width=10>&nbsp</td><td colspan=2 align=center><input type=submit value="&nbsp;&nbsp;Login&nbsp;&nbsp;" class="Button"></td></tr>
</td>
</tr>
</table>
</table>
</body>
</html>
