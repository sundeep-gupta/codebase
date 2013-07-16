<%
if(((String)session.getAttribute("user")).equals("admin")){
%>

<html>

<head>
<%
	String file = request.getParameter("file");	
	String name = file.substring(file.lastIndexOf("/")+1,file.length());
%>
<title>	Rename Folder  <%= name %> </title>
</head>

<body>
<center>
<form name="edit" method="post" action="/kndn/editComplete.jsp">
<input type="hidden" name="actualName" value="<%= file %>" />
	<table width="250">
	<tr>
		<td align="right"> Old Name : </td>
		<td align="left"> <%= name %> </td>
	</tr>
	<tr>
		<td align="right"> New name :	</td>
		<td align="left"> <input type="text" name="folderName" size="15" />	</td>
	</tr>
	<tr>
		<td align="center"> <a href="/kndn/folders.jsp"> Cancel	</a>	</td>
		<td align="center"> <input type="submit" value="Rename" />	</td>
	</tr>
	</table>
</form>
</center>

</body>

</html>

<%
}
%>