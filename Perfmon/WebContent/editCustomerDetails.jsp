<!--Updating the Customer Details  -->

<%@ include file="escapechars.jsp" %>
<%@ include file="connection.jsp" %>
<%
if(session.getAttribute("userid")!=null )
{
%>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
   try
	{
		//Class.forName("com.mysql.jdbc.Driver").newInstance();

		Connection C = getConnection();
		//DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");

		Statement stmt = C.createStatement();

		int oldCustID = Integer.parseInt(request.getParameter("selectCustNames"));

		ResultSet rs=stmt.executeQuery("select * from customers where CUSTID= "+oldCustID);
        
		rs.next();

%>
	
<HTML>
	<HEAD>
		<TITLE>Edit Customer Details</TITLE>
<script>
		function checkOnSubmit(form)
		{
			if(form.txtCustName.value=="")
				{
				alert("Customer Name Should not be NULL"); 
				form.txtCustName.focus();
				return false;
				}

			if(form.txtDescription.value=="")
				{
				alert("Description Should not be NULL"); 
				form.txtDescription.focus();
				return false;
				}
			if(form.txtEmail.value=="")
				{
				alert("Email Should not be NULL"); 
				form.txtEmail.focus();
				return false;
				}
			if(isEmail(form.txtEmail.value)==false)
				{
					alert("Please Enter a Valid E-Mail Address");
					form.txtEmail.focus();
					return false;
				}

				return true;
				

		}

		function isEmail(string) 
		{
			if (string.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1)
				return true;
			else
				return false;
		}
</script>
 </HEAD>

	<BODY>
	<CENTER>
		  <form name=updateCustForm onSubmit="return checkOnSubmit(updateCustForm);" action="updateCustomerDetails.jsp" method=post>
         <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
          <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;UPDATE CUSTOMER </td></tr>
		<tr> 
          <td align="center" valign="middle"> 
            <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
              <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>Customer Name :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtCustName" type="text" class="textfield" size="12" value="<%=rs.getString(4)%>">
                  </font></td>
              </tr>
			   <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>Description :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtDescription" type="text" class="textfield" size="12" value="<%=dbl(rs.getString(2))%>">
                  </font></td>
              </tr>

              <tr> 
                <td   align="right" class="fieldnames"><b>Email :</b></td>
                <td>&nbsp;</td>
                <td align=left><font face="verdana" size="1"> 
                  <input name="txtEmail"  class="textfield" size="12"  value="<%=dbl(rs.getString(3))%>">
                  </font></td>
              </tr>
			    <tr> 
                <td width="47%"   align="right"><b></b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" height="30" align=left><font face="verdana" size="1"> &nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="Submit" class="Button" value="&nbsp;UPDATE&nbsp;">
                  </font><input type=hidden name="oldCustID" value="<%=request.getParameter("selectCustNames")%>" class=text><input type=hidden name="NewCustID" value="<%=rs.getInt(1)%>" class=text></td>
              </tr>
		</table>
		</TD>
		</tr>
	</table>
<%}
	catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
%>

		</form>	
		</CENTER>
	</BODY>
</HTML><%
				   }

else {
%>
		<jsp:forward page="index.jsp" />
<%
}

%>