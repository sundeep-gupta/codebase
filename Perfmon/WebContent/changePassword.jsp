<HTML>
	<HEAD>
		<TITLE> User Settings </TITLE>

		<script>
		/* 
		
		Validation on old password,new Password and Confirm Password
		
		*/
function checkOnSubmit(form)
{
	var Space=/[^" "]/;
	var newpwd=form.txtNewPass.value;
	var confirmpwd=form.txtConfPass.value;

	if(form.txtOldPass.value=="" || (Space.test(form.txtOldPass.value)==false))
		{
		alert("Old Password Should not be NULL"); 
		form.txtOldPass.focus();
		return false;
		}

	if(form.txtNewPass.value==""|| (Space.test(form.txtNewPass.value)==false)) 
		{
		alert("New Password Should not be NULL"); 
		form.txtNewPass.focus();
		return false;
		}
	if(form.txtConfPass.value=="" || (Space.test(form.txtConfPass.value)==false))
		{
		alert("Confirm Password  Should not be NULL"); 
		form.txtConfPass.focus();
		return false;
		}
	if(newpwd!=confirmpwd)
		{
		alert("New Password & Confirm Password Should match"); 
		form.txtConfPass.focus();
		return false;		
		}
		return true;
}
/*
	Setting title of Change Password Page
*/
function setTitle(){
	parent.document.title = parent.frame3.document.title;
}


</script>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
 </HEAD>

	<BODY onLoad="javascript:setTitle()">
		
		<CENTER>
		  <form name="passwordForm" onSubmit="return checkOnSubmit(passwordForm	);" action="updatePassword.jsp" method=post>
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
          <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;CHANGE PASSWORD 
            </td></tr>
		<tr> 
          <td align="center" valign="middle"> 
            <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
              <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>Old Password :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtOldPass" type="password" class="textfield" size="12">
                  </font></td>
              </tr>
			   <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>New Password :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtNewPass" type="password" class="textfield" size="12">
                  </font></td>
              </tr>

              <tr> 
                <td   align="right" class="fieldnames"><b>Confirm New Password :</b></td>
                <td>&nbsp;</td>
                <td align=left><font face="verdana" size="1"> 
                  <input name="txtConfPass" type="password" class="textfield" size="12">
                  </font></td>
              </tr>
			    <tr> 
                <td width="47%"   align="right"><b></b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" height="30" align=left><font face="verdana" size="1"> &nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="submit" class="Button" value="&nbsp;Submit&nbsp;"s>
                  </font></td>
              </tr>
		</table>
		</TD>
		</tr>
	</table>
		</form>	
		</CENTER>
	</BODY>
</HTML>