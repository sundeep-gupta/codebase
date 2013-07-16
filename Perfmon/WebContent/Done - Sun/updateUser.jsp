<!-- To select a user to be updated from the users list -->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>
<%
// If a user is selected then it will display the details of the user to be updated 
if(session.getAttribute("userid")!=null ) {
%>
<link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<HTML>
	<HEAD>
		<TITLE> Delete User</TITLE>
<script>
function checkOnSubmit(form)
{

if(form.selectUserNames.selectedIndex=="")
    {
    alert("Select USER"); 
	form.selectUserNames.focus();
	return false;
	}


	return true;
}
</script>
	<link href="css/CFP_per.css" rel="stylesheet" type="text/css">

	</HEAD>

	<BODY>
		
		<CENTER>
         <form name=updateUserFrm onSubmit="return checkOnSubmit(updateUserFrm);" action="editUserDetails.jsp" method=post> 
		 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
         <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;UPDATE USER</td></tr>
		<tr> 
          <td align="center" valign="middle"> 
		<table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
              <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>User Name :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left>
                  <select name=selectUserNames class="select">
			   <option value="">&nbsp;&nbsp;&nbsp;Select User&nbsp;&nbsp;&nbsp;&nbsp;</option>
		 
<%
    try {
	Connection C = getConnection();
	Statement stmt = C.createStatement();
	ResultSet showUsers = stmt.executeQuery("select userid, username from users order by username");
	while(showUsers.next()) {
            out.println("<option value="+showUsers.getString(1)+">"+showUsers.getString(2)+"</option>");
	}
	showUsers.close();
	stmt.close();
	C.close();
    } catch (Exception E) {
	out.println("SQLException: " + E.getMessage());
    }
%>
				   </select>
				</td>
				 <tr> 
                <td colspan="3" height="30" align="center"><font face="verdana" size="1">
                 <INPUT TYPE="Submit" Value="&nbsp;UPDATE&nbsp;" class="Button">
                 </font></td>
              </tr>
		</table>
		</TD>
		</tr>
	</table>
  </td>
 </tr>
</table>
</form>
</center>
</BODY>
</HTML>
<%
} else {
%>
    <jsp:forward page="index.jsp" />
<%
}
%>