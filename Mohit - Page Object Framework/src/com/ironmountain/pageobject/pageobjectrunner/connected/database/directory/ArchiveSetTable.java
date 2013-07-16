package com.ironmountain.pageobject.pageobjectrunner.connected.database.directory;

import java.sql.ResultSet;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.directory.DirectoryDatabase;

public class ArchiveSetTable extends DirectoryDatabase {

	private static Logger logger = Logger.getLogger("ArchiveSetTable");

	public static final String TABLE_NAME = "ARCHIVESET";

	public ArchiveSetTable(DatabaseServer dbServer) {
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}

	public ArchiveSetTable(ConnectionManager conMgr) {
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}
	
	/**
	 * Returns volumeId for an archive name. (where the actual archive is located)
	 * 
	 * @param accountNumber
	 * @param archiveNameTdate
	 * @return
	 */
	public int getVolumeId(String accountNumber, String archiveNameTdate){
		String columnName = "VolumeID";
		final String query = createSelectQuery(columnName, TABLE_NAME, "Account ="
				+ accountNumber + " and archivename= '" + archiveNameTdate + "'");
		logger.debug("VolumeId Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] volumeid = ResultSetManager.getIntegerColumnValues(rs, columnName);
		if(volumeid.length <=0){
			logger.error("No volume Found for this file!!! Is this arcivename correct?" );
			throw new TestException("No volume Found for this file!!! Is this arcivename correct?");
		}
		return volumeid[0];
	}
	
	
}
