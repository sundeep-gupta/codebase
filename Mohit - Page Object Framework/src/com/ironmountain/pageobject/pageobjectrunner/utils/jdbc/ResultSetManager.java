package com.ironmountain.pageobject.pageobjectrunner.utils.jdbc;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.ListUtils;

/**
 * This class will do some meta data and common operations with the Resultset Object returned by QueryExecutor
 * 
 * @author Jinesh Devasia
 *
 */
public class ResultSetManager {

	private static Logger  logger      = Logger.getLogger("com.imd.connected.webuitest.utils.jdbc.ResultsetManager");
	
	/**
	 * Close the ResultSet Object
	 * 
	 * @param resultSet
	 */
	public static void closeResultSet(ResultSet resultSet){
		try {
			if(resultSet != null){
				resultSet.close();
			}			
		} catch (Exception e) {
			logger.error("Error found while closing the resultset:", e);
		}
	}

	/**
	 * To Get the Column headers from the Resultset
	 * Note that this method is not processing the ResultSet so you will be able to use the result set again.
	 * 
	 * @param resultSet
	 * @return
	 */
	public static String[] getColumnHeadersFromResultset(ResultSet resultSet){
		String[] headers = null;
		ResultSetMetaData meta = null;
		try {
			meta = resultSet.getMetaData();
			int noOfColumns = meta.getColumnCount();
			headers = new String [noOfColumns];		
		    for (int i = 1; i<=noOfColumns ; i++) {		    	
		    	headers[i-1] = meta.getColumnName(i);
		    	logger.debug("Column Header is: " + meta.getColumnName(i));
		   }	
		}
		catch (SQLException e) {
			logger.error("Error while getting table headers.." + e);
		}
		return headers;			
	}
	
	/**
	 * Get the values of a particular column which holds the String values
	 * 
	 * @param resultSet
	 * @param columnvalues
	 * @return
	 */
	public static ArrayList<String> getStringColumnValues(ResultSet resultSet, String columnLabel){
		
		ArrayList< String> columnValues = new ArrayList<String>();
		try {
			while (resultSet.next()) {				
				logger.debug("Column value for the row is:"  + resultSet.getString(columnLabel));
				columnValues.add(resultSet.getString(columnLabel));	
			}			
		}
		catch (Exception e) {
			logger.error("Error while getting table headers.." + e);
		}
		finally{
			closeResultSet(resultSet);
		}
		return columnValues;			
	}
    public static int[] getIntegerColumnValues(ResultSet resultSet, String columnLabel){
		
		ArrayList< String> vList = new ArrayList<String>();
		try {
			while (resultSet.next()) {				
				logger.debug("Column value for the row is: "  + resultSet.getInt(columnLabel));
				vList.add(resultSet.getString(columnLabel));	
			}			
		}
		catch (Exception e) {
			logger.error("Error while getting table headers.." + e);
		}
		finally{
			closeResultSet(resultSet);
		}
		return ListUtils.getStringListAsIntArray(vList);			
	}
	
	/**
	 * Get the number of columns in the ResultSet. 
	 * Note that the ResultSet will be closed once its processed. You will not be able to use the ResultSet again * 
	 * 
	 * @param resultSet
	 * @return
	 */
	public static int getNoOfRowsInResultSet(ResultSet resultSet){
		int rowCount = 0;
		try {
			while (resultSet.next()) {
				rowCount ++ ;
			}
		}
		catch (Exception e) {
			logger.error("Error while finding Rows in Resultset.." + e);
		}
		finally{
			closeResultSet(resultSet);
		}
		return rowCount;
	}
	
	/**Methos that returns the value of a particular column by the row number.
	 * @author pjames
	 * @param resultSet
	 * @param rowCount
	 * @param colString
	 * @return
	 */
	public static String getColValueByRowValue(ResultSet resultSet, int rowCount, String colString){
		String colVal = null;
		try{
		resultSet.absolute(rowCount);
		resultSet.refreshRow();
		colVal = resultSet.getString(colString);
		}
		catch (Exception e){
			logger.error("Error while finding the column value of the Row" + e);
		}
		finally {
			closeResultSet(resultSet);
		}
		return colVal;
	}
		
	/**
	 * This method will get the date field from a Table and return as String value
	 * 
	 * @param resultSet
	 * @param columnLabel
	 * @return
	 */
	public static String[] getDateColumnValues(ResultSet resultSet, String columnLabel){
		ArrayList<String> dList = new ArrayList<String>();
		try {
			while (resultSet.next()) {				
				logger.debug("Column value for the row is: "  + resultSet.getString(columnLabel));
				dList.add(resultSet.getString(columnLabel));	
			}			
		}
		catch (Exception e) {
			logger.error("Error while getting table headers.." + e);
		}
		finally{
			closeResultSet(resultSet);
		}
		return ListUtils.getStringListAsArray(dList);
	}
		
	

}
