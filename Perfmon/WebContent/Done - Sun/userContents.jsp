<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%!
	Object  sid,cid,uid;
	int serviceId,custId;
	String userId,custname;
%>
<%
if(session.getAttribute("userid")!=null)
{
%>
	<%
		try{
				sid=session.getAttribute("serviceid");
				uid=session.getAttribute("userid");
				serviceId=Integer.parseInt((String)sid);
				userId=(String)uid;	
				System.out.println("ServiceID="+" "+serviceId+"User ID="+userId);
			}
			catch(Exception e){
					System.out.println("Exception"+e);
			}
%>
<HTML>
	<HEAD>
		<TITLE></TITLE>
<script>

	history.forward(-1);
/*
		Function for setting the title of User Contents Page
*/
	function setTitle(titleString){
		parent.document.title = titleString;
	}

</script>
	</HEAD>
<link href="css/CFP_per_new.css" rel="stylesheet" type="text/css">
<body leftmargin="0" topmargin="00" marginwidth="0" marginheight="0">
	<form name="thisForm" bgcolor="#DAE7F2">

<table border="0" cellpadding="0" cellspacing="0" width="95%" bgcolor="#DAE7F2">
 <tr> 
    <td width="15%" align="center" valign="top" bgcolor="#DAE7F2"><br> 
	<table width="85%" border="0" cellpadding="2" cellspacing="0">
        <tr> 
          <td height="23" valign="middle" class="linkstext"><span class="sublinkstext"><strong>DAILY</strong></span></td>
        </tr>
        <tr>
      <td valign="middle" class="linkstext">
	<p>
		<a href="<%=request.getContextPath() + "/run?__report=DailySummaryReport.rptdesign&uidParam="%><%=userId%>&sidParam=<%=serviceId%>" onClick="javascript:setTitle('Daily Summary Report')" target="frame3">&nbsp;&nbsp;Summary
		 <!--<a href="javascript:goDailySummary()" target="frame3">&nbsp;&nbsp;Summary
		</a>-->
		<br><br> 
		<a href="DailyDetailedFirstFrame.jsp" target="frame3">&nbsp;&nbsp;Detailed</a>
		</p></td>
	</tr>
        <tr> 
          <td height="23" valign="middle" class="linkstext"><strong>WEEKLY </strong></td>
        </tr>
        <tr> 
          <td valign="middle" class="linkstext"> <p> <a href="<%= request.getContextPath( ) + "/run?__report=WeeklySummaryReport.rptdesign&uidParam="%><%=userId%>&sidParam=<%=serviceId%>" target="frame3" onClick="javascript:setTitle('Weekly Summary Report')">&nbsp;&nbsp;Summary</a><br><br>
			<a href="WeeklyDetailedFirstFrame.jsp" target="frame3">&nbsp;&nbsp;Detailed</a>
		</p></td>
        </tr>
        <tr> 
          <td height="23" valign="middle" class="linkstext"><strong>MONTHLY </strong></td>
        </tr>
        <tr> 
          <td valign="middle" class="linkstext"> <p>   <a href="<%= request.getContextPath( ) + "/run?__report=MonthlySummaryReport.rptdesign&uidParam="%><%=userId%>&sidParam=<%=serviceId%>" target="frame3" onClick="javascript:setTitle('Monthly Summary Report')">&nbsp;&nbsp;Summary</a><br><br>
					<a href="MonthlyDetailedFirstFrame.jsp" target="frame3">&nbsp;&nbsp;Detailed</a>
            </p></td>
        </tr>
		<tr> 
          <td height="23" valign="middle" class="linkstext"><strong>OTHERS </strong></td>
        </tr>
		<tr> 
          <td height="22" valign="middle" class="linkstext"><a href="CustomReport.jsp" target="frame3">&nbsp;&nbsp;Custom  </a><br><br><a href="Download.jsp" target="frame3"> &nbsp;&nbsp;Download </a>
            </p></td>
        </tr>
        <tr> 
          <td height="22" valign="middle" class="linkstext"><a href="userSuccess.jsp" target="_top"><strong>Home</strong></a></td>
        </tr>
		 <tr>
			<td height="22" valign="middle" class="linkstext" >
				<a href="changePassword.jsp" target="frame3">Change Password</a>
			</td>
		</tr>
		 <tr>
			<td height="22" valign="middle" class="linkstext" >
				<a href="ContextHelp.html"  target="newWindow">Help</a>
			</td>
		</tr>
		<tr>
			<td height="22" valign="middle" class="linkstext">
				<a href="logout.jsp" target="_top"><b>Log Out</a>
			</td>
		</tr>

	 <tr> 
         <td height="22" valign="middle" >&nbsp;</td>
     </tr>
	<tr> 
         <td height="22" valign="middle" >&nbsp;</td>
     </tr>
	<tr> 
         <td height="22" valign="middle" >&nbsp;</td>
    </tr>
	 <tr> 
         <td height="22" valign="middle" >&nbsp;</td>
     </tr>
	<tr> 
         <td height="22" valign="middle" >&nbsp;</td>
     </tr>
	<tr> 
         <td height="22" valign="middle" >&nbsp;</td>
    </tr>
	
 </table>
		 </td> </tr> </table>
	 </form>
</body>
</html>
<%
}else
	{
		%>
			<jsp:forward page="index.jsp" />
		<%
	}
%>