<%@ include file="connection.jsp" %>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<script language="javascript">
function sumbitForm(pidJS, crowJS){
	document.forms("showSpec").pid.value = pidJS
	document.forms("showSpec").crow.value = crowJS

	document.forms("showSpec").submit()

}
</script>
<%
if(session.getAttribute("userid")!=null ) {
%>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
<tr>
	<td bgcolor="#EFF4F9" align="center">
		<table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr>
			<td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;ORDER DETAILS</td>
		</tr>
<%
    Connection con = null;
    Statement stmt = null;
    String queryStr = null;
    ResultSet rs = null;
    int idOrder = 0;
    try {
	idOrder = Integer.parseInt(request.getParameter("orderId"));
    } catch (NumberFormatException ne) {
		ne.printStackTrace();
    }
    con = getConnection("services");
    stmt = con.createStatement();
    queryStr = "SELECT orders.idOrder, name, lastName, phone, email, orders.address AS address, orders.state AS state, orders.stateCode as stateCode, orders.zip AS zip, orders.city AS city, orders.countryCode AS countryCode, orderDate, total, details FROM orders, customers WHERE orders.idcustomer = customers.idcustomer AND orders.idOrder=" + idOrder + " AND customers.idCustomer = orders.idCustomer";
    rs = stmt.executeQuery(queryStr);
    if(!rs.next()){
%>
		<tr>
		<td class="fieldnames" align="center">
			Sorry, no records for the entered orderId. <br /> <br /> <br /> <a href="orderDetailsForm.jsp"><u><B> View another order </B></a>
			</td>
		</tr>
<%
    } else {
%>

<!-- --------------------------------------- -->

		<tr>
			<td align="center" valign="middle" colspan="2" class="fieldnames"> 
				<table width="60%" border="0" cellspacing="0" cellpadding="0" class="tabinside">
				<tr>
					<td class="tabheading"> Customer Details </td>
					<td class="tabheading" align="right"> Order Id : <%= idOrder %> </td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<table>
						<tr>
							<td class="fieldnames"> Customer Name </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("name") + " " + rs.getString("lastName") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> Email </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("email") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> Phone </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("phone") %> </td>
						</tr>
						<tr>
							<td class="fieldnames"> Address </td>
							<td class="fieldnames"> : </td>
							<td class="fieldnames"> <%= rs.getString("address") + ", " + rs.getString("city") + ", " + rs.getString("state") + rs.getString("stateCode") + ", " + rs.getString("zip") + ", " + rs.getString("countryCode") %> </td>
						</tr>
						</table>
					</td>					
				</tr>
				<tr> <td> &nbsp; </td> </tr>
				<tr>
					<td class="tabheading"> Service Details </td>
					<td class="tabheading" align="right"> Order placed on : <%= rs.getString("orderDate") %> </td>
				</tr>
<%
        queryStr = "SELECT cartRows.idCartRow, products.idProduct, products.sku, products.description, cartRows.quantity, cartRows.unitPrice, emailText, personalizationDesc, products.frequency FROM cartRows, dbSessionCart, products WHERE dbSessionCart.idDbSessionCart=cartRows.idDbSessionCart AND cartRows.idProduct=products.idProduct AND dbSessionCart.idOrder=" + idOrder;	
	rs = stmt.executeQuery(queryStr);
%>
				<tr>
					<td  colspan="2">
						<table class="tabinside" width="100%">
						<tr>
							<td class="tabheading" width="5%"> Id </td>
							<td class="tabheading" width="80%"> Service Name </td>
							<td class="tabheading"> Specifications </td>
						</tr>
						<form name="showSpec" action="serviceSpec.jsp" method="post">
							<input type="hidden" name="pid" value="" />
							<input type="hidden" name="crow" value="" />
<%
        while(rs.next()){
%>
						<tr>
							<td class="fieldnames" align="center"> <%= rs.getString("idProduct") %> </td>
							<td class="fieldnames"> <%= rs.getString("description") %> </td>
							<td class="fieldnames"> <a href="javascript:sumbitForm(<%= rs.getString("idProduct") %>, <%= rs.getString("idCartRow") %>)"> <u>Specifications</u> </a> </td>
						</tr>
<%
        }
%>
						</form>
						</table>
					</td>
				</tr>
				</table>
				<br /> <br /> <a href="orderDetailsForm.jsp"><u><B> View another order </B></a>
			</td>
		</tr>
<!-- --------------------------------------- -->
<%
    }
%>
		</table>
	</td>
</tr>
</table>
<%
} else {
%>
    <jsp:forward page="index.jsp" />
<%
}
%>
