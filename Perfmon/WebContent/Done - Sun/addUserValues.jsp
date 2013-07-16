<!--To accept the user values for a new user -->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %> 

<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %> 

<%
if(session.getAttribute("userid")!=null ) {
%>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<HTML>
	<HEAD>
		<TITLE>Add User</TITLE>
<script>
function checkOnSubmit(form)
{

	var Space=/[^" "]/;

if(form.txtUserID.value=="" || (Space.test(form.txtUserID.value)==false))
    {
    alert("UserID Should not be NULL"); 
	form.txtUserID.focus();
	return false;
	}
if(form.txtUserName.value=="" || (Space.test(form.txtUserName.value)==false))
    {
    alert("UserName Should not be NULL"); 
	form.txtUserName.focus();
	return false;
	}
if(form.txtPassword.value=="" || (Space.test(form.txtPassword.value)==false))
    {
    alert("Password Should not be NULL"); 
	form.txtPassword.focus();
	return false;
	}
if(form.txtCustID.selectedIndex==0)
    {
    alert("Select CustID"); 
	form.txtCustID.focus();
	return false;
	}
  
	return true;
}


</script>

 </HEAD>
	<BODY>
		<CENTER>
		  <form name=addUserForm onSubmit="return checkOnSubmit(addUserForm);" action="addUser.jsp" method=post>
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
          <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;ADD 
            USER</td></tr>
		<tr> 
          <td align="center" valign="middle"> 
            <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
              <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>UserId:</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtUserID" type="text" class="textfield" size="12">
                  </font></td>
              </tr>
			   <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>User Name:</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtUserName" type="text" class="textfield" size="12">
                  </font></td>
              </tr>

              <tr> 
                <td   align="right" class="fieldnames"><b>Password:</b></td>
                <td>&nbsp;</td>
                <td align=left><font face="verdana" size="1"> 
                  <input name="txtPassword" type="password" class="textfield" size="12">
                  </font></td>
              </tr>
              <tr> 
                <td width="47%"   align="right" class="fieldnames"><b>Customer 
                  Name:</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" height="30" align=left><SELECT name="txtCustID" class="select">
				  <font face="verdana" size="1"> 
			   <option value=""> &nbsp; &nbsp;&nbsp;&nbsp;Select Customer  &nbsp;&nbsp; &nbsp;&nbsp;</option>
<%
    try	{
        Connection C = getConnection();
        Statement stmt = C.createStatement();
        String SQL = "select * from customers where custid not in(0) order by custname";
        ResultSet rs=stmt.executeQuery(SQL);
        while(rs.next()) {
            out.println("<option value="+rs.getString(1)+">"+rs.getString(4)+"</option>");
        }
        //C.close();
    } catch (Exception E) {
	out.println("SQLException: " + E.getMessage());
    }
	//C.close();
%>
			   </select> 
                  </font></td>
              </tr>
				  <tr> 
                <td colspan="3" height="30" align="center"><font face="verdana" size="1">
                  <input type="Submit" class="Button" value="&nbsp;&nbsp;ADD&nbsp;&nbsp;">
                  </font></td>
              </tr>
            </table>
			</td>
              </tr>
            </table>
		</td>
        </tr>
	   </table>
		</form>	
		</CENTER>
	</BODY>
</HTML>
<%
} else {
%>
		<jsp:forward page="index.jsp" />
<%
}
%>