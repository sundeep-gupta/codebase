package com.ironmountain.pageobject.webobjects.connected.database.registry;

import java.sql.ResultSet;

import org.apache.log4j.Logger;
import com.ironmountain.pageobject.pageobjectrunner.utils.ListUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ResultSetManager;

/**
 * @author Jinesh Devasia
 * Table Object Class which represents the "CDQ" Table in the Register Database.
 *
 */
public class CdqTable extends RegistyDatabase{

	private static Logger  logger      = Logger.getLogger("com.imd.connected.database.registry.CdqTable");
	
	public static final String TABLE_NAME = "CDQ" ;
	
	public CdqTable(DatabaseServer dbServer){
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}	
	public CdqTable(ConnectionManager conMgr){
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}	
	/**
	 * Clean up the table
	 */
	public void clearTable(){
		super.clearTable(TABLE_NAME);
	}
	
	/**
	 * Get all the account numbers from CDQ Table
	 * 
	 * @return
	 */
	public int[] getAccountNumbers(){
		
		String columnName = "Account";
		String query = createSelectQuery(columnName,  TABLE_NAME, "");
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] accounts = ResultSetManager.getIntegerColumnValues(rs, columnName);
		return accounts ;	
	}
	
	/**
	 * Get the first account number from CDQ Table
	 * Useful when the test clean up the table before test and does the operation,In such cases there will be only 1 row,
	 * But be sure about the parallel processing of same tables
	 * 
	 * @return
	 */
	public int getAccountNumber(){
		int[] accounts = getAccountNumbers();
		return accounts[0] ;	
	}
    /**
     * Getting the media types from the Table
     * @return
     */
    public int[] getMediaTypes(){
		
		String columnName = "MediaType";
		String query = createSelectQuery(columnName,  TABLE_NAME, "");	
		logger.debug("MediaType Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] types = ResultSetManager.getIntegerColumnValues(rs, columnName);
		return types ;
	}
	/**
	 * Get the media type from first Row.
	 * @return
	 */
	public int getMediaType(){
		
		int[] types = getMediaTypes();
		return types[0] ;
	}
    /**
     * get the Shipping labels from CDQ Table
     * 
     * @return
     */
    public String[] getShippingLabels(){
		
		String columnName = "ShippingLabel";
		String query = createSelectQuery(columnName,  TABLE_NAME, "");		
		ResultSet rs = queryExecutor.executeQuery(query);
		String[] sLabels = ListUtils.getStringListAsArray(ResultSetManager.getStringColumnValues(rs, columnName));
		return sLabels ;
	}
    /**
     * get the First Shipping label from CDQ Table
     * 
     * @return
     */
    public String getShippingLabel(){		
		
		String[] sLabels = getShippingLabels();
		return sLabels[0] ;
	}
	/**
	 * Return true, if the specified shipping label is present in the table
	 * 
	 * @param shippingLabel
	 * @return
	 */
	public boolean isShippingLabelPresent(String shippingLabel){
		String[] sl = getShippingLabels();
		for (int i = 0; i < sl.length; i++) {
			if(sl[i].contains(shippingLabel)){
				return true;
			}
		}
		return false;
	}
	public String getLastMediaOrderDate(String accountNumber){
		String columnName = "ReqDate";
		String query = createSelectQuery(columnName,  TABLE_NAME, "Account =" + accountNumber);
		logger.debug("Acount Number Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		String[] dates = ResultSetManager.getDateColumnValues(rs, columnName);
		logger.debug("Last Mediaa Order date is: " + dates[(dates.length -1)]);
		return dates[(dates.length -1)];
	}
	public int getLastMediaOrderType(String accountNumber){
		String date = getLastMediaOrderDate(accountNumber);
		String columnName = "MediaType";
		String query = createSelectQuery(columnName,  TABLE_NAME, "ReqDate='" + date +"'");	
		logger.debug("MediaType Query generated: " + query);
		ResultSet rs = queryExecutor.executeQuery(query);
		int[] types = ResultSetManager.getIntegerColumnValues(rs, columnName);
		logger.debug("Last MediaType is: " + types[0]);
		return types[0] ;
	}
	
    
}
