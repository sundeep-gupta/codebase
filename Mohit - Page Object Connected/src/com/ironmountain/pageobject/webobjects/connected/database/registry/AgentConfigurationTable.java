package com.ironmountain.pageobject.webobjects.connected.database.registry;

import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;

public class AgentConfigurationTable extends RegistyDatabase{
	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.database.registry.AgentConfigurationTable");
	public static final String TABLE_NAME = "AGENTCONFIGURATION" ;
	
	public AgentConfigurationTable(DatabaseServer dbServer){
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}	
	public AgentConfigurationTable(ConnectionManager conMgr){
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}	
	/**
	 * Clean up the table
	 */
	public void clearTable(){
		super.clearTable(TABLE_NAME);
	}
	public String getAgentConfigurationId(String agentConfiguration, String communityId){

		String columnName = "Id";
		String whereClause = ("Name='"+ agentConfiguration + "' and CommunityID=" + communityId );
		String query = createSelectQuery(columnName,  TABLE_NAME, whereClause);
		logger.debug("Agent Configuration Query generated: " + query);
		try {
		ResultSet rs = queryExecutor.executeQuery(query);
			    int cids[] = ResultSetManager.getIntegerColumnValues(rs, columnName);
		     if(cids.length > 0){
				    return Integer.toString(cids[0]);		
			 }else
		     {
			    logger.error("No such configuration exist");
			    return null;
		     }
		}
		catch (Exception e){
			logger.error("Error while find the community " + e);
		}
		return null;

	}
	public boolean isAgentConfigurationExist(String agentConfiguration, String communityId){

		String columnName = "Id";
		String whereClause = ("Name='"+ agentConfiguration + "' and CommunityID=" + communityId );
		String query = createSelectQuery(columnName,  TABLE_NAME, whereClause);
		logger.debug("Agent Configuration Query generated: " + query);
		try {
		ResultSet rs = queryExecutor.executeQuery(query);
		if(rs.next())
			return true;
		} catch (Exception e){
			logger.error("Error while find the community " + e);
		}
		return false;

	}
	
	/**  Method to return the value of the column by community ID.
	 * @param ColName
	 * @param CommunityID
	 * @return
	 */
	public String getValueByColNameandWhereClause(String ColName, String whereClause){
		String ColValue = null;
		ArrayList<String> pclist = null;
		String rscolname = "resultcolumn";
		String columnName = ColName;
		String query = createSelectQuery(columnName + "AS " + rscolname,  TABLE_NAME, whereClause);
		logger.debug(ColName+" Query generated: " + query);
		try {
		ResultSet rs = queryExecutor.executeQuery(query);
		pclist = ResultSetManager.getStringColumnValues(rs, rscolname);
		ColValue = pclist.get(0);
		} catch (Exception e){
			logger.error("Error while finding the column value of the Row" + e);
		}
		return ColValue;
	}
}
