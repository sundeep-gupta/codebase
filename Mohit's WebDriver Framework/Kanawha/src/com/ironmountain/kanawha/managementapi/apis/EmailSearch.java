package com.ironmountain.kanawha.managementapi.apis;

import java.util.Collection;

import org.apache.http.entity.StringEntity;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;

public class EmailSearch {
	public static final Logger logger = Logger.getLogger(EmailSearch.class.getName());

	public EmailSearch(){
		super();
	}
	
	public static String emailSearch(String username, String password, String accountNumber, String fileName, String path,String startBackupDate,Boolean includeSubFolders, Boolean caseSensitive, String searchScope, String fileContent) throws Exception{
		logger.info("Search API:\n"+"username="+username+" password="+password+" accountNumber="+accountNumber+" fileName="+fileName+" path="+path+" startBackupDate="+startBackupDate+" includeSubFolders="+includeSubFolders);
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/retrievalset/search";
		//String uri = "/ManagementAPI/ManagementService.svc/accounts/101000298/retrievalset/search";
		//{"FileName":"%","Path":"C:\\MyRoamRegressionData\\CommonTestData\\","StartBackupDate":"Most Recent","bIncludeSubFolders":false,"bCaseSensitive":false,"SearchScope":3,"FileContent":"test"}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("FileName", fileName);
		jsonObj.put("Path", path);
		jsonObj.put("StartBackupDate", startBackupDate);
		jsonObj.put("bIncludeSubFolders", includeSubFolders);
		jsonObj.put("bCaseSensitive", caseSensitive);
		jsonObj.put("SearchScope", searchScope);
		jsonObj.put("FileContent", fileContent);
		logger.info("Header Inputs\n"+jsonObj.toString());
		
		StringEntity headerInputs;
		headerInputs = new StringEntity(jsonObj.toString());
		
		String jsonContent = HttpClientDriver.triggerPostRequest(uri, username, password, headerInputs);
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		return jsonContent;		
	}
	
	
}