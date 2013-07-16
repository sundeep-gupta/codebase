import java.sql.*;
import java.lang.reflect.Method;
import com.mysql.jdbc.jdbc2.optional.MysqlConnectionPoolDataSource;
import javax.sql.PooledConnection;


class  FirstJDBCProg{
	public static void main(String[] args)  throws Exception {
		
		Class.forName("com.mysql.jdbc.Driver"). newInstance();

/*
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/roughdb?defaultFetchSize=10","root","password");
		Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
*/


		MysqlConnectionPoolDataSource ds = new MysqlConnectionPoolDataSource();
		ds.setURL("jdbc:mysql://172.16.6.54/appmeter");
		ds.setUser("root");
		ds.setPassword("password");
		PooledConnection pooledConn = ds.getPooledConnection();
		Connection physConn = pooledConn.getConnection();
		Statement physStatement = physConn.createStatement();


		physStatement.setFetchSize(100);

		Method enableStreamingResultsMethodStmt = Class.forName(
				"com.mysql.jdbc.jdbc2.optional.StatementWrapper").getMethod(
				"enableStreamingResults", new Class[0]);
		enableStreamingResultsMethodStmt.invoke(physStatement, new Object[0]);


		ResultSet rs = physStatement.executeQuery("select * from reporting");
		rs.next();

		System.out.println(rs.getString(2));


	}
}
