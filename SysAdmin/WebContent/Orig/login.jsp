<html>

<head>
<title>	</title>


</head>

<body>
<center>
<table border="0" width="850">
<tr height="250" valign="bottom">
	<td>
		<table align="center" border="0">
		<%
			if(request.getParameter("message") != null){
		%>
			<tr>
				<td colspan="2">
					<font size="5" color="f22f0e"> <%= request.getParameter("message") %>	</font>
				</td>
			</tr>
			<tr height="15">
				<td>
				</td>
			</tr>
		<%
			}
		%>
		<form name="adminLogin" method="post" action="userVerify.jsp" />

		<tr>
			<td align="right">
				User : 
			</td>
			<td>
				<input type="text" name="user" size="12" />
			</td>
		</tr>

		<tr>
			<td align="right">
				Password : 
			</td>
			<td>
				<input type="password" name="passwd" size="12" />
			</td>
		</tr>

		<tr height="20">
			<td>
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2">
				<input type="submit" value="    Go   "/>
		</td>
		</tr>

		</form>
		</table>
		</td>
	</tr>
</table>
</center>
</body>


</html>