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
<TITLE> Custom Report </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script>
/*
	  Validation on From Date and Todate
*/
var dtCh= "/";
var minYear=1900;
var maxYear=2100;

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   

        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }

    return true;
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year){
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}

function isDate(dtStr){
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strMonth=dtStr.substring(0,pos1)
	var strDay=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		alert("The date format should be : mm/dd/yyyy")
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		alert("Please enter a valid month")
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		alert("Please enter a valid day")
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		alert("Please enter a valid date")
		return false
	}
return true
}
/*
	Finding Interval and Display Custom Reports
*/
function generateCustomReport(){
	
  var fromdate=document.getElementById("fromdate").value;
  var todate=document.getElementById("todate").value;
  if((isDate(fromdate)==false) || (isDate(todate)==false)){
		 return false;
  }

  var firstSlash = fromdate.indexOf(dtCh)
	var secondSlash = fromdate.indexOf(dtCh, firstSlash + 1)
	var month1=fromdate.substring(0, firstSlash)
	var day1=fromdate.substring(firstSlash+1, secondSlash)
	var year1=fromdate.substring(secondSlash+1)

	firstSlash = todate.indexOf(dtCh)
	secondSlash = todate.indexOf(dtCh, firstSlash + 1)
	var month2=todate.substring(0, firstSlash);
	var day2=todate.substring(firstSlash+1, secondSlash);
	var year2=todate.substring(secondSlash+1);

/*var month1=fromdate.substring(0,2);
var day1=fromdate.substring(3,5);
var year1=fromdate.substring(6,11);

var month2=todate.substring(0,2);
var day2=todate.substring(3,5);
var year2=todate.substring(6,11);*/

var d1=new Date(year1,month1,day1).getTime();
var d2=new Date(year2,month2,day2).getTime();
var   day_in_mills  = 24 * 60 * 60 * 1000;
var NoOfDaysFirst = d1 / day_in_mills;
var NoOFDaysSecond= d2 / day_in_mills;

var interval = NoOFDaysSecond - NoOfDaysFirst

	if(day1.length == 1){
		day1 = '0'+day1
	}
	if(day2.length == 1){
		day2 = '0'+day2
	}
	if(month1.length == 1){
		month1 = '0'+month1
	}
	if(month2.length == 1){
		month2 = '0'+month2
	}

var fromString=year1+"-"+month1+"-"+day1;
var toString=year2+"-"+month2+"-"+day2;
 if(interval<0){
	 alert("FromDate Should be less than ToDate");
		 return false;
 }
 else if(interval<=7 && interval>=0) {
	labelVal = "Distribution By Day" ;
	document.getElementById("interval").innerText = labelVal;
	document.getElementById("one").src ="<%=request.getContextPath()%>/run?__report=CustomReport.rptdesign&sidParam=<%= serviceId %>&uidParam=<%= userId %>&interval="+interval+"&fromParam="+fromString+"&toParam="+toString;
	document.getElementById("two").src ="<%=request.getContextPath() %>/frameset?__report=CustomTableReport.rptdesign&__overwrite=true&sidParam=<%= serviceId %>&uidParam=<%= userId %>&fromParam="+fromString+"&toParam="+toString;

	}
	else if(interval>7 && interval<=31)
	{
	labelVal = "Distribution By Week" ;
	document.getElementById("interval").innerText = labelVal;
	document.getElementById("one").src ="<%=request.getContextPath()%>/run?__report=CustomReport.rptdesign&sidParam=<%= serviceId %>&uidParam=<%= userId %>&interval="+interval+"&fromParam="+fromString+"&toParam="+toString;
	document.getElementById("two").src ="<%=request.getContextPath() %>/frameset?__report=CustomTableReport.rptdesign&__overwrite=true&sidParam=<%= serviceId %>&uidParam=<%= userId %>&fromParam="+fromString+"&toParam="+toString;
	}
	else
	{
	labelVal = "Distribution By Month" ;
	document.getElementById("interval").innerText = labelVal;
	document.getElementById("one").src ="<%=request.getContextPath()%>/run?__report=CustomReport.rptdesign&sidParam=<%= serviceId %>&uidParam=<%= userId %>&interval="+interval+"&fromParam="+fromString+"&toParam="+toString;
	
	document.getElementById("two").src ="<%=request.getContextPath() %>/frameset?__report=CustomTableReport.rptdesign&__overwrite=true&sidParam=<%= serviceId %>&uidParam=<%= userId %>&fromParam="+fromString+"&toParam="+toString;
	}
}
/*
	Function for Set the title of Custom Report
*/
function setTitle(){
	parent.document.title = parent.frame3.document.title;
}
</script>
</HEAD>

<%!
	Connection con=null;
	Statement stmt = null;
	ResultSet rs = null;

%>

<BODY onLoad="setTitle()">
<form name="customRpt">
 <table width="95%" border="0" cellpadding="0" cellspacing="0" align="center" class="tabinside">
        <tr> 
          <td height="30" class="tabheading">&nbsp;&nbsp;Custom Reports</td>
        </tr>
        <tr> 
          <td class="" valign="top">
		<table width="95%" align="CENTER" border=0 cellspacing=0 cellpadding=0 height="40%">
						<tr>
						<td class="fieldnames" height="30" width="40%">From Date : <input type="text" class="textfield" name="fromdate" value="MM/DD/YYYY" ></td>
						<td class="fieldnames">&nbsp;&nbsp;To Date : <input type="text" class="textfield" name="todate" value="MM/DD/YYYY" ></td>
						<td align="left" width="30%"><input type="button" value="Submit" CLASS="BUTTON" onClick="return generateCustomReport()"></td>
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
				<iframe name="two"  width="100%" height="360" frameborder="no" scrolling="no" marginwidth=0 valign="top">
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
