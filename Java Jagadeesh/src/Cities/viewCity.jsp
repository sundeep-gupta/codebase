<link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<HTML>
	<HEAD>
		<TITLE> View City</TITLE>
		<link href="birt.css" rel="stylesheet" type="text/css">

	</HEAD>

	<BODY>
		
		<CENTER>
         <form name=viewCityFrm action="viewCityDetails.jsp" method=post> 
        <table> 
		<tr><td height=80 class=bigtext align=center colspan=2>VIEW CITY</td></tr>
		<tr><td class=text height=50>CITY ID :</td>
		    <td>
			   <select name=selectCityId class=text>
			   <option value="">Select City</option>
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

		String SQL = "select * from cities";

		ResultSet rs=stmt.executeQuery(SQL);

		while(rs.next())
		{
			out.println("<option value="+rs.getInt(1)+">"+rs.getInt(1)+"</option>");

		}
    } 
	
    catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
			   %>
			   </select>
			</td>
		<tr><td colspan=2 align=center><INPUT TYPE="Submit" Value="VIEW DETAILS" class=text></td></tr>
        </table>
		</CENTER>
		
	</BODY>
</HTML>