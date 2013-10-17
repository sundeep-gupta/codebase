<HTML>
<HEAD>
<TITLE>Log Out</TITLE>
</HEAD>
<BODY>
<%session.invalidate();%>
<%response.sendRedirect(response.encodeRedirectURL("login.jsp"));%>

<h4> You were being Logged out </h4> <br>
<a href = "login.jsp" Target=frame3> Login </a><br>

</BODY>
</HTML>