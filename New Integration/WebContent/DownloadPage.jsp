<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ include file="connection.jsp" %>
<%
response.setContentType("application/csv");
response.setHeader("Content-Disposition", "attachment; filename=customreport.csv");
%>
<%
if(session.getAttribute("userid")!=null )
{
%>

<%!
	String format(Date visited) {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
    FieldPosition pos = new FieldPosition(0);
    StringBuffer empty = new StringBuffer();
    StringBuffer date = sdf.format(visited, empty, pos);
    return date.toString();
	}
%>

<%
	String from=request.getParameter("fromdate");
	String to=request.getParameter("todate");
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd");
	
	java.util.Date fromdate = new java.util.Date(from);
	java.util.Date todate = new java.util.Date(to);

	String date1 = df.format(fromdate);
	String date2 = df1.format(todate);

	System.out.println(date1+"        "+date2);
	
	String locations[]=request.getParameterValues("locations");
	StringBuffer cityID = new StringBuffer("(");;
	for(int loopCount=0; loopCount < locations.length; loopCount++){
		cityID.append(locations[loopCount] + ",");
	}
	cityID.deleteCharAt(cityID.length() - 1);
	cityID.append(")");


try
 {
  Connection C = getConnection();
  Statement stmt = C.createStatement(1000,1007);
		
	stmt.setFetchSize(100);

	Method enableStreamingResultsMethodStmt = Class.forName(
				"com.mysql.jdbc.jdbc2.optional.StatementWrapper").getMethod(
				"enableStreamingResults", new Class[0]);
	enableStreamingResultsMethodStmt.invoke(stmt, new Object[0]);
  String sql = "select serviceid,reporting.agentid,time,name,dnstime connecttime,ttfb,downloadtime,responsetime,status,responsecode from reporting,agents,cities where date_format(time, '%Y-%m-%d') >=\'" + date1 + "\' and date_format(time, '%Y-%m-%d') <=\'" + date2 + "\' and  reporting.agentid=agents.agentid and agents.cityid=cities.cityid and cities.cityid in " + cityID;
  
  ResultSet rs=stmt.executeQuery(sql);
 
  while(rs.next())
  {
out.println(rs.getString(1)+","+rs.getString(2)+","+rs.getString(3)+","+rs.getString(4)+","+rs.getString(5)+","+rs.getString(6)+","+rs.getString(7)+","+rs.getString(8)+","+rs.getString(9)+","+rs.getString(10));
  }
    } 
    catch (Exception E)
 {
  out.println("SQLException: " + E.getMessage());
    }
	
 
%>
<%
	}else	{
				%>
				<jsp:forward page="index.jsp" />
				<%
	}

%>