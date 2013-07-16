<link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
Int agentid = request.getParameter("selectAgentID");
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

String SQL = "delete from agents where AGENTID='"+agentid+"'";
		 
int i=stmt.executeUpdate(SQL);

if(i==1) {
%>
	        <br> <br> <br> <br>
			<center><font color=blue face=verdana size=3><b> Agent Deleted Successfully </b></font><br><b> 
	            
			 <br><br><a href="javascript:history.back()" class=text><font color=blue><u> Back to Delete Agent</a> 
			 
			 </center> 
              
			 
<%    
        }
	   else {
%>
		<center><br><br><br><font color=blue face=verdana size=3><b>Failed in Deleting Agent </b></font>
	    
        <br><br><a href="javascript:history.back()" class=text><font color=blue><u> Back to Delete Agent</a> </center>
<% 
		}
	}
	catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
%>