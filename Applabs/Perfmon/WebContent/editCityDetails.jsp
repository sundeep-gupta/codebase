<!-- To edit the details of the city values -->

<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>
<%
// Allows to edit the values of the city selected.
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
		
		Connection C = getConnection();
		

		Statement stmt = C.createStatement();

		int oldCityID = Integer.parseInt(request.getParameter("selectCityId"));

		ResultSet rs=stmt.executeQuery("select * from cities where CITYID= "+oldCityID);
        
		rs.next();

%>
	
<HTML>
	<HEAD>
		<TITLE>Add City</TITLE>
		<script>
function checkOnSubmit(form)
{
	var Space=/[^" "]/;
if(form.txtName.value=="" || (Space.test(form.txtName.value)==false))
    {
    alert("Name Should not be NULL"); 
	form.txtName.focus();
	return false;
	}
if(form.txtDescription.value=="" || (Space.test(form.txtDescription.value)==false))
    {
    alert("Description Should not be NULL"); 
	form.txtDescription.focus();
	return false;
	}


	return true;
}
</script>
 </HEAD>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<BODY>
	<form name=addCityForm onSubmit="return checkOnSubmit(addCityForm);" action="updateCityDetails.jsp" method=post>
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
          <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;UPDATE CITY
		<INPUT TYPE=hidden Size=20 name="txtCityID" value="<%=dbl(rs.getString(1))%>" class=text></td></tr>
		<tr> 
          <td align="center" valign="middle"> 
            <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
              <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>Name :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtName" type="text" class="textfield"  value="<%=dbl(rs.getString(2))%>" size="12" readonly>
                  </font></td>
              </tr>
			   <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>Description :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtDescription" value="<%=dbl(rs.getString(3))%>" type="text" class="textfield" size="12" >
                  </font></td>
              </tr>
					   <tr> 
                <td width="47%"   align="right"><b></b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" height="30" align=left><font face="verdana" size="1"> &nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="Submit" class="Button" value="&nbsp;UPDATE&nbsp;"><input type=hidden name="oldCityID" value="<%=request.getParameter("selectCityId")%>" class=text>
		      </font>
			 </TD>
			</tr>
		</table>
		</TD>
		</tr>
	</table>
			<%
C.close();				   
}
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