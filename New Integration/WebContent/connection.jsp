<%@ page import="java.io.*" %>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>

<%!
Connection getConnection() throws Exception
{
	Connection con = null;

InitialContext initCtx = new InitialContext();
Context envCtx = (Context) initCtx.lookup("java:comp/env");
System.out.println("Before ds loopup");
	DataSource ds = (DataSource) envCtx.lookup("jdbc/PerfMon");
System.out.println("After ds loopup");

/*

	Context ctxt = new InitialContext();
	if(ctxt == null){
		throw new Exception("No Context");
	}

	DataSource ds = (DataSource)ctxt.lookup("PerfMon");
*/

	if(ds != null){
		con = ds.getConnection();
	}
	return con;

	/*Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://172.16.6.54:3306/appmeter","root","password");
	return con;
	*/
}
int getMaxAgent() throws Exception 
{
	Connection C = getConnection();
	CallableStatement proc = C.prepareCall(" { call simple1(?) } ");
	proc.registerOutParameter(1,Types.INTEGER);
	proc.execute();
	int max = proc.getInt(1);
    return max;
}

int addCustomer(String description,String email,String custname) throws Exception 
{
	Connection C = getConnection();
	CallableStatement proc = C.prepareCall(" { call addCustomer(?,?,?) } ");
	proc.setString(1,description);
	proc.setString(2,email);
	proc.setString(3,custname);
	int i = proc.executeUpdate();
	return i;
}

/*int deleteCustomer(int custid) throws Exception 
{
	//out.println("inside function CUST :");
	//out.print(custid);

	Connection C = getConnection();
	CallableStatement proc = C.prepareCall(" { call deleteCustomer(?) } ");
	proc.setInt(1,custid);
	int i = proc.executeUpdate();
	return i;
}

int addAgent(String ip,String hostname,int cityid) throws Exception 
{
	Connection C = getConnection();
	CallableStatement proc = C.prepareCall(" { call addAgent(?,?,?) } ");
	proc.setString(1,ip);
	proc.setString(2,hostname);
	proc.setString(3,cityid);
	int i = proc.executeUpdate();
	return i;
}*/

int deleteAgent(int agentid) throws Exception 
{
	Connection C = getConnection();
	CallableStatement proc = C.prepareCall(" { call deleteAgent(?) } ");
	proc.setInt(1,agentid);
	int i = proc.executeUpdate();
	return i;
}

int addCities(String ip,String hostname) throws Exception 
{
	Connection C = getConnection();
	CallableStatement proc = C.prepareCall(" { call addCities(?,?) } ");
	proc.setString(1,ip);
	proc.setString(2,hostname);
	int i = proc.executeUpdate();
	return i;
}

int deleteCities(int cityid) throws Exception 
{
	Connection C = getConnection();
	CallableStatement proc = C.prepareCall(" { call deleteCities(?) } ");
	proc.setInt(1,cityid);
	int i = proc.executeUpdate();
	return i;
}

int updateAgent(String agentid,String hostname) throws Exception 
{
	Connection C = getConnection();
	CallableStatement proc = C.prepareCall(" { call updateAgent(?,?) } ");
	proc.setString(1,agentid);
	proc.setString(2,hostname);

	int i = proc.executeUpdate();
	return i;
}

int updateCity(int cid,String name, String description) throws Exception 
{
	Connection C = getConnection();
	CallableStatement proc = C.prepareCall(" { call updateCity(?,?,?) } ");
	proc.setInt(1,cid);
	proc.setString(2,name);
	proc.setString(3,description);

	int i = proc.executeUpdate();
	return i;
}

int updateCustomer(int custid,String custname,String description, String email) throws Exception 
{
	Connection C = getConnection();
	CallableStatement proc = C.prepareCall(" { call updateCustomer(?,?,?,?) } ");
	proc.setInt(1,custid);
	proc.setString(2,custname);
	proc.setString(3,description);
	proc.setString(4,email);
	int i = proc.executeUpdate();
	return i;
}


%>

