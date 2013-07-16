<html>

<head>	

<title>	AdminHomePage	</title>
<%@ page import="javax.servlet.*, javax.servlet.http.*, java.io.*" %>

</head>

<body>
<%

BufferedReader br = null;

if(request.getParameter("user").trim().equals("admin")){
	br = new BufferedReader(new FileReader("../webapps/kndn/WEB-INF/FlatFiles/administrator.txt"));
	if(request.getParameter("passwd").equals(br.readLine().trim())){
		session.setAttribute("user", new String("admin"));
%>
		<jsp:forward page="adminHome.jsp" />
<%
	}else{
%>
		<jsp:forward page="login.jsp">	
			<jsp:param name="message" value="Invalid Password" />
		</jsp:forward>

<%
	}
}else if(request.getParameter("user").trim().equals("user")){
	br = new BufferedReader(new FileReader("../webapps/kndn/WEB-INF/FlatFiles/userone.txt"));
	if(request.getParameter("passwd").equals(br.readLine().trim())){
		session.setAttribute("user", new String("user"));
%>
		<jsp:forward page="userHome.jsp" />
<%
	}else{
%>
		<jsp:forward page="login.jsp">	
			<jsp:param name="message" value="Invalid Password" />
		</jsp:forward>

<%
	}
}else{
%>

<jsp:forward page="login.jsp">	
	<jsp:param name="message" value="Invalid UserID" />
</jsp:forward>

<%
}
%>
</body>

</html>

