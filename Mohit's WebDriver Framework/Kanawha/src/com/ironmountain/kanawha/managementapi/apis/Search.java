package com.ironmountain.kanawha.managementapi.apis;

import org.apache.http.entity.StringEntity;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class Search {
	public static final Logger logger = Logger.getLogger(Search.class.getName());

	public Search(){
		
	}
	
	public static String search(String username, String password, String accountNumber, String fileName,String path,String startBackupDate,String includeSubFolders) throws Exception{
		logger.info("Search API:\n"+"username="+username+" password="+password+" accountNumber="+accountNumber+" fileName="+fileName+" path="+path+" startBackupDate="+startBackupDate+" includeSubFolders="+includeSubFolders);
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/retrievalset/search";
		//String uri = "/ManagementAPI/ManagementService.svc/accounts/101000298/retrievalset/search";
		//{"FileName":"file","Path":"C:\\","StartBackupDate":"Most Recent","IncludeSubFolders":true}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("FileName", fileName);
		jsonObj.put("Path", path);
		jsonObj.put("StartBackupDate", startBackupDate);
		jsonObj.put("bIncludeSubFolders", includeSubFolders);
		logger.info("Header Inputs\n"+jsonObj.toString());
		
		StringEntity headerInputs;
		headerInputs = new StringEntity(jsonObj.toString());
		
		String jsonContent = HttpClientDriver.triggerPostRequest(uri, username, password, headerInputs);
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		return jsonContent;		
	}
	
}
