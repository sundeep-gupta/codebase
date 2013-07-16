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
<%@ include file="menu.html" %>
<table width="100%" border="0">
<tr>
	<th> Projects </th>
</tr>

<tr>
	<td align="center">
	<b>
		<%
		String message = request.getParameter("message");
		if(message != null){
			out.print(message);
		}
		%>
	</b>
	</td>
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
			<a href="updateDetails.jsp?id=<%=rs.getInt("projectId")%>"> Add Details </a>
		</td>
		<td align="center" width="120">
			<a href="viewDetails.jsp?id=<%=rs.getInt("projectId")%>"> View Details </a>
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