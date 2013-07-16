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
		
		
		int custid = Integer.parseInt(request.getParameter("txtCustID"));
		String description = request.getParameter("txtDescription");
		String email = request.getParameter("txtEmail");
		String oldCustID = request.getParameter("oldCustID");


		String SQL = "update Customers set CUSTID='"+custid+"',DESRIPTION='"+description+"',E-MAIL="+email+" where CUSTID='"+oldCustID+"'" ;

		//out.println(SQL);

int i=stmt.executeUpdate(SQL);

if(i==1) {
%>
	        <br> <br> <br> <br>
			<center><font color=blue face=verdana size=3><b> Customer Updated Successfully </b></font><br><b> 
	            
			 <br><br><a href="javascript:history.back()" class=text><font color="blue"><u> Back  to UpdateCustomer</a>
			 
			 </center> 
              
			 
<%    
        }
	   else {
%>
		<center><br><br><br><font color=blue face=verdana size=3><b>Failed in Updating Customer </b></font>
	    
        <br><br><a href="javascript:history.back()" class=text><font color="blue"><u> Back to UpdateCustomer</a> </center>
<% 
		}
	}
	catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
%>