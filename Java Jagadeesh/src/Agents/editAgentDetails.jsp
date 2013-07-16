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

		int oldAgentID = Integer.parseInt(request.getParameter("selectAgentId"));

		ResultSet rs=stmt.executeQuery("select * from agents where AGENTID= "+oldAgentID);
        
		rs.next();

%>
	
<HTML>
	<HEAD>
		<TITLE>Add User</TITLE>
 </HEAD>
<link href="birt.css" rel="stylesheet" type="text/css">
	<BODY>
		
		<CENTER>
		  <form name=addAgentForm action="updateAgentDetails.jsp" method=post>
          <table>
		  <tr>
		  <td colspan=2 align=center height=100><FONT FACE="verdana" SIZE=3 COLOR="red"><B> Update AGENT </B></FONT><td></tr>
		  <tr><td align=right height=30 class=text>AgentID :</td>
			  <td class=text><INPUT TYPE="Text" name="txtAgentID" value="<%=rs.getInt(1)%>" class=text></td>
		  </tr>
		  <tr><td align=right height=30 class=text>IP :
			  <td class=text><INPUT TYPE=text Size=20 name="txtIp" value="<%=rs.getString(2)%>" class=text></td>
		  </tr>

		  <tr><td colspan=2 align=center class=text>
		       <INPUT Type="Submit" VALUE="Update"><input type=hidden name="oldAgentID" value="<%=request.getParameter("selectAgentId")%>" class=text></td>
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