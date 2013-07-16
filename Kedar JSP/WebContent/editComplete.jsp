<%
if(((String)session.getAttribute("user")).equals("admin")){
%>

<html>

<head>
<title>	Rename Completed	</title>
<%@ page import="java.io.*"	%>
</head>

<body>

<%
	String str = request.getParameter("folderName");
	String oldName = request.getParameter("actualName").trim();

	String path = oldName.substring(0, oldName.lastIndexOf("/")+1);
	str = path + str;

/*	if(oldName.indexOf("/") != -1 && (oldName.substring(0, oldName.indexOf("/"))).equals("Photos")){
		str = "Photos/" + str;		
	}else{
		str = "Reports/" + str;

	}
*/

		System.out.println(str);
		System.out.println(oldName);

	File f = new File("../webapps/kndn/WEB-INF/Data/" + str);

	if(f.exists() && !(str.equals(oldName))){
%>

		<center>
		<form name="newName"  method="post" action="/kndn/editComplete.jsp">
			Sorry, a folder with same name <font size="3" color="red"> <%= " " + str + " " %> </font> already exists.
			<br />
			Another Name : &nbsp; &nbsp; <input type="text" name="folderName" size="15" />
			<br />
			<a href="/kndn/folders.jsp"> Cancel	</a> &nbsp; &nbsp; 
			<input type="submit" value="Rename" />
			<input type="hidden" name="actualName" value="<%= oldName %>">
		</form>
		</center>

<%
	}else{
//		new File("../webapps/kndn/WEB-INF/Data" + request.getParameter("actualName").trim())

		boolean renamed = new File("../webapps/kndn/WEB-INF/Data/" + oldName).renameTo(new File("../webapps/kndn/WEB-INF/Data/" + str));
		if(oldName.indexOf("/") != -1 && oldName.substring(0, oldName.indexOf("/")).equals("Photos")){
%>
			<jsp:forward page="folders.jsp" >
				<jsp:param name="fromPage" value="editFolder"	/>
				<jsp:param name="file" value="<%= str.substring(str.indexOf("/")+1, str.length()) %>" />
				<jsp:param name="oldName" value="<%= oldName.substring(oldName.indexOf("/")+1, oldName.length()) %>" />
				<jsp:param name="message" value="<%= renamed %>" />
			</jsp:forward>

<%
		}else{
%>
			<jsp:forward page="sFolders.jsp" >
				<jsp:param name="fromPage" value="editFolder"	/>
				<jsp:param name="file" value="<%= str.substring(str.indexOf("/")+1, str.length()) %>" />
				<jsp:param name="oldName" value="<%= oldName.substring(oldName.indexOf("/")+1, oldName.length()) %>" />
				<jsp:param name="message" value="<%= renamed %>" />
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