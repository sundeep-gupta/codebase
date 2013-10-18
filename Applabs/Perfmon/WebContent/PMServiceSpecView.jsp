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

	queryStr = "select url1, url2, url3, url4, url5, frequency, modified from perfmonspec where idCartRows=" + request.getParameter("crow");

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
					<td class="tabheading" colspan="2"> Service Specifications </td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<table width="95%" border="0">
						<tr>
							<td class="fieldnames" width="18%"> URL 1 </td>
							<td class="fieldnames" width="2%"> : </td>
							<td class="fieldnames"> <%= rs.getString("url1") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> URL 2 </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("url2") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> URL 3 </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("url3") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> URL 4 </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("url4") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> URL 5 </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("url5") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> Frequency </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%=  rs.getString("frequency") + " minutes"  %>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				<br /> <br /> <a href="orderDetailsForm.jsp"><u><B>View another order</B></u></a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="javascript:history.back()"><u><B>Back to Order Details</B></u></a>
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