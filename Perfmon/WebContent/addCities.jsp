<!-- To add a new city to the cities table-->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>

<%
// It adds a new city to the city table provided the city name should be unique
if(session.getAttribute("userid")!=null )
{
%>
	<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
	<%@ page import="java.net.*" %>
		<%@ page import="java.util.*" %>
		<%@ page import="java.io.*" %>
		<%@ page import="java.sql.*" %>
<%

   try
	{
	   %>
		 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
		<tr>
		<td bgcolor="#EFF4F9" align="center">
        <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;ADD 
        CITIES</td></tr>
		<tr> 
        <td align="center" valign="middle"> 
        <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<TR>
		<td class="fieldnames" ALIGN="CENTER">
		<%

		Connection C = getConnection();

		Statement stmt = C.createStatement();

		String name = request.getParameter("txtName");
		
		String description = request.getParameter("txtDescription");

        name = single(name); /* escaping string  */
		name=name.trim();
		description = single(description); /* escaping string  */
		description=description.trim();
		int i=0;
		/*String SQL="select max(cityid) from cities";
		ResultSet rs=stmt.executeQuery(SQL);
		rs.next();*/
		// To check for a city name to be unique
		String SQL1="select Count(cityid) from cities where name='"+name+"'";
		ResultSet r=stmt.executeQuery(SQL1);
		r.next();
		int j=r.getInt(1);
		//out.println(j);
		if(j!=0 ) 
		{
			
		%>		
			<b> City Already exists with the Name <%=name%> </b><br><br>
				<a href="javascript:history.back()"><u> Back to AddCity</a>
			
		<%    
	   }//End of If
       else 
		   {
			i=addCities(name,description);
			if(i==1)
			{
				String SQL="select cityid from cities where name='"+name+"'";
				ResultSet rs=stmt.executeQuery(SQL);
				rs.next();
			%>
			
				<b> City Added Successfully </b><BR><br>
				<table>
				<tr><td class=fieldnames align=right> CityID   : </td><td class=fieldnames><%=rs.getInt(1)%></td></tr>
				 <tr><td class=fieldnames align=right> Name : </td><td class=fieldnames><%=request.getParameter("txtName")%></td></tr>
				 <tr><td class=fieldnames align=right> Description : </td><td class=fieldnames><%=request.getParameter("txtDescription")%></td></tr>
				</table>
				<br><br><a href="javascript:history.back()" class=text><u> Back to AddCity </a> 
			<%  
					 
			}
			 else
			{
			%>
				<B>Failed in Adding City </b><br><a href="javascript:history.back()"><u> Back to AddCity</a>
			<% 
		   }
	
	}
	C.close();
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
		out.println("Exception: " + E.getMessage());
    }

}
else
{
	%>
		<jsp:forward page="index.jsp" />
<%
}
%>