<%@ page import="java.sql.*" %>
<%@ include file="includes.jsp" %>

<%!
	Connection con = null;
	Statement stmt = null;
	int result = 0;
	String queryStr = null;
%>

<%
	int type = 0, nameId = 0, qty = 0, prjId = 0;
	String comments = "";

	try{
	prjId = Integer.parseInt((String)session.getAttribute("prjId"));
	type = Integer.parseInt(request.getParameter("type"));
	nameId = Integer.parseInt(request.getParameter("name"));
	qty = Integer.parseInt(request.getParameter("qty"));
	}catch(Exception e){
	}
	comments = request.getParameter("comments");

	switch(type){
		case 1:	queryStr = "insert into projects_applications(projectId, applicationId, qty, comments) values(" + prjId + ", " + nameId + ", " + qty + ", '" + comments + "')";
				break;
		case 2:	queryStr = "insert into projects_operatingsystems(projectId, OSId, qty, comments) values(" + prjId + ", " + nameId + ", " + qty + ", '" + comments + "')";
				break;
		case 3:	queryStr = "insert into projects_databases(projectId, databaseId, qty, comments) values(" + prjId + ", " + nameId + ", " + qty + ", '" + comments + "')";
				break;
		case 4:	queryStr = "insert into projects_hardware(projectId, hardwareId, qty, comments) values(" + prjId + ", " + nameId + ", " + qty + ", '" + comments + "')";
				break;

	}

	con = getConnection();
	stmt = con.createStatement();

	result = stmt.executeUpdate(queryStr);

	if(result == 1){
%>
		<jsp:forward page="updateDetails.jsp">	
			<jsp:param name="message" value="Info updated." />
		</jsp:forward>

<%
	}

%>