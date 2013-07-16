<!-- To update the values of the city edited -->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>
<%
// updates the values of the city edited.
if(session.getAttribute("userid")!=null )
{
%>
<link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%

	
	try
	{
		%>
		 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
		<tr>
		<td bgcolor="#EFF4F9" align="center">
        <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		 <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;UPDATE CITY DETAILS</td></tr>
		<tr> 
        <td align="center" valign="middle"> 
        <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<td class="fieldnames" ALIGN="CENTER">
	<%
		Connection C = getConnection();
		Statement stmt = C.createStatement();
		int cid = Integer.parseInt(request.getParameter("txtCityID"));
		String name = request.getParameter("txtName");
		String description = request.getParameter("txtDescription");
		name = single(name);
		description = single(description);
		int i = updateCity(cid,name,description);

		if(i==1)
			{
			%>
	        
			<b> City Updated Successfully </b> 
	        <br><br><a href="javascript:history.back()"><u> Back to UpdateCity</a>
				
              
			 
			<%    
			}
	 	    else
			{
			%>
				<center><b>Failed in Updating City </b>
				<br><br><a href="javascript:history.back()"><u> Back to UpdateCity</a>
				</center>
			<% 
			}
			C.close();
	}//End of try block
	catch (Exception E)
	{
	out.println("SQLException: " + E.getMessage());
	}
 }
 else
{
%>
		<jsp:forward page="index.jsp" />
<%
}
%>