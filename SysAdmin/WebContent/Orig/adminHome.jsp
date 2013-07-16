
<%
if(((String)session.getAttribute("user")).equals("admin")){
%>

<html>

<script>
history.forward(-1);
</script>
<frameset rows="15%,*">
	<frame name="constantFrame" src="header.jsp" frameborder="0" noresize="noresize"	/>
	<frame name="varyingFrame" src="welcome.jsp" frameborder="0" noresize="noresize"	/>
</frameset>

</html>

<%
}
%>