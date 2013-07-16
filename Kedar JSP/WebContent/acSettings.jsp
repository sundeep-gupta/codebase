<%
if(((String)session.getAttribute("user")).equals("admin")){
%>

<%@ page import="java.io.*" %>

<html>

<head>
<link href="css/styles.css" rel="stylesheet" type="text/css">

</head>

<body>

<table bgcolor="#AC5CEE" border="0" width="100%" height="100%">
<tr>
<td>

<table border="0" width="100%" height="100%" bgcolor="white">
<tr align="center" valign="middle">
	<td>



<%
	String message=request.getParameter("message");

	if(message.equals("cPasswd")){

		BufferedReader br = new BufferedReader(new FileReader("../webapps/kndn/WEB-INF/FlatFiles/administrator.txt"));
		String actualPasswd = br.readLine().trim();
		br.close();

		String oldPasswd = request.getParameter("oldPasswd");
		String newPasswd = request.getParameter("newPasswd");
		String newPasswd2 = request.getParameter("newPasswd2");
		if(oldPasswd.equals(actualPasswd)){
			if(newPasswd.equals(newPasswd2)){
				if(newPasswd.equals("")){
%>
					<p class="blackText" align="center"> Sorry, password cannot be empty.
					<br />
					<a href="cPassword.jsp"> Try Again <a>
					</p>
<%
				}else{
					PrintWriter pw = new PrintWriter(new FileWriter("../webapps/kndn/WEB-INF/FlatFiles/administrator.txt"));
					pw.write(newPasswd);
					pw.close();
%>
					<p class="blackText" align="center"> Password changed successfully. </p>
<%
				}
			}else{
%>
					<p class="blackText" align="center"> Your new password and retyped new password are not same.
					<br />
					<a href="cPassword.jsp"> Try Again <a>
					</p>
<%
				}
			}else{
%>
				<p class="blackText" align="center"> Your old password did not match.
				<br />
				<a href="cPassword.jsp"> Try Again <a>
				</p>
<%
		}
	}
%>
</td>
</tr>
</table>
</td>
</tr>
</table>
</body>


</html>

<%
}
%>