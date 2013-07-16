

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>

<%
if(session.getAttribute("userid")!=null ) {
%>

<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<link href="birt.css" rel="stylesheet" type="text/css">

<HTML>
<HEAD>
<TITLE> View City</TITLE>

<script>
	function submitForm(idOrderJS){
		document.forms("orderDetails").orderId.value=idOrderJS
		document.forms("orderDetails").submit()
		
	}
</script>

</HEAD>

<BODY>
<form name="orderDetails" onSubmit="return checkOnSubmit(orderDetails);" action="orderDetailsExec.jsp" method=post>
<input type="hidden" name="orderId" value="" />
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
<tr>
	<td bgcolor="#EFF4F9" align="center">
		<table width="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr>
			<td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;ORDER DETAILS</td>
		</tr>
		<tr> 
			<td align="center" valign="middle"> 
				<table width="50%" border="0" cellspacing="0" cellpadding="1" class="tabinside">
<%
    Connection con = null;
    Statement stmt = null;
    String queryStr = null;
    ResultSet rs = null;
    con = getConnection("services");
    stmt = con.createStatement();
    queryStr = "select orders.idOrder, name, lastName, orderDate from orders, customers where customers.idCustomer = orders.idCustomer order by orders.idOrder desc";
    rs = stmt.executeQuery(queryStr);
    if(!rs.next()){
%>
				<tr>
					<td colspan="3"> Sorry, no orders yet. </td>
				</tr>
<%
    } else {
        rs.beforeFirst();
%>
				<tr>
					<td class="tabheading" width="20%"> OrderId </td>
					<td class="tabheading" width="60%"> Customer Name </td>
					<td class="tabheading"> Order Date </td>
				</tr>
<%
        while(rs.next()) {
%>
				<tr>
					<td class="fieldnames" align="center"> <a href="javascript:submitForm(<%= rs.getString("idOrder") %>)"> <%= rs.getString("idOrder") %> </a> </td>
					<td class="fieldnames"> <%= rs.getString("name") + " " + rs.getString("lastName") %> </td>
					<td class="fieldnames"> <%= rs.getString("orderDate") %> </td>
				</tr>
<% 
        }
        rs.close();
	stmt.close();
	con.close();
    }
%>
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
} else {
%>
    <jsp:forward page="index.jsp" />
<%
}
%>


