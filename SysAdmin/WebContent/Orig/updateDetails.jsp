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

function submitForm(){
	if(document.forms('detailsForm').elements('type').value == 0){
		alert('Select a type to update')
		document.forms('detailsForm').elements('type').focus()
		return
	}
	if(document.forms('detailsForm').elements('name').value == 0){
		alert('Select a name from name listbox')
		document.forms('detailsForm').elements('name').focus()
		return
	}
	if(document.forms('detailsForm').elements('qty').value == 0){
		alert('Enter quantity')
		document.forms('detailsForm').elements('qty').focus()
		return
	}

	document.forms('detailsForm').action="updateInfo.jsp"
	document.forms('detailsForm').submit()
}

</script>

</head>

<body onLoad="javascript:firstOfAll()">
<%@ include file="menu.html" %>
<p align="center">
<form name="detailsForm" action="updateDetails.jsp" method="post">
<table width="60%" border="0">

<tr>
	<th colspan="4"> Add Details </th>
</tr>

<tr height="50">
	<td valign="middle" align="center" colspan="4">
	<b> 
	<%
	if(request.getParameter("message") != null ){
		out.print(request.getParameter("message"));
	}
	%>
	</b>
	</td>
</tr>

<tr>
	<td width="15%"> Type </td>
	<td width="35%">
		<select name="type" onChange="javascript:submitLocal()">
			<option value="0" selected> Select one </option>
			<option value="1"> Applications </option>
			<option value="2"> Operating Systems </option>
			<option value="3"> Databases </option>
			<option value="4"> Hardware </option>
		</select>
	</td>
	<td width="15%"> Name </td>
	<td width="35%%">
		<select name="name">
			<option value="0"> Select one </option>
			<%
			
				con = getConnection();
				stmt = con.createStatement();

				switch(type){
					case 1:	queryStr = "select applicationId, appName from applications order by appName";
							rs = stmt.executeQuery(queryStr);
							break;
					case 2:	queryStr = "select OSId, OSName from operatingsystems order by OSName";
							rs = stmt.executeQuery(queryStr);
							break;
					case 3:	queryStr = "select databaseId, dbName from sysadmin.databases order by dbName";
							rs = stmt.executeQuery(queryStr);
							break;
					case 4:	queryStr = "select hardwareId, hardwareName from hardware order by hardwareName";
							rs = stmt.executeQuery(queryStr);
							break;
				}
				
				if(rs != null){
				while(rs.next()){
			%>
					<option value="<%= rs.getInt(1) %>"> <%= rs.getString(2)%> </option>
			<%
				}
				}

			%>
		</select>
	</td>
</tr>

<tr>
	<td> Quantity </td>
	<td> <input type="text" name="qty" size="5" /> </td>
	<td> Comments </td>
	<td> <textarea name="comments"></textarea> </td>
</tr>

<tr>
	<td align="center" colspan="4"> <input type="button" name="update" value="Update" onClick="javascript:submitForm()" /> </td>
</tr>

</table>
</form>

</p>
</body>

</html>