package com.ironmountain.pageobject.webobjects.connected.database.registry;

import java.sql.ResultSet;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.ListUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;

public class AccountProfileTable extends RegistyDatabase {

	private static Logger logger = Logger
			.getLogger("com.imd.connected.database.registry.AccountProfileTable");

	public static final String TABLE_NAME = "ACCOUNTPROFILE";

	public AccountProfileTable(DatabaseServer dbServer) {
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}

	public AccountProfileTable(ConnectionManager conMgr) {
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}

	public String getNetworkComputerName(String accountNumber) {
		String columnName = "NetworkComputerName";
		String query = createSelectQuery(columnName, TABLE_NAME, "Account ="
				+ accountNumber);
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		String[] accounts = ListUtils.getStringListAsArray(ResultSetManager
				.getStringColumnValues(rs, columnName));
		if (accounts.length > 1) {
			logger
					.error("The Account Number query returned more than one, row which means 2 accounts are registered with the email");
		}
		return accounts[0];
	}
}
