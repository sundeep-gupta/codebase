<%
if(((String)session.getAttribute("user")).equals("user")){
%>

<html>

<script>
history.forward(-1);
</script>
<frameset rows="15%,*">
	<frame name="constantFrame" src="header.jsp" frameborder="0" noresize="noresize"	/>
	<frameset cols="20%,*">
		<frame name="contents" src="contentsUser.jsp" frameborder="0" noresize="noresize" marginwidth="20" marginheight="25" />
		<frame name="varyingFrame" src="welcomeUser.jsp" frameborder="0" noresize="noresize"	/>
	</frameset>
</frameset>

</html>

<%
}
%>