<html>
<head>
<script language="javascript">
	function go(){
		history.go(-3);
	}
</script>
</head>

<%@ page import="java.sql.*" %>

<jsp:useBean id="obj" class="k.Prj2" scope="request" />
<jsp:setProperty name="obj" property="firstname" />
<jsp:setProperty name="obj" property="middlename" />
<jsp:setProperty name="obj" property="lastname" />
<jsp:setProperty name="obj" property="title" />
<jsp:setProperty name="obj" property="gender" />
<jsp:setProperty name="obj" property="type" />
<jsp:setProperty name="obj" property="address1" />
<jsp:setProperty name="obj" property="address2" />
<jsp:setProperty name="obj" property="address3" />
<jsp:setProperty name="obj" property="city" />
<jsp:setProperty name="obj" property="county" />
<jsp:setProperty name="obj" property="zip" />
<jsp:setProperty name="obj" property="country" />
<jsp:setProperty name="obj" property="phone1" />
<jsp:setProperty name="obj" property="extn1" />
<jsp:setProperty name="obj" property="phone2" />
<jsp:setProperty name="obj" property="extn2" />
<jsp:setProperty name="obj" property="tollfreenumber" />
<jsp:setProperty name="obj" property="mobile" />
<jsp:setProperty name="obj" property="fax1" />
<jsp:setProperty name="obj" property="fax2" />
<jsp:setProperty name="obj" property="email" />
<jsp:setProperty name="obj" property="website" />
<jsp:setProperty name="obj" property="modeofcontact" />
<jsp:setProperty name="obj" property="donotsolicit" />
<jsp:setProperty name="obj" property="comments" />
<%	obj.setCstmr((String)session.getAttribute("cstmr"));	%>



<%	


	if(obj.addcstmr1()){	%>
		<center>	
			New Customer Contact added successfully <br><br>
			<br><br>
			<a href="javascript:go()"> Ok </a> 
		<center>

<%	}else{	%>
		<center> Sorry, unable to add customer details </center>
<% 	}	%>


</html>