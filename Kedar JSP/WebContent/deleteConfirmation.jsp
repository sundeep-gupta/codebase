<%
if(((String)session.getAttribute("user")).equals("admin")){
%>

<html>

<head>
<title>	Delete Confirmation	</title>
</head>

<body>

<%
	String name = request.getParameter("file");
	name = name.substring(name.lastIndexOf("/")+1, name.length());
%>

<center>

<br />	<br />
Do you really want to delete the folder <font size="5">		<%=	" " + name 	%></font>.
<br />	<br />
<a href="/kndn/folders.jsp"> Cancel	</a> 
&nbsp; &nbsp; &nbsp;
<a href="/kndn/deleteFolder.jsp?file=<%=  request.getParameter("file")  %>"> Yes	</a>

</center>
</body>

</html>

<%
}
%>