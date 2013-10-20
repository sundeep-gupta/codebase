package com.ironmountain.kanawha.managementapi.apis;

import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class History {

	public History()
	{
		
	}
	public static String viewHistory(String username,String password,int accountNumber) throws Exception
	{
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/accounthistory";
		String jsonContent = "";
		jsonContent = HttpClientDriver.triggerGetRequest(uri, username, password, "");
		return jsonContent;	
	}
}
