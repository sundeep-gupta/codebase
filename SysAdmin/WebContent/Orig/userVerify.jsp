<html>

<head>	

<title>	AdminHomePage	</title>
<%@ page import="javax.servlet.*, javax.servlet.http.*, java.sql.*" %>
<%@ include file="includes.jsp" %>


</head>

<body>

<%!
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	String queryStr = null;

%>

<%

	String userName = request.getParameter("user").trim();
	String passwd = request.getParameter("passwd");

	con = getConnection();
	stmt = con.createStatement();
	queryStr = "select userId from users where userName='" + userName + "' and passwd='" + passwd + "'";
	rs = stmt.executeQuery(queryStr);

	if(rs.next()){
		if(rs.getInt("userId") == 0){
			session.setAttribute("user",(String)"admin");
			rs.close();
			stmt.close();
			con.close();
%>
			<jsp:forward page="adminHome.jsp" />
<%
		}else{
			rs.close();
			stmt.close();
			con.close();

%>
			<jsp:forward page="userHome.jsp" />
<%
		}
	}else{
%>
		<jsp:forward page="login.jsp">
			<jsp:param name="message" value="Invalid Password" />
		</jsp:forward>
<%
	}
	
%>

</body>

</html>

