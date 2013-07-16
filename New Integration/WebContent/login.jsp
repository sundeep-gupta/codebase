<!-- login.jsp -->
<%@ include file="escapechars.jsp" %>
<%@ include file="connection.jsp" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<script>

/*function unEncrypt(theText) {
output = new String;
Temp = new Array();
Temp2 = new Array();
TextSize = theText.length;
for (i = 0; i < TextSize; i++) {
Temp[i] = theText.charCodeAt(i);
Temp2[i] = theText.charCodeAt(i + 1);
}
for (i = 0; i < TextSize; i = i+2) {
output += String.fromCharCode(Temp[i] - Temp2[i]);
}
return output;
}*/
</script>
</head>
<body>


<%
    if(request.getParameter("txtUserID")!=null && request.getParameter("txtPassword")!=null)
	  {
 			//out.println(request.getParameter("txtUserID")+"gjg");
			try
	{
		//Class.forName("com.mysql.jdbc.Driver").newInstance();

		Connection C = getConnection();
		//DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");
		//out.println("Connected to Mysql Database ");
		
		//String str = "";
		/*if(request.getParameter("txtUserID")!="admin")
			str = "javascript:unEncrypt("+request.getParameter("txtPassword")+")";
        

		out.println(str);*/

		String SQL1="select usertype from users where userid='"+request.getParameter("txtUserID")+"'";
		out.println(SQL1);
		Statement stmt = C.createStatement();
		ResultSet r = stmt.executeQuery(SQL1);
		//r.next();
		
		//int i=r.getInt(1);
		
		boolean c=r.next();
		//out.println(c);

		if(c==false)
		{
			%><jsp:forward page="errorPage.jsp" /><%
		}

		//out.println(r.getInt(1));
		String SQL="";
		if(r.getInt(1)==0)
		{
		 SQL = "select USERID,USERNAME,PASSWORD,CUSTID from users where USERID='"+request.getParameter("txtUserID")+"' and PASSWORD='"+request.getParameter("txtPassword")+"'";
		}
		else
		{
		if(r.getInt(1)==1){
		 String pwd=request.getParameter("txtPassword");
		 out.println(pwd);
		 SQL = "select USERID,USERNAME,PASSWORD,users.CUSTID,custname from users,customers where  USERID='"+request.getParameter("txtUserID")+"' and PASSWORD=PASSWORD('"+pwd+"') and users.custid=customers.custid";
		 out.println(SQL);
		}
		 
		}
	
		out.println(SQL);

		
		
		ResultSet rs = stmt.executeQuery(SQL);

		boolean b = rs.next();
		//out.println(b);
		if(b)
		{
			String userid = rs.getString(1);
			String username = rs.getString(2);
			String pwd = rs.getString(3);
			int custid = rs.getInt(4);
			String custname=rs.getString(5);
			session.setAttribute("userid",userid);
			//session.setAttribute("username",username);
			//session.setAttribute("pwd",pwd);
			session.setAttribute("custid",new Integer(custid));
			session.setAttribute("custname",custname);
			session.setAttribute("userName",username);
			System.out.println("Customer Name:"+custname);
			if(custid==0)
			{
%>			<jsp:forward page="adminPage.jsp" />
<% 			}
            else
			{
%>			<jsp:forward page="userSuccess.jsp" />
<% 
			}
		}
		else
			{
%>			<jsp:forward page="errorPage.jsp" />
<% 
			}
		

		//out.println("Count : "+rs.getInt(1));
  } 
	
    catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
	  }
	  else
	  {
		  %><jsp:forward page="errorPage.jsp" /> <%
	  }
 
%>
</body>
</html>
