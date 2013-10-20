package com.ironmountain.kanahwa.exceptions.handler;

import java.util.HashMap;

import org.apache.log4j.Logger;

public class ApiExceptionHandler {
	private static final Logger logger = Logger.getLogger(ApiExceptionHandler.class.getName());
	static HashMap<String, String> imdStatusCodeMap = new HashMap<String, String>();
	static String responseString = null;
	
	public static void checkResponseForIssues(String response) throws Exception{
		responseString = response;
		ImdStatusCodeMap();
		//Iterating through the Status Code Map.
		for(String status : imdStatusCodeMap.keySet()){
			 if (responseString.contains(status)){
		    	logger.info("The request failed with the status code "+ status + " and the reason is "+ imdStatusCodeMap.get(status));
		    	break;
		    	}

		}
	}
	
	public static String getErrorMessage( String errorCode )
	{
		ImdStatusCodeMap();
		return imdStatusCodeMap.get( errorCode );
	}
	
	//Creating a Error Code Map and Initialising it
	static void ImdStatusCodeMap(){
		imdStatusCodeMap.put("1000", "Authentication Failed!");
	    imdStatusCodeMap.put("1001", "User Not Found");
	    imdStatusCodeMap.put("1002", "Invalid Hash Exception");
	    imdStatusCodeMap.put("1003", "Internal Server Error");
	    imdStatusCodeMap.put("1004", "OutFlow Exception/Please check the URI/There may be an invalid parameter in URI");
	    imdStatusCodeMap.put("1005", "Bad Request Exception");
	    imdStatusCodeMap.put("1006", "Invalid Query Parameters");
	    imdStatusCodeMap.put("1007", "Invalid Body Parameters");
	    imdStatusCodeMap.put("1008", "No Data To Retrieve");
	    imdStatusCodeMap.put("1009", "Permission Denied");
	    imdStatusCodeMap.put("1010", "Not Applicable");
	    imdStatusCodeMap.put("1011", "Account Inconsistent Error");
	    imdStatusCodeMap.put("1012", "Retrieve Authentication Failed");
	    imdStatusCodeMap.put("1013", "Expected Data Not Found");
	    imdStatusCodeMap.put("1014", "Entity Framework Error In EntityClient");
	    imdStatusCodeMap.put("1015", "Password Validation Failed");
	    imdStatusCodeMap.put("1016", "LDAP Account Change Password Failed");
	    imdStatusCodeMap.put("1017", "Password Policy Failed");
	}

	
}
