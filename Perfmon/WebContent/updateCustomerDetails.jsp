<!-- Update Customer Details in Database-->
<%@ include file="escapechars.jsp" %>
<%@ include file="connection.jsp" %>
<%
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
		 <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;UPDATE CUSTOMER</td></tr>
		<tr> 
        <td align="center" valign="middle"> 
        <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<td class="fieldnames" ALIGN="CENTER">
	<%

		//Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection C = getConnection();
		//DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");

		Statement stmt = C.createStatement();
	
		int custid = Integer.parseInt(request.getParameter("NewCustID"));
		String description = request.getParameter("txtDescription");
		String email = request.getParameter("txtEmail");
		String custname= request.getParameter("txtCustName");
		//Check whether customer exists in the database
		String SQL = "select count(*) from customers where custname='"+custname+"' and custid="+custid;
		ResultSet rs=stmt.executeQuery(SQL);
		rs.next();
		int test = rs.getInt(1);

		if(test==1)
		{
			
			/*String SQL = "update Customers set CUSTID="+custid+",DESRIPTION='"+description+"',EMAIL='"+email+"' where CUSTID="+oldCustID ;

			out.println(SQL);

			int i=stmt.executeUpdate(SQL);*/

			// calling the stored procedure for updating the customer details 

				int i = updateCustomer(custid,custname,description,email);

				if(i==1)
					{
					%>
					<center><b> Customer Updated Successfully </b></font><br><b><br><br>
					<a href="javascript:history.back()">Back to UpdateCustomer</a>
					 </center>
					<%}
					else
					{
					%>
					<center><b>Failed in Updating Customer </b>
					<br><br><a href="javascript:history.back()">Back to UpdateCustomer</a>
					</center>
					<%    
					 }
		}
		else
		{
			
					Connection C1 = getConnection();
					Statement stmt1 = C1.createStatement();
					SQL="select count(*) from customerS where custname='"+custname+"'";
					ResultSet rs1=stmt1.executeQuery(SQL);
					rs1.next();
					int test1 = rs1.getInt(1);
					if(test1==1)
					{
					%>	
					
					<center><b> Customer Exists with Name <%=custname%></b><br><b> 
					<br><br><a href="javascript:history.back()" >Back to UpdateCustomer</a>
					</center> 
					<% 
					}
					 else
					{	
						int j = updateCustomer(custid,custname,description,email);
					%>
						
					<center><b> Customer Updated Successfully </b><br><BR><b> 
					 <br><br><a href="javascript:history.back()">Back to UpdateCustomer</a>
					 </center>
					<%

					}
		}
		
		//End of Main If
		}//End of try block

		catch (Exception E)
		{
			out.println(E.getMessage());
		}

  }

else {
%>
		<jsp:forward page="index.jsp" />
<%
}

%>