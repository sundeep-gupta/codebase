<%!
Connection getConnection()
{
	Connection con = null;

	try{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection("jdbc:mysql://localhost/sysadmin","root","password");
	}catch(Exception e){
		e.printStackTrace();
	}
	return con;
	
}

%>