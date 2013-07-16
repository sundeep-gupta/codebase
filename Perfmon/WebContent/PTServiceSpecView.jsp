<%@ include file="connection.jsp" %>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%
if(session.getAttribute("userid")!=null )
{
%>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
<tr>
	<td bgcolor="#EFF4F9" align="center">
		<table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr>
			<td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;ORDER DETAILS</td>
		</tr>

<%
	Connection con = null;
	Statement stmt = null;
	String queryStr = null;
	ResultSet rs = null;
	int idOrder = 0;

	con = getConnection("services");
	stmt = con.createStatement();

	queryStr = "select appDesc, url, userPassword, criteria, ttime, softwareSpec, hardwareSpec, networkSpec, scenariodesc, testExecutionDate, frequency, modified from perftestspec where idCartRows=" + request.getParameter("crow");

	rs = stmt.executeQuery(queryStr);

	if(!rs.next()){
%>
		<tr>
			<td class="fieldnames" align="center"> Specifications not yet added. <br /> <br /> <br /> <a href="orderDetailsForm.jsp"><u><B>View another order</B></u></a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="javascript:history.back()"><u><B>Back to Order Details</B></u></a>
			</td>
		</tr>
<%
	}else{
%>
		<tr>
			<td align="center" valign="middle" colspan="2" class="fieldnames"> 
				<table width="60%" border="0" cellspacing="0" cellpadding="0" class="tabinside">
				<tr>
					<td class="tabheading"  colspan="2"> Service Specifications </td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<table width="95%" border="0">
						<tr>
							<td class="fieldnames" width="38%"> Application Description </td>
							<td class="fieldnames" width="2%"> : </td>
							<td class="fieldnames"> <%= rs.getString("appDesc") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> URL </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("url") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> UserName@password </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("userPassword") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> Criteria </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("criteria") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> Think Time </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("ttime") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> Software Specifications </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("softwareSpec") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> Hardware Specifications </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("hardwareSpec") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> Network Specifications </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("networkSpec") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> Scenario Description </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("scenariodesc") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> Test Execution Date </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("testExecutionDate") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> Number of Virtual Users </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%=  rs.getString("frequency")  %>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				<br /> <br /> <a href="orderDetailsForm.jsp"><u><B>View another order</B></u></a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="javascript:history.back()"> <u>Back to Order Details</u> </a> 
			</td>
		</tr>
<%
	}

%>
</table>
	</td>
</tr>
</table>


<%
}else {
%>
		<jsp:forward page="index.jsp" />
<%
}
%>