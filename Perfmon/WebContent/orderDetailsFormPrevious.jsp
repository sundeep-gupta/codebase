<!-- To display the names of the cities to view -->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>
<%
// To display the names of the cities to select a city
if(session.getAttribute("userid")!=null )
{
%><link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<HTML>
	<HEAD>
		<TITLE> View City</TITLE>
		<link href="birt.css" rel="stylesheet" type="text/css">
<script>
function checkOnSubmit(form)
{
	var orderIdJS = form.orderId.value
	if(trimAll(orderIdJS)==""){
		alert("Order Id please");
		form.orderId.value = "";
		form.orderId.focus();
		return false;
	}
	if(isNaN(parseInt(orderIdJS))){
		alert("Order Id must be an Integer");
		form.orderId.value = "";
		form.orderId.focus();
		return false;
	}else{
		form.orderId.value = parseInt(orderIdJS)
	}
	return true;
}

function trimAll(sString){
	while (sString.substring(0,1) == ' '){
		sString = sString.substring(1, sString.length);
	}
	while (sString.substring(sString.length-1, sString.length) == ' '){
		sString = sString.substring(0,sString.length-1);
	}
	return sString;
}

</script>
	</HEAD>

<BODY>

<form name="orderDetails" onSubmit="return checkOnSubmit(orderDetails);" action="orderDetailsExec.jsp" method=post> 
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
<tr>
	<td bgcolor="#EFF4F9" align="center">
		<table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr>
			<td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;ORDER DETAILS</td>
		</tr>
		<tr> 
			<td align="center" valign="middle"> 
				<table width="100%" border="0" cellspacing="0" cellpadding="1" height="90">
				<tr> 
					<td width="49%"  align="right" class="fieldnames"><b>Order Id :</b></td>
					<td width="2">&nbsp;</td>
					<td align=left> <input name="orderId" type="text" class="textfield" size="12" style="WIDTH: 60px"> </td>
				</tr>
				<tr> 
					<td colspan="3" height="30" align="center"><font face="verdana" size="1"> <INPUT TYPE="Submit" Value="VIEW DETAILS" class="Button"> </font></td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
</form>

</BODY>
</HTML>
<%
				   }

else {
%>
		<jsp:forward page="index.jsp" />
<%
}

%>


