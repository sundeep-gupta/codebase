<!--Page is created for Displaying the Customer details -->
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
		<TITLE> View Customer</TITLE>
	
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
<form name=viewCustFrm onSubmit="return checkOnSubmit(viewCustFrm);" action="viewCustomerDetails.jsp" method=post> 
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
         <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;VIEW CUSTOMER</td></tr>
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
		Connection C = getConnection();
		Statement stmt = C.createStatement();

		String SQL = "select CUSTID,CUSTNAME from customers order by custname";

		ResultSet rs=stmt.executeQuery(SQL);

		while(rs.next())
		{
			out.println("<option value="+rs.getInt(1)+">"+rs.getString(2)+"</option>");

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
                 <INPUT TYPE="Submit" Value="&nbsp;VIEW DETAILS&nbsp;" class="Button">
                 </font></td>
              </tr>
		</table>
		</TD>
		</tr>
	</table>
  </td>
 </tr>
</table>
</BODY>
</HTML><%
				   }

else {
%>
		<jsp:forward page="index.jsp" />
<%
}

%>