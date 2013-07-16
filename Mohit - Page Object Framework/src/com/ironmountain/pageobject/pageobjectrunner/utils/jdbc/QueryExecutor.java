package com.ironmountain.pageobject.pageobjectrunner.utils.jdbc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;

/**This class is used to build an SQL statement and execute the resulting SQL statement.
 * @author pjames
 * @author Jinesh Devasia (refractor the code to accommodate new changes)
 * @return ResultSet Object
 */
public class QueryExecutor {
	
	
	private static Logger  logger = Logger.getLogger("com.imd.connected.webuitest.utils.jdbc.QueryExecutor");
	
	private ConnectionManager conMgr = null;
	private Connection con = null;
	private Statement stmt = null;
	private ResultSet rs = null;

	public void setConnectionManager(ConnectionManager conMgr){
		this.conMgr = conMgr;		
	}
	public ConnectionManager getConnectionManager(){
		return conMgr;		
	}
	public void setConnection(Connection con){
		this.con = con;		
	}
	public Connection getConnection(){
		return con;		
	}	
	public void createStatement(){
		try {
			this.stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		} catch (SQLException e) {
			logger.error("Error while creating the Statement Object for QueryExecutor..");
			e.printStackTrace();
		}
	}
	/**
	 * Get the queryExecutors statement object.
	 * 
	 * @return
	 */
	public Statement getStatement()	{
		return this.stmt;
	}
	public ResultSet getResultSet() {
		return rs;
	}
	/**
	 * Create a QueryExecutor with DatabseServer
	 * 
	 * @param dbServer
	 * @param database
	 */
	public QueryExecutor(DatabaseServer dbServer, String database){
		this.conMgr = new ConnectionManager(dbServer, database);
		this.con = conMgr.getConnection();
		logger.info("Connection object is " + con);
		try {
			con.setAutoCommit(true);
		} catch (SQLException e) {
			logger.error("Error occured while setting auto commit" , e);
		}
		try {
			this.stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		}
		catch (Exception e) {
			logger.error("Error while creating the Statement Object for QueryExecutor..");
		}
	}
	/**
	 * Create a QueryExecutor using a ConnectionManager.
	 * 
	 * @param conMgr
	 * @param database
	 */
	public QueryExecutor(ConnectionManager conMgr, String database){
		this.conMgr = conMgr;
		this.con = conMgr.getConnection();
		try {
			con.setAutoCommit(true);
		} catch (SQLException e) {
			logger.error("Error occured while setting auto commit" , e);
		}
		try {
			this.stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		}
		catch (Exception e) {
			logger.error("Error while creating the Statement Object for QueryExecutor..");
		}
	}
	
	/**
	 * @author Jinesh Devasia
	 * Method to execute a query 
	 * 
	 * @param dbServer
	 * @param query
	 * @return
	 */
	public ResultSet executeQuery(String query){
		try {
			rs = stmt.executeQuery(query);	
		}catch(SQLException e1) {
			logger.error("Error occured while executing the query: " + e1.getMessage(), e1);
			if ( con != null) {
				try {
					logger.debug("Transaction is being rolled back");
					con.rollback();
				} catch(SQLException e2) {
					logger.error("Error occured while rolling back the transaction" + e2.getMessage());
				}
			}
		}
		if(rs != null){
			return rs;
		}
		else{
			throw new TestException("No Resultset Found after query execution!!!");
		}		
	}

    /**
     * @author Jinesh Devasia
     * Executing a sql statement where no resultSet is returned
     * 
     * @param dbServer
     * @param query
     */
    public int executeUpdate(String updateQuery){
		try {
			return stmt.executeUpdate(updateQuery);	
		}catch(SQLException e1) {
		    logger.error("Error occured while executing the query: " + e1.getMessage(), e1);
		    if ( con != null) {
			    try {
				    logger.debug("Transaction is being rolled back");
				    con.rollback();
			    } catch(SQLException e2) {
				    logger.error("Error occured while rolling back the transaction" + e2.getMessage());
		        }
		    }	 
		}
		return 0;
	}
	public void closeStatement(){
		try {
			logger.debug("Closing the Statement...");
			stmt.close();
		} catch (Exception e) {
			logger.error("Error while closing the statement: " + e.getMessage(), e);
		}
	}
	
	
	
	
	
}

