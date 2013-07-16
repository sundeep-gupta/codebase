<html>

<%@ page import="java.sql.*" %>

<head>
<script language="javascript">

	function go(){
		history.back();
	}

	function go1(name){
		document.srch1.use.value=name;
		document.srch1.submit();
	}

	function go2(){
		documetn.srch1.use.value=name;
		document.srch1.submit();
	}

</script>
</head>

<jsp:useBean id="obj1" class="k.Prj2" scope="request"/>
<jsp:setProperty name="obj1" property="esrch1" param="groupname"/>
<jsp:setProperty name="obj1" property="esrch2" param="shortname"/>
<jsp:setProperty name="obj1" property="esrch3" param="companyname"/>
<jsp:setProperty name="obj1" property="esrch4" param="accnumber"/>
<jsp:setProperty name="obj1" property="back" param="back" />

<body>
<br>
<b> Customer Group Search Results </b>
<br><br>
<center>

<table width="850" border="2">
<tr> <td> <center>
<table>
<tr>
	<td> <center> <b> Customer Group - Search Results </b> </center> </td>
</tr>
<tr> 
	<td> &nbsp; </td>
</tr>
<tr>
<td>

<%	String act = null;
	if(request.getParameter("back").equals("edit"))
		act = "/kndn/editcg2";
	if(request.getParameter("back").equals("srch"))
		act = "/kndn/editcg4";

%>

	
<center>
<form name=srch1 action="<%= act %>" >
<input type="hidden" name="use">

	<table border="1" width="800">
	<tr>
		<th> S.No. </th>
		<th> Group ID </th>
		<th> Group Name </th>
		<th> Short Name </th>
		<th> Phone </th>
	</tr>

<% 	obj1.srchcg(out);	%>
	
	</table>
</form>
</center>
</td>
</tr>
<tr> 
	<td> &nbsp; </td>
</tr>

<tr>

	<td> <center> <a href="javascript:go()"> Back </a> </center> </td>
</tr>

<tr> 
	<td> &nbsp; </td>
</tr>

</table>
</center> </td> </tr>
</table>

</center>

</body>

</html>