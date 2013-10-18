<!-- The values provided for the user to update will be updated to the users table in the database -->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>
<%
// for a selected users the update values given will be updated to the users table in the database
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
		 <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;CHANGE PASSWORD</td></tr>
		<tr> 
        <td align="center" valign="middle"> 
        <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<td class="fieldnames" ALIGN="CENTER">
	<%
		
		Connection C = getConnection();
		Statement stmt = C.createStatement();
		Statement stmt1 = C.createStatement();
		int i=0;
		String useridstr=(String)session.getAttribute("userid");
		String oldpwd = request.getParameter("txtOldPass");
		String newpwd = request.getParameter("txtNewPass");
		String confirmpwd = request.getParameter("txtConfPass");
		oldpwd = single(oldpwd);
		oldpwd=oldpwd.trim();
        String SQL="";
		String SQL1 = "insert into tempuser(userid,password) values('"+useridstr+"',PASSWORD('"+oldpwd+"'))";
		int j=stmt1.executeUpdate(SQL1);
		if(j>0)
			{
				String s="SELECT  u.password,tu.password FROM users u,tempuser tu where u.userid=tu.userid and u.userid='"+useridstr+"'";
				ResultSet rs=stmt.executeQuery(s);
				rs.next();
				String opwd=rs.getString(1);
				String temppwd=rs.getString(2);		
				if(opwd.equals(temppwd))
					{
						SQL = "update users set Password=password('"+newpwd+"') where USERID='"+useridstr+"' ";
						i=stmt.executeUpdate(SQL);
					}
				else
					{
					
				%>
					<center><b>Please Enter correct old password for the User</b><b> <br><br>
					<a href="javascript:history.back()" ><u> Back  to Change Password</a>
					 </center> 
					  
				<%}
				if(i==1) {
				%>
					<center><b>Password Updated Successfully </b><b> <br><br>
					  <a href="javascript:history.back()" ><u> Back  to Change Password</a>
					 </center> 
					  
				<%    
				}
				
				C.close();
				
				}
				
		stmt1.executeUpdate("delete from tempuser");
		
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