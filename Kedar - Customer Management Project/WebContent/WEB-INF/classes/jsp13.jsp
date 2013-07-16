<html>
<head>
<script language="javascript">
	function go(){
		history.back();
	}
</script>
</head>

<%@ page import="java.sql.*" %>

<jsp:useBean id="obj" class="k.Prj2" scope="request" />
<jsp:setProperty name="obj" property="group" />
<jsp:setProperty name="obj" property="name" />
<jsp:setProperty name="obj" property="createdby" />
<jsp:setProperty name="obj" property="creditlimit" />
<jsp:setProperty name="obj" property="collectiontype" />
<jsp:setProperty name="obj" property="latelimit" />
<jsp:setProperty name="obj" property="creditstatus" />
<jsp:setProperty name="obj" property="terms" />
<jsp:setProperty name="obj" property="description" />
<jsp:setProperty name="obj" property="creditstatusdetail" />


<%	session.setAttribute("cstmr",request.getParameter("name"));


	if(obj.addcg1()){	%>
		<center>	
			New customer added <br><br>
			want to add contact or not 
			<br><br>
			<a href="/kndn/jsp14"> Yes </a> 
			<br> <br>
			<a href="javascript:go()"> No </a>
		<center>

<%	}else{	%>
		<center> Sorry, unable to add new group </center>
<% 	}	%>


</html>