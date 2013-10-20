package com.ironmountain.pageobject.pageobjectrunner.connected.database.registry;

import java.sql.ResultSet;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;

public class StoredProcedures extends RegistyDatabase{
private static Logger  logger      = Logger.getLogger("com.imd.connected.database.registry.AccountBackupDatesTable");
	
	public StoredProcedures(DatabaseServer dbServer){
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}	
	public StoredProcedures(ConnectionManager conMgr){
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}	
	public void executePurgePushedMessages(){
		String query = "Exec [dbo].[sp_PurgePushedMessages]";
		logger.info(query);
		queryExecutor.executeUpdate(query);
	}

}
