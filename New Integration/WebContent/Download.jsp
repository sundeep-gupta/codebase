<%@ page import="java.sql.*,java.sql.Statement" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="connection.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


<%
if(session.getAttribute("userid")!=null)
{
%>

<%

 Object  sid=(String)session.getAttribute("serviceid");
	int serviceId = Integer.parseInt((String)sid);
	Object uid=session.getAttribute("userid");
	String userId=uid.toString();
	System.out.println(uid);

%>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script>
</script>
</HEAD>
<%!
	Connection con=null;
	Statement stmt = null;
	ResultSet rs = null;

%>

<BODY>
<form name="customRpt" action="DownloadPage.jsp"><br>
 <table width="95%" height="92%" border="0" cellpadding="0" cellspacing="0" align="center" class="tabinside">
        <tr> 
          <td height="30" class="tabheading">&nbsp;&nbsp;Download Reports</td>
        </tr>
        <tr> 
          <td class="tdstrokecont" valign="top">
		<table width="95%" align="CENTER" border=0 cellspacing=0 cellpadding=0 height="92%">
						<tr>
						<td class="fieldnames" height="30" width="40%">From Date : <input type="text" class="textfield" name="fromdate" value="MM/DD/YYYY" ></td>
						<td class="fieldnames">&nbsp;&nbsp;To Date : <input type="text" class="textfield" name="todate" value="MM/DD/YYYY" ></td>
						</tr>
						<tr>
						<td  colspan=2 valign="top">
						<table valign=top align=left BORDER=0 WIDTH=100%>
								<tr>
									<td class="fieldnames" valign="top" WIDTH=10%>Location&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp;&nbsp;&nbsp;	
									</td>
									<td>
									<table valign=top align=left>
									<tr>
									<td >
									<SELECT  multiple  NAME="locations"  class="textarea">						
								<%			
									try
									{
				con = getConnection();
				stmt = con.createStatement();

				String sqlString = "select cities.cityid,cities.name from cities,agents,agentsbyservice where  agentsbyservice.serviceid=" + session.getAttribute("serviceid")+ " and agentsbyservice.agentid=agents.agentid and agents.cityid=cities.cityid";
										rs=stmt.executeQuery(sqlString);
										while(rs.next())
										{
											out.println("<option value="+rs.getInt(1)+">"+rs.getString(2)+"</option>");

										}
									}catch (Exception sqlException){
									out.println("SQLException: " + sqlException.getMessage());
									}
								%>
								 </SELECT>
							
									<td class="fieldnames" height="10" width="10">
									
									</td>
									<td>&nbsp;&nbsp;&nbsp;</td>
		<td class="fieldnames"><input type="submit" value="Submit" CLASS="BUTTON"></td>
					
									</tr>
									</table>
									</td>
										
								</tr>
								
								</table>
		</td>
        </tr>
			
      </table>
 </form>
</BODY>
</HTML>
<%
}else {
			%>
				<jsp:forward page="index.jsp" />
			<%
	}

%>
