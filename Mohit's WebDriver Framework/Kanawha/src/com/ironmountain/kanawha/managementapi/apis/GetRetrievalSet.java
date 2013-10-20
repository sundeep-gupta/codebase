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

public class GetRetrievalSet {
	public static final Logger logger = Logger.getLogger(Login.class.getName());
	
	public GetRetrievalSet(){
		super();
	}
	
	public static String getRetrievalSet (String username, String password,String account,String path,String fileName,String backupDate)  throws Exception, JSONException, ClientProtocolException, IOException, InvalidKeyException, NoSuchAlgorithmException {
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+account+"/retrievalset/revisions/Most%20Recent/download/ZIP%20File%20-%20Restores%20data%20only";
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("Path", path);
		jsonObj.put("BackupDate", backupDate);
		jsonObj.put("Filename", fileName);
		
		JSONArray jsonArr = new JSONArray();
		jsonArr.put(jsonObj);
		logger.info("Header Inputs Array\n"+jsonArr.toString());
		
		StringEntity headerInputs;
		headerInputs = new StringEntity(jsonArr.toString());
		
		String content = HttpClientDriver.triggerPostRequest(uri, username, password, headerInputs);
		ApiExceptionHandler.checkResponseForIssues(content);
		return content;
	}
}
