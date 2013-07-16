<html>

<head>

<%@ page import="javax.servlet.*, javax.servlet.http.*, java.sql.*" %>
<%@ include file="includes.jsp" %>

<%!
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	String queryStr = null;
%>

<%
	if(request.getParameter("id") != null){
		session.setAttribute("prjId", request.getParameter("id"));
	}
	int type = 0;
	try{
		type = Integer.parseInt(request.getParameter("type"));
	}catch(Exception e){
	}
%>

<script language="javascript">
function submitLocal(){
	document.forms('detailsForm').submit()
}

function firstOfAll(){
	document.forms('detailsForm').elements('type').selectedIndex="<%=type%>"
}

</script>
</head>

<body onLoad="javascript:firstOfAll()">
<%@ include file="menuUser.html" %>

<table width="100%" border="0">
<form name="detailsForm" action="viewDetailsUser.jsp" method="post">
<tr>
	<td align="center">
		<table border="0" width="200">
		<tr>
			<th colspan="2"> View Details </th>
		</tr>

		<tr height="50">
			<td width="15%"> Type </td>
			<td width="35%" align="right">
				<select name="type" onChange="javascript:submitLocal()">
					<option value="0" selected> Select one </option>
					<option value="1"> Applications </option>
					<option value="2"> Operating Systems </option>
					<option value="3"> Databases </option>
					<option value="4"> Hardware </option>
				</select>
			</td>
		</tr>
		</table>
	</td>
</tr>

<tr>
	<td align="center">
		<table width="500" border="0" bgcolor="">
		<%
		if(request.getParameter("id") == null){
			int prjId = 0;
			try{
			prjId = Integer.parseInt((String)session.getAttribute("prjId"));
			}catch(Exception e){
			}
			switch(type){
				case 1:	queryStr = "select id, applications.appName, qty, comments from projects_applications, applications where applications.applicationId = projects_applications.applicationId and projects_applications.projectId = " + prjId;
				break;
				case 2:	queryStr = "select id, operatingsystems.OSName, qty, comments from projects_operatingsystems, operatingsystems where operatingsystems.OSId = projects_operatingsystems.OSId and projects_operatingsystems.projectId = " + prjId;
				break;
				case 3:	queryStr = "select id, sysadmin.databases.dbName, qty, comments from projects_databases, sysadmin.databases where sysadmin.databases.databaseId = projects_databases.databaseId and projects_databases.projectId = " + prjId;
				break;
				case 4:	queryStr = "select id, hardware.hardwareName, qty, comments from projects_hardware, hardware where hardware.hardwareId = projects_hardware.hardwareId and projects_hardware.projectId = " + prjId;
				break;
			}

			con = getConnection();
			stmt = con.createStatement();

			rs = stmt.executeQuery(queryStr);
		%>
			<tr>
				<td width="50%"> <strong> Name </strong> </td>
				<td width="15%"> <strong> Quantity </strong> </td>
				<td> <strong> Comments </strong> </td>
			</tr>
		<%
			while(rs.next()){
		%>
			<tr>
				<td> <%= rs.getString(2) %> </td>
				<td> <%= rs.getString(3) %> </td>
				<td> <%= rs.getString(4) %> </td>
			</tr>
		<%
			}
		}
		%>
		</table>
	</td>
</tr>

</table>

</body>
</html>