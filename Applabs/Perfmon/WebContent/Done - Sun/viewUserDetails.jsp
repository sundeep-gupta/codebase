<!-- To view the details of the selected user -->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>
<%
// To display the details of the selected user
if(session.getAttribute("userid")!=null )
{
%>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%

try
	{
	
	%>
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
		<tr>
		<td bgcolor="#EFF4F9" align="center">
         <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;VIEW USER DETAILS</td></tr>
		<tr> 
          <td align="center" valign="middle"> 
	<%
		

		Connection C = getConnection();
		

		Statement stmt = C.createStatement();
		
		String param = request.getParameter("selectUserNames");

        int findString = param.indexOf("$#$");

		String UserID = param.substring(0,findString);

		int custid = Integer.parseInt(param.substring(findString+3,param.length()));

		

		String SQL = "select * from users,customers where USERID='"+UserID+"' and users.CUSTID=customers.custid";

		

		ResultSet rs=stmt.executeQuery(SQL);

		rs.next();

%>
	       	<table>
             
			 <tr><td class=fieldnames align=right> UserID   : </td><td class=fieldnames><%=rs.getString(1)%></td></tr>
			
			 <tr><td class=fieldnames align=right> CustName   : </td><td class=fieldnames><%=rs.getString(9)%></td></tr>
			</table>
			<br><br>
			<a href="viewUser.jsp"><b>Back to View Users</B>
<% 
	C.close();
	}
	catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }

				   }

else {
%>
		<jsp:forward page="index.jsp" />
<%
}

%>