<link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%

try
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	}
	catch (Exception E)
	{
		E.printStackTrace();
	}
	try
	{
		Connection C = DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");

		Statement stmt = C.createStatement();
		
		String UserID = request.getParameter("selectCustNames");

		String SQL = "select * from customers where CustID='"+CustID+"'" ;

		//out.println(SQL);

		ResultSet rs=stmt.executeQuery(SQL);

		rs.next();

%>
	        <br> <br> 
			 <center>   
			<table>
             <tr><td class=bigtext height=70 colspan=2 align=center>User Details </td></tr> 
			 <tr><td class=text align=right> CustID   : </td><td class=text><%=rs.getInt(1)%></td></tr>
			 <tr><td class=text align=right> Description : </td><td class=text><%=rs.getString(2)%></td></tr>
			 <tr><td class=text align=right> Email   : </td><%=rs.getString(3)%><td class=text><%=Integer.parseInt(rs.getString(3))%></td></tr>
			
			 </table>
			<br><br>
			<a href="javascript:history.back()" class=text><font color=blue><u> Back  to View Customers</a>
			 
			 </center> 
              
			 
<% 

	}
	catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
%>