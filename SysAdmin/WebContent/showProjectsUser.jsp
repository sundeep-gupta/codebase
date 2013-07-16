<html>
<head>
<%@ include file="includes.jsp" %>
<%@ page import="java.sql.*" %>

<%!
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	String queryStr = null;

%>

</head>

<body>
<%@ include file="menuUser.html" %>
<table width="100%" border="0">
<tr>
	<th> Projects </th>
</tr>

<tr>
	<td align="center">
	<table>

<%

con = getConnection();
stmt = con.createStatement();
queryStr = "select projectId, projectName from projects";
rs = stmt.executeQuery(queryStr);

while(rs.next()){
%>
	<tr>
		<td align="left">
			<b> <%= rs.getString("projectName") %> </b>
		</td>
		<td align="center" width="120">
			<a href="viewDetailsUser.jsp?id=<%=rs.getInt("projectId")%>"> View Details </a>
		</td>
	</tr>
<%
}

%>
	</table>
	</td>
</tr>

</table>

</body>

</html>