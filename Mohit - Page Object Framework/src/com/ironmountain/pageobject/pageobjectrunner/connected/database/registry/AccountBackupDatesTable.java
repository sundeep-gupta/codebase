package com.ironmountain.pageobject.pageobjectrunner.connected.database.registry;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;

public class AccountBackupDatesTable  extends RegistyDatabase{

private static Logger  logger      = Logger.getLogger("com.imd.connected.database.registry.AccountBackupDatesTable");
	
	public static final String TABLE_NAME = "ACCOUNTBACKUPDATES" ;
	
	public AccountBackupDatesTable(DatabaseServer dbServer){
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}	
	public AccountBackupDatesTable(ConnectionManager conMgr){
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}	
	/**
	 * Clean up the table
	 */
	public void clearTable(){
		super.clearTable(TABLE_NAME);
	}
	
	public String[] getBackupDates(String accountNumber){
		String columnName = "BackupDate";
		String query = createSelectQuery(columnName,  TABLE_NAME, "Account =" + accountNumber);
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		String[] dates = ResultSetManager.getDateColumnValues(rs, columnName);
		return dates ;	
	}
	
	public String getBackupTDate(String accountNumber,String backupDate){
		String columnName = "BackupTDate";
		String query = createSelectQuery(columnName,  TABLE_NAME, "Account =" + accountNumber + " and BackupDate ="+backupDate);
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		String TDate = ResultSetManager.getDateColumnValues(rs, columnName)[0];
		return TDate ;	
	}
	
	public String getLastBackupDate(String accountNumber){
		String columnName = "BackupDate";
		String query = createSelectQuery(columnName,  TABLE_NAME, "Account =" + accountNumber);
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		String[] dates = ResultSetManager.getDateColumnValues(rs, columnName);
		logger.debug("Last backup date is: " + dates[(dates.length -1)]);
		return dates[(dates.length -1)];
	}
	
	public String getLastBackupDateCompleted(String accountNumber){
		String columnName1 = "BackupDate";
		String columnName2 = "Status";
		String query = createSelectQuery(columnName1,  TABLE_NAME, "Account =" + accountNumber +" AND " + columnName2 + "=1" );
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		String[] dates = ResultSetManager.getDateColumnValues(rs, columnName1);
		logger.debug("Lastbackup complete date is: " + dates[(dates.length -1)]);
		return dates[(dates.length -1)];
	}
	public int getTotalBackupsInMonth(String accountNumber){
		String colName = "Count(*)";
		String query = createSelectQuery(colName,  TABLE_NAME, "Account =" + accountNumber+" AND BackupDate between (CURRENT_TIMESTAMP-30 )and (CURRENT_TIMESTAMP)");
		logger.info("Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int totalBackups =0;
		try {
		
			while (rs.next())
			{
				totalBackups=rs.getInt(1);
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return totalBackups;
	}
	
	public String getWeekDay(String Date){
		String query="Select DATEPART(weekday,'"+Date+"')";
		logger.info(query);
		ResultSet rs= queryExecutor.executeQuery(query);
		int weekDayInt =0;
		try {
			while(rs.next()){
				 weekDayInt = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String[] weekDayString={"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
		return weekDayString[weekDayInt-1];
	}
}
