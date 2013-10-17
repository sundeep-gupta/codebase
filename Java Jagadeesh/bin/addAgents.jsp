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

        //out.println(session.getAttribute("custid"));
		int agentid=request.getParameter("txtAgentID");
		String ip = request.getParameter("txtIp");
		//String email = request.getParameter("txtEmail");
		//int custid=Integer.parseInt(request.getParameter("txtCustID"));

		String SQL = "insert into agents values("+agentid+",'"+ip+"')";
		 

		int i=stmt.executeUpdate(SQL);
  
		if(i==1) {
%>
			<center><font color=blue face=verdana size=3><b> Agent Added Successfully </b></font><br><b> <br> <br> <br> <br>
	            
	         <table>

			 <tr><td class=text> AgentID   : </td><td><%=agentid%></td></tr>
			 <tr><td class=text> IP : </td><td><%=ip%></td></tr>
			 
			
			 </table>


			 <br><br><a href="javascript:history.back()" class=text> Back </a> to AddAgent
			 
			 </center> 
              
			 
<%    
        }
	   else {
%>
		<font color=blue face=verdana size=9><b>Failed in Adding Agent </b></font>
<% 
		}
    } 
	
    catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }


else {
%>
		<jsp:forward page="index.jsp" />
<%
}

%>