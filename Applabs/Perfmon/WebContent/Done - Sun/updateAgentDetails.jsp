<!-- Update Agent Details in database-->
<%@ include file="escapechars.jsp" %>
<%@ include file="connection.jsp" %>
<%
if(session.getAttribute("userid")!=null ) {
%>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
    try {
%>
		 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
		<tr>
		<td bgcolor="#EFF4F9" align="center">
        <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		 <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;UPDATE AGENT DETAILS</td></tr>
		<tr> 
        <td align="center" valign="middle"> 
        <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<td class="fieldnames" ALIGN="CENTER">
	<%
        Connection C = getConnection();
        Statement stmt = C.createStatement();
        String agentid = request.getParameter("txtAgentID");
        String hostname = request.getParameter("txtHostName");
        hostname=hostname.trim();
	//String SQL = "update agents set IP='"+ip+"' where AGENTID="+agentid;
	//int i=stmt.executeUpdate(SQL);
	int i = updateAgent(agentid,hostname);
	if(i==1) {
%>
          	<center><b> Agent Updated Successfully </b><br><b> 
	            
			 <br><br><a href="javascript:history.back()" ><B><u> Back  to UpdateAgent</a></B>
			 
			 </center> 
              
			 
<%    
        } else {
%>
		<center><b>Failed in Updating Agent </b>
	    
        <br><br><a href="javascript:history.back()"><u><b> Back to UpdateAgent</b></a> </center>
<% 
	}//End of Inner If
		//}//End of Main if
		
    } catch (Exception E) {//End of try block
	out.println("SQLException: " + E.getMessage());
    }
} else {
%>
    <jsp:forward page="index.jsp"/>
<%
}
%>