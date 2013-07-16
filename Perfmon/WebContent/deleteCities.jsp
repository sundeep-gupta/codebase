<!-- To select the name of the city to be deleted -->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>

<%
// To display the names of the city to be selected
if(session.getAttribute("userid")!=null )
{
%><link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<HTML>
	<HEAD>
		<TITLE> Delete City</TITLE>
		<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<script>
function checkOnSubmit(form)
{

if(form.selectCityID.selectedIndex==0)
    {
    alert("Select City"); 
	form.selectCityID.focus();
	return false;
	}
	return true;
}
</script>
	</HEAD>

	<BODY>
		
		<CENTER>
         <form name=deleteCityFrm onSubmit="return checkOnSubmit(deleteCityFrm);" action="deleteCityDetails.jsp" method=post> 
       
		


			<table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;DELETE CITY</td></tr>
			  <tr> 
          <td align="center" valign="middle"> 
		<table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
              <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>City Name :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left>
                  <select name=selectCityID class="select">
			   <option value="">&nbsp;&nbsp;&nbsp;&nbsp;Select city&nbsp;&nbsp;&nbsp;&nbsp;</option>
	<%

	try
	{
		Connection C = getConnection();
		Statement stmt = C.createStatement();

		String SQL = "select * from cities order by name";

		ResultSet rs=stmt.executeQuery(SQL);

		while(rs.next())
		{
			out.println("<option value="+rs.getInt(1)+">"+rs.getString(2)+"</option>");

		}
		C.close();
    } 
	
    catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
	
	%>

		 </select>
			</td>
         <tr> 
                <td colspan="3" height="30" align="center"><font face="verdana" size="1"> &nbsp;&nbsp;&nbsp;&nbsp;
                  <INPUT TYPE="Submit" Value="&nbsp;DELETE&nbsp;" class="Button">
                  </font></td>
              </tr>
		</table>
		</TD>
		</tr>
	</table>
	</form>
	</BODY>
</HTML><%
				   }

else {
%>
		<jsp:forward page="index.jsp" />
<%
}

%>
	
    




	