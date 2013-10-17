<link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<HTML>
	<HEAD>
		<TITLE> Delete User</TITLE>
		<link href="birt.css" rel="stylesheet" type="text/css">

	</HEAD>

	<BODY>
		
		<CENTER>
         <form name=deleteCustomerFrm action="deleteCustomerDetails.jsp" method=post> 
        <table> 
		<tr><td class=bigtext height=70 colspan=2 align=center>Enter Customer ID to delete </td></tr>
		<tr><td class=text height=50>CUST ID :</td>
		    <td>
			   <select name=selectCustNames>
			   <option value="">Select</option>
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

		String recCountQry = "select count(*) as rowCount from customers";

		ResultSet r = stmt.executeQuery(recCountQry);

		r.next();
		
		int ResultCount = r.getInt("rowCount") ;

		r.close() ;

		String SQL = "select * from customers";

		ResultSet rs=stmt.executeQuery(SQL);

		while(rs.next())
		{
			out.println("<option value="+rs.getString(2)+">"+rs.getString(2)+"</option>");

		}
    } 
	
    catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
			   %>
			   </select>
			</td>
		<tr><td colspan=2 align=center><INPUT TYPE="Submit" Value="DELETE"></td></tr>
        </table>
		</form>
		</CENTER>
		
	</BODY>
</HTML>