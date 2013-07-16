package com.ironmountain.kanawha.managementapi.apis;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.entity.StringEntity;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

/** Change Password API
 * @author pjames
 *
 */
public class ChangeLogonInfo {
	
	
		public static final Logger logger = Logger.getLogger(ChangeLogonInfo.class.getName());
		
		public ChangeLogonInfo(){
			super();
		}
		
		@SuppressWarnings("unchecked")
		public static String setAccountPassword (String userName, String oldPassword, String newPassword)  throws Exception, JSONException, ClientProtocolException, IOException, InvalidKeyException, NoSuchAlgorithmException {
			String uri = "/ManagementAPI/ManagementService.svc/changelogoninfo";
		
			//Building the JSON content body
			JSONObject jsonObj = new JSONObject();
			//jsonObj.put("ConfirmPassword", newPassword);
			jsonObj.put("OldPassword", oldPassword);
			jsonObj.put("NewPassword", newPassword);
			jsonObj.put("Emailaddress", userName);
			
			//Printing the json String
			JSONArray jsonArr = new JSONArray();
			jsonArr.put(jsonObj);
			logger.info("Content Body Inputs Array\n"+jsonArr.toString());
			
			//Assigning the content body to string entity
			StringEntity contentBodyInputs;
			contentBodyInputs = new StringEntity(jsonObj.toString());
			
			//Triggering the post request
			String content = HttpClientDriver.triggerPostRequest(uri, userName, oldPassword, contentBodyInputs);
			ApiExceptionHandler.checkResponseForIssues(content);
			return content;
		}
		
		public static String setAccountEmailID (String newUserName, String userName,String Password)  throws Exception, JSONException, ClientProtocolException, IOException, InvalidKeyException, NoSuchAlgorithmException {
			String uri = "/ManagementAPI/ManagementService.svc/changelogoninfo";
		
			//Building the JSON content body
			JSONObject jsonObj = new JSONObject();
			//jsonObj.put("ConfirmPassword", newPassword);
			jsonObj.put("Emailaddress", newUserName);
			
			//Printing the json String
			//JSONArray jsonArr = new JSONArray();
			//jsonArr.put(jsonObj);
			logger.info("Content Body Inputs Array\n"+jsonObj.toString());
			
			//Assigning the content body to string entity
			StringEntity contentBodyInputs;
			contentBodyInputs = new StringEntity(jsonObj.toString());
			
			//Triggering the post request
			String content = HttpClientDriver.triggerPostRequest(uri, userName, Password, contentBodyInputs);
			ApiExceptionHandler.checkResponseForIssues(content);
			return content;
		}


}
