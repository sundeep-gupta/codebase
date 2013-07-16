<!-- To add the user to the users table in the database-->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*"  %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"   %>
<%@ page import="java.sql.*"  %>
<%

// If the userid is not null and the userid is not same as it is in the users table then it will add the record to the users table else it will display that the user already exists and will not add any record to the users table.

if(session.getAttribute("userid")!="") {
    try {
%>
		 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
		<tr>
		<td bgcolor="#EFF4F9" align="center">
        <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;ADD USER</td></tr>
		<tr> 
        <td align="center" valign="middle"> 
        <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<TR>
		<td class="fieldnames" ALIGN="CENTER">
<%
        String userid=request.getParameter("txtUserID");
        String pwd =request.getParameter("txtPassword");
        String username =request.getParameter("txtUserName");
        userid = addSlashes(userid);
        userid=userid.trim();
        pwd = addSlashes(pwd);
        pwd=pwd.trim();
        username=addSlashes(username);
        username=username.trim();
        int custid=Integer.parseInt(request.getParameter("txtCustID"));
        Connection C = getConnection();
        Statement stmt = C.createStatement();
        String SQL1 = "select count(*) as rowCount from users where USERID='"+userid+"' or USERNAME='"+username+"'";
        ResultSet rs1 = stmt.executeQuery(SQL1);
        rs1.next();
        int count = rs1.getInt("rowCount");
        if(count<1) {
            String SQL = "insert into users(userid,password,custid,username,usertype) values('"+userid+"',PASSWORD('"+pwd+"'),"+custid+",'"+username+"',"+1+")";
            int i=stmt.executeUpdate(SQL);
            if(i==1) {
		Connection Ccname = getConnection();
		Statement stmtcname = Ccname.createStatement();
		String SQLcname="select custname as customer from customers where custid="+custid;
		ResultSet rscname = stmt.executeQuery(SQLcname);
		rscname.next();
		String cname = rscname.getString("customer");
%>
			<center><b>User Added Successfully </b><br><br>
			<table>
			 <tr><td class="fieldnames" align=right> UserID   : </td>
			 <td class="fieldnames"><%=request.getParameter("txtUserID")%></td></tr>
			 <tr><td class="fieldnames" align=right> Password : </td><td class="fieldnames">*****</td></tr>
			 <tr><td class="fieldnames" align=right> Customer Name   : </td><td class="fieldnames"><%=cname%></td></tr>
			 </table>
			<br><a href="javascript:history.back()"><u><b>Back to AddUser<b>
			</a> 			 
			 </center> 
<%
            } else {
%>
			<b>Failed in Adding User</b>
        <br><br><a href="javascript:history.back()"><b><u>Back to Add User</a></b> 	
<%
            }
        } else {
%>
			<b>UserID or UserName Already Exists Please Create a Different One</b>
			<br><br><a href="javascript:history.back()"><u> <b>Back to Add User
			</b></a> 		
<% 
        }
%>
		</td>		
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
} else {
%>
<jsp:forward page="index.jsp" />
<%
}
%>