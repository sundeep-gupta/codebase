<%@ page import="java.sql.*,java.sql.Statement" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="connection.jsp" %>
<link href="css/CFP_per_new.css" rel="stylesheet" type="text/css">
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
	System.out.println("User Id"+uid+"Service ID"+serviceId);
	
%>
<HTML>
<HEAD>
<TITLE>  </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script language="javascript">
history.forward(-1);
function generateWeeklyReports(){
		
var SelectedLocation=document.getElementById("selectServiceOptions").value;
var SelectedStatus=document.getElementById("selectStatusOptions").value;
var contextpath='<%=request.getContextPath()%>';
	
	if(SelectedLocation=="selectLocation"){
		alert("Select a location");
		document.getElementById("selectServiceOptions").focus();
		//return;
	}

	document.getElementById("one").src ="<%=request.getContextPath() %>/run?__report=WeeklyDetailedChartReport.rptdesign&sidParam=<%= serviceId %>&uidParam=<%= userId %>&cityParam=" + SelectedLocation;

	if(SelectedStatus=="All"){

//document.getElementById("one").src ="/NewIntegration/run?__report=WeeklyDetailedChartReport.rptdesign&sidParam=<%= serviceId %>&uidParam=<%= userId %>&cityParam=" + SelectedLocation;

document.getElementById("two").src="<%=request.getContextPath() %>/frameset?__report=WeeklyDetailedTableReport.rptdesign&__overwrite=true&sidParam=<%= serviceId %>&uidParam=<%= userId %>&cityParam=" + SelectedLocation;

}
else{
	
//document.getElementById("one").src="/NewIntegration/run?__report=WeeklyDetailedChartReport.rptdesign&sidParam=<%= serviceId %>&uidParam=<%= userId %>&cityParam=" + SelectedLocation;

document.getElementById("two").src="<%=request.getContextPath() %>/frameset?__report=WeeklyDetailedFailure.rptdesign&__overwrite=true&sidParam=<%= serviceId %>&uidParam=<%= userId %>&cityParam=" + SelectedLocation;


}	
}

function weekDays(){
	var dt = new Date();

	dt.setDate(dt.getDate()-dt.getDay()-1)
	mon = dt.getMonth()
	mon += 1
	
	var lastDate = dt.getDate() + '-' + mon + '-' + dt.getFullYear();

	dt.setDate(dt.getDate()-6)
	mon = dt.getMonth()
	mon += 1

	var firstDate = dt.getDate() + '-' + mon + '-' + dt.getFullYear();

	labelVal = "From Date   : " + firstDate + ' To Date : ' + lastDate;
	document.getElementById('weekDate').innerText = labelVal;

}

</script>
</HEAD>
<%!
	Connection con=null;
	Statement stmt = null;
	ResultSet rs = null;

%>
<BODY onLoad="javascript:weekDays()">
<form name="" method="get">
<table width="95%" border="0" cellpadding="0" cellspacing="0" align="center" class="tabinside">
			
				<table width="95%" border="0" cellpadding="0" cellspacing="0" align="center" class="tabinside">
        <tr> 
          <td height="30" class="tabheading">&nbsp;&nbsp;Detailed - Weekly</td>
        </tr>
        <tr> 
          <td  valign="top">
		<table width="95%" align="CENTER" border="0" cellspacing=0 cellpadding=0  height="40%">
						<tr>
						<td colspan="3" valign=middle height="30" width="30%" class="fieldnames"><b>
							Customer &nbsp;&nbsp; :<%=session.getAttribute("custname")%>
						</td>
						</tr>
					<tr>
					<td id="weekDate" align colspan="3" class="fieldnames" height="30" width="55%">
					</td>
					</tr>
						<tr>
						<td colspan="3" class="fieldnames" valign=middle height="30" width="30%"><b>
				Location &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: 
				<SELECT name="selectServiceOptions" class=dropmenu>
						<option value="selectLocation" class=select>Select Location</option>			
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
			</td>
			<td class="fieldnames" valign=middle height="30" width="25%" align=left><b>
			Select Status:
	    	 <SELECT name="selectStatusOptions" class=dropmenu>
						 <option value="All" selected class=select>All</option>
						 <option value="Failure" class=select>Failure</option>				
						 
			 </SELECT>
			</td>
			<td align="left" width="25%"><input type="button" value="View Report" class=button  onClick="javascript:generateWeeklyReports()"/></td>
						</tr>
						
		</table>
		</td>
	</tr>
	</table>
 </TABLE >	 
		<TABLE width="95%" border="0" cellpadding="0" cellspacing="0" valign="middle" align="center">
			<tr>
				<td colspan="3">&nbsp;
				</td>
			</tr>
		<TR>
				<TD colspan="3">
					<DIV id="first">
				 <iframe name="one"  width="350%" height="250" frameborder="no" scrolling="no" marginwidth=0>
				 </iframe>
					</DIV>
				</TD>
		</TR>
	 <TR>
		<TD colspan="3">
			<DIV id="second">
				<iframe name="two" width="100%" height="350" frameborder="no" scrolling="no" marginwidth=0>
				 </iframe>	
			</DIV>
		</TD>
	 </TR>
	 </TABLE>	 
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
