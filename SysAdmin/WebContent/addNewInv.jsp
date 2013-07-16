<%@ page import="javax.servlet.*, javax.servlet.http.*, java.sql.*" %>
<%@ include file="includes.jsp" %>

<%!
	Connection con = null;
	Statement stmt = null;
	int result = 0;
	String queryStr = null;
%>

<%
	String name = request.getParameter("newInventory");
	String type = request.getParameter("inventoryType");

	queryStr = "insert into sysadmin." + type + "(";

	if(type.equals("applications")){
		queryStr += "appName";
	}else if(type.equals("databases")){
		queryStr += "dbName";
	}else if(type.equals("operatingsystems")){
		queryStr += "OSName";
	}else if(type.equals("hardware")){
		queryStr += "hardwareName";
	}

	queryStr += ") values('" + name + "')";

	con = getConnection();
	stmt = con.createStatement();
	result = stmt.executeUpdate(queryStr);

	if(result == 1){
%>
		<jsp:forward page="showInventory.jsp">
			<jsp:param name="id" value="<%=type%>" />
		</jsp:forward>
<%
	}
%>