package com.ironmountain.kanawha.managementapi.apis;


import org.apache.http.entity.StringEntity;
import org.apache.log4j.Logger;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.kanawha.managementapi.ManagementApi;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;


/** Schedule Management API Specific Class
 * @author somasekhar.bobba@ironmountain.com
 * 
 */
public class AgentSchedule extends ManagementApi{
	
	private static final Logger logger = Logger.getLogger(AgentSchedule.class.getName());
	
	
	public AgentSchedule(){
		super();
    }
		
	 /** This getAgentSchedule method sends an HTTP GET Request to the gets the Agent schedule for a given accountNumber
     * @param username: Used for authentication of the send request 
     * @param password: Used for authentication of the send request 
     * @param accountNumber : Used to get the schedule for the given account number
     * @return String : returns the response in the format of json string 
     * @throws Exception
     */
	public static String getAgentSchedule(String username, String password, String accountNumber) throws Exception
	{
		logger.info("Agent Schedule API:\n"+"username="+username+" password="+password+" accountNumber="+accountNumber);
		
		String jsonContent;
		String URI_TEMPLATE_GET_AGENT_SCHEDULE = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/agentpreferences/AgentPrefSchedule";

		// Set Null content for the HTTP Get Request  
		String httpRequestBody = "";
		
		
		// Trigger the get request with all inputs.
		jsonContent = HttpClientDriver.triggerGetRequest(URI_TEMPLATE_GET_AGENT_SCHEDULE, username, password, httpRequestBody);
		
		// Check for the custom exceptions defined in the json content received.
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		
		return jsonContent;
	}
	
	
	 /** This setAgentSchedule method sends an HTTP POST Request to the set the Agent schedule for a given accountNumber
     * @param username: Used for authentication of the send request 
     * @param password: Used for authentication of the send request 
     * @param accountNumber : Used to get the schedule for the given account number
     * @param scheduleString : content of the http request for the schedule to be set in the json string format. 
     * @return String : returns the response in the format of json string 
     * @throws Exception
     */
	public static String setAgentSchedule(String username, String password, String accountNumber, String scheduleString) throws Exception

	{
		
		logger.info("Agent Schedule API:\n"+"username="+username+" password="+password+" accountNumber="+accountNumber+" scheduleString="+scheduleString);
		
		String URI_TEMPLATE_SET_AGENT_SCHEDULE = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/agentpreferences/AgentPrefSchedule";
			
		// Form the request body for the POST request.
		StringEntity httpRequestBody;
		httpRequestBody = new StringEntity(scheduleString);
		
		// Trigger the post request with all inputs.
		String jsonContent = HttpClientDriver.triggerPostRequest(URI_TEMPLATE_SET_AGENT_SCHEDULE, username, password, httpRequestBody);
		
		// Check for the custom exceptions defined in the json content received
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		
		return jsonContent;		
	}

}