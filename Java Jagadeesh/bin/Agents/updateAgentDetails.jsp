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
		
		
		int agentid = Integer.parseInt(request.getParameter("txtAgentID"));
		String ip = request.getParameter("txtIp");
//		String email = request.getParameter("txtEmail");
		String oldAgentID = request.getParameter("oldAgentID");


		String SQL = "update agents set AGENTID="+agentid+",IP='"+ip+"' where AGENTID="+oldAgentID ;

		//out.println(SQL);

		int i=stmt.executeUpdate(SQL);

		if(i==1) {
%>
	        <br> <br> <br> <br>
			<center><font color=blue face=verdana size=3><b> Agent Updated Successfully </b></font><br><b> 
	            
			 <br><br><a href="javascript:history.back()" class=text><font color="blue"><u> Back  to UpdateAgent</a>
			 
			 </center> 
              
			 
<%    
        }
 	    else {
%>
		<center><br><br><br><font color=blue face=verdana size=3><b>Failed in Updating Agent </b></font>
	    
        <br><br><a href="javascript:history.back()" class=text><font color="blue"><u> Back to UpdateAgent</a> </center>
<% 
		}//End of Main If
		}//End of try block
		catch (Exception E)
		{
			out.println("SQLException: " + E.getMessage());
		}
%>