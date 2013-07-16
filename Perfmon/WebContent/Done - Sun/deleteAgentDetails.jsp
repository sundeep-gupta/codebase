<!--To Delete agent details from the Database -->
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
	 <form name=deleteAgentFrm onSubmit="return checkOnSubmit(deleteAgentFrm);" action="deleteAgentDetails.jsp" method=post> 
	  <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
		<tr>
		<td bgcolor="#EFF4F9" align="center">
	      <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;DELETE AGENT</td></tr>
			<tr> 
          <td align="center" valign="middle"> 
		<table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<td class="fieldnames" ALIGN="CENTER">
<%
        Connection C = getConnection();
        Statement stmt = C.createStatement();
        String agentid = request.getParameter("selectAgentID");
        // To check the constraints from the database for Services assigned to this agent
        String SQL ="select count(*) as rowcount from agentsbyservice where agentid='"+agentid+"'";
        ResultSet rs=stmt.executeQuery(SQL);
        rs.next();
        int test = rs.getInt("rowcount");
        if (test!=0) {
%>
            <b>There are services assigned to this agents    Delete Services First </b>
            <br><br><a href="deleteAgent.jsp">Back to Delete Agent</a> 
            </center> 
<%
        } else {
            /*int i = deleteCustomer(custid);
            out.println("i = ");
            out.print(i);*/
            Connection C1 = getConnection();
            Statement stmt1 = C1.createStatement();
            String SQLDel="delete from agents where agentid='"+agentid+"'";
            int i=stmt1.executeUpdate(SQLDel);
            if(i==1) {
%>
    <b> Agent Deleted Successfully </b></font><br><b> 
    <br><br><a href="deleteAgent.jsp">Back to Delete Customer</a> 
<%    
            } else {
%>
    <b>Failed in Deleting Agent </b><br><br>
    <a href="javascript:history.back()"><u> Back to Delete Agent</a>
<% 
            }
        }
%>
			  </td>
		  </tr>
		</table>
		</td>
		</tr>
		</table>
		</td>
		</tr>
		</table>
<%
    } catch (Exception E){
        out.println("SQLException: " + E.getMessage());
    }
} else {
%>
<jsp:forward page="index.jsp" />
<%
}
%>