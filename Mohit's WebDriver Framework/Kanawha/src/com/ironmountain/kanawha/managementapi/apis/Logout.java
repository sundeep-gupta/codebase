package com.ironmountain.kanawha.managementapi.apis;

import org.apache.http.entity.StringEntity;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.kanawha.managementapi.ManagementApi;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class Logout extends ManagementApi{
	
	public static final Logger logger = Logger.getLogger(Logout.class.getName());
	public static String Uri = "/ManagementAPI/ManagementService.svc/Logout";
	
	public Logout() throws Exception {
		super();
	}
	
	public static String logout (String username, String password) throws Exception {
		
		String content = HttpClientDriver.triggerGetRequest(Uri, username, password, "");
		ApiExceptionHandler.checkResponseForIssues(content);
		return content;
	}	
}//End of Login
