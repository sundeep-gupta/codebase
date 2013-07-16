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
<jsp:setProperty name="obj" property="groupname" />
<jsp:setProperty name="obj" property="shortname" param="shortname"/>
<jsp:setProperty name="obj" property="address1" />
<jsp:setProperty name="obj" property="address2" />
<jsp:setProperty name="obj" property="address3" />
<jsp:setProperty name="obj" property="city" />
<jsp:setProperty name="obj" property="county" />
<jsp:setProperty name="obj" property="state" />
<jsp:setProperty name="obj" property="zip" />
<jsp:setProperty name="obj" property="country" />
<jsp:setProperty name="obj" property="phone" />
<jsp:setProperty name="obj" property="tollfreenumber" />
<jsp:setProperty name="obj" property="fax" />
<jsp:setProperty name="obj" property="website" />
<jsp:setProperty name="obj" property="description" />


<%	if(obj.addcg()){	%>
		<center> New customer group added </center>
<%	}else{	%>
		<center> Sorry, unable to add new group </center>
<% 	}	%>




<br><br>

<center>	<a href="javascript:go()"> Add one more group </a> 
<br> <br>
		<a href="/kndn/jsp2"> Back to home page </a>
<center>




</html>