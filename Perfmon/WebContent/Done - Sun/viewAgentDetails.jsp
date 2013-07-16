<!--Page is created for Displaying the agent details -->
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

try {
		%>
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
         <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;VIEW AGENT</td></tr>
		<tr> 
          <td align="center" valign="middle"> 
	<%
		//Class.forName("com.mysql.jdbc.Driver").newInstance();

		Connection C = getConnection();
		//DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");

		Statement stmt = C.createStatement();
		
		String AgentID = request.getParameter("selectAgentId");

		String SQL = "select agentid,hostname,agents.cityid,(select name from cities where cityid=agents.cityid) as cityname from agents where AgentID=\'"+AgentID+"\'";

		//out.println(SQL);

		ResultSet rs=stmt.executeQuery(SQL);

		rs.next();

%>		
			<center>   
			<table>
             <tr><td align="right" class="fieldnames"> AgentID(IP) : </td><td align="left" class="fieldnames"><%=rs.getString(1)%></td></tr>
			 <tr><td align="right" class="fieldnames"> Host Name : </td><td align="left" class="fieldnames"><%=rs.getString(2)%></td></tr>
				 <tr><td align="right" class="fieldnames"> City Name : </td><td align="left" class="fieldnames"><%=rs.getString(4)%></td></tr>
			 </table>
			<br><br>
			<a href="javascript:history.back()"><u><B> Back  to View Agents</B></a>
			 </center> 
              
			 
<% 

	}
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