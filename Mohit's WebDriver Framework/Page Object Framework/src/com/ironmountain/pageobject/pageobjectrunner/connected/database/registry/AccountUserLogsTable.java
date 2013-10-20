package com.ironmountain.pageobject.pageobjectrunner.connected.database.registry;



import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.RegistyDatabase;

public class AccountUserLogsTable  extends RegistyDatabase{

private static Logger  logger      = Logger.getLogger("com.imd.connected.database.registry.AccountSizeTable");
	
	public static final String TABLE_NAME = "ACCOUNTUSERLOGS" ;
	
	public AccountUserLogsTable(DatabaseServer dbServer){
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}	
	public AccountUserLogsTable(ConnectionManager conMgr){
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}
	
	/*This function will return the start or end time of all the events other than with Type = 3 */
	public ArrayList<String> returnStartEndTime(String typeStart,int accountNumber) {
		String columnName = typeStart;
		String query = createSelectQuery(columnName,  TABLE_NAME, "Account= "+accountNumber+" and Type <> 3 order by "+typeStart+" desc");
		logger.debug("Backup Time Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		ArrayList<String> returnResultset = ResultSetManager.getStringColumnValues(rs, columnName);
		logger.info(returnResultset);
		return returnResultset;
	}
	
	public ResultSet returnEventsForDate( int accountNumber, String date )
	{
		String query = createSelectQuery("*",  TABLE_NAME, "Account= "+accountNumber+" and Type <> 3 and ( StartTime >'" + date + "' and StartTime < '" + date + " 23:59:59.999') order by StartTime desc");
		logger.info("Event Details Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		return rs;
	}
}