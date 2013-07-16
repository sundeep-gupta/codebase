<!-- Update Customers Details User Interface page-->
<%@ include file="escapechars.jsp" %>
<%@ include file="connection.jsp" %>
<%
if(session.getAttribute("userid")!=null )
{
%>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<HTML>
	<HEAD>
		<TITLE> Update Customer</TITLE>
<script>
		function checkOnSubmit(form)
		{

		if(form.selectCustNames.selectedIndex==0)
			{
			alert("Select Customer"); 
			form.selectCustNames.focus();
			return false;
			}
		return true;
		}
</script>
	</HEAD>
<BODY>
<form name=updateCustomerFrm onSubmit="return checkOnSubmit(updateCustomerFrm);" action="editCustomerDetails.jsp" method=post> 
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
         <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;UPDATE CUSTOMER</td></tr>
		<tr> 
          <td align="center" valign="middle"> 
		<table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
              <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>Customer Name :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left>
                <select name=selectCustNames class="select">
			   <option value="">&nbsp;&nbsp;&nbsp;&nbsp;Select Customer&nbsp;&nbsp;&nbsp;&nbsp;</option>
<%
try
	{
		//Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection C = getConnection();
		//DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");

		Statement stmt = C.createStatement();

		String recCountQry = "select count(*) as rowCount from customers";

		ResultSet r = stmt.executeQuery(recCountQry);

		r.next();
		r.close() ;

		String SQL = "select * from customers where custid <>0 order by custname";

		ResultSet rs=stmt.executeQuery(SQL);

		while(rs.next())
		{
			out.println("<option value="+rs.getInt(1)+">"+rs.getString(4)+"</option>");

		}
    } 
	
    catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
 %>
 </select>
			</td>
         <tr> 
                <td colspan="3" height="30" align="center"><font face="verdana" size="1"> 
                  <INPUT TYPE="Submit" Value="&nbsp;UPDATE&nbsp;" class="Button">
                  </font></td>
              </tr>
		</table>
		</TD>
		</tr>
	</table>
  </td>
 </tr>
</table>
</form>
</BODY>
</HTML>
<%
}
else
{%>
		<jsp:forward page="index.jsp" />
<%}
%>
	