package com.ironmountain.kanawha.managementapi.apis;

import org.apache.http.entity.StringEntity;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;

public class AgentSettings {
	private static final Logger logger = Logger.getLogger(AgentSettings.class.getName());
	public AgentSettings(){
		super();
    }
	
	//The getAgentSettings method will get the current agent settings. It requires accountNumber as the input parameter.
	public static String getAgentSettings(String username, String password, String accountNumber) throws Exception
	{
		logger.info("Agent Settings API:\n"+"username="+username+" password="+password+" accountNumber="+accountNumber);
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/agentpreferences/common";
		String jsonContent = "";
		jsonContent = HttpClientDriver.triggerGetRequest(uri, username, password, "");
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		return jsonContent;
	}
	
	//The setAgentSettings method set the Agent settings options based on the input values for ManualBackupOverDialup,BackupOverDialup and ShowTaskbarIcon for a given accountNumber   
	public static String setAgentSettings(String username, String password, String accountNumber, String manualBackupOverDialup, String backupOverdialup, String showTaskbar) throws Exception
	{
		logger.info("Agent Settings API:\n"+"username="+username+" password="+password+" accountNumber="+accountNumber);
		String uri = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/agentpreferences/common";
				
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("ManualBackupOverDialup", manualBackupOverDialup);
		jsonObj.put("BackupOverDialup", backupOverdialup);
		jsonObj.put("ShowTaskbarIcon", showTaskbar);
		logger.info("Header Inputs\n"+jsonObj.toString());
		
		StringEntity headerInputs;
		headerInputs = new StringEntity(jsonObj.toString());
		
		String jsonContent = HttpClientDriver.triggerPostRequest(uri, username, password, headerInputs);
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		return jsonContent;		
	}
	
}