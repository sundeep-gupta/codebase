package com.ironmountain.kanawha.managementapi.apis;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class ContactSupport  {
	public static final Logger logger = Logger.getLogger(ContactSupport.class.getName());

	public ContactSupport() {
		
	}
	public static String getSupportInfo(String username,String password,int accountNumber) throws Exception
	{
		String uri = "/ManagementAPI/ManagementService.svc/supportinformation";
		System.out.println(uri);
		String jsonContent = "";
		String query = ("?accountid="+accountNumber);
		jsonContent = HttpClientDriver.triggerGetRequest(uri, username, password,query);
		return jsonContent;	
	}
}
