<html>
<head>
<title> Customer Group List </title>

<script language="javascript">
<!--
	function go(){
		window.close();
	}
	
	function go1(){
		document.srch.submit();
	}


//-->
</script>


</head>

<%@ page import="java.sql.*" %>
<jsp:useBean id="obj" class="k.Prj2" scope="request" />
<body>
<form name="srch" action="/kndn/jsp11">
<center>

<h2> Customer Group List </h2>

<table border="2" cellspacing="5" cellpadding="2">


<%	obj.grpsrch(out);	%>

</table>


<br><br>

<a href="javascript:go()"> Cancel </a>
&nbsp; &nbsp; &nbsp;
<a href="javascript:go1()"> Submit </a>

</center>
</form>
</body>
</html>