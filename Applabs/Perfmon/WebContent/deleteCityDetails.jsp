<!-- To delete the name of the city selected -->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%
if(session.getAttribute("userid")!=null )
{
	// Deletes the name of the city selected from the list else displays failed in deleting a city.
%>
			
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
     int cityid = Integer.parseInt(request.getParameter("selectCityID"));




try
	{
	%>
		 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
		<tr>
		<td bgcolor="#EFF4F9" align="center">
        <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		 <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;DELETE CITY</td></tr>
		<tr> 
        <td align="center" valign="middle"> 
        <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<td class="fieldnames" ALIGN="CENTER">
	<%

	
		Connection C = getConnection();

		Statement stmt = C.createStatement();

		
		// Checking whether there exists any agents for this city in the Database.
		//int i = deleteCities(cityid);
		String SQL="select count(cityid) as city from agents where cityid="+cityid;
		ResultSet rs=stmt.executeQuery(SQL);
		rs.next();

		
		int test = rs.getInt(1);
		if (test!=0)
			{%>
				 
					<b> There are Agents for this City   Delete Agents First </b>
										
					<br><br><a href="deleteCities.jsp" ><u> Back to Delete City</a> 
					
					
					
			<%}	
			else
			{
					
					Connection C1 = getConnection();
					Statement stmt1 = C1.createStatement();
					String SQLDel="delete from cities where cityid="+cityid;
					int i=stmt1.executeUpdate(SQLDel);
							if(i==1) {
										%>
											
											<center><b> City Deleted Successfully </b>
												
											 <br><br><a href="deleteCities.jsp" ><u> Back to Delete City</a> 
											 
											 </center> 
											  
											 
										<%    
										}
									   else
										{
										%>
											<center><b>Failed in Deleting City </b>
											
											<br><br><a href="javascript:history.back()" ><u> Back to Delete City</a> </center>
										<% 
										}
		  }
		   %>
			  </td>
		  </tr>
		</table>
		</td>
		</tr>
		</table>
		</td>
		</tr>
		</table>
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