package com.ironmountain.pageobject.webobjects.connected.database.registry;

import java.sql.ResultSet;

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
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] accounts  = ResultSetManager.getIntegerColumnValues(rs, columnName);
		if(accounts.length >1){
			logger.error("The Account Number query returned more than one, row which means 2 accounts are registered with the email");
		}
		return accounts[0] ;	
	}
	public String getAccountStartDate(String accountNumber){
		String columnName = "StartDate";
		String query = createSelectQuery(columnName,  TABLE_NAME, "Account =" + accountNumber);
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		String[] dates = ResultSetManager.getDateColumnValues(rs, columnName);
		if(dates.length >1){
			logger.error("The Account Number query returned more than one, row which means 2 accounts are registered with the email");
		}
		return dates[0] ;	
	}
}
