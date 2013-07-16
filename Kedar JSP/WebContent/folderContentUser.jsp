<%
if(((String)session.getAttribute("user")).equals("user")){
%>

<html>

<%
	String folderName = request.getParameter("file").trim();
//	request.setAttribute("rootFolder", (String)folderName);
%>

<head>
<%@ page import="java.io.*"	%>
<title>	Contents of folder	<%= "\"" + folderName	+ "\"" %>	</title>
<link href="css/styles.css" rel="stylesheet" type="text/css">

</head>



<body>
<center>
<table bgcolor="#AC5CEE" border="0" width="100%" valign="middle" align="center" height="100%">
<tr valign="middle" height="100%">
<td>
<table border="0" width="100%" align="center" bgcolor="white" valign="down" height="100%">
<tr>
<tr bgcolor="" valign="top">
<td>
	<table border="0" align="center" width="100%">
	<tr bgcolor="white">	<th align="center" colspan="3" class="greenHead">
				Folder Contents
	</th>	</tr>

	<tr>
		<td height="20" colspan="3">		</td>
	</tr>
<%
	File folder= new File("../webapps/kndn/WEB-INF/Data/" + folderName);

	String contents[] = folder.list();
	
	for(int loopCount = 0; loopCount < contents.length; loopCount++){
		if(!contents[loopCount].equals("null")){
		out.println("<tr>");
		
		out.println("<td width=\"75%\" align=\"center\"> <a href=\"/kndn/contentsJsp.jsp?file=" + folderName + "/" + contents[loopCount] + "\" style=\"TEXT-DECORATION:none\"> <font face=\"verdana\"size=\"5\" color=\"black\">" + contents[loopCount] + " </font> </a> </td>");

		out.println("</tr>");
		}
	}
		
		
%>
	<tr>
		<td height="20" colspan="3">		</td>
	</tr>
	</table>	
</td>	</tr>

<tr height="30">	<td>	</td>	</tr>

<tr>	<td>

</table>
</td>
</tr>
</table>
</center>
</body>

</html>

<%
}
%>