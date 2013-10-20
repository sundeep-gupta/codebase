package com.ironmountain.pageobject.pageobjectrunner.connected.database.registry;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;

public class AccountMessageTable extends RegistyDatabase{
	private static Logger logger = Logger
	.getLogger("com.imd.connected.database.registry.AccountMessageTable");

public static final String TABLE_NAME = "ACCOUNTMESSAGE";

public AccountMessageTable(DatabaseServer dbServer) {
setDatabaseServer(dbServer);
queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
}

public AccountMessageTable(ConnectionManager conMgr) {
queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
}

public String[] getPushedIDJoin(String accountNumber){
		String[] messDate = null;
		String colName = "Top 50 PushedMessageId";
		String fromClause = " INNER JOIN PushedMessage ON AccountMessage.PushedMessageId=PushedMessage.CreatedOn ";
		String whereClause = "Account = "+accountNumber+" order by PushedMessageId desc";
		String query = createSelectQuery(colName,  TABLE_NAME+fromClause, whereClause);
		logger.debug(colName+" Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		messDate=ResultSetManager.getDateColumnValues(rs, "PushedMessageId");
		return messDate;
	}
public String[] getPushedId(String accountNumber) throws SQLException{
	String colName = "PushedMessageId";
	String[] pushedId = null;
	String query = createSelectQuery(colName,  TABLE_NAME, "Account = "+accountNumber+" Order by "+colName+" desc");
	logger.info(query);
	ResultSet rs = queryExecutor.executeQuery(query);
	pushedId = ResultSetManager.getDateColumnValues(rs, colName);
	return pushedId;
}
public String[] getPushedIdAsc(String accountNumber) throws SQLException{
	String colName = "PushedMessageId";
	String[] pushedId = null;
	String query = createSelectQuery(colName,  TABLE_NAME, "Account = "+accountNumber+" Order by "+colName);
	logger.info(query);
	ResultSet rs = queryExecutor.executeQuery(query);
	pushedId = ResultSetManager.getDateColumnValues(rs, colName);
	return pushedId;
}

public void insertExpiredMessage(int accountNumber) throws SQLException{
	/*String querydate = "Select CURRENT_TIMESTAMP-401";
	logger.info(querydate);
	ResultSet rsdate = queryExecutor.executeQuery(querydate);
	Date date = rsdate.getDate(1);*/
	String query = "Insert into "+TABLE_NAME+" Values ("+accountNumber+",CURRENT_TIMESTAMP-401,0)";
	logger.info(query);
	queryExecutor.executeUpdate(query);
	//return date;
}
public void insertRow(int accountNumber){
	String query = "Insert into "+TABLE_NAME+" values('"+accountNumber+"',CURRENT_TIMESTAMP,0)";
	//logger.info(query);
	queryExecutor.executeUpdate(query);
}

	
}


