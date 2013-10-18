<!-- View Agents using a dropdown list -->
<%@ include file="escapechars.jsp" %>
<%@ include file="connection.jsp" %>

<%
if(session.getAttribute("userid")!=null ) {
%>
<link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">

<HTML>
	<HEAD>
		<TITLE> View Agent</TITLE>
<script>
function checkOnSubmit(form)
{
	

	if(form.selSdes.selectedIndex==0)
		{
		alert("Select Service Description"); 
		form.selSdes.focus();
		return false;
		}
	if(form.selectAgentbycity.selectedIndex==0)
		{
		alert("Select Atleast One Agent"); 
		form.selectAgentbycity.focus();
		return false;
		}
	return true;
}

</script>

	</HEAD>
	<BODY>
	  <form name=agentsbyService onSubmit="return checkOnSubmit(agentsbyService);" action="agentsbyServalues.jsp" method=post> 
       <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
		<tr>
		<td bgcolor="#EFF4F9" align="center">
        <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=3>&nbsp;&nbsp;AGENTS BY SERVICE</td></tr>
		<tr> 
          <td align="center" valign="middle"> 
            <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
			<tr> 
                <td width="47%" align="left" class="fieldnames"><b>SERVICE DESCRIPTION :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" height="30" align=left><SELECT name="selSdes" class="select">
				<option value="">Select service description</option>
		
<%
    try {
        Connection C = getConnection();
        Statement stmt = C.createStatement();
        String SQL = "select * from monitoringspecifications order by sdescription";
        ResultSet rs=stmt.executeQuery(SQL);
        while(rs.next()) {
            out.println("<option value="+rs.getString(2)+">"+rs.getString(6)+"</option>");
        }
    } catch (Exception E) {
        out.println("SQLException: " + E.getMessage());
    }
%>
			   </select>
			</td>
	</tr>

	<tr> 
        <td width="47%" valign=top  align="left" class="fieldnames"><b>AGENTS BY CITIES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b></td>
        <td width="2%">&nbsp;</td>
        <td width="51%" height="30" align=left><select name="selectAgentbycity" multiple size=5 class="select">
		<option value="">Select Agent by Cities</option>
<%
    try {
        /*Connection C = DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");*/
        Connection C = getConnection();
        Statement stmt = C.createStatement();
        String SQL = "select agentid,name from cities,agents where cities.cityid=agents.cityid";
        ResultSet rs=stmt.executeQuery(SQL);
        while(rs.next()) {
            out.println("<option value="+rs.getString(1)+">"+rs.getString(1)+"("+rs.getString(2)+")</option>");
        }
    } catch (Exception E) {
	out.println("SQLException: " + E.getMessage());
    }
%>
			  </select> 
              </font>
			  </td>
              </tr>
				
			  <tr> 
                <td colspan="3" height="30" align="center"><font face="verdana" size="1">
				  <input type="Submit" class="Button" value="&nbsp;&nbsp;ADD&nbsp;&nbsp;">
                 </td>
              </tr>
            </table>
			</td>
            </tr>
          </table>
		</td>
        </tr>
	   </table>
	</BODY>
</HTML>
<%
} else {
%>
    <jsp:forward page="index.jsp" />
<%
}
%>