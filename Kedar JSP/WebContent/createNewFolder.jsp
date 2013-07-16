<%
if(((String)session.getAttribute("user")).equals("admin")){
%>

<html>

<head>

<title>	New Folder Creation	</title>
<%@ page import="java.io.*"	%>

</head>

<body>

<%	String f = null;
	File folderToBeCreated = null;
	f = request.getParameter("newFolderName");
	String rootFolder = request.getParameter("rootFolder");
	String photorReport = request.getParameter("photorReport");

//out.println(rootFolder);
	if(rootFolder == null){
		f = request.getParameter("newFolderName");
		if(photorReport.equals("Photos")){
			folderToBeCreated = new File("../webapps/kndn/WEB-INF/Data/Photos/" + f);
		}else{
			folderToBeCreated = new File("../webapps/kndn/WEB-INF/Data/Reports/" + f);
		}
	}else{
		folderToBeCreated = new File("../webapps/kndn/WEB-INF/Data/" + rootFolder + "/" + f);

	}

	if(folderToBeCreated.exists()){
%>

		<center>
		<form name="renameFolder" method="post" action="/kndn/createNewFolder.jsp">
		<input type="hidden" name="photorReport" value=<%= photorReport %> />
<%
			if(f.equals("")){
%>
			Enter a name to create a new folder.
<%
			}else{
%>
			<font size="4" color="maroon"> <%= " " + f + " "%> </font> already exists...
			<br /> Provide another name for the folder...
<%
			}
%>
			<br /> <br /> <input type="text" name="newFolderName" size="20" />
			<br /> 
			<a href="/kndn/folders.jsp"> Cancel	</a> &nbsp; &nbsp;
			<input type="submit" value="Create" />
		</form>
		</center>

<%
	}else{

		boolean created = folderToBeCreated.mkdir();
		if(request.getParameter("photorReport").equals("Photos")){
%>

<jsp:forward page="folders.jsp" >
	<jsp:param name="fromPage" value="createFolder"	/>
	<jsp:param name="file" value="<%= f %>" />
	<jsp:param name="message" value="<%= created %>" />
</jsp:forward>

<%
		}else{
%>

<jsp:forward page="sFolders.jsp" >
	<jsp:param name="fromPage" value="createFolder"	/>
	<jsp:param name="file" value="<%= f %>" />
	<jsp:param name="message" value="<%= created %>" />
</jsp:forward>

<%
		}
	}
%>

</body>
</html>

<%
}
%>