package com.ironmountain.pageobject.pageobjectrunner.connected.database.registry;



import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.RegistyDatabase;

public class AgentRulesTable extends RegistyDatabase{

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.database.registry.AgentRulesTable");
	public static final String TABLE_NAME = "AGENTRULES" ;
	
	public AgentRulesTable(DatabaseServer dbServer){
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}	
	public AgentRulesTable(ConnectionManager conMgr){
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}	
	/**
	 * Clean up the table
	 */
	public void clearTable(){
		super.clearTable(TABLE_NAME);
	}

	public int setAgentRuleDetails(String communityId, String ruleName, String ruleDetails){
		String columnName = "RuleDetails";
		String query = createUpdateQuery(columnName,  TABLE_NAME, "'" + ruleDetails + "'", "CommunityID=" + communityId + " and name='" + ruleName + "'");
		logger.debug("Acount Number Query generated: " + query);
		return queryExecutor.executeUpdate(query);
	}
	
	public int setAgentRuleTrueName(String communityId, String ruleName, String trueName){
		String columnName = "TrueName";
		String query = createUpdateQuery(columnName,  TABLE_NAME, trueName , "CommunityID=" + communityId + " and name='" + ruleName + "'");
		logger.debug("Acount Number Query generated: " + query);
		return queryExecutor.executeUpdate(query);
	}
	
}
