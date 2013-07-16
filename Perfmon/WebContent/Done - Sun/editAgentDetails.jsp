<!--Editing Agent Details-->
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
<%
   try {
        //Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection C = getConnection();
        //DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");
        Statement stmt = C.createStatement();
        String oldAgentID = request.getParameter("selectAgentId");
        ResultSet rs=stmt.executeQuery("select * from agents where AGENTID='"+oldAgentID+"'");
        rs.next();
%>

<HTML>
	<HEAD>
		<TITLE>Add User</TITLE>
<script>
function checkOnSubmit(form) {
	var Space=/[^" "]/;
	if( form.txtHostName.value=="" || (Space.test(form.txtHostName.value)==false)) {
            alert("Enter Valid Host Name"); 
            form.txtHostName.focus();
            return false;
	}
	/*if(!validateIP(form.txtIp.value)) 
    {
    alert("Enter Valid IP Address"); 
	form.txtIp.focus();
	return false;
	}


	return true;*/
}
/*function validateIP(what) {
    if (what.search(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/) != -1) {
        var myArray = what.split(/\./);
        if (myArray[0] > 255 || myArray[1] > 255 || myArray[2] > 255 || myArray[3] > 255)
            return false;
        if (myArray[0] == 0 && myArray[1] == 0 && myArray[2] == 0 && myArray[3] == 0)
            return false;
        return true;
    }
    else
        return false;
}*/
</script>
 </HEAD>
<link href="birt.css" rel="stylesheet" type="text/css">
	<BODY>
	<CENTER>
		  <form name=addAgentForm onSubmit="return checkOnSubmit(addAgentForm);" action="updateAgentDetails.jsp" method=post>
 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
          <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;UPDATE AGENT </td></tr>
		<tr> 
          <td align="center" valign="middle"> 
            <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
              <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>AgentID(IP) :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input  name="txtAgentID" value="<%=rs.getString(1)%>" readonly class="textfield" size="12">
                  </font></td>
              </tr>
			   <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>Host Name :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtHostName" value="<%=rs.getString(2)%>" class="textfield" size="12">
                  </font></td>
              </tr>
			 <tr> 
                <td width="47%"   align="right"><b></b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" height="30" align=left><font face="verdana" size="1"> &nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="Submit" class="Button" value="&nbsp;Update&nbsp;">
                  <input type=hidden name="oldAgentID" value="<%=request.getParameter("selectAgentId")%>" ></td>
              </tr>
					  </table>
		</TD>
		</tr>
	</table>
<%
   } catch (Exception E) {
        out.println("SQLException: " + E.getMessage());
   }
%>
	</form>	
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