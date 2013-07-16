package com.ironmountain.kanawha.managementapi.apis;


import org.apache.http.entity.StringEntity;
import org.apache.log4j.Logger;
import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.kanawha.managementapi.ManagementApi;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;


/** Agent Rules Management API Specific Class
 * @author somasekhar.bobba@ironmountain.com
 * 
 */
public class AgentRules extends ManagementApi{
	
	private static final Logger logger = Logger.getLogger(AgentRules.class.getName());
	
	
	
	public AgentRules() throws Exception{
		super();
    }
		
	 /** This getAgentRules method sends an HTTP GET Request to the gets the Agent Rules for a given accountNumber
     * @param username: Used for authentication of the send request 
     * @param password: Used for authentication of the send request 
     * @param accountNumber : Used to get the Rules for the given account number
     * @return String : returns the response in the format of json string 
     * @throws Exception
     */
	public static String getAgentRules(String username, String password, String accountNumber) throws Exception
	{
		logger.info("Agent Rules API:\n"+"username="+username+" password="+password+" accountNumber="+accountNumber);
		
		String jsonContent;
		String URI_TEMPLATE_GET_AGENT_RULES = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/agentpreferences/AgentPrefRules";
		
		
		// Set Null content for the HTTP Get Request  
		String httpRequestBody = "";
		
		
		// Trigger the get request with all inputs.
		jsonContent = HttpClientDriver.triggerGetRequest(URI_TEMPLATE_GET_AGENT_RULES, username, password, httpRequestBody);
		
		// Check for the custom exceptions defined in the json content received.
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		
		return jsonContent;
	}
	
	
	 /** This setAgentRules method sends an HTTP POST Request to the set the Agent Rules for a given accountNumber
     * @param username: Used for authentication of the send request 
     * @param password: Used for authentication of the send request 
     * @param accountNumber : Used to get the Rules for the given account number
     * @param RulesString : content of the http request for the Rules to be set in the json string format. 
     * @return String : returns the response in the format of json string 
     * @throws Exception
     */
	public static String setAgentRules(String username, String password, String accountNumber, String RulesString) throws Exception

	{
		
		logger.info("Agent Rules API:\n"+"username="+username+" password="+password+" accountNumber="+accountNumber+" RulesString="+RulesString);
		
		String URI_TEMPLATE_SET_AGENT_Rules = "/ManagementAPI/ManagementService.svc/accounts/"+accountNumber+"/agentpreferences/AgentPrefRules";
		
		
		// Form the request body for the POST request.
		StringEntity httpRequestBody;
		httpRequestBody = new StringEntity(RulesString);
		
		// Trigger the post request with all inputs.
		String jsonContent = HttpClientDriver.triggerPostRequest(URI_TEMPLATE_SET_AGENT_Rules, username, password, httpRequestBody);
		
		// Check for the custom exceptions defined in the json content received
		ApiExceptionHandler.checkResponseForIssues(jsonContent);
		
		return jsonContent;		
	}

}