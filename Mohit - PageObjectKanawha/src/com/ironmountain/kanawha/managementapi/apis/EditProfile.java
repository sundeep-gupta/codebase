package com.ironmountain.kanawha.managementapi.apis;

import java.util.HashMap;

import org.apache.http.entity.StringEntity;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class EditProfile {
	public static final Logger logger = Logger.getLogger(EditProfile.class.getName());

	public EditProfile() {
		
	}
	public static String getProfileDetails(String username,String password,String accountNumber) throws Exception
	{
		String uri = "/ManagementAPI/ManagementService.svc/profile";
		System.out.println(uri);
		String jsonContent = "";
		String query = ("?accountnumber="+accountNumber);
		jsonContent = HttpClientDriver.triggerGetRequest(uri, username, password,query);
		return jsonContent;	
	}
	public static String setProfileDetails(String username,String password,String accountNumber,HashMap<String, String> profileDetails) throws Exception{
		String uri = "/ManagementAPI/ManagementService.svc/profile";
		String queryString = "?accountnumber="+accountNumber;
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("Firstname", profileDetails.get("Firstname"));
		jsonObj.put("Middlename",profileDetails.get("Middlename"));
		jsonObj.put("Lastname",profileDetails.get("Lastname"));
		jsonObj.put("Company",profileDetails.get("Company"));
		jsonObj.put("Department",profileDetails.get("Department"));
		jsonObj.put("Location",profileDetails.get("Location"));
		jsonObj.put("MailStop",profileDetails.get("MailStop"));
		jsonObj.put("CostCenter",profileDetails.get("CostCenter"));
		jsonObj.put("EmployeeID",profileDetails.get("EmployeeID"));
		jsonObj.put("Country",profileDetails.get("Country"));
		jsonObj.put("Addressline1",profileDetails.get("Addressline1"));
		jsonObj.put("Addressline2",profileDetails.get("Addressline2"));
		jsonObj.put("Addressline3",profileDetails.get("Addressline3"));
		jsonObj.put("City",profileDetails.get("City"));
		jsonObj.put("State",profileDetails.get("State"));
		jsonObj.put("Zip",profileDetails.get("Zip"));
		jsonObj.put("Phonenumber",profileDetails.get("Phonenumber"));
		jsonObj.put("Extension",profileDetails.get("Extension"));
		jsonObj.put("CustomField1",profileDetails.get("CustomField"));
		
		//Printing the json String
		JSONArray jsonArr = new JSONArray();
		jsonArr.put(jsonObj);
		logger.info("Content Body Inputs Array\n"+jsonArr.toString());
		
		//Assigning the content body to string entity
		StringEntity contentBodyInputs;
		contentBodyInputs = new StringEntity(jsonObj.toString());

		//Triggering the post request
		String content = HttpClientDriver.triggerPostRequest(uri, username,password ,contentBodyInputs,queryString);
		ApiExceptionHandler.checkResponseForIssues(content);
		return content;
		
	}

}
