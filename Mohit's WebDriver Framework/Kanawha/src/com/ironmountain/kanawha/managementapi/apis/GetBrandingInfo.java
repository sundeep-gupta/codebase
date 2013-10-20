package com.ironmountain.kanawha.managementapi.apis;

import org.apache.log4j.Logger;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class GetBrandingInfo {
	private static final Logger logger = Logger.getLogger(GetBrandingInfo.class.getName());
	public GetBrandingInfo(){
		super();
    }
	
	//The getBrandingInfo method will get the current branding settings info.
	public static String getBrandingInfo(String username, String password, String accountNumber) throws Exception
	{
		logger.info("GetBrandingInfo API:\n"+"username="+username+" password="+password+" accountid="+accountNumber);
	
		String uri = "/ManagementAPI/ManagementService.svc/brandinginfo";
		String queryString = "?accountid="+accountNumber;
		String jsonContent = "";
		jsonContent = HttpClientDriver.triggerGetRequest(uri, username, password, queryString);
		//{"CommunityId":3,"Image":null,"MgmtSiteName":null,"bImageAvailable":false,"bPoweredByFlag":false}
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		return jsonContent;
	}
	
}
