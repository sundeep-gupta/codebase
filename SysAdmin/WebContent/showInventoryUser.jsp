<html>
<head>
<%@ page import="javax.servlet.*, javax.servlet.http.*, java.sql.*" %>
<%@ include file="includes.jsp" %>

<script language="javascript">
function submitForm(){
	if(document.forms('addNewInventory').elements('newInventory').value == ""){
		alert('Enter the name of the inventory')
		document.forms('addNewInventory').elements('newInventory').focus()
		return
	}
	document.forms('addNewInventory').submit()
}
</script>

</head>

<%!
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	String queryStr = null;
%>

<body align="center">
<%@ include file="mainMenuUser.html" %>
<br />

<table border="0">
<tr>
<td width="200" valign="top">
</td>
<td>
<table border="0" width="300">
<%
	String id = request.getParameter("id");
	if(id != null){
		id = id.trim();
		queryStr = "select * from sysadmin." + id + " order by 2";
%>
		<tr>
		<th align="left"> <%= id.toUpperCase() %> </th>
		</tr>
<%
		con = getConnection();
		stmt = con.createStatement();

		rs = stmt.executeQuery(queryStr);

		while(rs.next()){
%>
			<tr>
				<td width="85%"> <%= rs.getString(2) %> </td>
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