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
		
		
		int cityid = Integer.parseInt(request.getParameter("txtCityID"));
		String name = request.getParameter("txtName");
		String description = request.getParameter("txtDescription");
		String oldCityID = request.getParameter("oldCityID");


		String SQL = "update cities set CityID="+Cityid+",Name='"+name+",Description='"+description+"' where CityID="+oldCityID ;

		//out.println(SQL);

		int i=stmt.executeUpdate(SQL);

		if(i==1) {
%>
	        <br> <br> <br> <br>
			<center><font color=blue face=verdana size=3><b> City Updated Successfully </b></font><br><b> 
	            
			 <br><br><a href="javascript:history.back()" class=text><font color="blue"><u> Back  to UpdateCity</a>
			 
			 </center> 
              
			 
<%    
        }
 	    else {
%>
		<center><br><br><br><font color=blue face=verdana size=3><b>Failed in Updating City </b></font>
	    
        <br><br><a href="javascript:history.back()" class=text><font color="blue"><u> Back to UpdateCity</a> </center>
<% 
		}//End of Main If
		}//End of try block
		catch (Exception E)
		{
			out.println("SQLException: " + E.getMessage());
		}
%>