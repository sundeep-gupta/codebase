<!--
  Authore : Performance Monitoring Services

  
  Copyright (c) 1999 The Apache Software Foundation.  All rights 
  reserved.
  
  Description: Getting the Maximum no of rows and displaying 10 request for each request
-->

<%! int localcounter=0;       //localcounter for getting first record
	int countofRows=0;        // Total No.of records
	int lastRowNumber = 0;    // Find out the last row number

%>
<%
String cnt = request.getParameter("counter");
	PaginationConnection pagination = new PaginationConnection();
	
	if(cnt != null)
	{
		localcounter = Integer.parseInt(cnt);
	}
	else
	{
		
			localcounter=1;	
			
			int countofRows = pagination.getCount();
			
			lastRowNumber = countofRows/10;

			if( lastRowNumber*10 < countofRows)
			{
				lastRowNumber = lastRowNumber + 1;
				
			}

	}
	
%>
<script>
function submitData(next,localcounter)
{
	
	
	
	if(next == 'next')
	{
	
		localcounter=localcounter+1;
		
		
	}
	else if(next == 'previous')
	{
		localcounter = localcounter-1;
	
	}
	else if(next == 'last')
	{
		localcounter = localcounter;
	
	}
	if(next == 'first')
	{
		localcounter = 1;
	
	}
	mainform.counter.value = localcounter;

	document.mainform.submit();
}

</script>




<a href="javascript:submitData('first',<%=localcounter%>)">first</a> 





<%
	
	if(localcounter != lastRowNumber)
	{
%>
<a href="javascript:submitData('next',<%=localcounter%>)">next</a>
<%
	}
	if(localcounter != 1)
	{
%>	

<a href="javascript:submitData('previous',<%=localcounter%>)">previous</a> 

<%
	}	
%>
<a href="javascript:submitData('last',<%=lastRowNumber%>)">last</a>
<%@ page import="java.util.*,myprojects.pagination.*" %>
<form action="ListData.jsp" name="mainform" method="post">
<input type="hidden" name="counter"/>

<table>
<%
	
	ArrayList dataList = pagination.getData(localcounter);
	
	for(int i=0;i<dataList.size();i++)
	{
	
	 AppMeterBean bean=(AppMeterBean)dataList.get(i); 


%>

<tr><td><%=bean.getServiceId() %></td>
<td><%=bean.getReportingId() %></td></tr>
<%
	}
		
%>

</table>	 	
	
</form>

<a href="javascript:submitData('first',<%=localcounter%>)">first</a> 
<%
	if(localcounter != lastRowNumber)
	{
%>
<a href="javascript:submitData('next',<%=localcounter%>)">next</a>
<%
	}
	if(localcounter != 1)
	{
%>	

<a href="javascript:submitData('previous',<%=localcounter%>)">previous</a> 

<%
	}	
%>
<a href="javascript:submitData('last',<%=lastRowNumber%>)">last</a> 
