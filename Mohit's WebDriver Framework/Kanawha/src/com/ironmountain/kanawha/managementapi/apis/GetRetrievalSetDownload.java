package com.ironmountain.kanawha.managementapi.apis;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
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

public class GetRetrievalSetDownload  {
	public static final Logger logger = Logger.getLogger(GetRetrievalSetDownload.class.getName());
	
	public GetRetrievalSetDownload(){
		super();
	}
	//This method is not used and will be removing this code once the hudson runs are stable enough
	/*@SuppressWarnings("unchecked")
	public static String getRetrievalSet (String revision, String username, String password,String account,String path,String fileName,String backupDate)  throws Exception, JSONException, ClientProtocolException, IOException, InvalidKeyException, NoSuchAlgorithmException {
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+account+"/retrievalset/revisions/"+revision+"/retrieve/ZIP";
	
		JSONObject jsonObj = new JSONObject();
		Map jsonMap = new HashMap();
		JSONArray jarr = new JSONArray();
		jsonMap.put("Path", path);
		jsonMap.put("BackupDate", backupDate);
		jsonMap.put("Filename", fileName);
		jarr.put(jsonMap);
		jsonObj.put("fileList", jarr);
		jsonObj.put("password", password);
		
		
		JSONArray jsonArr = new JSONArray();
		jsonArr.put(jsonObj);
		logger.info("Content Body Inputs Array\n"+jsonArr.toString());
		
		StringEntity headerInputs;
		headerInputs = new StringEntity(jsonObj.toString());
		
		String content = HttpClientDriver.triggerPostRequest(uri, username, password, headerInputs);
		ApiExceptionHandler.checkResponseForIssues(content);
		return content;
	}*/
	
	@SuppressWarnings("unchecked")
	public static String getRetrievalSet (String revision, String username, String password,String account,ArrayList<HashMap<String,String>> fileDetails,String[] backupDate,int noOfFiles)  throws Exception, JSONException, ClientProtocolException, IOException, InvalidKeyException, NoSuchAlgorithmException {
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+account+"/retrievalset/revisions/"+revision+"/retrieve/ZIP";
	
		JSONObject jsonObj = new JSONObject();
		
		String fileName;
		JSONArray jarr = new JSONArray();
		int arrayListLength =fileDetails.size();
		System.out.println(arrayListLength);
		for(int index=0;index<arrayListLength;index++){
		HashMap<String, String> hashmaptemp = fileDetails.get(index);
	
		//Getting key values out of the hash map
		logger.info("Getting key values from the hash map");
		java.util.Set<String> SetTemp = hashmaptemp.keySet();
		Object[] object1=SetTemp.toArray();
		logger.info(object1[0]);
		fileName = hashmaptemp.get(object1[0]);
			
		Map jsonMap = new HashMap();
		System.out.println(object1[0]);
		jsonMap.put("Filename",fileName );
		//backupdate is null for folders
		if(backupDate==null){
			jsonMap.put("BackupDate","");
		}
		//backup date is not null for files in a folder
		else{
		jsonMap.put("BackupDate", backupDate[index]);
		}
		System.out.println(object1[0]);
		jsonMap.put("Path", object1[0]);
		jarr.put(jsonMap);
		jsonObj.put("fileList", jarr);
		}
		jsonObj.put("password", password);
		
		JSONArray jsonArr = new JSONArray();
		jsonArr.put(jsonObj);
		logger.info("Content Body Inputs Array\n"+jsonArr.toString());
		
		StringEntity headerInputs;
		headerInputs = new StringEntity(jsonObj.toString());
		
		String content = HttpClientDriver.triggerPostRequest(uri, username, password, headerInputs);
		ApiExceptionHandler.checkResponseForIssues(content);
		return content;
	}

}
