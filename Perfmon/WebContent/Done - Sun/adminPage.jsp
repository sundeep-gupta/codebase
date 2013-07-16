<html>
<HEAD> 
<title> Admin Home Page </title>
<script> 
history.forward(-1);
</script>
</HEAD> 

<%
if(session.getAttribute("userid")!=null)
{
%>

<FRAMESET ROWS="22%,74%,4%"  border=0> 
	<FRAME  NAME="frame1" SCROLLING="no" NORESIZE SRC="Header.jsp" marginwidth=0 marginheight=0 border=0>
<FRAMESET  COLS="17%,83%" border=0 >
	<FRAME NAME="frame2" SCROLLING="NO" NORESIZE SRC="Contents.html" marginwidth=0 marginheight=0 border=0>
	<FRAME NAME="frame3" NORESIZE SRC="welcome.htm" marginwidth=0 marginheight=0 border=0>
</FRAMESET border=0>
	<FRAME NAME="frame4" SCROLLING="NO" NORESIZE SRC="Footer.html"  marginwidth=0 marginheight=0 border=0>
</FRAMESET> 

</HTML> 

<%
}

else
{
	%>
		<jsp:forward page="index.jsp" />
<%
}

%>