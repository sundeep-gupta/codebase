package com.ironmountain.pageobject.pageobjectrunner.connected.database.registry;



	import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

	import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
	import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
	import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
	import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.RegistyDatabase;

	public class ActivityTable  extends RegistyDatabase{

	private static Logger  logger      = Logger.getLogger("com.imd.connected.database.registry.AccountSizeTable");
		
		public static final String TABLE_NAME = "ACTIVITY" ;
		
		public ActivityTable(DatabaseServer dbServer){
			setDatabaseServer(dbServer);
			queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
		}	
		public ActivityTable(ConnectionManager conMgr){
			queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
		}

		public int getOrigSize(String accountNumber){
			String colName = "OrigSize";
			int origSize = 0;
			String query = createSelectQuery(colName,  TABLE_NAME, "Account="+accountNumber+" and Type = 'j' and OrigSize != 0 order by ActDate desc");
			logger.info(colName+" Query generated: " + query);
			ResultSet rs = queryExecutor.executeQuery(query);
			try {
				while(rs.next()){
					origSize=rs.getInt(colName);
					logger.info(origSize);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return origSize;
		}
		public int getNumOfFiles(String accountNumber){
			String colName = "NumOfFiles";
			int numOfFiles = 0;
			String query = createSelectQuery(colName,  TABLE_NAME, "Account="+accountNumber+" and Type = 'j' and OrigSize != 0 order by ActDate desc");
			logger.debug(colName+" Query generated: " + query);
			ResultSet rs = queryExecutor.executeQuery(query);
			try {
				while(rs.next()){
					numOfFiles=rs.getInt(colName);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return numOfFiles;
		}
		public String getActivityDate(String accountNumber){
			String colName = "ActDate";
			String ActDate = "";
			String query = createSelectQuery(colName,  TABLE_NAME, "Account="+accountNumber+" and Type = 'j' and OrigSize != 0 order by ActDate desc");
			logger.debug(colName+" Query generated: " + query);
			ResultSet rs = queryExecutor.executeQuery(query);
			try {
				while(rs.next()){
					ActDate=rs.getString(colName);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return ActDate;
		}
		
}
