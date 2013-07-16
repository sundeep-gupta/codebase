<!--To Add agent details into the Database -->
<!-- To avoid problems with special characters like ',"" etc -->
<%@ include file="escapechars.jsp" %>
<%@ include file="connection.jsp" %>
<%
if(session.getAttribute("userid")!=null )
{
%>
<link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%
   try {
%>
	 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
		<tr>
		<td bgcolor="#EFF4F9" align="center">
        <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;ADD 
        AGENT</td></tr>
		<tr> 
        <td align="center" valign="middle"> 
        <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<td class="fieldnames" ALIGN="CENTER">
		<%
		Connection C = getConnection();
		Statement stmt = C.createStatement();
		//Getting the Form elements
		String hostname = request.getParameter("txtHostName");
		hostname=hostname.trim();
		String ip = request.getParameter("txtIp");
		int cityid=Integer.parseInt(request.getParameter("selectCityId"));
		//String cityname=request.getParameter("selectCityId");
		Connection C1 = getConnection();
		//Checking if Agent already exists
		Statement stmt1 = C1.createStatement();
		String CHECK = "select count(agentid) as rowcount from agents where agentid='"+ip+"'";
		ResultSet rs=stmt1.executeQuery(CHECK);
		rs.next();
		int test = rs.getInt(1);
		if (test!=0) {%>
                    <center><b> Agent Already exists with the Agent ID <%=ip%> </b><br><b> <center> 
				<br><br><a href="javascript:history.back();">Back to AddAgent</a> 
				</center> 
            <%}	else {//Adding new Agent into the Database		
                Statement stmthost = C1.createStatement();
                String HostCheck = "select count(agentid) as rowcount from agents where hostname='"+hostname+"'";
                ResultSet rshost=stmthost.executeQuery(HostCheck);
                rshost.next();
                int testhost = rshost.getInt(1);
        	if (testhost!=0) { %>
                    <b> Agent Already exists with the Host Name <%=hostname%> </b><br><b> 
	            <br><br><a href="javascript:history.back();">Back to AddAgent</a>
              <%} else {
                    String SQL = "insert into agents(agentid,hostname,cityid) values('"+ip+"','"+hostname+"',"+cityid+")";
                    int j = stmt.executeUpdate(SQL);
		//int j = addAgent(ip,hostname,cityid);
                    if(j==1) {
			int i=1;
			if(i==1) {
                            String SQLCity="select name from cities where cityid="+cityid;
                            Statement stmt2=C1.createStatement();
                            ResultSet rsCity=stmt1.executeQuery(SQLCity);
                            rsCity.next();
                            String cityname=rsCity.getString(1);
			    C1.close();
            %>
        <b> Agent Added Successfully </b></font> <br> <br>
         <table>
         <tr><td class="fieldnames" align=right> HostName   : </td><td class="fieldnames" ><%=hostname%></td></tr>
         <tr><td class="fieldnames" align=right> IP : </td><td class="fieldnames"><%=ip%></td></tr>
         <tr><td class="fieldnames" align=right> City Name : </td><td class="fieldnames"><%=cityname%></td></tr>
        </table>
        <br><br><a href="addAgentValues.jsp">Back to AddAgent</a> 
            <%   
                        }
                    } else {
            %>
	<b> Add Agent Failed</b>
        <br><br><a href="javascript:history.back()">Back to AddAgent</a> 
            <%      }
        	}
            }
	} catch (Exception E){
            out.println("SQLException: " + E.getMessage());
        }
    } else {
            %>
<jsp:forward page="index.jsp" />
<% } %>