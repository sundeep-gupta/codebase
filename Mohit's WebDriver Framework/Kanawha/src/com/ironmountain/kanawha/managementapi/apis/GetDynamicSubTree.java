package com.ironmountain.kanawha.managementapi.apis;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.entity.StringEntity;
import org.apache.log4j.Logger;
import org.json.JSONException;
import org.json.JSONObject;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class GetDynamicSubTree {
	public static final Logger logger = Logger.getLogger(Login.class.getName());
	
	public GetDynamicSubTree() throws Exception {
		super();
	}
	
	public static String getDynamicSubTree (String username, String password,String account,String backupDate,String type,String path) throws Exception, JSONException, ClientProtocolException, IOException, InvalidKeyException, NoSuchAlgorithmException {
		
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+account+"/retrievsubtree?backupDate="+backupDate+"&type="+type;
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("StartBackupDate", backupDate);
		jsonObj.put("Path", path);
		
		StringEntity headerInputs;
		headerInputs = new StringEntity(jsonObj.toString());

		String content = HttpClientDriver.triggerPostRequest(uri, username, password, headerInputs);
		ApiExceptionHandler.checkResponseForIssues(content);
		return content;
	}
}
