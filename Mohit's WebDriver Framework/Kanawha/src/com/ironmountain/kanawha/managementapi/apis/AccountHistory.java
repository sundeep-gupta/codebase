package com.ironmountain.kanawha.managementapi.apis;

import org.apache.log4j.Logger;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.kanawha.managementapi.ManagementApi;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class AccountHistory extends ManagementApi
{
	private static final Logger logger = Logger.getLogger(AccountHistory.class.getName());
	
	public AccountHistory() throws Exception
	{
		super();
    }

	public static String GetHistoryDates( String userName, String password, int accountNumber) throws Exception
	{
		logger.info("Account History GetHistoryDates API:\n"+"username="+userName+" password="+password+" accountNumber="+accountNumber);
		
		String jsonContent;
		String getHistoryDatesURI = "/ManagementAPI/ManagementService.svc/accounts/" + accountNumber + "/history/dates";
		
		
		// Set Null content for the HTTP Get Request  
		String httpRequestBody = "";
		
		
		// Trigger the get request with all inputs.
		jsonContent = HttpClientDriver.triggerGetRequest(getHistoryDatesURI, userName, password, httpRequestBody);
		
		// Check for the custom exceptions defined in the json content received.
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		
		return jsonContent;
	}
	
	public static String GetHistorySummary( String userName, String password, int accountNumber, String fromDate, String toDate ) throws Exception
	{
		logger.info("Account History GetHistorySummary API:\n"+"username="+userName+" password="+password+" accountNumber="+accountNumber+
				" from Date: "+fromDate+" to Date: "+toDate);
		
		String jsonContent;
		String getHistorySummaryURI = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/history/summary/from/"+fromDate+"/to/"+toDate;
		
		
		// Set Null content for the HTTP Get Request  
		String httpRequestBody = "";
		
		
		// Trigger the get request with all inputs.
		jsonContent = HttpClientDriver.triggerGetRequest(getHistorySummaryURI, userName, password, httpRequestBody);
		
		// Check for the custom exceptions defined in the json content received.
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		
		return jsonContent;
	}
	
	public static String GetHistoryNotifications( String userName, String password, int accountNumber, String date ) throws Exception
	{
		logger.info("Account History GetHistoryNotifications API:\n"+"username="+userName+" password="+password+" accountNumber="+accountNumber+" for Date: "+date);
		
		String jsonContent;
		String getHistoryNotificationsURI = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/history/notifications/"+date;
		
		
		// Set Null content for the HTTP Get Request  
		String httpRequestBody = "";
		
		
		// Trigger the get request with all inputs.
		jsonContent = HttpClientDriver.triggerGetRequest(getHistoryNotificationsURI, userName, password, httpRequestBody);
		
		// Check for the custom exceptions defined in the json content received.
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		
		return jsonContent;
	}
	
	public static String GetHistoryFileDetails( String userName, String password, int accountNumber, String date) throws Exception
	{
		logger.info("Account History GetHistoryFileDetails API:\n"+"username="+userName+" password="+password+" accountNumber="+accountNumber);
		
		String jsonContent;
		String getHistorySummaryURI = "/ManagementAPI/ManagementService.svc/accounts/" + accountNumber + "/history/filelist/" + date;
		
		
		// Set Null content for the HTTP Get Request  
		String httpRequestBody = "";
		
		
		// Trigger the get request with all inputs.
		jsonContent = HttpClientDriver.triggerGetRequest(getHistorySummaryURI, userName, password, httpRequestBody);
		
		// Check for the custom exceptions defined in the json content received.
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		
		return jsonContent;
	}

}
