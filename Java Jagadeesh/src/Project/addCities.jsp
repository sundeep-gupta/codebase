<link href="birt.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%

   try
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	}
	catch (Exception E)
	{
		E.printStackTrace();
	}
	try
	{
		Connection C = DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");

		Statement stmt = C.createStatement();

        //out.println(session.getAttribute("custid"));
		int cityid=request.getParameter("txtCityID");
		String name = request.getParameter("txtName");
		String description = request.getParameter("txtDescription");
		//int custid=Integer.parseInt(request.getParameter("txtCustID"));

		String SQL = "insert into agents values('"+cityid+"','"+name+"','"description"')";
		 

		int i=stmt.executeUpdate(SQL);
  
		if(i==1) {
%>
			<center><font color=blue face=verdana size=3><b> City Added Successfully </b></font><br><b> <br> <br> <br> <br>
	            
	         <table>

			 <tr><td class=text> CityID   : </td><td><%=cityid%></td></tr>
			 <tr><td class=text> Name : </td><td><%=name%></td></tr>
			 <tr><td class=text> Description : </td><td><%=description%></td></tr>
			 
			
			 </table>


			 <br><br><a href="javascript:history.back()" class=text> Back </a> to AddCity
			 
			 </center> 
              
			 
<%    
        }
	   else {
%>
		<font color=blue face=verdana size=9><b>Failed in Adding City </b></font>
<% 
		}
    } 
	
    catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }


else {
%>
		<jsp:forward page="index.jsp" />
<%
}

%>