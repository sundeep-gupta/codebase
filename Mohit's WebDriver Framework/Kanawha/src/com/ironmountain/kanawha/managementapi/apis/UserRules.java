package com.ironmountain.kanawha.managementapi.apis;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.entity.StringEntity;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;

public class UserRules {
	private static final Logger logger = Logger.getLogger(UserRules.class.getName());
	public UserRules(){
		super();
    }
	
	//The getUserRules method will get the User Rules depending on the parameter passed. It requires accountNumber and rulesCategory as the input parameter.
	public static String getUserRules(String username, String password, String accountNumber, String rulesCategory) throws Exception
	{
		logger.info("User Rules API:\n"+"username="+username+" password="+password+" accountNumber="+accountNumber);
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/rules/"+rulesCategory;
		String jsonContent = "";
		jsonContent = HttpClientDriver.triggerGetRequest(uri, username, password, "");
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		return jsonContent;
	}
	
	//The setUserRules method creates/deletes or modifies rules based on the input parameter values for a given accountNumber
	@SuppressWarnings("unchecked")
	public static String setUserRules(String username, String password, String accountNumber, String rulesCategory, String AfterFileCreatedDate, String AfterFileModifiedDate, int[] BasicRules,String BeforeFileCreatedDate,String BeforeFileModifiedDate,int Category,String ExcludeFileExtension,long ExcludeFileSize, String ExcludeFolderPath, int FileCreatedWithinLastSpecificDays, String FileExtension,int FileModifiedWithinLastSpecificDays,String FileName,String FolderPath,int Id,String Name,int RuleType, int RuleOrder) throws Exception
	{
		logger.info("User Rules API:\n"+"username="+username+" password="+password+" accountNumber="+accountNumber);
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/rules/"+rulesCategory;
				
		JSONObject jsonObj = new JSONObject();
		Map jsonMap = new HashMap();
		JSONArray jarr = new JSONArray();
		jsonMap.put("AfterFileCreatedDate", AfterFileCreatedDate);
		jsonMap.put("AfterFileModifiedDate", AfterFileModifiedDate);
		jsonMap.put("BasicRules", BasicRules);
		jsonMap.put("BeforeFileCreatedDate", BeforeFileCreatedDate);
		jsonMap.put("BeforeFileModifiedDate", BeforeFileModifiedDate);
		jsonMap.put("Category", Category);
		jsonMap.put("ExcludeFileExtension", ExcludeFileExtension);
		jsonMap.put("ExcludeFileSize", ExcludeFileSize);
		jsonMap.put("ExcludeFolderPath", ExcludeFolderPath);
		jsonMap.put("FileCreatedWithinLastSpecificDays", FileCreatedWithinLastSpecificDays);
		jsonMap.put("FileExtension", FileExtension);
		jsonMap.put("FileModifiedWithinLastSpecificDays", FileModifiedWithinLastSpecificDays);
		jsonMap.put("FileName", FileName);
		jsonMap.put("FolderPath", FolderPath);
		jsonMap.put("Id", Id);
		jsonMap.put("Name", Name);
		jsonMap.put("RuleType", RuleType);
		jsonMap.put("RuleOrder", RuleOrder);
		jarr.put(jsonMap);
		jsonObj.put("Rules", jarr);
		
		
		JSONArray jsonArr = new JSONArray();
		jsonArr.put(jsonObj);
		logger.info("Content Body Inputs Array\n"+jsonArr.toString());
			
		logger.info("Header Inputs\n"+jsonObj.toString());
		
		StringEntity headerInputs;
		headerInputs = new StringEntity(jsonObj.toString());
		
		String jsonContent = HttpClientDriver.triggerPostRequest(uri, username, password, headerInputs);
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		return jsonContent;		
	}
	
}