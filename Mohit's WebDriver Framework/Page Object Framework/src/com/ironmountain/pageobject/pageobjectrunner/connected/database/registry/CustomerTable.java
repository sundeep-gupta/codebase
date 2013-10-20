package com.ironmountain.pageobject.pageobjectrunner.connected.database.registry;

import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;

public class CustomerTable  extends RegistyDatabase{

private static Logger  logger      = Logger.getLogger("com.imd.connected.database.registry.CustomerTable");
	
	public static final String TABLE_NAME = "CUSTOMER" ;
	
	public CustomerTable(DatabaseServer dbServer){
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}	
	public CustomerTable(ConnectionManager conMgr){
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}
	
	public int getAccountNumber(String emailAddress){
		String columnName = "Account";
		String query = createSelectQuery(columnName,  TABLE_NAME, "email ='" + emailAddress + "'");
		logger.info("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		// Polling for 30 seconds
		if (rs == null){
			for (int i=0; i<3; i++){
				try {
					Thread.sleep(10000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			rs = queryExecutor.executeQuery(query);
		}
		int[] accounts  = ResultSetManager.getIntegerColumnValues(rs, columnName);
		if(accounts.length >1){
			logger.error("The Account Number query return ed more than one, row which means 2 accounts are registered with the email");
		}
		logger.info(accounts[0]);
		return accounts[0] ;	
	}
	public String getAccountStartDate(String accountNumber){
		String columnName = "StartDate";
		String query = createSelectQuery(columnName,  TABLE_NAME, "Account =" + accountNumber);
		logger.info("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		String[] dates = ResultSetManager.getDateColumnValues(rs, columnName);
		if(dates.length >1){
			logger.error("The Account Number query returned more than one, row which means 2 accounts are registered with the email");
		}
		queryExecutor.closeStatement();
		return dates[0] ;	
	}
	public String getAccountStatus(int accountNumber) {
		String columnName = "Status";
		String query = createSelectQuery(columnName,  TABLE_NAME, "Account =" + accountNumber);
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		ArrayList<String> status = ResultSetManager.getStringColumnValues(rs, columnName);
		queryExecutor.closeStatement();
		return status.get(0) ;
	}
	public void updateCommunityIDForAccount(String communityID, String accountNumber) {
		//UPDATE Customer SET OfferID = 3 WHERE Account = 101000892
		String query = "UPDATE Customer SET OfferID = " + communityID + " WHERE Account = " + accountNumber;
		logger.info(query);
		queryExecutor.executeUpdate(query);
		queryExecutor.closeStatement();
	}
}
