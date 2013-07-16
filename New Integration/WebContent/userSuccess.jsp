<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="connection.jsp" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*,java.sql.Statement" %>
<%
if(session.getAttribute("userid")!=null)
{
%>
<HTML>
<HEAD> 
<title>User Success</title>
<link href="css/CFP_per_new.css" rel="stylesheet" type="text/css">
<script> 
history.forward(-1);
function displayDailySummary(){


		var serviceId= document.getElementById("selectServiceOptions").value;
		
		document.selectServiceForm.action="userAccess.jsp?serviceId=serviceId";
		document.selectServiceForm.submit();

}
</script>
</HEAD> 
<%!
	Connection con=null;
	Statement stmt = null;
	ResultSet rs = null;
	Object  id;
	int custID;
	String customerName=null;
	
%>
<!--<%
try{
out.println("<b>Welcome To</b>");
out.println("<b>"+session.getAttribute("userName")+"</b>"+"<br>");
custID = ((Integer)session.getAttribute("custid")).intValue();
out.println(" CustomerID"+" "+custID);

}
catch(Exception e){
	System.out.println(e);
}


%>-->
<body bgcolor="#EFF4F9" onload="" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<form name="selectServiceForm">
<table width="100%" border="0" height=127 cellpadding="0" cellspacing="0" background="images/CFP_top_bar.gif">
<tr>
<td>
<table width="100%" height="60" border="0" cellpadding="0" cellspacing="0" >
              <tr> 
                <td width="50%"><p>&nbsp;</p>
                  <p>&nbsp;</p></td>
                <td width="50%" align="right"><p><img src="images/applogo.gif" width="166" height="54"></p>
                  <p>&nbsp;</p></td>
				</tr><tr>
				<td width="50%" align="right"></b></a>&nbsp;&nbsp;&nbsp;</td>
				</tr>
              
 </table>
 </td>
 </tr>
 </table><br> 
 <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
	<tr>
	<td bgcolor="#EFF4F9" align="center">
    <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
	<tr><td height="25" align="left" valign="middle" class="tabheading" >&nbsp;&nbsp;WELCOME TO PERFORMANCE MONITORING SUITE</td>
	<TD class="tabheading" ALIGN="RIGHT">Hello &nbsp;&nbsp;<font CLASS="HEADDB"><%=session.getAttribute("userName")%>!!&nbsp;&nbsp;&nbsp;&nbsp;</font></TD>	
	</tr>
	<tr>
		<td >
			<table class="tabinside" align="left">
					<tr>
						<td colspan=2 class="heading">
							URL Performance Monitoring
						</td>
					</tr>
					<tr>
						<td colspan=2>
							&nbsp;
						</td>
					</tr>
				 <tr>
					<td colspan=2 class="runningtext">
					<p>
					The phenomenal growth of internet driven businesses has placed the onus on application performance and availability in determining company's profitability. Managing application performance in a systematic, proactive and from an end user perspective is the need of the hour. In order to manage application performance, AppLabs offers business process performance monitoring service.  The service helps to :
					</p>
					<p>
					<ul type="disc">
					<li>
						Ensure all components of the application is functional and available (24x7)
					<li>	Reduction in lead time to diagnose the problems 
					<li>	Pinpointing the problems accurately
					<li>	Provides trends in customer usage & behavior.
					<li>	Helps to proactively find the problems before your customer finds it.
					</ul>

				</p>
				</td>
				</tr>
				<tr>
					<td colspan=2 class="heading">
						Service specifications
					</td>
				</tr>
				<tr>
						<td colspan=2>
							&nbsp;
						</td>
					</tr>
				<tr>
					<td colspan=2 class="runningtext">
					<p>
					AppLabs' business process performance monitoring helps you to monitor your critical and frequently used business processes. The monitoring frequency and the monitoring location are configurable based on the customer needs. The monitors collect end to end performance metrics and provide feedback on the trends in customer usage, service availability, end user experience by geographic location, quality of service and initial diagnosis to pinpoint problems.  The service also provides instant notification via e-mail on service failure.   Customer provides the URL's and business processes to be monitored, locations from which the monitoring is carried out and the frequency of monitoring.
					</p>
				</td>
				</tr>
				<tr>
						<td colspan=2>
							&nbsp;
						</td>
				</tr>
				<tr>
					<td colspan=2>
					 <table  cellspacing="0" cellpadding="4" valign=top border=1 align="center">
						<tr><td class="tabtddiff" align="center">Features</td><td class="tabtddiff" align="center">Benefits</td></tr>
						<tr><td class="runningtext">Measure simultaneously from  different geographic locations</td><td class="runningtext">Modeling real world web-site traffic with highest accuracy</td></tr>
						<tr><td class="runningtext">Measure end to end performance from end user perspective (outside firewall)</td><td class="runningtext">Models true end-user experience</td></tr>
						<tr><td class="runningtext">Provides detailed breakdown of transaction time in terms of DNS resolution, TCP connect time, time to first byte, download time etc.</td><td class="runningtext">Helps in troubleshooting and granular performance metric analysis</td></tr>
						<tr><td class="runningtext">Provides availability and end user experience  trend analysis </td><td class="runningtext">Helps in improving quality of services by avoiding outages, slowdowns and proactively meeting SLA</td></tr>
						<tr><td class="runningtext">Superior on-line reporting</td><td class="runningtext">Reports can be delivered on daily, weekly, monthly or on-demand basis via e-mail or can be accessed through our secure portal.</td></tr>
					 </table>
					 </td>
					 </tr>
					<tr>
						<td colspan=2>
							&nbsp;
						</td>
					</tr>
				<tr>
						<td colspan=2 class="runningtext">
							<b>Please contact for any clarifications</b> <a href="mailto:performance@applabs.com"><font  color="blue" >performancesupport@applabs.com</a>
						</td>
				</tr>
			</table>
		</td>
		<td align="right" width="35%" valign="top"> 
			<table  border="0" cellspacing="0" cellpadding="1" height="30" align="right">
			<tr> 
						<td width="47%" align="right" class="fieldnames"><b>SERVICE DESCRIPTION&nbsp;&nbsp;</b></td>
						<td width="47%" height="30" align=left><SELECT name="selectServiceOptions" class="select" onChange=" javascript:displayDailySummary()">
						<option value="">Select Service</option>
					<%	
				
				try
				{
				con = getConnection();
				stmt = con.createStatement();
				String sqlString = "select serviceid,sdescription from monitoringspecifications where custid="+custID;
				rs=stmt.executeQuery(sqlString);
				while(rs.next())
				{
					out.println("<option value="+rs.getInt(1)+">"+rs.getString(2)+"</option>");

				}
				
			}catch (Exception sqlException){
				out.println("SQLException: " + sqlException.getMessage());
			}
			
			%>
			 </select>
			</td>
			<tr> 
			</table>
	</td>
    
	</tr>
	<tr> 
     </tr>
     </table>
	
     
  </td>
  </tr>
 </table>
</body>
</html>
<%
}else {
			%>
				<jsp:forward page="index.jsp" />
			<%
	}

%>