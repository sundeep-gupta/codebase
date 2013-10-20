package com.ironmountain.kanawha.commons;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ironmountain.kanawha.pages.KanawhaHomePage;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountMessageTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountProfileTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.PushedMessageTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.StoredProcedures;
import com.ironmountain.pageobject.pageobjectrunner.utils.ListUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;

public class CommonUtils {
	
	private static final Logger logger = Logger.getLogger(CommonUtils.class.getName());
	
	/**
	 * This method gets the hostname where agent is installed, corresponding to the given username  
	 * @param username
	 * @return
	 */
	public static String getDeviceName(String username) { 
		int accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(username);
		String deviceName = (new AccountProfileTable(DatabaseServer.COMMON_SERVER).getNetworkComputerName(""+accountNumber));
		return deviceName;
	}
	
	/**
	 * This method gets the account number for a given username. It returns the top account number if the username has more than one account associated
	 * @param username
	 * @return
	 */
	public static int getAccountNumber(String username) { 
		int accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(username);
        return accountNumber;
	}
	
	/**
	 * This method gets all the account messages for a given username from DB
	 * @param username
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<String[]> getAccountMessagesFromDB(String username) throws SQLException {
		ArrayList<String[]> messages = new ArrayList<String[]>();
		String [] row = new String[2];
		int accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(username);
		/*SELECT Message  FROM [Registry].[dbo].[PushedMessage] where createdon in ( SELECT [PushedMessageId]
		  FROM [Registry].[dbo].[AccountMessage] where Account='101000892')*/
		
		QueryExecutor qe = new QueryExecutor(DatabaseServer.COMMON_SERVER, "REGISTRY");
    	ResultSet res = qe.executeQuery("SELECT CreatedOn as date,Message as mesg FROM PushedMessage where createdon in ( SELECT PushedMessageId FROM AccountMessage where Account='"+accountNumber+"' )");
    	while(res.next()){
    		row[0] = res.getString("date");
    		row[1] = res.getString("mesg");
    		messages.add(row);
    		row = new String[2];
    	}
		
		return messages;
		
	}
	
	/**
	 * This method deletes all the account messages for a given username
	 * @param username
	 * @throws SQLException
	 */
	public static void deleteAccountMessagesFromDB(String username) throws SQLException {
		logger.info("Cleaning up Messages for " + username);
		int accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(username);
		/*  delete from PushedMessage where CreatedOn in ( SELECT PushedMessageId FROM AccountMessage where Account='101000892')
            delete from AccountMessage where Account='101000892'*/
		
		QueryExecutor qe = new QueryExecutor(DatabaseServer.COMMON_SERVER, "REGISTRY");
    	qe.executeUpdate("delete FROM PushedMessage where createdon in ( SELECT PushedMessageId FROM AccountMessage where Account='"+accountNumber+"' )");
    	qe.executeUpdate("delete FROM AccountMessage where Account='"+accountNumber+"'");
	}
	/**
	 * This method deletes all the account messages for a given username
	 * @param username
	 * @throws SQLException
	 */
	@SuppressWarnings("null")
	public static void deleteMessagesForAllAccountsFromDB(String[] username) throws SQLException {
		logger.info("Cleaning up Messages for " + username[0]+" and "+username[1]+" and "+username[2]);
		CustomerTable customerTableObject = null;
		QueryExecutor qe = null;
		try
		{
				customerTableObject = new CustomerTable(DatabaseServer.COMMON_SERVER);
				int[] accountNumber = new int[3];
				for(int index=0;index < 3;index++){
					accountNumber[index]= customerTableObject.getAccountNumber(username[index]);
				}
				qe = new QueryExecutor(DatabaseServer.COMMON_SERVER, "REGISTRY");
		    	qe.executeUpdate("delete FROM PushedMessage where createdon in ( SELECT PushedMessageId FROM AccountMessage where Account in ("+accountNumber[0]+","+accountNumber[1]+","+accountNumber[2]+"))");
		    	qe.executeUpdate("delete FROM AccountMessage where Account in ("+accountNumber[0]+","+accountNumber[1]+","+accountNumber[2]+")");
		    	
		}
		finally
		{
				if(customerTableObject!=null)
				{
					customerTableObject.closeDatabaseConnection();
				}
				if(qe != null)
				{
					qe.closeStatement();
				}
		}	
	}

	/**
	 * This method inserts a message in the DB for a given account
	 * @param accountNumber
	 * @param technician
	 * @param message
	 * @param type
	 * @param validity
	 * @throws SQLException
	 */
	public static void addAccountMessageToDB(int accountNumber, String technician, String message, String type, String validity) throws SQLException {
		
		AccountMessageTable accountMessageObject = new AccountMessageTable(DatabaseServer.COMMON_SERVER);
		PushedMessageTable pushedMessageObject = new PushedMessageTable(DatabaseServer.COMMON_SERVER);
		StoredProcedures storedProcedureObject = new StoredProcedures(DatabaseServer.COMMON_SERVER);
		String accountNumberString = Integer.toString(accountNumber);
		String[] createDate = new String[10];
		
		//Inserting rows to DB
		if(validity.equals("active")) {
			accountMessageObject.insertRow(accountNumber);
			createDate = accountMessageObject.getPushedId(accountNumberString);
		}else if(validity.equals("expired")) {
			accountMessageObject.insertExpiredMessage(accountNumber);
			createDate = accountMessageObject.getPushedIdAsc(accountNumberString);
		}
		
		logger.info(createDate[0]);
		if(type.equals("ascii")) {
			pushedMessageObject.insertRow(technician, message, createDate[0]);
		}else if(type.equals("unicode")) {
			pushedMessageObject.insertRowUnicode(technician, message, createDate[0]);
		}
		if(validity.equals("expired")) {
			storedProcedureObject.executePurgePushedMessages();
		}
	}
	
	/**
	 * This method moves an account to a given community
	 * @param username
	 * @param community
	 * @throws Exception
	 */
	public static void updateAccountCommunity(String username, String community) throws Exception {
		CommunityTable Community = new CommunityTable(DatabaseServer.COMMON_SERVER);
		CustomerTable Customer = new CustomerTable(DatabaseServer.COMMON_SERVER);
		String communityID = Community.getCommunityIDbyCommunityName(community);
		int accountNumber = Customer.getAccountNumber(username);
		Customer.updateCommunityIDForAccount(communityID, ""+accountNumber);
	}
}