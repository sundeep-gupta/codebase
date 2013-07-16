package com.ironmountain.pageobject.webobjects.connected.database.directory;

import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;

public class VolumesTable extends DirectoryDatabase {

	private static Logger logger = Logger.getLogger("VolumesTable");

	public static final String TABLE_NAME = "VOLUMES";

	public VolumesTable(DatabaseServer dbServer) {
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}

	public VolumesTable(ConnectionManager conMgr) {
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}
	
	/**
	 * Return the actual drive/volume name for this volume id where the customer 
	 * 
	 * @param volumeId
	 * @return
	 */
	public String getLocalPath(int volumeId){
		String columnName = "LocalPath";
		final String query = createSelectQuery( "top 1 " + columnName, TABLE_NAME, "id ="
				+ volumeId );
		logger.debug("Volume LocalPath (Customer Volume) Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		ArrayList<String> localPath = ResultSetManager.getStringColumnValues(rs, columnName);
		if(localPath.size() <=0){
			logger.error("No LoclaPath Found for this volume!!! Is this volumeid exists!!" );
			throw new TestException("No LoclaPath Found for this volume!!! Is this volumeid exists!!");
		}
		return localPath.get(0);
	}
	
}

