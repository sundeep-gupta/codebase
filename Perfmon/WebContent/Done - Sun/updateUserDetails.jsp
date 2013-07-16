<!-- The values provided for the user to update will be updated to the users table in the database -->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>
<%
// for a selected users the update values given will be updated to the users table in the database
if(session.getAttribute("userid")!=null ) {
%>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
    try {
%>
		 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
		<tr>
		<td bgcolor="#EFF4F9" align="center">
        <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		 <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;UPDATE USER</td></tr>
		<tr> 
        <td align="center" valign="middle"> 
        <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<td class="fieldnames" ALIGN="CENTER">
<%
        Connection C = getConnection();
        Statement stmt = C.createStatement();
        String userid = request.getParameter("txtUserID");
        String pwd = request.getParameter("txtPassword");
        String username = request.getParameter("txtUserName").trim();
        userid = single(userid);
        username=single(username);
        pwd = single(pwd);
        String updateQuery = "update users set username=\'" + username + "\', password=password(\'" + pwd + "\') where userid=\'" + userid + "\'";
        int isUpdated = stmt.executeUpdate(updateQuery);
        if(isUpdated==1) {
%>
	
			<center><b> User Updated Successfully </b><b> <br><br>
	        <a href="javascript:history.back()" ><u> Back  to UpdateUser</a>
			</center> 
<%    
        } else {
%>
		<center><b>Failed in Updating User </b></font>
	    
        <br><br><a href="javascript:history.back()"><u> Back to UpdateUser</a> 
		</center>
<% 
        }
        stmt.close();
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