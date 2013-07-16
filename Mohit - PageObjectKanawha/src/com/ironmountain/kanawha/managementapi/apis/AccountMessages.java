package com.ironmountain.kanawha.managementapi.apis;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.entity.StringEntity;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class AccountMessages {
	public static final Logger logger = Logger.getLogger(ChangeLogonInfo.class.getName());

	public AccountMessages() {
		
	}
	public static String getAccountMessages(String username,String password,int accountNumber) throws Exception
	{
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/messages";
		System.out.println(uri);
		String jsonContent = "";
		jsonContent = HttpClientDriver.triggerGetRequest(uri, username, password, "");
		return jsonContent;	
	}
		public static String setMessageStatus (String userName, String password, ArrayList<HashMap<String,String>> messageInfo, String accountNumber)  throws Exception, JSONException, ClientProtocolException, IOException, InvalidKeyException, NoSuchAlgorithmException {
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/messages";
			
		//Building the JSON content body
		JSONObject jsonObj = new JSONObject();
		int arrayListLength = messageInfo.size();
		for(int index=0;index<arrayListLength;index++){
		HashMap<String, String> hashmaptemp = messageInfo.get(index);
	
		//Getting key values out of the hash map
		logger.info("Getting key values from the hash map");
		java.util.Set<String> SetTemp = hashmaptemp.keySet();
		Object[] object1=SetTemp.toArray();
		logger.info(object1[0]);
		
		//Getting the values from the hash map using the key values
		logger.info("Getting the values from the hash map using the key values");
		String messageStatus = hashmaptemp.get(object1[0]);
		logger.info(messageStatus);
		String messageId=(String) object1[0];
		logger.info(messageId);
		logger.info(messageStatus);
		jsonObj.put("MessageId", messageId);
		jsonObj.put("MessageState", messageStatus);
		}	
			
		//Printing the json String
		JSONArray jsonArr = new JSONArray();
		jsonArr.put(jsonObj);
		logger.info("Content Body Inputs Array\n"+jsonArr.toString());
			
		//Assigning the content body to string entity
		StringEntity contentBodyInputs;
		contentBodyInputs = new StringEntity(jsonArr.toString());
			
		//Triggering the post request
		String content = HttpClientDriver.triggerPostRequest(uri, userName,password ,contentBodyInputs);
		ApiExceptionHandler.checkResponseForIssues(content);
		return content;
			
		}

	}


