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

public class ContentSearch {
	public static final Logger logger = Logger.getLogger(ContentSearch.class.getName());

	public ContentSearch(){
		
	}
	
	public static String contentSearch(String username, String password, String accountNumber, String fileName, String path,String startBackupDate,String includeSubFolders, Boolean caseSensitive, String searchScope, String fileContent) throws Exception{
		logger.info("Search API:\n"+"username="+username+" password="+password+" accountNumber="+accountNumber+" fileName="+fileName+" path="+path+" startBackupDate="+startBackupDate+" includeSubFolders="+includeSubFolders);
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/retrievalset/search";
		//String uri = "/ManagementAPI/ManagementService.svc/accounts/101000298/retrievalset/search";
		//{"FileName":"test","Path":"C:\\kanawhaqa\\Kanahwa Test Data\\ContentSearch\\","StartBackupDate":"Most Recent","IncludeSubFolders":true,"bCaseSensitive":false,"SearchScope":0,"FileContent":""}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("FileName", fileName);
		jsonObj.put("Path", path);
		jsonObj.put("StartBackupDate", startBackupDate);
		jsonObj.put("IncludeSubFolders", includeSubFolders);
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