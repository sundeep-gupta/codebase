<link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
     
	try
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		Connection C = DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");

		Statement stmt = C.createStatement();

		int cityid = Integer.parseInt(request.getParameter("selectCityID"));
		
		String SQL = "delete from cities where CITYID="+cityid;
		 
		int i=stmt.executeUpdate(SQL);

		if(i==1) {
%>
	        <br> <br> <br> <br>
			<center><font color=blue face=verdana size=3><b> City Deleted Successfully </b></font><br><b> 
	            
			 <br><br><a href="javascript:history.back()" class=text><font color=blue><u> Back to Delete City</a> 
			 
			 </center> 
              
			 
<%    
        }
	   else {
%>
		<center><br><br><br><font color=blue face=verdana size=3><b>Failed in Deleting City </b></font>
	    
        <br><br><a href="javascript:history.back()" class=text><font color=blue><u> Back to Delete City</a> </center>
<% 
		}
	}
	catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
%>