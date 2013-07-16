<%@ page import="java.sql.*" %>
<%@ include file="includes.jsp" %>

<%!
	Connection con = null;
	Statement stmt = null;
	int result = 0;
	String queryStr = null;
%>

<%
	String prjName = request.getParameter("prjName");

	con = getConnection();
	stmt = con.createStatement();
	queryStr = "insert into projects(projectName) values('" + prjName + "')";

	result = stmt.executeUpdate(queryStr);

	if(result == 1){
%>
		<jsp:forward page="showProjects.jsp">	
			<jsp:param name="message" value="One project added." />
		</jsp:forward>
<%
	}
%>