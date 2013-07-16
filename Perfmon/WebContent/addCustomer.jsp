<!--To Add Customer details into the Database -->
<%@ include file="connection.jsp" %>
<%@ include file="escapechars.jsp" %>

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
		<tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;ADD 
        CUSTOMER</td></tr>
		<tr> 
        <td align="center" valign="middle"> 
        <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<TR>
		<td class="fieldnames" ALIGN="CENTER">
		<%
		//Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection C = getConnection();
		//DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");
		Statement stmt = C.createStatement();
		String custname=request.getParameter("txtCname");
		String description = request.getParameter("txtDescription");
		String email = request.getParameter("txtEmail");
		description = single(description);
		email = single(email);
		custname = single(custname);
		description=description.trim();
		email=email.trim();
		custname=custname.trim();
		//Checking whether the Customer already exists in Database
		String SQL="select count(custid) as user from customers where custname='"+custname+"'";
		ResultSet rs=stmt.executeQuery(SQL);
		rs.next();
		int i=0;
		int test = rs.getInt(1);
		if (test!=0)
			{
			%>
				<b> Customer Already exists with the Name <%=custname%> </b><br><br>
				<a href="javascript:history.back()"><u> Back to AddCustomer</a>
					
			<%
			}	
			else
		//Adding new Customer into the Database		
			{	
				//Function call into connect.jsp page to call Stored procedure 
					i=addCustomer(description,email,custname);
					if(i==1)
						{
						%>
									<b> Customer Added Successfully </b><BR><br>
										
									 <table>
									 <tr><td class="fieldnames" align=right> Customer Name   : </td><td class="fieldnames"><%= request.getParameter("txtCname")%></td></tr>
									 <tr><td class="fieldnames" align=right> Description : </td><td class="fieldnames"><%=request.getParameter("txtDescription")%></td></tr>
									 <tr><td class="fieldnames" align=right> Email   : </td><td class="fieldnames"><%=request.getParameter("txtEmail")%></td></tr>
									 </table><br>
									<a href="addCustomer.html"><B><u> Back to AddCustomer</a></B>
									</td>

						<%    
						}
					   else
						{
						%>
						<B>Failed in Adding Customer </b><br><a href="javascript:history.back()"><u> Back to AddCustomer</a>
					
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

%>