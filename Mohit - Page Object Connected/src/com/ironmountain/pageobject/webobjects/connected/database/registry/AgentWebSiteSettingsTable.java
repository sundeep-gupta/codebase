package com.ironmountain.pageobject.webobjects.connected.database.registry;

import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;

public class AgentWebSiteSettingsTable extends RegistyDatabase{

	private static Logger  logger      = Logger.getLogger("com.imd.connected.database.registry.AgentWebSiteSettingsTable");
	private String TABLE_NAME = "AgentWebSiteSettings";
	private DatabaseServer dbServer = DatabaseServer.COMMON_SERVER;
	
	
	public AgentWebSiteSettingsTable(DatabaseServer dbsServer){
		this.dbServer = dbsServer;
		queryExecutor = new QueryExecutor(dbServer, DATABASE_NAME);
	}
	public DatabaseServer getDatabaseServer(){
		return dbServer;
	}
	public QueryExecutor getQueryExecutor(){
		return queryExecutor;
	}
	
	/**  Method to return the value of the column by community ID.
	 * @param ColName
	 * @param CommunityID
	 * @return
	 */
	public String getValueByColNameandCommunityID(String ColName, String CommunityID){
		String ColValue = null;
		ArrayList<String> pclist = null;
		String columnName = ColName;
		String whereClause = ("CommunityID = " + "'"+ CommunityID + "'");
		String query = createSelectQuery(columnName,  TABLE_NAME, whereClause);
		logger.debug(ColName+" Query generated: " + query);
		try {
		ResultSet rs = queryExecutor.executeQuery(query);
		pclist = ResultSetManager.getStringColumnValues(rs, columnName);
		ColValue = pclist.get(0);
		} catch (Exception e){
			logger.error("Error while finding the column value of the Row" + e);
		}
		return ColValue;
	}
	
	/**  Method to return the value of the column by community ID and any other column.
	 * @param ColName
	 * @param CommunityID
	 * @return
	 */
	public String getValueByColNameandCommunityID(String ColName, String CommunityID, String WhereClause){
		String ColValue = null;
		ArrayList<String> pclist = null;
		String columnName = ColName;
		String whereClause = ("CommunityID = " + "'"+ CommunityID + "'" + " AND" + WhereClause);
		String query = createSelectQuery(columnName,  TABLE_NAME, whereClause);
		logger.debug(ColName+" Query generated: " + query);
		try {
		ResultSet rs = queryExecutor.executeQuery(query);
		pclist = ResultSetManager.getStringColumnValues(rs, columnName);
		ColValue = pclist.get(0);
		} catch (Exception e){
			logger.error("Error while finding the column value of the Row" + e);
		}
		return ColValue;
	}

	/**  Method to return the value of the column by community ID and any other column.
	 * @param ColName
	 * @param WhereClause
	 * @return
	 */
	public String getValueByColNameandWhereClause(String ColName, String whereClause){
		String ColValue = null;
		ArrayList<String> pclist = null;
		String columnName = ColName;
		String query = createSelectQuery(columnName,  TABLE_NAME, whereClause);
		logger.debug(ColName+" Query generated: " + query);
		try {
		ResultSet rs = queryExecutor.executeQuery(query);
		pclist = ResultSetManager.getStringColumnValues(rs, columnName);
		ColValue = pclist.get(0);
		} catch (Exception e){
			logger.error("Error while finding the column value of the Row" + e);
		}
		return ColValue;
	}
}
