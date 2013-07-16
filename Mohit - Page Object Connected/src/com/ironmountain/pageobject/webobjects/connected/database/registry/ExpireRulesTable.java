package com.ironmountain.pageobject.webobjects.connected.database.registry;


import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;

public class ExpireRulesTable extends RegistyDatabase{

	    private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.database.registry.ExpireRulesTable");
		
		public static final String TABLE_NAME = "EXPIRERULES" ;
		
		public ExpireRulesTable(DatabaseServer dbServer){
			setDatabaseServer(dbServer);
			queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
		}	
		public ExpireRulesTable(ConnectionManager conMgr){
			queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
		}
		
		public void setDeletedRevs(String noOfDays){
			String columnName = "DeletedRevs" ;
			String updateQuery = createUpdateQuery(columnName, TABLE_NAME, noOfDays, "");
			logger.info(updateQuery);
			queryExecutor.executeUpdate(updateQuery);
		}
		
		
	
}
