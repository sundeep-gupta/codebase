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

		int oldCustID = Integer.parseInt(request.getParameter("selectCustNames"));

		ResultSet rs=stmt.executeQuery("select * from customers where CUSTID= "+oldCustID);
        
		rs.next();

%>
	
<HTML>
	<HEAD>
		<TITLE>Add User</TITLE>
 </HEAD>
<link href="birt.css" rel="stylesheet" type="text/css">
	<BODY>
		
		<CENTER>
		  <form name=addCustForm action="updateCustomerDetails.jsp" method=post>
          <table>
		  <tr>
		  <td colspan=2 align=center height=100><FONT FACE="verdana" SIZE=3 COLOR="red"><B> Update CUSTOMER </B></FONT><td></tr>
		  <tr><td align=right height=30 class=text>CustID :</td>
			  <td class=text><INPUT TYPE="Text" name="txtCustID" value="<%=rs.getInt(1)%>" class=text disabled=true></td>
		  </tr>
		  <tr><td align=right height=30 class=text>Description :
			  <td class=text><INPUT TYPE=text Size=20 name="txtDescription" value="<%=rs.getString(2)%>" class=text></td>
		  </tr>
		  <tr><td align=right height=30 class=text>Email :</td>
		      <td class=text><INPUT TYPE="text" Size=20 name="txtEmail" value="<%=rs.getString(3)%>" class=text></td>
		  </tr>
		  <tr><td colspan=2 align=center class=text>
		       <INPUT Type="Submit" vALUE="Update"><input type=hidden name="oldCustID" value="<%=request.getParameter("selectCustNames")%>" class=text></td>
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