<link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%

try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		Connection C = DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");

		Statement stmt = C.createStatement();
		
		int CityID = Integer.parseInt(request.getParameter("selectCityId"));

		String SQL = "select * from cities where CityID="+CityID ;

		//out.println(SQL);

		ResultSet rs=stmt.executeQuery(SQL);

		rs.next();

%>
	        <br> <br> 
			 <center>   
			<table>
             <tr><td class=bigtext height=70 colspan=2 align=center>City Details </td></tr> 
			 <tr><td class=text align=right> CityID : </td><td class=text><%=rs.getInt(1)%></td></tr>
			 <tr><td class=text align=right> Name : </td><td class=text><%=rs.getString(2)%></td></tr>
			 <tr><td class=text align=right> Description : </td><td class=text><%=rs.getString(3)%></td></tr>
			
			 </table>
			<br><br>
			<a href="javascript:history.back()" class=text><font color=blue><u> Back  to View Cities</a>
			 
			 </center> 
              
			 
<% 

	}
	catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
%>