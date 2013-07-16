package com.ironmountain.pageobject.pageobjectrunner.utils.jdbc;

import java.sql.Connection;
import javax.sql.DataSource;

import org.apache.commons.dbcp.ConnectionFactory;
import org.apache.commons.dbcp.DriverManagerConnectionFactory;
import org.apache.commons.dbcp.PoolableConnectionFactory;
import org.apache.commons.dbcp.PoolingDataSource;
import org.apache.commons.pool.ObjectPool;
import org.apache.commons.pool.impl.GenericObjectPool;
import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;


/**
 * @author Jinesh  Devasia
 * 
 * This class is used to establish a connection to the database and returns the connection object.
 * Since we may need to connect to different types databases from different machines we need to provide the DatabaseServer to
 * establish a particular database Connection
 * To close the connection object is the callers responsibility.
 *
 */
public class ConnectionManager{

	private static Logger  logger      = Logger.getLogger("com.imd.connected.webuitest.utils.jdbc.ConnectionManager");
	
	private static final String MSSQL_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver"; 	
	
	private DataSource dataSource ;
	private String dataBaseType ;
	private String dbDriver;
	private String dbServerUrl;
	private String dbPort;
	private String dbUsername;
	private String dbPassword;	
	private String databaseName;	
	private String connectionUrl;
	private Connection con;	
	
	private static ConnectionManager conMgr;
	
	/**
	 * Creating a ConnectionManager with no connection properties
	 */
	public ConnectionManager(){		
	}
	/**
	 * Creating a ConnectionManager with specific Server type and specific database name
	 * 
	 * @param dbServer
	 * @param database
	 */
	public ConnectionManager(DatabaseServer dbServer, String database){		
		loadConnectionProperties(dbServer, database);
	}
	/**
	 * Create a ConnectionManager class with the connection properties
	 * 
	 * @param serverType
	 * @param driver
	 * @param serverUrl
	 * @param port
	 * @param username
	 * @param password
	 * @param databaseName
	 */
	public ConnectionManager(String serverType, String driver, String serverUrl, String port, String username, String password, String databaseName){
		setConnectionProperties(driver, serverUrl, port, serverType, username, password, databaseName);
	}
	/**
	 * Create a ConnectionManager with common driver and server type
	 * 
	 * @param serverUrl
	 * @param port
	 * @param username
	 * @param password
	 */
	public ConnectionManager(String serverUrl, String port, String database, String username, String password){
		String serverType = PropertyPool.getProperty("DBServerType");
		String driver = PropertyPool.getProperty("DBDriver");
		setConnectionProperties(driver, serverUrl, port, serverType, username, password, database);
	}
	/**
	 * Create a ConnectionManager with common driver ,server type and listens to a common port
	 * 
	 * @param serverUrl
	 * @param username
	 * @param password
	 */
	public ConnectionManager(String serverUrl, String database, String username, String password){
		String serverType = PropertyPool.getProperty("DBServerType");
		String driver = PropertyPool.getProperty("DBDriver");
		String port = PropertyPool.getProperty("DBPort");
		setConnectionProperties(driver, serverUrl, port, serverType, username, password, database);
	}
	/**
	 * Get the Database Driver used for this connection.
	 * 
	 * @return
	 */
	public String getDbDriver() {
		return dbDriver;
	}

	/**
	 * Set the Database Driver for the connection
	 * 
	 * @param dbDriver
	 */
	public void setDbDriver(String dbDriver) {
		this.dbDriver = dbDriver;
	}
	/**
	 * Set the database server Type. (Database Server  is used to define the commercially available database management system server names)
	 * The names must be from the list {MSSQL, Oracle, SQLLite, MySQL}
	 * */
	public void setDataBaseType(String dataBaseType) {
		this.dataBaseType = dataBaseType;
	}

	public String getDataBaseType() {
		return dataBaseType;
	}
	/**
	 * Get the database server url, This is primary connection url without the port and database names
	 * 
	 * @return
	 */
	public String getDbServerUrl() {
		return dbServerUrl;
	}

	/**
	 * Set the database server url for this connection
	 * @param connectionUrl
	 */
	public void setDbServerUrl(String dbServerUrl) {
		this.dbServerUrl = dbServerUrl;
	}
	/**
	 * Set the Database Port for the connection
	 * 
	 * @param dbPort
	 */
	public void setDbPort(String dbPort) {
		this.dbPort = dbPort;
	}

	/**
	 * Get the Database Port used for the connection
	 * 
	 * @return
	 */
	public String getDbPort() {
		return dbPort;
	} 

	/**
	 * Get the Database user	 
	 * * 
	 * @return
	 */
	public String getDbUsername() {
		return dbUsername;
	}

	/**
	 * Set the database user
	 * 
	 * @param dbUsername
	 */
	public void setDbUsername(String dbUsername) {
		this.dbUsername = dbUsername;
	}

	/**
	 * Get the password for the user
	 * 
	 * @return
	 */
	public String getDbPassword() {
		return dbPassword;
	}

	/**
	 * Set the password for database user
	 * 
	 * @param dbPassword
	 */
	public void setDbPassword(String dbPassword) {
		this.dbPassword = dbPassword;
	}
	public void setDatabaseName(String databaseName) {
		this.databaseName = databaseName;
	
	}
	public String getDatabaseName() {
		return databaseName;
	}
	/**
	 * return the datasource for the ConnectionManager.
	 * 
	 * @return
	 */
	public DataSource getDataSource(){
		return this.dataSource;
	}	
	public void setDataSource(DataSource ds){
		this.dataSource = ds;
	}	
	/**
	 * Set the datasource for the connection. This will set the created datasource to ConnectionManager's datasource
	 * 
	 * @param dataSource
	 */
	public void createDataSource() {
		try {
			GenericObjectPool.Config config = new GenericObjectPool.Config();
			config.maxActive = 10;
			config.maxIdle = 10;
			config.minIdle = 30;
			config.maxWait = 1000;
			ObjectPool connectionPool = new GenericObjectPool(null, config); 
			ConnectionFactory connectionFactory = new DriverManagerConnectionFactory(this.connectionUrl,this.dbUsername, this.dbPassword); 		
			new PoolableConnectionFactory(connectionFactory,connectionPool,null,null,false,true); 
			this.dataSource = new PoolingDataSource(connectionPool); 
		} catch (Exception e) {
			logger.error("Error while settign up the Data Source: "+ e.getMessage(), e);
		}
	}
		
	private final void setConnectionProperties(String driver, String serverUrl, String port, String serverType, String username, String password, String databaseName){

		this.dataBaseType = serverType;
		logger.debug("Databse Server Type is: " + dataBaseType);
		this.dbDriver = driver;
		logger.debug("JDBC Driver is: " + dbDriver);
		this.dbServerUrl = serverUrl;
		logger.debug("Database Server Url is: " + dbServerUrl);
		this.dbPort = port;
		logger.debug("Databse Server Port is: " + this.dbPort);
		this.databaseName = databaseName;
		logger.debug("DatabseName to be connected is: " + this.databaseName);
		connectionUrl = generateConnectionUrl();
		logger.debug("JDBC Connection Url is: " + connectionUrl);
		dbUsername = username;
		logger.debug("Database Username Loaded: " + dbUsername);
		dbPassword = password;
		logger.debug("Database Password Loaded: " + dbPassword);
		if(StringUtils.isNullOrEmpty(dbDriver)||StringUtils.isNullOrEmpty(dbServerUrl)|| StringUtils.isNullOrEmpty(dbPort)||StringUtils.isNullOrEmpty(connectionUrl) || 
				StringUtils.isNullOrEmpty(dataBaseType)||StringUtils.isNullOrEmpty(dbUsername) || StringUtils.isNullOrEmpty(dbPassword)){
			throw new TestException("JDBC connection property is null..Please check your DatabaseServer and it has right properties..");
		}
	}
	/**
	 * Set the connection Properties based on the Connection Type.
	 * 
	 * @param dbServer
	 * @param databaseName
	 */
	private final void loadConnectionProperties(DatabaseServer dbServer, String databaseName){
		this.dataBaseType = dbServer.getServerType();
		logger.debug("Databse Server Type is: " + dataBaseType);
		this.dbDriver = dbServer.getDbDriver();
		logger.debug("JDBC Driver is: " + dbDriver);
		this.dbServerUrl = dbServer.getDbServerUrl();
		logger.debug("Database Server Url is: " + dbServerUrl);
		this.dbPort = dbServer.getPort();
		logger.debug("Databse Server Port is: " + this.dbPort);
		this.databaseName = databaseName;
		logger.debug("DatabaseName to be connected is: " + this.databaseName);
		connectionUrl = generateConnectionUrl();
		logger.debug("JDBC Connection Url is: " + connectionUrl);
		dbUsername = dbServer.getUserName();
		logger.debug("Database Username Loaded: " + dbUsername);
		dbPassword = dbServer.getPassword();
		logger.debug("Database Password Loaded: " + dbPassword);
		if(StringUtils.isNullOrEmpty(dbDriver)||StringUtils.isNullOrEmpty(dbServerUrl)|| StringUtils.isNullOrEmpty(dbPort)||StringUtils.isNullOrEmpty(connectionUrl) || 
				StringUtils.isNullOrEmpty(dataBaseType)||StringUtils.isNullOrEmpty(dbUsername) || StringUtils.isNullOrEmpty(dbPassword)){
			throw new TestException("JDBC connection property is null..Please check your DatabaseServer and it has right properties..");
		}
	}
	public final String generateConnectionUrl(){
		String url = dbServerUrl + ":" + dbPort ;
		if(!StringUtils.isNullOrEmpty(this.databaseName)){
			if(dataBaseType.equalsIgnoreCase("MSSQL")){			
			    return url +";databaseName="+databaseName+";selectMethod=cursor;";
			}			
			else{
				return url +"/"+databaseName ; 
		    }
		}		
		return url;
    }
	
	
	/**
	 * Load the driver based on the connection type.
	 * 
	 * @param conType
	 */
	private final void loadDriver(){
		if(StringUtils.isNullOrEmpty(this.dbDriver)){
		    this.dbDriver = MSSQL_DRIVER ;
		}		
		try {
			logger.debug("Trying to load a JDBC Driver..");
			logger.debug("The JDBC Driver in use is: " + this.dbDriver);
			Class.forName(this.dbDriver);
		}
		catch (Exception e) {
			logger.error("Error while loading the JDBC driver: "+ e.getMessage(), e);
		}		
	}
	/**
	 * Get the connection object from the ConnectionManager
	 * Make sure that the properties are set using the connection manager constructor
	 * @return
	 */
	public synchronized Connection  getConnection() {
		loadDriver();
	    createDataSource();
		try {
			con = this.dataSource.getConnection();
			logger.debug("Database connection is established with connection: " + con);			
		} catch (Exception e) {
			logger.error("Error while establishing the connection: " + e.getMessage(), e);
		}
		return con ;	
	}

	/**
	 * The factory method to create a connection object using the underlying data source,
	 * The data source will be created based on the Connection Type.
	 * 
	 * @param conType
	 * @return
	 */
	public static synchronized Connection  getConnection(DatabaseServer dbServer, String database) {
    	Connection dbConnection = null;
    	if(conMgr == null){
    		conMgr = new ConnectionManager();
    	}  
    	conMgr.loadConnectionProperties(dbServer, database);
    	conMgr.loadDriver();
    	conMgr.createDataSource();
		try {
			dbConnection = conMgr.getDataSource().getConnection();
			logger.debug("Database connection is established with connection: " + dbConnection);
		
		} catch (Exception e) {
			logger.error("Error while establishing the connection: " + e.getMessage(), e);
		}
		return dbConnection ;	
	}

	/**
	 * Closing a connection
	 * @param con
	 */
	public static void closeConnection(Connection con){
		if(con != null){
			try {
				con.close();
			} catch (Exception e) {
				logger.error("Error while closing a connection: " + con, e);
			}
		}
	}
	/**
	 * Closing the Connection Object of ConnectionManager
	 * @param con
	 */
	public void closeConnection(){
		if(con != null){
			try {
				logger.debug("Closing the database connection...!");
				con.close();
			} catch (Exception e) {
				logger.error("Error while closing a connection: " + con, e);
			}
		}
	}
	

}
