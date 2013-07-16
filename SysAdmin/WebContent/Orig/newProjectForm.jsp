<html>

<head>
<script language="javascript">
function submitForm(){
	var prj = document.forms('newProject').elements('prjName').value
	if(prj == ""){
		alert('Enter the project name')
		return
	}
	document.forms('newProject').submit()
}
</script>
</head>

<body>
<%@ include file="menu.html" %>

<table width="100%" border="0">
<form name="newProject" action="addNewProject.jsp">
<tr>
	<td align="center">
		Project Name <input type="text" name="prjName" size="15" />
	</td>
</tr>
<tr>
	<td align="center">
		<input type="button" value="Create" onClick="javascript:submitForm()" />
	</td>
</tr>
</form>
</table>

</body>

</html>