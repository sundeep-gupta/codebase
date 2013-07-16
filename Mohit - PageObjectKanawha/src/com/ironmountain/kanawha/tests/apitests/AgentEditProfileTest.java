package com.ironmountain.kanawha.tests.apitests;


import java.util.HashMap;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.testng.Assert;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.managementapi.apis.AgentSchedule;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class AgentEditProfileTest extends HttpJsonAppTest{

	public static final Logger logger = Logger.getLogger(Login.class.getName());
	
	
	// Create the Account and Get the Account Number details which will be used to run the test suite.
	@BeforeSuite(alwaysRun= true)
	public void startTestSuite() throws Exception {
		super.inithttpTest();
	}
	
	//.......... TestCase Execution Starts .........
	
	
	// Validate Default Schedule Options
	@Test(enabled = true)
	public void defaultScheduleOptions() throws Exception{
		
		logger.info("Start default Automatic Backup Schedule Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");	
		
		// Get AccountNumber from DB corresponding to the username
			accountNumber = getAcountNumberForTheUser(username );
			
		// Set the automatic Backup schedule to Empty or No Schedule.	
		//setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
		// Log in to the Web Application and Assert
			jsonContent = Login.login(username, password);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
			
		// Select the Automatic backup Option radio button- TBD
			
			
		 // Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringDefaultAutomaticBackupSchedule = reqresponse.toString();

		// Assert the response with what is set before
			Assert.assertEquals(stringDefaultAutomaticBackupSchedule,defaultAutomaticBackupSchedule,"Schedule Not Matching With The Default Value");
			
			logger.info("End of default Automatic Backup Schedule Test");		

        
		 
		
}

	
	// Supporting Functions

    // Set the Default Schedule to Empty
	private void setDefaultScheduleToEmpty(String username, String password, String accountNumberString, String defaultAutomaticBackupSchedule)throws Exception{
		
		logger.info("Start Default AgentSchedule To Empty [ No Schedule ]");
		
	// Declaration and Initialisation
		String jsonContent;
		
	// Log in to the Web Application and Assert
		jsonContent = Login.login(username, password);
	//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
	// Set the Automatic backup Schedule to Empty and Assert for 
		jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumberString, defaultAutomaticBackupSchedule);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		
		
	}
	
	
	// Get the Account Number from DB for the User
	private String getAcountNumberForTheUser(String username ){
		
		logger.info("Getting the AccountNumber for the User Details Provided ");
		int accountNumber;
		String  accountNumberString;
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(username);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+username+"accountnumber="+accountNumber);
		
		return accountNumberString;
	}
	
	// Get the parameter Value for the Parameter Name Provided.
	
	// Get the paramValue from the testName and parameter name of the data provider.
	private String getParamValue( String testName, String paramName){
		
		//Declaration and  Initilization
		HashMap<String, String> testInputHandler = new HashMap<String,String>();
		String paramValue;
		
		//Loading the TestData Provider
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "AgentScheduleDataProvider.xml");
		
		//Getting input from test data provider for the given paramater name
		testInputHandler = TestDataProvider.getTestInput(testName);
		
		paramValue = testInputHandler.get(paramName);
		
		//Return the paramater Value
		return paramValue;
	}
	
	
	// Clean up Steps after running the test
	@AfterSuite(alwaysRun= true)
	public void stopTest() throws Exception {
}
}
	
