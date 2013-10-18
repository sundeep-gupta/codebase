<!-- To delete the user from the users table in the database-->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">

<%

// If a user is selected from the user name option then a selected user will be deleted, else a message will be displayed  that failed in deleting user.

if(session.getAttribute("userid")!=null ) {
%>

<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
    String userid = request.getParameter("selectUserNames");
    try {
%>
		 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
		<tr>
		<td bgcolor="#EFF4F9" align="center">
        <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		 <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;DELETE USER</td></tr>
		<tr> 
        <td align="center" valign="middle"> 
        <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<td class="fieldnames" ALIGN="CENTER">
<%	
        Connection C = getConnection();
        Statement stmt = C.createStatement();
        String SQL = "delete from users where USERID='"+userid+"'";
        int i=stmt.executeUpdate(SQL);

        if(i==1) {
%>
					<center><b> User Deleted Successfully </b><br><b><br><br><a href="deleteUser.jsp">Back to Delete User</a> 
					</center> 
					 
<%
        }
        else {
%>
					
				<b>Failed in Deleting User </b>
				<br><br><a href="javascript:history.back()"><b> Back to Delete User</b></a>
<% 
        } 
        C.close();
    } catch (Exception E) {
        out.println("SQLException: " + E.getMessage());
    }
} else {
%>
    <jsp:forward page="index.jsp" />
<%
}
%>