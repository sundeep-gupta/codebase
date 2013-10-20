package com.ironmountain.kanawha.managementapi.apis;

import org.apache.log4j.Logger;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class GetDevices {
	private static final Logger logger = Logger.getLogger(Search.class.getName());
	public static String uri = "/ManagementAPI/ManagementService.svc/devices"; 
	public GetDevices(){
		
	}
	public static String getDevices(String username, String password) throws Exception
	{
		String jsonContent = "";
		jsonContent = HttpClientDriver.triggerGetRequest(uri, username, password, "");
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		return jsonContent;
	}

}
