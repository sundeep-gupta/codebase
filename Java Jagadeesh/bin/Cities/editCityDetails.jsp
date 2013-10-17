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

		int oldCityID = Integer.parseInt(request.getParameter("selectCityId"));

		ResultSet rs=stmt.executeQuery("select * from cities where CITYID= "+oldCityID);
        
		rs.next();

%>
	
<HTML>
	<HEAD>
		<TITLE>Add City</TITLE>
 </HEAD>
<link href="birt.css" rel="stylesheet" type="text/css">
	<BODY>
		
		<CENTER>
		  <form name=addCityForm action="updateCityDetails.jsp" method=post>
          <table>
		  <tr>
		  <td colspan=2 align=center height=100><FONT FACE="verdana" SIZE=3 COLOR="red"><B> Update CITY </B></FONT><td></tr>
		  <tr><td align=right height=30 class=text>CityID :</td>
			  <td class=text><INPUT TYPE="Text" name="txtCityID" value="<%=rs.getInt(1)%>" class=text></td>
		  </tr>
		  <tr><td align=right height=30 class=text>Name :
			  <td class=text><INPUT TYPE=text Size=20 name="txtName" value="<%=rs.getString(2)%>" class=text></td>
		  </tr>
		  <tr><td align=right height=30 class=text>Description :
			  <td class=text><INPUT TYPE=text Size=20 name="txtDescription" value="<%=rs.getString(3)%>" class=text></td>
		  </tr>

		  <tr><td colspan=2 align=center class=text>
		       <INPUT Type="Submit" VALUE="Update"><input type=hidden name="oldCityID" value="<%=request.getParameter("selectCityId")%>" class=text></td>
		  </tr>
		</table>
<%}
	catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
%>

		</form>	
		</CENTER>
	</BODY>
</HTML>