<html>
<HEAD> 
<script> 
history.forward(-1);
</script>
</HEAD> 
<%
if(session.getAttribute("userid")!=null )
{
	String sid=request.getParameter("selectServiceOptions");
		
		System.out.println("selectServiceOptions="+sid);
		session.setAttribute("serviceid",sid);
%>
<HTML>
<FORM>
<FRAMESET ROWS="22%,*" border=0> 
	<FRAME  NAME="frame1" SCROLLING="no" NORESIZE SRC="Header.jsp" marginwidth=0 marginheight=0 border=0>
<FRAMESET  COLS="16%,84%" border=0 >
	<FRAME NAME="frame2" SCROLLING="NO" NORESIZE SRC="userContents.jsp" marginwidth=0 marginheight=0 border=0>
 <FRAME NAME="frame3" SCROLLING="YES" NORESIZE SRC="welcome.html" marginwidth=0 marginheight=0 border=0> 
</FRAMESET>
	<FRAME NAME="frame4" SCROLLING="NO" NORESIZE SRC="Footer.html" marginwidth=0 marginheight=0 border=0> 
</FRAMESET> 
</FORM>
</HTML> 

<%
	}else {
			%>
				<jsp:forward page="index.jsp" />
			<%
	}

%>
