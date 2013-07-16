<%
if(((String)session.getAttribute("user")).equals("user")){
%>

<html>

<head>
<link href="css/styles.css" rel="stylesheet" type="text/css">
<title>	Folders	</title>
<%@ page import="java.io.*"	%>


</head>

<body>

<center>
<table bgcolor="#AC5CEE" height="100%" width="100%">
<tr>
<td>
<table width="100%" height="100%" border="0" bgcolor="white">

<tr height="50">
	<th align="center" class="greenHead">	<a href="/kndn/sFoldersUser.jsp" class="greenLink" > Reports </a> </th>
</tr>



<%

	File data = new File("../webapps/kndn/WEB-INF/Data/Reports");
	String[] folderNames = data.list();
	if(folderNames.length != 0){
		out.println("<tr align=\"center\"> <td>");
		out.println("<table width=\"300\" border=\"0\">");
		for(int loopCount=0; loopCount < folderNames.length; loopCount++){
			if(!folderNames[loopCount].equals("null")){
			out.println("<tr>");

			out.println("<td width=\"75%\" align=\"center\"> <a href=\"/kndn/folderContentUser.jsp?file=Reports/" + folderNames[loopCount] + "\" style=\"TEXT-DECORATION:none\"> <font size=\"5\" face=\"verdana\" color=\"black\">" + folderNames[loopCount] + " </font> </a> </td>");

			out.println("</tr>");
			}
		}
		out.println("</table>");
		out.println("</td> </tr>");
	}else{
		out.println("<tr> <td align=\"center\"> Oops...this folder is empty </td> </tr>");
	}

%>
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