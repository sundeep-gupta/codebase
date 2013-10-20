package com.ironmountain.pageobject.pageobjectrunner.connected.database.directory;

import java.sql.ResultSet;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.directory.DirectoryDatabase;

public class FileIndexTable extends DirectoryDatabase {

	private static Logger logger = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.database.directory.FileIndexTable");

	public static final String TABLE_NAME = "FILEINDEX";

	public FileIndexTable(DatabaseServer dbServer) {
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}

	public FileIndexTable(ConnectionManager conMgr) {
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}
	
	public String getArchiveNameAsTDate(String accountNumber, String fileName){
		String columnName = "ArchiveName";
		final String query = createSelectQuery( "top 1 " + columnName, TABLE_NAME, "Account ="
				+ accountNumber + " and filename= '" + fileName + "'");
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] arcTdate = ResultSetManager.getIntegerColumnValues(rs, columnName);
		if(arcTdate.length <=0){
			logger.error("No Archive Tadate Found for this file!!! Is this file really backedup for this account" );
			throw new TestException("No archive found for the given file name!!! Is this file backedup for this account??");
		}
		return Integer.toString(arcTdate[0]);
	}
	/**
	 * Get the ArchiveName TDate when there are different versions of file available
	 * Based on the backed-up index the archive TDate will be displayed
	 * 
	 * @param accountNumber
	 * @param fileName
	 * @param expectedIndex
	 * @return
	 */
	public String getArchiveNameAsTDate(String accountNumber, String fileName, int expectedIndex){
		String columnName = "ArchiveName";
		final String query = createSelectQuery(columnName, TABLE_NAME, "Account ="
				+ accountNumber + " and filename= '" + fileName + "'");
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] arcTdate = ResultSetManager.getIntegerColumnValues(rs, columnName);
		if(arcTdate.length <=0){
			logger.error("No Archive Tadate Found for this file!!! Is this file really backedup for this account" );
			throw new TestException("No archive found for the given file name!!! Is this file backedup for this account??");
		}
		return Integer.toString(arcTdate[expectedIndex]);
	}
	
	public String getArchiveName(String accountNumber, String fileName){		
		int arcTdate = Integer.parseInt(getArchiveNameAsTDate(accountNumber, fileName));
		String archName = Integer.toHexString(arcTdate);
		return archName;
	}
	/**
	 * @param accountNumber
	 * @param fileName
	 * @param i "If you backed up more than one version resultIndex indicates that from which row the archive name should retrieved"
	 * @return
	 */
	public String getArchiveName(String accountNumber, String fileName, int i){
		String columnName = "ArchiveName";
		String query = createSelectQuery(columnName, TABLE_NAME, "Account ="
				+ accountNumber + " and filename= '" + fileName + "'");
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] arcTdate = ResultSetManager.getIntegerColumnValues(rs, columnName);
		if(arcTdate.length <=0){
			logger.error("No Archive Found for this file!!! Is this file really backedup for this account" );
			throw new TestException("No archive found for the given file name!!! Is this file backedup for this account??");
		}
		String archName = Integer.toHexString(arcTdate[i]);
		return archName;
	}
	public int[] getFileTypes(String accountNumber, String fileName){
		String columnName = "Type";
		String query = createSelectQuery(columnName, TABLE_NAME, "Account ="
				+ accountNumber + " and filename= '" + fileName + "'");
		logger.debug("File Type Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] fileTypes = ResultSetManager.getIntegerColumnValues(rs, columnName);
		if(fileTypes.length <=0){
			throw new TestException("No types found for the given file name!!! Is this file backedup for this account??");
		}
		return fileTypes;
	}
	public int[] getFileKinds(String accountNumber, String fileName){
		String columnName = "Kind";
		String query = createSelectQuery(columnName, TABLE_NAME, "Account ="
				+ accountNumber + " and filename= '" + fileName + "'");
		logger.debug("File Kind Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] fileTypes = ResultSetManager.getIntegerColumnValues(rs, columnName);
		if(fileTypes.length <=0){
			throw new TestException("No kind found for the given file name!!! Is this file backedup for this account??");
		}
		return fileTypes;
	}
	/**
	 * Get the file Kind when there are different versions of file available
	 * Based on the backed-up index the file kind will be displayed
	 * "If you backed up more than one version Index indicates that from which row the archive name should retrieved
	 * 
	 * @param accountNumber
	 * @param fileName
	 * @param index
	 * @return
	 */
	public int getFileKind(String accountNumber, String fileName, int index){
		String columnName = "Kind";
		String query = createSelectQuery(columnName, TABLE_NAME, "Account ="
				+ accountNumber + " and filename= '" + fileName + "'");
		logger.debug("File Kind Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] fileTypes = ResultSetManager.getIntegerColumnValues(rs, columnName);
		if(fileTypes.length <=0){
			throw new TestException("No kind found for the given file name!!! Is this file backedup for this account??");
		}
		return fileTypes[index];
	}


}
