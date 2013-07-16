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
<link href="css/CFP_per_new.css" rel="stylesheet" type="text/css">
<HTML>
<HEAD>
<TITLE> Download Report  </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script>
/*
	Functions for FromDate and ToDate validations
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
	Function for converting date format into mm-dd-yyyy from mm/dd/yyyy
*/
function submitForm(form){
	var fromdateJS=form.fromdate.value;
	var todateJS=form.todate.value;

	if((isDate(fromdateJS)==false) || (isDate(todateJS)==false)){
		return;
	}

	var firstSlash = fromdateJS.indexOf(dtCh)
	var secondSlash = fromdateJS.indexOf(dtCh, firstSlash + 1)
	var month1=fromdateJS.substring(0, firstSlash)
	var day1=fromdateJS.substring(firstSlash+1, secondSlash)
	var year1=fromdateJS.substring(secondSlash+1)

	firstSlash = todateJS.indexOf(dtCh)
	secondSlash = todateJS.indexOf(dtCh, firstSlash + 1)
	var month2=todateJS.substring(0, firstSlash);
	var day2=todateJS.substring(firstSlash+1, secondSlash);
	var year2=todateJS.substring(secondSlash+1);

	var d1=new Date(year1,month1,day1).getTime();
	var d2=new Date(year2,month2,day2).getTime();

	if(d1 > d2){
		alert('From date should not be less than To date');
		return;
	}
	
	var loc = document.getElementById("locations").value;
	if(loc == ' ' || loc == '' || loc == null){
		alert('Please select atleast one location');
		document.getElementById('locations').focus();
		return;
	}

	document.forms("customRpt").submit();

}
/*
	Function for setting the title of Download Page
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

<BODY onLoad="javascript:setTitle()">
<form name="customRpt" action="DownloadPage.jsp"><br>
 <table width="95%" height="92%" border="0" cellpadding="0" cellspacing="0" align="center" class="tabinside">
        <tr> 
          <td height="30" class="tabheading">&nbsp;&nbsp;Download Reports</td>
        </tr>
        <tr> 
          <td class="" valign="top">
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
		<td class="fieldnames"><input type="button" value="Submit" CLASS="BUTTON" onClick="javascript:submitForm(customRpt)"></td>
					
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
