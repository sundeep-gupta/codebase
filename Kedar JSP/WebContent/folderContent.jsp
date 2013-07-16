<%
if(((String)session.getAttribute("user")).equals("admin")){
%>

<html>

<%
	String folderName = request.getParameter("file").trim();
//	request.setAttribute("rootFolder", (String)folderName);
%>

<head>
<%@ page import="java.io.*"	%>
<link href="css/styles.css" rel="stylesheet" type="text/css">

<title>	Contents of folder	<%= "\"" + folderName	+ "\"" %>	</title>

<script language="javascript">

function formSubmitFunc(){
	document.forms("newFolder").submit();
}

function addMoreFiles(){
	
	var tbl = document.getElementById('fileTable');
	var lastRow = tbl.rows.length;

	// if there's no header row in the table, then iteration = lastRow + 1
	var iteration = lastRow;
	var row = tbl.insertRow(lastRow);

  
	// right cell
	var colOne = row.insertCell(0);
	var el = document.createElement('input');
	el.setAttribute('type', 'file');
	el.setAttribute('name', 'file' + iteration);
	el.setAttribute('id', 'file' + iteration);
	el.setAttribute('size', '35');
	
	colOne.appendChild(el);


	var colTwo = row.insertCell(1);
	var el1 = document.createElement('img');
	el1.setAttribute('src', 'C:\\Documents and Settings\\050330\\My Documents\\My Pictures\\gifs\\sc_gertolf_lighter.gif');
	el1.setAttribute('id', 'remove' + iteration);
	el1.onclick = function() { removeFile(iteration); };

	colTwo.appendChild(el1);
}
	
function removeFile(a){
	document.getElementById('file' + a).value="";
	var elementToBeDeleted = document.getElementById('file' + a);
	elementToBeDeleted.parentNode.removeChild(elementToBeDeleted);
//	document.getElementById('file' + a).style.display="none";
	document.getElementById('remove' + a).style.display="none";
		
}

function submitUpload(){
	if(document.getElementById('newFolderName').value == ""){
		alert("Enter the name for the new Folder");
		document.forms("upload").folderName.focus();
		return;
	}
	document.forms("upload").submit();
}


</script>
</head>



<body>
<center>
<table bgcolor="#AC5CEE" border="0" width="100%" valign="middle" align="center">
<tr valign="middle" height="10">
<td>
<table border="0" width="100%" align="center" bgcolor="white" valign="down" height="100%">
<tr>
<td>
	<table border="0" align="center" width="350">
	<tr height="25"> <td> </td> </tr>
	<tr>
		<th align="center" colspan="3" class="greenHead"> Folder Contents </th> 
	</tr>
	<tr>
		<td height="20" colspan="3">		</td>
	</tr>
<%
	File folder= new File("../webapps/kndn/WEB-INF/Data/" + folderName);

	String contents[] = folder.list();
	
	for(int loopCount = 0; loopCount < contents.length; loopCount++){
		if(!contents[loopCount].equals("null")){
		out.println("<tr>");
		
		out.println("<td width=\"75%\" align=\"left\"> <a href=\"/kndn/contentsJsp.jsp?file=" + folderName + "/" + contents[loopCount] + "\" style=\"TEXT-DECORATION:none\"> <font size=\"5\" color=\"black\" face=\"verdana\">" + contents[loopCount] + " </font> </a> </td>");

		out.println("<td widht=\"50%\" align=\"center\"> <a href=\"/kndn/editFolder.jsp?file=" + folderName + "/" + contents[loopCount] + "\" style=\"TEXT-DECORATION:none\"> <font size=\"2\"> [ Rename ] </font> </a> </td>");

		out.println("<td width=\"50%\" align=\"center\"> <a href=\"/kndn/deleteConfirmation.jsp?file=" + folderName + "/" + contents[loopCount] + "\" style=\"TEXT-DECORATION:none\"> <font size=\"2\"> [ Delete ] </font> </a> </td>");

		out.println("</tr>");
		}
	}
	
%>
	<tr height="25"> <td> </td> </tr>
	</table>
	<hr color="#AC5CEE" size="3" />
</td>	</tr>

<!-- <tr bgcolor="white" height="50"> <td> </td> </tr> -->

<tr>	<td>

<form name="upload" method="post" action="/kndn/upload.jsp" enctype="multipart/form-data">
<input type="hidden" id="rootFolder" name="rootFolder" value="<%= folderName %>" />
<table align="center" border="0">
	<tr height="25"> <td> </td> </tr>
	<tr>	<td align="center" colspan="2" class="greenHead"> New Folder </td> </tr>
	<tr height="10">	<td> </td> </tr>
	<tr>
		<td class="blackText"> New Folder Name: </td>
		<td>	<input type="text" id="newFolderName" name="newFolderName" size="25" value="" class="TextField" />	</td>

	</tr>

	<tr>
	<table align="center" border="0">
<tr>	<td>
	


		<table name="fileTable" id="fileTable" border="0">
			<tr>
				<td align="center" class="greenHeadSmall"> File uploads </td>
			</tr>

			<tr height="20">	<td align="center">	</td>	</tr>

			<tr> <td align="center"> <input type="file" size="35" name="file" />	</td> </tr>
			<br />
			</td> </tr>
		</table>

		<br /> 
		<tr>	<td align="center">
			<input type="button" name="addMoreFiles1" value="More Files..." class="button" onClick="addMoreFiles()"> 
		</td>	</tr>
		<tr height="25"> <td> </td> </tr>

</td>	</tr>
</table>
<hr color="#AC5CEE" size="3"/>

	</tr>

	<tr height="50">

		<td align="center"> <input type="button" value="Upload" class="button" onClick="javascript:submitUpload()"/>	</td>

<!--		<td colspan="2" align="center"> <a href="javascript:formSubmitFunc()" style="TEXT-DECORATION:none"> Create new folder and Upload the files </a> </td>
-->
	</tr>
</table>
</form>


</td>	</tr>

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