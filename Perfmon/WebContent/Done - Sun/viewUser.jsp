<!-- To select the user name from the option to view -->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>

<%
// To display the user names from the users table to view
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
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<script>
function checkOnSubmit(form)
{

if(form.selectUserNames.selectedIndex==0)
    {
    alert("Select USER"); 
	form.selectUserNames.focus();
	return false;
	}


	return true;
}
</script>

	</HEAD>

	<BODY>
		
		<CENTER>
         <form name=viewUserFrm onSubmit="return checkOnSubmit(viewUserFrm);" action="viewUserDetails.jsp" method=post> 
			 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
         <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;VIEW USER</td></tr>
		<tr> 
          <td align="center" valign="middle"> 
		<table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
              <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>User Name :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left> 
                  <select name=selectUserNames class="select">
			   <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Select User&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
       
<%

    try {
        Connection C = getConnection();
        Statement stmt = C.createStatement();

        String SQL = "select USERID,USERNAME,users.CUSTID from users,customers where users.CUSTID=customers.CUSTID and usertype <> 0 order by username";

        ResultSet rs=stmt.executeQuery(SQL);

        while(rs.next()) {
            out.println("<option value="+rs.getString(1)+"$#$"+rs.getInt(3)+">"+rs.getString(2)+"</option>");
	}
	C.close();
    } catch (Exception E) {
        out.println("SQLException: " + E.getMessage());
    }
%>
			   </select>
				</td>
				 <tr> 
                <td colspan="3" height="30" align="center"><font face="verdana" size="1">
                 <INPUT TYPE="Submit" Value="VIEW DETAILS" class="Button">
                 </font></td>
              </tr>
		</table>
		</TD>
		</tr>
	</table>
  </td>
 </tr>
</table>
		</CENTER>
	</BODY>
</HTML><%
    } else {
%>
		<jsp:forward page="index.jsp" />
<%
}

%>