<html>

<head>
<%@ page import="java.io.File" %>
</head>

<body>

<table align="center">

<%
	
	File folder = new File("../webapps/kndn/WEB-INF/Data/" + request.getParameter("file"));
	String contents[] = folder.list();
	
	for(int loopCount = 0; loopCount < contents.length; loopCount++){
		out.println("<tr> <td align=\"center\">");
		out.println("<img src=\"/kndn/contents1?file=" + request.getParameter("file") + "/" + contents[loopCount] + "\"");
		out.println("</td> </tr>");
	}

%>
	

</table>

</body>

</html>