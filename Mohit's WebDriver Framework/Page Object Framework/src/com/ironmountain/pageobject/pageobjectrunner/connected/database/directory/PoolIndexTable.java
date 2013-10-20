package com.ironmountain.pageobject.pageobjectrunner.connected.database.directory;

import java.sql.ResultSet;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.directory.DirectoryDatabase;

public class PoolIndexTable extends DirectoryDatabase {

	private static Logger logger = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.database.directory.PoolIndexTable");

	public static final String TABLE_NAME = "POOLINDEX";

	public PoolIndexTable(DatabaseServer dbServer) {
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}

	public PoolIndexTable(ConnectionManager conMgr) {
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}
	
	public String getAccountNumberForFile(String fileName){
		String columnName = "Account";
		String query = createSelectQuery(columnName, TABLE_NAME, "filename= '" + fileName + "'");
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] accountNos = ResultSetManager.getIntegerColumnValues(rs, columnName);
		if(accountNos.length <=0){
			throw new TestException("No accounts found for the given file name!!! Is this file backedup for this account??");
		}
		return Integer.toString(accountNos[0]);
	}

	public void deletePoolIndexEntryForFile(String account, String fileName){

		String query = "DELETE FROM " +  TABLE_NAME + " WHERE filename= '" + fileName + "'" + " AND Account=" + account;
		logger.debug("Acount Number Query generated: " + query);
		queryExecutor.executeUpdate(query);
	}

}
