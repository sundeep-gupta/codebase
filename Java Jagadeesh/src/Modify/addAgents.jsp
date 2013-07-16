<%
if(session.getAttribute("userid")!=null )
{
%>
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
		Connection C = DriverManager.getConnection("jdbc:mysql://localhost:3306/newbirtdb","root","password");

		Statement stmt = C.createStatement();

    	//int agentid=Integer.parseInt(request.getParameter("txtAgentID"));
	
		
		String hostname = request.getParameter("txtHostName");
		String ip = request.getParameter("txtIp");
		int cityid=Integer.parseInt(request.getParameter("txtCityId"));

		// need clarification
		//String SQL1 = "select count(*) as rowCount from agents where AGENTID="+agentid;

		//out.print(SQL1);

		//ResultSet rs1 = stmt.executeQuery(SQL1);

		//rs1.next();

		//int count = rs1.getInt("rowCount");

        //if(count<1)
		//{
		String SQL = "insert into agents values("+ip+",'"+hostname+"')";
		
		 
      	int i=stmt.executeUpdate(SQL);

		String SQL2="select max(AgentID) as max from agents "
		ResultSet rs2 =stmt.executeQuery(SQL2);
		rs2.next();

		int max = rs2.getInt("max");


		String SQL3="insert into agentsbycities (Agentid,Cityid) values("+max+","+cityid+")";
		ResultSet rs3 = stmt.executeUpdate(SQL2);
		rs3.next();
  
		if(i==1) {
%>
			<center><font color=blue face=verdana size=3><b> Agent Added Successfully </b></font><br><b> <br> <br> <br> <br>
	            
	         <table>

			 <tr><td class=text align=right> HostName   : </td><td class=text ><%=hostname%></td></tr>
			 <tr><td class=text align=right> IP : </td><td class=text><%=ip%></td></tr>
       		 <tr><td class=text align=right> City ID : </td><td class=text><%=cityid%></td></tr>
			 
			
			 </table>


			 <br><br><a href="javascript:history.back()" class=text><font color=blue><u> Back to AddAgent</a> 
			 
			 </center> 
              
			 
<%    
        }
	  
	
<% 

		}
    } 
	
    catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
}

else
{
	%>
		<jsp:forward page="index.jsp" />
<%
}

%>