<!--Interface To Add agent details into the Database -->
<%@ include file="escapechars.jsp" %>
<%@ include file="connection.jsp" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">

<HTML>
	<HEAD>
		<TITLE>Add Agents</TITLE>
<script>
function checkOnSubmit(form)
{
	var Space=/[^" "]/;
if( form.txtHostName.value=="" || (Space.test(form.txtHostName.value)==false))
    {
    alert("Enter Host Name"); 
	form.txtHostName.focus();
	return false;
	}

if(!validateIP(form.txtIp.value)) 
    {
    alert("Enter Valid IP Address"); 
	form.txtIp.focus();
	return false;
	}

if( form.selectCityId.selectedIndex==0)
    {
    alert("Select City ID"); 
	form.selectCityId.focus();
	return false;
	}

	return true;
}

function validateIP(what) {
    if (what.search(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/) != -1) {
        var myArray = what.split(/\./);
        if (myArray[0] > 255 || myArray[1] > 255 || myArray[2] > 255 || myArray[3] > 255)
            return false;
        if (myArray[0] == 0 && myArray[1] == 0 && myArray[2] == 0 && myArray[3] == 0)
            return false;

		if (myArray[0] == 255 && myArray[1] == 255 && myArray[2] == 255 && myArray[3] == 255)
            return false;

		return true;
    }
    else
        return false;
}

</script>
 </HEAD>
	<BODY>
		<CENTER>
		  <form name=addAgentsForm onSubmit="return checkOnSubmit(addAgentsForm);" method=post action="addAgents.jsp">
          <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
          <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;ADD AGENT</td></tr>
		<tr> 
          <td align="center" valign="middle"> 
            <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
              <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>Agent ID :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtIp" type="text" class="textfield" size="12">
                  </font></td>
              </tr>
			   <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>HostName :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtHostName" type="text" class="textfield" size="12">
                  </font></td>
              </tr>
			  <tr> 
                <td width="47%"   align="right" class="fieldnames"><b>City Name:</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" height="30" align=left><SELECT name="selectCityId" class="select">
				<option value="">&nbsp;&nbsp;&nbsp;&nbsp;Select City&nbsp;&nbsp;&nbsp;&nbsp;</option>
		
<%
try {
    Connection C = getConnection();
    //DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");
    Statement stmt = C.createStatement();
    String SQL = "select * from cities order by name";
    ResultSet rs=stmt.executeQuery(SQL);
    while(rs.next()) {
        out.println("<option value='"+rs.getString(1)+"'>"+rs.getString(2)+"</option>");
    }
} catch (Exception E) {
    out.println("SQLException: " + E.getMessage());
}
%>
					 </select> 
                  </font></td>
              </tr>
				  <tr> 
                <td colspan="3" height="30" align="center"><font face="verdana" size="1">
                  <input type="Submit" class="Button" value="&nbsp;ADD AGENT&nbsp;">
                  </font></td>
              </tr>
            </table>
			</td>
              </tr>
            </table>
		</td>
        </tr>
	   </table>
	</form>	
		</CENTER>
	</BODY>
</HTML>