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
	System.out.println("User Id"+userId+"Service ID"+serviceId);


%>
<link href="css/CFP_per_new.css" rel="stylesheet" type="text/css">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script>
function generateCustomReport(){
	
  var fromdate=document.getElementById("fromdate").value;

  var todate=document.getElementById("todate").value;

var month1=fromdate.substring(0,2);
var day1=fromdate.substring(3,5);
var year1=fromdate.substring(6,11);

var month2=todate.substring(0,2);
var day2=todate.substring(3,5);
var year2=todate.substring(6,11);

var d1=new Date(year1,month1,day1).getTime();
var d2=new Date(year2,month2,day2).getTime();
var   day_in_mills  = 24 * 60 * 60 * 1000;
var NoOfDaysFirst = d1 / day_in_mills;
var NoOFDaysSecond= d2 / day_in_mills;
var interval = NoOFDaysSecond - NoOfDaysFirst
var fromString=year1+"-"+month1+"-"+day1;
var toString=year2+"-"+month2+"-"+day2;
 if(interval<=7) {
	labelVal = "Distribution By Day" ;

	document.getElementById("interval").innerText = labelVal;
	
	document.getElementById("one").src ="/NewIntegration/run?__report=CustomReport.rptdesign&sidParam=<%= serviceId %>&uidParam=<%= userId %>&interval="+interval+"&fromParam="+fromString+"&toParam="+toString;

	
	document.getElementById("two").src ="/NewIntegration/frameset?__report=CustomTableReport.rptdesign&__overwrite=true&sidParam=<%= serviceId %>&uidParam=<%= userId %>&fromParam="+fromString+"&toParam="+toString;

	}
	else if(interval>7 && interval<=31)
	{
	labelVal = "Distribution By Week" ;
	document.getElementById("interval").innerText = labelVal;
	document.getElementById("one").src ="/NewIntegration/run?__report=CustomReport.rptdesign&sidParam=<%= serviceId %>&uidParam=<%= userId %>&interval="+interval+"&fromParam="+fromString+"&toParam="+toString;

	document.getElementById("two").src ="/NewIntegration/frameset?__report=CustomTableReport.rptdesign&__overwrite=true&sidParam=<%= serviceId %>&uidParam=<%= userId %>&fromParam="+fromString+"&toParam="+toString;


	}
	else
	{
	labelVal = "Distribution By Month" ;
	document.getElementById("interval").innerText = labelVal;
	document.getElementById("one").src ="/NewIntegration/run?__report=CustomReport.rptdesign&sidParam=<%= serviceId %>&uidParam=<%= userId %>&interval="+interval+"&fromParam="+fromString+"&toParam="+toString;
	
	document.getElementById("two").src ="/NewIntegration/frameset?__report=CustomTableReport.rptdesign&__overwrite=true&sidParam=<%= serviceId %>&uidParam=<%= userId %>&fromParam="+fromString+"&toParam="+toString;


	}

}
</script>
</HEAD>

<%!
	Connection con=null;
	Statement stmt = null;
	ResultSet rs = null;

%>

<BODY onLoad="">
<form name="customRpt">
 <table width="95%" border="0" cellpadding="0" cellspacing="0" align="center" class="tabinside">
        <tr> 
          <td height="30" class="tabheading">&nbsp;&nbsp;Custom Reports</td>
        </tr>
        <tr> 
          <td class="tdstrokecont" valign="top">
		<table width="95%" align="CENTER" border=0 cellspacing=0 cellpadding=0 height="40%">
						<tr>
						<td class="fieldnames" height="30" width="40%">From Date : <input type="text" class="textfield" name="fromdate" value="MM/DD/YYYY" ></td>
						<td class="fieldnames">&nbsp;&nbsp;To Date : <input type="text" class="textfield" name="todate" value="MM/DD/YYYY" ></td>
						<td align="left" width="30%"><input type="button" value="Submit" CLASS="BUTTON" onClick="javascript:generateCustomReport()"></td>
						</tr>
		</table>
		</td>
	</tr>
	</table>
	<table width="95%" border="0" cellpadding="0" cellspacing="0" valign="middle" align="center">
	<TR height="20">
				
				<TD id="interval" colspan=3 class="distribution" valign="center" align="center"><b>
				</TD>
	</TR>

	<TR>
			<TD >
				<DIV id="first">
				<iframe name="one"  valign="middle" width="100%" height="275" frameborder="no" scrolling="no" marginwidth=0 align="center">
				 </iframe>
				</DIV>
			</TD>
	</TR>
	 <TR>
			<TD >
			<DIV id="second">
				<iframe name="two"  width="100%" height="300" frameborder="no" scrolling="no" marginwidth=0 valign="top">
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
