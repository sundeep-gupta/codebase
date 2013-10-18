<!-- To delete a user from the users table-->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>

<%
// Displays the option to select UserName from the users to delete a user.
if(session.getAttribute("userid")!=null ) {
%>
<link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">

<HTML>
	<HEAD>
		<TITLE> Delete User</TITLE>
		<link href="birt.css" rel="stylesheet" type="text/css">

	</HEAD>

	<BODY>
		
		<CENTER>
         <form name=deleteUserFrm action="deleteUserDetails.jsp" method=post> 
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
		<tr>
		<td bgcolor="#EFF4F9" align="center">
         <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=3>&nbsp;&nbsp;DELETE 
            USER</td></tr>
			<tr> 
          <td align="center" valign="middle"> 
            <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<tr>
			<td width="47%"   align="right" class="fieldnames"><b>User Name :</b></td>
            <td width="2%">&nbsp;</td>
            <td width="51%" height="30" align=left><SELECT name="selectUserNames" class="select">
			<option value="">&nbsp;&nbsp;&nbsp;&nbsp;Select User&nbsp;&nbsp;&nbsp;&nbsp;</option>
			
<%
    try {
        Connection C = getConnection();
        Statement stmt = C.createStatement();
        String recCountQry = "select count(*) as rowCount from users ";
        ResultSet r = stmt.executeQuery(recCountQry);
        r.next();
        int ResultCount = r.getInt("rowCount") ;
        r.close() ;
        String SQL = "select USERID,USERNAME from users,customers where users.CUSTID=customers.CUSTID and usertype <> 0 order by username";
        ResultSet rs=stmt.executeQuery(SQL);
        while(rs.next()) {
            out.println("<option value='"+rs.getString(1)+"'>"+rs.getString(2)+"</option>");
	}
	C.close();
    } catch (Exception E) {
	out.println("SQLException: " + E.getMessage());
    }
%>
			 
			    </select> 
                  </font>
				</td>
				</tr>
				 <tr> 
                <td colspan="3" height="30" align="center"><font face="verdana" size="1">
                  <INPUT TYPE="Submit" Value="&nbsp;DELETE&nbsp;" class="Button">
                  </font></td></tr>
			</table>
		 </td>
        </tr>
	   </table>
		</td>
        </tr>
	   </table>
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