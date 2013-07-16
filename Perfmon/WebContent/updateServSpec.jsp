<!-- Update Agent Details User Interface page-->
<%@ include file="escapechars.jsp" %>
<%@ include file="connection.jsp" %>
<%
if(session.getAttribute("userid")!=null ) {
%>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*"  %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"   %>
<%@ page import="java.sql.*"  %>
<HTML>
	<HEAD>
		<TITLE>Update Service Specifications</TITLE>
		<link href="birt.css" rel="stylesheet" type="text/css">
<script>
function checkOnSubmit(form)
{

if(form.selectSdesc.selectedIndex==0)
    {
    alert("Select Service Description"); 
	form.selectSdesc.focus();
	return false;
	}
	return true;
}
</script>
</HEAD>
<BODY>
<CENTER>
 <form name=updateservSpecFrm onSubmit="return checkOnSubmit(updateservSpecFrm);" action="editjmxupload.jsp" method=post> 
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
		 <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;UPDATE SERVICE SPECIICATIONS</td></tr>
		<tr> 
          <td align="center" valign="middle"> 
		<table width="370" border="0" cellspacing="0" cellpadding="1" height="90">
              <tr> 
					<td width="47%"  align="right" class="fieldnames"><b>SERVICE DESCRIPTION :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left>
                  <select name=selectSdesc class="select">
			   <option value="">&nbsp;&nbsp;&nbsp;Select Service Description&nbsp;&nbsp;&nbsp;</option>
 
 <%
    try {
        Connection C = getConnection();
        Statement stmt = C.createStatement();
        String recCountQry = "select count(*) as rowCount from monitoringspecifications";
        ResultSet r = stmt.executeQuery(recCountQry);
        r.next();
        int ResultCount = r.getInt("rowCount") ;
        r.close() ;
        String SQL = "select serviceid,sdescription from monitoringspecifications order by sdescription";
        ResultSet rs=stmt.executeQuery(SQL);
        while(rs.next()) {
            out.println("<option value="+rs.getString(1)+">"+rs.getString(2)+"</option>");
	}
    } catch (Exception E) {
        out.println("SQLException: " + E.getMessage());
    }
%>
			   </select>
			</td>
         <tr> 
                <td colspan="3" height="30" align="center"><font face="verdana" size="1"> 
				   <INPUT TYPE="Submit" Value="&nbsp;UPDATE&nbsp;" class="Button">
                  </font></td>
              </tr>
		</table>
		</TD>
		</tr>
	</table>
  </td>
 </tr>
</table>
</CENTER>
</BODY>
</HTML>
<%
} else {
%>
    <jsp:forward page="index.jsp" />
<%
}
%>