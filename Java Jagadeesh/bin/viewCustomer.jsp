<link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<HTML>
	<HEAD>
		<TITLE> View Customer</TITLE>
		<link href="birt.css" rel="stylesheet" type="text/css">

	</HEAD>

	<BODY>
		
		<CENTER>
         <form name=viewCustFrm action="viewCustomerDetails.jsp" method=post> 
        <table> 
		<tr><td height=50></td></tr>
		<tr><td class=text height=50>SELECT CUSTID :</td>
		    <td>
			   <select name=selectCustNames class=text>
			   <option value="">CustName</option>
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

		String SQL = "select CUSTID,DESRIPTION,E-Mail from users,customers where users.CUSTID=customers.CUSTID";


		ResultSet rs=stmt.executeQuery(SQL);

		while(rs.next())
		{
			out.println("<option value="+rs.getInt(1)+">"+rs.getInt(1)+"--->"+rs.getString(2)+"</option>");

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