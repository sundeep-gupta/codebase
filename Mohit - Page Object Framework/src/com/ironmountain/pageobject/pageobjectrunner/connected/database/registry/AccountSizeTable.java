package com.ironmountain.pageobject.pageobjectrunner.connected.database.registry;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.RegistyDatabase;

public class AccountSizeTable  extends RegistyDatabase{

private static Logger  logger      = Logger.getLogger("com.imd.connected.database.registry.AccountSizeTable");
	
	public static final String TABLE_NAME = "ACCOUNTSIZE" ;
	
	public AccountSizeTable(DatabaseServer dbServer){
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}	
	public AccountSizeTable(ConnectionManager conMgr){
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}
	
	public int getBackupsetSize(String backupDate){
		
		int size = getSizeUniqueUncompressed(backupDate);
		int kbSize = size/1024;
		int mbSize = kbSize/1024;
		return mbSize;
	}
	
	public int getSizeUniqueUncompressed(String backupDate){
		String columnName = "SizeUniqueUncompressed";
		String query = createSelectQuery(columnName,  TABLE_NAME, "SnapShotDate ='" + backupDate+ "00'");
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] size  = ResultSetManager.getIntegerColumnValues(rs, columnName);
		if(size.length >1){
			logger.error("The Account Number query returned more than one, row which means 2 accounts are registered with the email");
		}
		return size[0] ;	
	}
	public long getTipRevisionUncompressed(String accountNumber) throws SQLException{
		String columnName = "TipRevisionUncompressed";
		String query = createSelectQuery(columnName,  TABLE_NAME, "Account="+accountNumber+" order by SnapShotDate desc");
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		long size = -1;
		if (rs.next())
		{
			 size  = rs.getLong(1);
		}
		if(size >1){
			logger.error("The Account Number query returned more than one, row which means 2 accounts are registered with the email");
		}
		return size ;
	}
	public int getTipRevisionNumFiles(String accountNumber){
		String columnName = "TipRevisionNumFiles";
		String query = createSelectQuery(columnName,  TABLE_NAME, "Account="+accountNumber+" order by SnapShotDate desc");
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] size  = ResultSetManager.getIntegerColumnValues(rs, columnName);
		if(size.length >1){
			logger.error("The Account Number query returned more than one, row which means 2 accounts are registered with the email");
		}
		return size[0] ;
	}
	}

