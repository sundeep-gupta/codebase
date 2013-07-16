<html>

<head>	

<title>	AdminHomePage	</title>
<%@ page import="javax.servlet.*, javax.servlet.http.*, java.io.*" %>

</head>

<body>
<%

BufferedReader br = new BufferedReader(new FileReader("../webapps/kndn/WEB-INF/FlatFiles/administrator.txt"));
if(request.getParameter("adminPasswd").trim().equals(br.readLine().trim())){
	response.sendRedirect("/kndn/myUpload1.jsp");
}else{

%>

Who r u?

<%
}
%>
</body>

</html>