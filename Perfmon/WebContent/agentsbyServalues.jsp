<!-- To add the AgentId and  Service Id to the agentsbyservice table in the database-->
<!-- To accept the characters such as , ' etc from the user  -->
<%@ include file="escapechars.jsp" %>
<!-- To make use of the fuctions such as connection, and various stored procedures-->
<%@ include file="connection.jsp" %>
<link href="birt.css" rel="stylesheet" type="text/css">
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
// 
if(session.getAttribute("userid")!="") {		
    try {
        int serviceid=Integer.parseInt(request.getParameter("selSdes"));
        Connection C3 = getConnection();
        Statement stmt3 = C3.createStatement();
        String SQL3="select SDESCRIPTION from monitoringspecifications where SERVICEID="+serviceid;
        String serdes="";
        ResultSet rs3=stmt3.executeQuery(SQL3);
        while(rs3.next())
            serdes=rs3.getString(1);
        C3.close();
        //out.println(serdes);
        String[] agentbycities;
        agentbycities=new String[request.getParameterValues("selectAgentbycity").length];
        int len=agentbycities.length;
        int chk=0;
%>
  <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
					<tr>
					<td bgcolor="#EFF4F9" align="center">
					<table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
					<tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=3>&nbsp;&nbsp;AGENTS BY SERVICE</td></tr>
					<tr> 
					<td align="center" valign="middle"> 
			        <table width="440" border="0" cellspacing="0" cellpadding="1" height="90">
					<tr>
					<td class="dbvalues" align=left>
<%
        for(int i=0;i<len;i++) {
            agentbycities[i]=(request.getParameterValues("selectAgentbycity"))[i];
            Connection C1 = getConnection();
            Statement stmt1 = C1.createStatement();
            String SQLChk = "select count(*) as rowcount from agentsbyservice where agentid='"+agentbycities[i]+"' and serviceid="+serviceid;
            ResultSet rs=stmt1.executeQuery(SQLChk);
            rs.next();
            if(rs.getInt(1)==0) {
                C1.close();
                Connection C = getConnection();
                Statement stmt = C.createStatement();
                String SQL = "insert into agentsbyservice(agentid,serviceid) values('"+agentbycities[i]+"',"+serviceid+")";
                stmt.executeUpdate(SQL);
%>
					<b>Agent Id=<%=agentbycities[i]%> & Service Description=<%=serdes%></b>&nbsp;&nbsp;&nbsp;&nbsp;Inserted Successfully <br><br>
<%
                C.close();
                chk++;
            } else {
%>
					
					<b>Agent Id=<%=agentbycities[i]%> & Description=<%=serdes%></b>&nbsp;&nbsp;&nbsp;&nbsp;Already exists<br><br>
					
<%
            }
        }
        {
%>
			</td></tr>
			<tr><td align="center" valign=top>
			<a href="agentsbyService.jsp"><u> Back to Agents By Service</a> 
			</td></tr>
			</table>				
			</td></tr>
			</table>
			</td></tr></table>
<%
        }
    } catch (Exception E) { 
        out.println("SQLException: " + E.getMessage());
    }
} else {
%>
    <jsp:forward page="index.jsp" />
<%
}
%>