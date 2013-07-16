<html>

<head>
<%@ page import="java.io.*" %>
<title>	Folder Delete	</title>
</head>

<body>
<center>
<%
	String fileD = request.getParameter("file").trim();
	File f = new File("../webapps/kndn/WEB-INF/Data/" + fileD );
	String[] contents =  f.list();

	for(int loopCount = 0; loopCount < contents.length; loopCount++){
		new File(f.getAbsolutePath() + "/" + contents[loopCount]).delete();
	}
	boolean del = f.delete();
	
	if(fileD.indexOf("/") != -1 && fileD.substring(0, fileD.indexOf("/")).equals("Photos")){
%>

<jsp:forward page="folders.jsp" >
	<jsp:param name="fromPage" value="deleteFolder"	/>
	<jsp:param name="file" value="<%= fileD.substring(fileD.indexOf("/")+1, fileD.length()) %>" />
	<jsp:param name="message" value="<%= del %>" />
</jsp:forward>

<%
	}else{
%>

<jsp:forward page="sFolders.jsp" >
	<jsp:param name="fromPage" value="deleteFolder"	/>
	<jsp:param name="file" value="<%= fileD.substring(fileD.indexOf("/")+1, fileD.length()) %>" />
	<jsp:param name="message" value="<%= del %>" />
</jsp:forward>

<%
	}
%>
		
</center>
</body>

</html>