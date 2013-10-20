package com.ironmountain.pageobject.pageobjectrunner.connected.database;


import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;

public class DataBase {

	private static Logger  logger      = Logger.getLogger("Database.class");
	

	public  String DATABASE_NAME = "";
	protected DatabaseServer databaseServer = null;
	protected QueryExecutor queryExecutor = null;
	protected ConnectionManager conManager = null;
	
	public void setDatabaseServer(DatabaseServer dbServer) {
		this.databaseServer = dbServer;
	}
	public DatabaseServer getDatabaseServer() {
		return databaseServer;
	}	
	public void setDatabaseName(String databaseName) {
		DATABASE_NAME = databaseName;
	}
	public String getDatabaseName() {
		return DATABASE_NAME;
	}
	
	public QueryExecutor getQueryExecutor(){
		if(queryExecutor == null){
			logger.error("QueryExecutor is not initialized!!!..");
			throw new TestException("QueryExecutor is not initialized!!!..");
		}
		return queryExecutor;
	}
	public ConnectionManager getConnectionManager(){
		if(queryExecutor == null){
			logger.error("QueryExecutor is not initialized!!!..");
			throw new TestException("QueryExecutor is not initialized!!!..");
		}
		return queryExecutor.getConnectionManager();
	}
		
	/**
	 * 
	 * @param dbServer
	 * @param database
	 * @param tableName
	 */
	public void clearTable(String tableName){
		String deleteQuery = "DELETE FROM " + tableName;
		logger.debug("Delete Query is: " + deleteQuery);
		try{
			queryExecutor.executeUpdate(deleteQuery);
			logger.debug(tableName +" Table is cleared..");
		}
		catch (Exception e) {
			logger.error("Error file executing the query");
		}		
	}
	public static String createSelectQuery(String columnName, String tableName, String whereClause){
		String select = "SELECT " + columnName + " FROM " + tableName ;
		String where = "" ;
		if(! StringUtils.isNullOrEmpty(whereClause)){
			where = " WHERE " + whereClause ;
		}
		String selectQuery = select + where ;	
		logger.debug("Select Query Generated is: "  + selectQuery);
		return 	selectQuery;
	}	
	public static String createUpdateQuery(String columnName, String tableName, String newValue, String whereClause){
		String update = "UPDATE " + tableName  + " SET " + columnName + "=" + newValue;
		String where = "" ;
		if(! StringUtils.isNullOrEmpty(whereClause)){
			where = " WHERE " + whereClause ;
		}
		String updateQuery = update + where ;	
		logger.debug("Select Query Generated is: "  + updateQuery);
		return 	updateQuery;
	}
	
	public void closeQueryExecutor(){
		queryExecutor = getQueryExecutor();
		queryExecutor.closeStatement();
	}	
	public void closeDatabaseConnection(){
		queryExecutor = getQueryExecutor();
		conManager = getConnectionManager();
		queryExecutor.closeStatement();
		conManager.closeConnection();
	}	
	/**
	 * The account number for connected is different in UI and DB, the "-" and the next digit will not be seen in the DB format
	 * This method will convert the UI format Account number to DB format 
	 * 
	 * @param accountNumber
	 * @return
	 */
	public String getDbFormattedAccountNumber(String accountNumber){
		return accountNumber.replaceAll("-\\d", "");
	}
	public String getUiFormattedAccountNumber(String accountNumber){
		
		/*
		 * Same algoritham from dev code is used to get the Check Digit
		 */
		int nCheckDigit = 0;
		boolean bEven = false;
		long dwAcctNum = Integer.parseInt(accountNumber);

		while ( dwAcctNum> 0)
		{
			int nDigit = (int) (dwAcctNum %  10);
			dwAcctNum /= 10;
			if (bEven)
				nCheckDigit -= nDigit;
			else
				nCheckDigit += nDigit;

			bEven = !bEven;
		}
		nCheckDigit = (nCheckDigit + 90) % 10;
		
		String accountSub1 = accountNumber.substring(0, 5);
		String accountSub2 = accountNumber.substring(5, 9);
		return accountSub1 + "-" + nCheckDigit + accountSub2 ;		
	}
	
	public static void closeDatabaseConnections(DataBase... tableObjects){
		for (DataBase tableObject : tableObjects) {
			logger.debug("Closing DataBase Connection for: " + tableObject);
			if(tableObject != null){
				try {
					tableObject.closeDatabaseConnection();
				} catch (Exception e) {
					e.printStackTrace();
				}
				finally{
					tableObject.closeDatabaseConnection();
				}
			}
		}		
	}
	
	
}
