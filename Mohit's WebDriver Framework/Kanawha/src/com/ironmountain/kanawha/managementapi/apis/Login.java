package com.ironmountain.kanawha.managementapi.apis;

import org.apache.http.entity.StringEntity;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.kanawha.managementapi.ManagementApi;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class Login extends ManagementApi{
	
	public static final Logger logger = Logger.getLogger(Login.class.getName());
	public static String Uri = "/ManagementAPI/ManagementService.svc/Login";
	
	public Login() throws Exception {
		super();
	}
	
	public static String login (String username, String password) throws Exception {
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("LoginUsername", username);
		jsonObj.put("LoginPassword", password);
		
		StringEntity headerInputs;
		headerInputs = new StringEntity(jsonObj.toString());
		
		String content = HttpClientDriver.triggerLoginPostRequest(Uri, username, password, headerInputs);
		ApiExceptionHandler.checkResponseForIssues(content);
		return content;
	}	
}//End of Login
