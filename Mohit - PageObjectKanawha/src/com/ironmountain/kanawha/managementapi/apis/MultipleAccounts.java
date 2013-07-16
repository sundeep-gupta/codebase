package com.ironmountain.kanawha.managementapi.apis;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.entity.StringEntity;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class MultipleAccounts {
	
	
	public static final Logger logger = Logger.getLogger(ChangeLogonInfo.class.getName());
	
	public MultipleAccounts(){
		super();
	}
	
	@SuppressWarnings("unchecked")
	public static String getAccounts(String userName, String password)  throws Exception, JSONException, ClientProtocolException, IOException, InvalidKeyException, NoSuchAlgorithmException {
		String uri = "/ManagementAPI/ManagementService.svc/accounts";
	
		//Triggering the Get request
		String content = HttpClientDriver.triggerGetRequest(uri, userName, password, "");
		ApiExceptionHandler.checkResponseForIssues(content);
		return content;
	}



}
