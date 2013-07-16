<html>

<head>
<title>	Logout	</title>



</head>

<body>


<%

	response.setHeader("Cache-control","no-store");
	response.setHeader("Expires","now-1");
	session.removeAttribute("user");
	request.getSession(true).invalidate();

%>

<jsp:forward page="login.jsp" />

</body>

</html>