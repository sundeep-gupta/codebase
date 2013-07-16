<%
if(((String)session.getAttribute("user")).equals("admin")){
%>

<html>

<head>

<title>	Folders	</title>
<%@ page import="java.io.*"	%>
<link href="css/styles.css" rel="stylesheet" type="text/css">


</head>

<body>

<center>
<table bgcolor="#AC5CEE" height="100%" width="100%">
<tr>
<td>
<table width="100%" border="0" bgcolor="white" height="100%">
<tr height="50">
	<th  align="center" class="greenHead"> <a href="/kndn/sFolders.jsp" class="greenLink"  onMouseOver=""> <font size="5"> Reports </font> </a> </th>
</tr>
<%

	String fromPage = request.getParameter("fromPage");
	if(fromPage != null){

		String message = request.getParameter("message");
		String file = request.getParameter("file");

		if(fromPage.equals("deleteFolder")){
			if(message.equals("true")){
%>
				<tr height="20">
					<td align="center" cellspacing="2"> <span style="background-color: d8ef85"> <font size="4"> &nbsp; Folder <font size="5"> <%= file %> </font> deleted. <br /> </font> </span>	</td>
				</tr>
<%
			}else{
%>
				<tr height="20">
					<td align="center"> <span style="background-color: f22f0e"> <font size="4" color="white"> &nbsp; Sorry, unable to delete the folder - <font size="5"> <%= file %> </font> &nbsp; </font>	</span> </td>
				</tr>
<%
			}
		}else if(fromPage.equals("editFolder")){
			if(message.equals("true")){
%>
				<tr height="20">
					<td align="center" cellspacing="2"> <span style="background-color: d8ef85"> <font size="4" face="verdana"> &nbsp; Folder <font size="5" color="blue"> <%= request.getParameter("oldName") %> </font> renamed to  <font size="5" color="blue"> <%= file %> </font> </font> </span>	</td>
				</tr>

<%
			}else{
%>
				<tr height="20">
					<td align="center"> <span style="background-color: f22f0e"> <font size="4" color="white"> &nbsp; Sorry, unable to rename the folder - <font size="5"> <%= request.getParameter("oldName") %> </font> &nbsp; </font>	</span> </td>
				</tr>
<%
			}
		}else{
			if(message.equals("true")){
%>
				<tr height="20">
					<td align="center" cellspacing="2"> <span style="background-color: d8ef85"> <font size="4" face="verdana"> &nbsp; New folder - <font size="5" color="blue"> <%= file %> </font> created. </font> </span>	</td>
				</tr>

<%
			}else{
%>
				<tr height="20">
					<td align="center"> <span style="background-color: f22f0e"> <font size="4" color="white"> &nbsp; Sorry, unable to create the folder - <font size="5"> <%= file %> </font> &nbsp; </font>	</span> </td>
				</tr>

<%
			}
		}
%>
				<tr height="20">
					<td align="center"> <span style="background-color: red"> <font size="4" color="white"> </td>
				</tr>
<%
	}


	File data = new File("../webapps/kndn/WEB-INF/Data/Reports");
	String[] folderNames = data.list();
	if(folderNames.length != 0){
		out.println("<tr align=\"center\"> <td>");
		out.println("<table width=\"300\" border=\"0\">");
		for(int loopCount=0; loopCount < folderNames.length; loopCount++){
			if(!folderNames[loopCount].equals("null")){
			out.println("<tr>");

			out.println("<td width=\"75%\" align=\"left\"> <a href=\"/kndn/folderContent.jsp?file=Reports/" + folderNames[loopCount] + "\" style=\"TEXT-DECORATION:none\"> <font size=\"5\" color=\"black\" face=\"verdana\">" + folderNames[loopCount] + " </font> </a> </td>");

			out.println("<td> </td>");

			out.println("<td widht=\"50%\" align=\"center\"> <a href=\"/kndn/editFolder.jsp?file=Reports/" + folderNames[loopCount] + "\" style=\"TEXT-DECORATION:none\"> <font size=\"2\"> [ Rename ] </font> </a> </td>");

/*			out.println("<td width=\"50%\" align=\"center\"> <a href=\"/kndn/deleteConfirmation.jsp?file=Reports/" + folderNames[loopCount] + "\" style=\"TEXT-DECORATION:none\"> <font size=\"2\"> [ Delete ] </font> </a> </td>");
*/

			out.println("</tr>");
			}
		}

		out.println("<tr height=\"25\"> <td> </td> </tr>");
		out.println("</table>");
		out.println("</td> </tr>");
	}else{
		out.println("<tr> <td align=\"center\"> <font size=\"5\" face=\"verdana\" color=\"black\"> Oops...this folder is empty </font> </td> </tr>");
	}

%>
<tr valign="bottom">


	<td align="center">
	<hr color="#AC5CEE" size="3" />

		<table border="0">
		<tr height="25"> <td> </td> </tr>

		<tr>
				<th class="greenHeadSmall"> New Folder </th>
		</tr>

		<tr height="10"> <td> </td> </tr>

<form name="newFolder" method="post" action="/kndn/createNewFolder.jsp">
<input type="hidden" name="photorReport" value="Reports" />
<tr align="center">
			<td>
<p class="blackText">Create new folder :	<input type="text" class="TextField" name="newFolderName" size="15" /> </p>
			</td>
		</tr>

		<tr align="center" height="25">
			<td> <input type="submit" value="create" class="button"/> </td>
		</tr>
</form>
<tr height="25"> <td> </td> </tr>
		</table>
	</td>
</tr>
</table>

<%
	
%>
</td>
</tr>
</table>
</center>

</body>

</html>

<%
}
%>