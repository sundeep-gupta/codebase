<title> Status </title>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ include file="connection.jsp" %>
<%
			String id=(String)request.getParameter("reportingid");
			int reportingid=Integer.parseInt((String)id);
try{
	Connection C = getConnection();
	Statement stmt = C.createStatement();
	String sql ="select content from reporting where reportingid="+reportingid;  
	ResultSet rs=stmt.executeQuery(sql);
	rs.next();
	if(rs.getString(1) != null){
%>
		<center>
		<%=rs.getString(1)%>
		</center>
<%
	}else{
%>
		<center>
		<br /> <br /> <br />
		<FONT SIZE="5">No error content to display</FONT>
		</center>
<%	}
	C.close();
}catch (Exception E){
	out.println("SQLException: " + E.getMessage());
}
	
%>
