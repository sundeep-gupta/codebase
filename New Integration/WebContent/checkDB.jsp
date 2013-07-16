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
		Connection C = DriverManager.getConnection("jdbc:mysql://localhost:3306/birt","root","password");
		out.println("Connected to Mysql Database ");
		File f = new File("C:\\Program Files\\Apache Software Foundation\\Tomcat 5.5\\webapps\\Birt\\checkdata.csv");
		FileInputStream fis = new FileInputStream(f); 
		BufferedInputStream bis = new BufferedInputStream(fis); 
		DataInputStream dis = new DataInputStream(bis);
		String record=null;
		String str = null;
		while((record=dis.readLine()) != null)
		{
			str = record;
			StringTokenizer st = new StringTokenizer (str,",");
			while (st.hasMoreTokens ()) 
				{
					Statement stmt=C.createStatement();
					stmt.executeUpdate("insert into student values("+st.nextToken()+",'"+st.nextToken()+"',"+st.nextToken()+")");
					stmt.executeUpdate("insert into marks values("+st.nextToken()+",'"+st.nextToken()+"',"+st.nextToken()+")");
					
					out.println("<br>Record Inserted<br>");
				}
        }  
    
  } 
	
    catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
 
%>