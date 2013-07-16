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
<%@ include file="mainMenu.html" %>
<br />

<table border="0">
<tr>
<td width="200" valign="top">
<table border="0" width="100%">
<form name="addNewInventory" action="addNewInv.jsp" method="post">
<tr>
	<th colspan="2" align="left"> Add New </th>
</tr>
<tr>
	<td width="10%">  </td>
	<td>
		<input type="text" name="newInventory" size="20" /> <br />
		<input type="radio" name="inventoryType" value="applications" checked> Application </input> <br />
		<input type="radio" name="inventoryType" value="operatingsystems"> Operating System </input> <br />
		<input type="radio" name="inventoryType" value="databases"> Database </input> <br />
		<input type="radio" name="inventoryType" value="hardware"> Hardware </input> <br />

	</td>
</tr>
<tr>
	<td colspan="2" align="left"> <input type="button" value="Add" onClick="javascript:submitForm()" /> </td>
</tr>
</form>
</table>
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
				<td> <a href="deleteInv.jsp?type=<%=id%>&id=<%=rs.getInt(1)%>"> [Delete] </a> </td>
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