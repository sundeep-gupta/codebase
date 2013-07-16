<%@ page import="javax.servlet.*, javax.servlet.http.*, java.sql.*" %>
<%@ include file="includes.jsp" %>

<%!
	Connection con = null;
	Statement stmt = null;
	int result = 0;
	String queryStr = null;
%>

<%
	String type = request.getParameter("type");

	queryStr = "delete from sysadmin." + type + " where ";

	if(type.equals("applications")){
		queryStr += "applicationId";
	}else if(type.equals("databases")){
		queryStr += "databaseId";
	}else if(type.equals("operatingsystems")){
		queryStr += "OSId";
	}else if(type.equals("hardware")){
		queryStr += "hardwareId";
	}

	try{
	queryStr += "=" + Integer.parseInt(request.getParameter("id"));
	}catch(Exception e){
	}

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