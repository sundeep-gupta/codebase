package com.ironmountain.pageobject.pageobjectrunner.connected.database.registry;

import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.RegistyDatabase;


/**Community Table Object
 * @author pjames
 *
 */
public class CommunityTable extends RegistyDatabase{

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.database.registry.CommunityTable");
	
	public static final String TABLE_NAME = "Community" ;
	private DatabaseServer dbServer = DatabaseServer.COMMON_SERVER;
	
	
	public CommunityTable(DatabaseServer dbsServer){
		this.dbServer = dbsServer;
		queryExecutor = new QueryExecutor(dbServer, DATABASE_NAME);
	}
	public DatabaseServer getDatabaseServer(){
		return dbServer;
	}
	public QueryExecutor getQueryExecutor(){
		return queryExecutor;
	}
	/** Get the latest CommunityID
	 * @return
	 */
	public String getLatestCommunityID(){
		String columnName = "CommunityID";
		String communityID = null;
		String query = createSelectQuery(columnName,  TABLE_NAME, "");
		logger.debug("CommunityID Query generated: " + query);
		try{
		ResultSet rs = queryExecutor.executeQuery(query);
		if (rs == null){
			for (int i=0; i<3; i++){
				Thread.sleep(10000);
			}
			rs = queryExecutor.executeQuery(query);
		}
		int rowcnt = ResultSetManager.getNoOfRowsInResultSet(rs);
		communityID = ResultSetManager.getColValueByRowValue(rs, rowcnt, columnName);
		} catch (Exception e){
			logger.error("Error while finding the column value of the Row" + e);
		}
		return communityID ;	
	}
	
	/**Get the Community ID by the communityName
	 * @param CommunityName
	 * @return
	 * @throws Exception 
	 */
	public String getCommunityIDbyCommunityName(String CommunityName) throws Exception{
		String communityId = null;
		ArrayList<String> commID = null;
		String columnName = "CommunityID";
		String whereClause = ("CommunityName = " + "'"+ CommunityName + "'");
		String query = createSelectQuery(columnName,  TABLE_NAME, whereClause);
		logger.debug("CommunityID Query generated: " + query);
		try {
		Thread.sleep(1000);
		ResultSet rs = queryExecutor.executeQuery(query);
		if (rs == null){
			for (int i=0; i<3; i++){
				Thread.sleep(10000);
			}
			rs = queryExecutor.executeQuery(query);
		}
		commID = ResultSetManager.getStringColumnValues(rs, columnName);
		communityId = commID.get(0);
		 
		} catch (Exception e){
			logger.error("Error while finding the community Id for community " + CommunityName);
			throw new Exception("Error while finding the column value of the Row " + e);
		}
		return communityId;
	}
	
	/**Get the Community Name by the communityId
	 * @param CommunityID - Id of the community foe which you want to find the name 
	 * @return CommunityName
	 */
	public String getCommunityNameByCommunityId(String CommunityId){
		String communityName = null;
		ArrayList<String> commName = null;
		String columnName = "CommunityName";
		String whereClause = ("CommunityId = " + "'"+ CommunityId + "'");
		String query = createSelectQuery(columnName,  TABLE_NAME, whereClause);
		logger.debug("CommunityID Query generated: " + query);
		try {
		Thread.sleep(1000);
		ResultSet rs = queryExecutor.executeQuery(query);
		if (rs == null){
			for (int i=0; i<3; i++){
				Thread.sleep(10000);
			}
			rs = queryExecutor.executeQuery(query);
		}
		commName = ResultSetManager.getStringColumnValues(rs, columnName);
		communityName = commName.get(0);
		 
		} catch (Exception e){
			logger.error("Error while finding the column value of the Row" + e);
		}
		return communityName;
	}
	public boolean isCommunityExist(String communityName){

		String columnName = "CommunityID";
		String whereClause = ("CommunityName = " + "'"+ communityName + "'");
		String query = createSelectQuery(columnName,  TABLE_NAME, whereClause);
		logger.debug("CommunityID Query generated: " + query);
		try {
		ResultSet rs = queryExecutor.executeQuery(query);
		if(rs.next())
			return true;
		} catch (Exception e){
			logger.error("Error while find the community " + e);
		}
		return false;

	}


}
