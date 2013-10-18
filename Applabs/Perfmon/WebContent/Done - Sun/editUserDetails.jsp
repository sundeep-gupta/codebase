<!-- To edit the values of the user for the purpose of updating -->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>
<%
// if a user is selected then for a paticular user one can update the values
if(session.getAttribute("userid")!=null ) {
%>
<HTML>
	<HEAD>
		<TITLE>EDIT USER</TITLE>
<script>
function checkOnSubmit(form)
{
	var Space=/[^" "]/;
	
if(form.txtUserID.value=="")
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
if(form.selectCustName.selectedIndex==0)
    {
    alert("Select Customer"); 
	form.selectCustName.focus();
	return false;
	}


	return true;
}
</script>
 </HEAD>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">

<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
    try {
        Connection C = getConnection();
        Statement stmt = C.createStatement();
        String userId = request.getParameter("selectUserNames");
        String query = "select userid, users.custid, custname, username, users.password from users, customers where users.userid=\'" + userId + "\' and users.custid=customers.custid";
        ResultSet rs = stmt.executeQuery(query);
        rs.next();
%>
	
	<BODY>
		
		<CENTER>
		  <form name=addUserForm onSubmit="return checkOnSubmit(addUserForm);" action="updateUserDetails.jsp" method=post>
          <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
          <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;UPDATE  
            USER</td></tr>
		<tr> 
          <td align="center" valign="middle"> 
            <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
              <tr> 
                <td width="47%"  align="right" class="fieldnames" ><b>UserId</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtUserID" type="text" class="textfield"  value="<%=dbl(rs.getString(1))%>" size="12" readonly>
                  </font></td>
              </tr>
			   <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>User Name</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtUserName" value="<%=dbl(rs.getString(4))%>" type="text" class="textfield" size="12">
                  </font></td>
              </tr>

              <tr> 
                <td   align="right" class="fieldnames"><b>Password</b></td>
                <td>&nbsp;</td>
                <td align=left><font face="verdana" size="1"> 
                  <input type=password name="txtPassword" value="<%= rs.getString(5) %>" class="textfield" size="12">
                  </font></td>
              </tr>
              <tr> 
                <td width="47%"   align="right" class="fieldnames"><b>Customer 
                  Name:</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" height="30" align=left>
				 <input type="text" name="txtPassword" value="<%= rs.getString(3) %>" class="textfield" size="12" readOnly>
                 </font></td>
              </tr>
				  <tr> 
                <td width="47%"   align="right"><b></b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" height="30" align=left><font face="verdana" size="1"> &nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="Submit" class="Button" value="&nbsp;UPDATE&nbsp;">
                  </font>
              </tr>
            </table>
			</td>
              </tr>
            </table>
		</td>
        </tr>
	   </table>
<%
    } catch (Exception E) {
        out.println("SQLException: " + E.getMessage());
    }
%>

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