<!--To Delete customer details from the Database  -->
<%@ include file="escapechars.jsp" %>
<%@ include file="connection.jsp" %>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">

<%
if(session.getAttribute("userid")!=null )
{
%>

<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
int custid = Integer.parseInt(request.getParameter("selectCustNames"));
try
	{
	%>
		 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
		<tr>
		<td bgcolor="#EFF4F9" align="center">
        <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		 <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;DELETE CUSTOMER</td></tr>
		<tr> 
        <td align="center" valign="middle"> 
        <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<td class="fieldnames" ALIGN="CENTER">
	<%
		Connection C = getConnection();

		Statement stmt = C.createStatement();
		
		//Checking whether Users exists in Database For this Customer 
		String SQL="select count(custid) as user from users where custid="+custid;
		ResultSet rs=stmt.executeQuery(SQL);
		rs.next();
		int test = rs.getInt(1);
		if (test!=0)
			{
			%>
				<b> There are Users for this Customer Delete Users First </b>
				<br><br><a href="deleteCustomer.jsp"  ><u> Back to Delete Customer</a> 
				 
			<%
			}
			else
			{
					/*int i = deleteCustomer(custid);
					out.println("i = ");
					out.print(i);*/
					Connection C1 = getConnection();
					Statement stmt1 = C1.createStatement();
					String SQLDel="delete from customers where custid="+custid;
					int i=stmt1.executeUpdate(SQLDel);
							if(i==1) {
										%>
											
											<center><b> Customer Deleted Successfully </b><br><b><br><br><a href="deleteCustomer.jsp" ><u> Back to Delete Customer</a> 
											 </center> 
									 <%}
									 else
										{
										%>
											<center><b>Failed in Deleting Customer </b>
											<br><br><a href="javascript:history.back()"  ><u> Back to Delete Customer</a></center>
										<% 
										}
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
	<%}
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