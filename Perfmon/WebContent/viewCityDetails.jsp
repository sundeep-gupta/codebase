<!-- Displays the details of the selected city -->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>
<%
// Displays the details of the selected city.
if(session.getAttribute("userid")!=null )
{
%><link href="css/CFP_per.css" rel="stylesheet" type="text/css">
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
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;VIEW CITIES</td></tr>
		<tr> 
          <td align="center" valign="middle"> 
<%
		Connection C = getConnection();
		

		Statement stmt = C.createStatement();
		
		int CityID = Integer.parseInt(request.getParameter("selectCityId"));

		String SQL = "select * from cities where CityID="+CityID ;

		

		ResultSet rs=stmt.executeQuery(SQL);

		rs.next();

%>
	<center>   
			<table>
           
			 <tr><td align="right" class="fieldnames" > City Name : </td><td class="fieldnames" ><%=rs.getString(2)%></td></tr>
			 <tr><td  align="right" class="fieldnames"> Description : </td><td class="fieldnames"><%=rs.getString(3)%></td></tr>
			
			 </table>
			<br><br>
			<a href="viewCities.jsp"><u><B> Back  to View Cities</B></a>
			 </center> 
             </td>
    </tr>
	</table>
	</TD>
	</tr>
	</table> 
	 
      
			 
<% 
		C.close();
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