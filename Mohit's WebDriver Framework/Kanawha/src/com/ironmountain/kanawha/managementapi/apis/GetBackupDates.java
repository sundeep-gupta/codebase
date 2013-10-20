package com.ironmountain.kanawha.managementapi.apis;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class GetBackupDates {
	
	
	public GetBackupDates()
	{
		
	}
	public static String getBackupDates(String username,String password,String accountNumber) throws Exception
	{
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/backupdates";
		String jsonContent = "";
		jsonContent = HttpClientDriver.triggerGetRequest(uri, username, password, "");
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		return jsonContent;	
	}
}
