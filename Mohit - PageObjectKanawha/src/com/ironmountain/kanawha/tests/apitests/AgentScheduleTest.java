package com.ironmountain.kanawha.tests.apitests;


import java.util.HashMap;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.testng.Assert;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.managementapi.apis.AgentSchedule;
import com.ironmountain.kanawha.managementapi.apis.ContactSupport;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.kanawha.managementapi.apis.Logout;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class AgentScheduleTest extends HttpJsonAppTest{

	public static final Logger logger = Logger.getLogger(Login.class.getName());
	String imdStatusCode = "";
	
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
			jsonReqContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, defaultAutomaticBackupSchedule);
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringDefaultAutomaticBackupSchedule = reqresponse.toString();

		// Assert the response with what is set before
			Assert.assertEquals(stringDefaultAutomaticBackupSchedule,defaultAutomaticBackupSchedule,"Schedule Not Matching With The Default Value");
			
			logger.info("End of default Automatic Backup Schedule Test");		

}

	
	//Validate Save Operations - Manual Backup 
	@Test(enabled = true)
	public void saveManualBackupOption() throws Exception{
		
		logger.info("Start saveManualBackupOption Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyManualBackupSchedule");
			
		
		// Get AccountNumber from DB corresponding to the username
			accountNumber = getAcountNumberForTheUser(username );
			
		// Log in to the Web Application and Assert
			jsonContent = Login.login(username, password);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");			
			
		 // Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, defaultAutomaticBackupSchedule);
			
		//Asserting for the response
			JSONAsserter.assertJSONObjects(jsonReqContent, "success", "true");
			
			logger.info("End of saveManualBackupOption Test");
		
	}
	 
	// Validate Save Operations - Automatic Backup
	@Test(enabled = true)
	public void saveAutomaticBackupOption() throws Exception{
		
		logger.info("Start saveAutomaticBackupOption Test");	

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
			jsonReqContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, defaultAutomaticBackupSchedule);
			
		//Asserting for the response
			JSONAsserter.assertJSONObjects(jsonReqContent, "success", "true");
			
			logger.info("End of saveAutomaticBackupOption Test");	
		
	}

	
	//  - BLOCKED - Validate the retrieval of the Saved Option - Manual Backup Option after page reload. 
	// Validate Retrieve Operations on Page Load - Manual Backup Option
	@Test(enabled = true)
	public void retrieveSavedManualBackupOptionOnPageReload() throws Exception{
		
		logger.info("Start saveAutomaticBackupOption Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyManualBackupSchedule");
			
		
		// Get AccountNumber from DB corresponding to the username
			accountNumber = getAcountNumberForTheUser(username );
			int accountNumberInt = Integer.parseInt(accountNumber);
			
		// Set the automatic Backup schedule to Empty or No Schedule.	
		//setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
		// Log in to the Web Application and Assert
			jsonContent = Login.login(username, password);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
			
		// Select the Automatic backup Option radio button- TBD
			
			
		 // Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, defaultAutomaticBackupSchedule);
			
		//Asserting for the response
			JSONAsserter.assertJSONObjects(jsonReqContent, "success", "true");
		
		//Calling different api for reload action
			ContactSupport.getSupportInfo(username, password, accountNumberInt);
		
		//Calling schedule api
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringDefaultAutomaticBackupSchedule = reqresponse.toString();

		// Assert the response with what is set before
				Assert.assertEquals(stringDefaultAutomaticBackupSchedule,defaultAutomaticBackupSchedule,"Schedule Not Matching With The Default Value");
			logger.info("End of saveAutomaticBackupOption Test");
		
	}
	 
	
	// Validate Retrieve Operations on Page Load - Automatic Backup Option
	@Test(enabled = true)
	public void retrieveSavedAutomaticBackupOptionOnPageReload() throws Exception{
		logger.info("Start saveAutomaticBackupOption Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
			
		
		// Get AccountNumber from DB corresponding to the username
			accountNumber = getAcountNumberForTheUser(username );
			int accountNumberInt = Integer.parseInt(accountNumber);
			
		// Set the automatic Backup schedule to Empty or No Schedule.	
		//setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
		// Log in to the Web Application and Assert
			jsonContent = Login.login(username, password);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");			
			
		 // Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, defaultAutomaticBackupSchedule);
			
		//Asserting for the response
			JSONAsserter.assertJSONObjects(jsonReqContent, "success", "true");
		
		//Calling different api for reload action
			ContactSupport.getSupportInfo(username, password, accountNumberInt);
		
		//Calling schedule api
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringDefaultAutomaticBackupSchedule = reqresponse.toString();

		// Assert the response with what is set before
				Assert.assertEquals(stringDefaultAutomaticBackupSchedule,defaultAutomaticBackupSchedule,"Schedule Not Matching With The Default Value");
			logger.info("End of saveAutomaticBackupOption Test");	
		
	}
	
	
   
	// Validate Retrieve Operations on user reLogin - Manual Backup Option
	@Test(enabled = true)
	public void retrieveSavedManualBackupOptionOnRelogin() throws Exception{

		logger.info("Start saveAutomaticBackupOption Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyManualBackupSchedule");
			
		
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
			jsonReqContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, defaultAutomaticBackupSchedule);
			
		//Asserting for the response
			JSONAsserter.assertJSONObjects(jsonReqContent, "success", "true");
		
		//Relogin to the same account
			Logout.logout(username, password);
			Login.login(username, password);
		
		//Calling schedule api
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringDefaultAutomaticBackupSchedule = reqresponse.toString();

		// Assert the response with what is set before
				Assert.assertEquals(stringDefaultAutomaticBackupSchedule,defaultAutomaticBackupSchedule,"Schedule Not Matching With The Default Value");
			logger.info("End of saveAutomaticBackupOption Test");	
	}

	
    
	// Validate Retrieve Operations on user reLogin - Automatic Backup Option
	@Test(enabled = true)
	public void retrieveSavedAutomaticBackupOptionOnRelogin() throws Exception{
		
		logger.info("Start saveAutomaticBackupOption Test");	

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
			jsonReqContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, defaultAutomaticBackupSchedule);
			
		//Asserting for the response
			JSONAsserter.assertJSONObjects(jsonReqContent, "success", "true");
		
		//Relogin to the same account
			Logout.logout(username, password);
			Login.login(username, password);
		
		//Calling schedule api
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringDefaultAutomaticBackupSchedule = reqresponse.toString();

		// Assert the response with what is set before
				Assert.assertEquals(stringDefaultAutomaticBackupSchedule,defaultAutomaticBackupSchedule,"Schedule Not Matching With The Default Value");
			logger.info("End of saveAutomaticBackupOption Test");	
	}

	
    //  Validate the option to disable the Backup schedule for the complete day.
	@Test(enabled = true)
	public void disableBackupScheduleADay() throws Exception{
	
		logger.info("Start disable Automatic Backup Schedule A Day Test");	

	// Declaration and Initialisation
		String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,backupScheduleADay = null;
		
	// Get the username ,password , defaultAutomaticbackupschedule from test data provider
		username = getParamValue("TestSuiteParameters","defaultUsername");
		password = getParamValue("TestSuiteParameters","defaultPassword");
		defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
		backupScheduleADay = getParamValue("TestSuiteParameters","disableBackupScheduleADayOnMonday");
	
	// Get AccountNumber from DB corresponding to the username
		accountNumber = getAcountNumberForTheUser(username );
		
	// Set the automatic Backup schedule to Empty or No Schedule.	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
	// Log in to the Web Application and Assert
		jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
	// Select the Automatic backup Option radio button- TBD
		
	
	// Set the  Automatic Backup Schedule to disable on Monday ( A Single day)
		jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, backupScheduleADay);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		
	 // Get the response for the get agent schedule request and compare with what is being set before
		jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
		
	// Convert the response to String
		JSONObject reqresponse = new JSONObject(jsonReqContent);
		String stringAutomaticBackupScheduleDay = reqresponse.toString();

	// Assert the response with what is set before
		Assert.assertEquals(stringAutomaticBackupScheduleDay,backupScheduleADay,"Schedule Not Matching With The Set Value");
		
	//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
		logger.info("End of disable Automatic Backup Schedule A Day Test");		

	}
	
	
	//  Validate the option to enable the Backup schedule for the complete day.
	@Test(enabled = true)
	public void enableBackupScheduleADay() throws Exception{
		
		logger.info("Start enable Automatic Backup Schedule A Day Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,disableBackupScheduleADay =null ,enableBackupScheduleADay = null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
			disableBackupScheduleADay = getParamValue("TestSuiteParameters","disableBackupScheduleADayOnMonday");
			enableBackupScheduleADay = getParamValue("TestSuiteParameters","enableBackupScheduleADayOnMonday");
		
		// Get AccountNumber from DB corresponding to the username
			accountNumber = getAcountNumberForTheUser(username );
			
		// Set the automatic Backup schedule to Empty or No Schedule 
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		    
		// Log in to the Web Application and Assert
			jsonContent = Login.login(username, password);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
			
	    // Disable the Automatic Backup Schedule on A Day ( On Monday so that it can be tested for enable later )
			jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, disableBackupScheduleADay);
			JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			
			
		// Select the Automatic backup Option radio button- TBD
			
		
		// Enable the Automatic Backup Schedule to enable on Monday ( A Single day)
			jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, enableBackupScheduleADay);
			JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			
		 // Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringAutomaticBackupScheduleDay = reqresponse.toString();

		// Assert the response with what is set before
			Assert.assertEquals(stringAutomaticBackupScheduleDay,enableBackupScheduleADay,"Schedule Not Matching With The Set Value");
			
		// Reset the automatic Backup schedule to Empty or No Schedule 
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		    
		
			logger.info("End of disable Automatic Backup Schedule A Day Test");		

	}
	
	
	// Validate the Disable Automatic backup for All days
	@Test(enabled = true)
	public void disableBackupScheduleAllDays() throws Exception{
		
		logger.info("Start disable Automatic Backup Schedule All Days Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,backupScheduleAllDays = null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
			backupScheduleAllDays = getParamValue("TestSuiteParameters","disableBackupScheduleAllDays");
		
		// Get AccountNumber from DB corresponding to the username
			accountNumber = getAcountNumberForTheUser(username );
			
		// Set the automatic Backup schedule to Empty or No Schedule.	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
		// Log in to the Web Application and Assert
			jsonContent = Login.login(username, password);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
			
		// Select the Automatic backup Option radio button- TBD
			
		
		// Set the  Automatic Backup Schedule to disable on All days
			jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, backupScheduleAllDays);
			JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			
		 // Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringAutomaticBackupScheduleDay = reqresponse.toString();

		// Assert the response with what is set before
			Assert.assertEquals(stringAutomaticBackupScheduleDay,backupScheduleAllDays,"Schedule Not Matching With The Set Value");
			
		//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
			logger.info("End of disable Automatic Backup Schedule All Days Test");		

	}
	
	
	// Validate the Enable Automatic Backups for ALL days
	@Test(enabled = true)
	public void enableBackupScheduleAllDays() throws Exception{
		
		logger.info("Start enable Automatic Backup Schedule All Days Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,backupScheduleAllDays = null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
			backupScheduleAllDays = getParamValue("TestSuiteParameters","enableBackupScheduleAllDays");
		
		// Get AccountNumber from DB corresponding to the username
			accountNumber = getAcountNumberForTheUser(username );
			
		// Set the automatic Backup schedule to Empty or No Schedule.	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
		// Log in to the Web Application and Assert
			jsonContent = Login.login(username, password);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
			
		// Select the Automatic backup Option radio button- TBD
			
		
		// Set the  Automatic Backup Schedule to disable on All days
			jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, backupScheduleAllDays);
			JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			
		 // Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringAutomaticBackupScheduleDay = reqresponse.toString();

		// Assert the response with what is set before
			Assert.assertEquals(stringAutomaticBackupScheduleDay,backupScheduleAllDays,"Schedule Not Matching With The Set Value");
			
		//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
			logger.info("End of enable Automatic Backup Schedule All Days Test");		

	}
	
	
	// Validate the Enable Selected Automatic Backups
	
	// Validate the Disable the Selected backup Schedule.
	@Test(enabled = true)
	public void disableSelectedBackupSchedule() throws Exception{
		logger.info("Start disable Selected Automatic Backup Schedule Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,backupScheduleAllDays = null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
			backupScheduleAllDays = getParamValue("TestSuiteParameters","disableSelectedBackupSchedule");
		
		// Get AccountNumber from DB corresponding to the username
			accountNumber = getAcountNumberForTheUser(username );
			
		// Set the automatic Backup schedule to Empty or No Schedule.	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
		// Log in to the Web Application and Assert
			jsonContent = Login.login(username, password);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
			
		// Select the Automatic backup Option radio button- TBD
			
		
		// Set the  Automatic Backup Schedule to disable on selected days and time.
			jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, backupScheduleAllDays);
			JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			
		 // Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringAutomaticBackupScheduleDay = reqresponse.toString();

		// Assert the response with what is set before
			Assert.assertEquals(stringAutomaticBackupScheduleDay,backupScheduleAllDays,"Schedule Not Matching With The Set Value");
			
		//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
			logger.info("End of disable Selected Automatic Backup Schedule Test");	

	}
	
	
	// Validate the disable Selected Automatic Backups
	
	// Validate the enable the Selected backup Schedule.
	@Test(enabled = true)
	public void enableSelectedBackupSchedule() throws Exception{
		
		logger.info("Start enable Selected Automatic Backup Schedule Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,selectedBackupSchedule = null ,diableScheduleAllDays =null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
			selectedBackupSchedule = getParamValue("TestSuiteParameters","enableSelectedBackupSchedule");
			diableScheduleAllDays = getParamValue("TestSuiteParameters","disableBackupScheduleAllDays");
		
		// Get AccountNumber from DB corresponding to the username
			accountNumber = getAcountNumberForTheUser(username );
			
		// Set the automatic Backup schedule to Empty or No Schedule.	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
		// Log in to the Web Application and Assert
			jsonContent = Login.login(username, password);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
			
		// Select the Automatic backup Option radio button- TBD
			
		
		// Set the  Automatic Backup Schedule to disable on All days so as to enable the selected schedule below.
			AgentSchedule.setAgentSchedule(username, password, accountNumber, diableScheduleAllDays);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			
		// Set the Selected Automatic backup Schedule 
			jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, selectedBackupSchedule);
			JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			
		// Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringAutomaticBackupScheduleDay = reqresponse.toString();

		// Assert the response with what is set before
			Assert.assertEquals(stringAutomaticBackupScheduleDay,selectedBackupSchedule,"Schedule Not Matching With The Set Value");
			
		//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
			logger.info("End of enable Selected Automatic Backup Schedule Test");	

	}
		
	
	// Validate the enable the Selected backup Schedule for All Days
	@Test(enabled = true)
	public void disableSelectedBackupScheduleAllDays() throws Exception{
		
		logger.info("Start disable Selected Automatic Backup Schedule All Days Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null  ,defaultAutomaticBackupSchedule =null ,backupScheduleAllDays = null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
			backupScheduleAllDays = getParamValue("TestSuiteParameters","disableSelectedBackupScheduleAllDays");
		
		// Get AccountNumber from DB corresponding to the username
			accountNumber = getAcountNumberForTheUser(username );
			
		// Set the automatic Backup schedule to Empty or No Schedule.	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,backupScheduleAllDays);
			
		// Log in to the Web Application and Assert
			jsonContent = Login.login(username, password);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
			
		// Select the Automatic backup Option radio button- TBD
			
		
		// Set the  Automatic Backup Schedule to disable on selected days and time.
			jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, backupScheduleAllDays);
			JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			
		 // Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringAutomaticBackupScheduleDay = reqresponse.toString();

		// Assert the response with what is set before
			Assert.assertEquals(stringAutomaticBackupScheduleDay,backupScheduleAllDays,"Schedule Not Matching With The Set Value");
			
		//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
			logger.info("End of disable Selected Automatic Backup Schedule All Days Test");	

		
	}
	
	
	// Validate the enable the Selected backup Schedule for All Days
	@Test(enabled = true)
	public void enableSelectedBackupScheduleAllDays() throws Exception{
		
		logger.info("Start enable Selected Automatic Backup ALl Days Schedule Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,selectedBackupSchedule = null ,diableScheduleAllDays =null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
			selectedBackupSchedule = getParamValue("TestSuiteParameters","enableSelectedBackupScheduleAllDays");
			diableScheduleAllDays = getParamValue("TestSuiteParameters","disableBackupScheduleAllDays");
		
		// Get AccountNumber from DB corresponding to the username
			accountNumber = getAcountNumberForTheUser(username );
			
		// Set the automatic Backup schedule to Empty or No Schedule.	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
		// Log in to the Web Application and Assert
			jsonContent = Login.login(username, password);
		//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
			
		// Select the Automatic backup Option radio button- TBD
			
		
		// Set the  Automatic Backup Schedule to disable on All days so as to enable the selected schedule below.
			AgentSchedule.setAgentSchedule(username, password, accountNumber, diableScheduleAllDays);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			
		// Set the Selected Automatic backup Schedule 
			jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, selectedBackupSchedule);
			JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			
		// Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringAutomaticBackupScheduleDay = reqresponse.toString();

		// Assert the response with what is set before
			Assert.assertEquals(stringAutomaticBackupScheduleDay,selectedBackupSchedule,"Schedule Not Matching With The Set Value");
			
		//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
			logger.info("End of enable Selected Automatic Backup All Days Schedule Test");	

	}

	
	// Validate the disabled Automatic Selected backup Schedule on Re login
	@Test(enabled = true)
	public void validateDisableSelectedBackupScheduleOnRelogin() throws Exception{
		
		logger.info("Start disable Selected Automatic Backup Schedule All Days Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null  ,defaultAutomaticBackupSchedule =null ,backupScheduleAllDays = null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
			backupScheduleAllDays = getParamValue("TestSuiteParameters","disableSelectedBackupScheduleAllDays");
		
		// Get AccountNumber from DB corresponding to the username
			accountNumber = getAcountNumberForTheUser(username );
			
		// Set the automatic Backup schedule to Empty or No Schedule.	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,backupScheduleAllDays);
			
		// Log in to the Web Application and Assert
			jsonContent = Login.login(username, password);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
			
		// Select the Automatic backup Option radio button- TBD
			
		
		// Set the  Automatic Backup Schedule to disable on selected days and time.
			jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, backupScheduleAllDays);
			JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			
		 // Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringAutomaticBackupScheduleDay = reqresponse.toString();

		// Assert the response with what is set before
			Assert.assertEquals(stringAutomaticBackupScheduleDay,backupScheduleAllDays,"Schedule Not Matching With The Set Value");
			
		//Relogin to the same account
			jsonContent=Logout.logout(username, password);
			jsonContent=Login.login(username, password);
		
		// Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Assert the response with what is set before
			Assert.assertEquals(stringAutomaticBackupScheduleDay,backupScheduleAllDays,"Schedule Not Matching With The Set Value");
			
		//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
			logger.info("End of disable Selected Automatic Backup Schedule All Days Test");	
	}
	
	// Validate the enabled Automatic Selected backup Schedule on Re login
	@Test(enabled = true)
	public void validateEnableSelectedBackupScheduleOnRelogin() throws Exception{
		logger.info("Start enable Selected Automatic Backup ALl Days Schedule Test");	

		// Declaration and Initialisation
			String username = null ,password = null ,jsonContent ,jsonReqContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,selectedBackupSchedule = null ,diableScheduleAllDays =null;
			
		// Get the username ,password , defaultAutomaticbackupschedule from test data provider
			username = getParamValue("TestSuiteParameters","defaultUsername");
			password = getParamValue("TestSuiteParameters","defaultPassword");
			defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
			selectedBackupSchedule = getParamValue("TestSuiteParameters","enableSelectedBackupScheduleAllDays");
			diableScheduleAllDays = getParamValue("TestSuiteParameters","disableBackupScheduleAllDays");
		
		// Get AccountNumber from DB corresponding to the username
			accountNumber = getAcountNumberForTheUser(username );
			
		// Set the automatic Backup schedule to Empty or No Schedule.	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
		// Log in to the Web Application and Assert
			jsonContent = Login.login(username, password);
		//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
			
		// Select the Automatic backup Option radio button- TBD
			
		
		// Set the  Automatic Backup Schedule to disable on All days so as to enable the selected schedule below.
			AgentSchedule.setAgentSchedule(username, password, accountNumber, diableScheduleAllDays);
			//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			
		// Set the Selected Automatic backup Schedule 
			jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, selectedBackupSchedule);
			JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
			
		// Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Convert the response to String
			JSONObject reqresponse = new JSONObject(jsonReqContent);
			String stringAutomaticBackupScheduleDay = reqresponse.toString();

		// Assert the response with what is set before
			Assert.assertEquals(stringAutomaticBackupScheduleDay,selectedBackupSchedule,"Schedule Not Matching With The Set Value");
			
		//Relogin to the same account
			jsonContent=Logout.logout(username, password);
			jsonContent=Login.login(username, password);
		
		// Get the response for the get agent schedule request and compare with what is being set before
			jsonReqContent = AgentSchedule.getAgentSchedule(username, password, accountNumber);
			
		// Assert the response with what is set before
			Assert.assertEquals(stringAutomaticBackupScheduleDay,selectedBackupSchedule,"Schedule Not Matching With The Set Value");
			
		//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
		    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
			
			logger.info("End of enable Selected Automatic Backup All Days Schedule Test");	
		
	}

	@Test(enabled = true)
	public void startTimeGreaterThan24Hrs() throws Exception{
	
		logger.info("Start disable Automatic Backup Schedule A Day Test");	

	// Declaration and Initialisation
		String username = null ,password = null ,jsonContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,startTimeLarge = null;
		
	// Get the username ,password , defaultAutomaticbackupschedule from test data provider
		username = getParamValue("TestSuiteParameters","defaultUsername");
		password = getParamValue("TestSuiteParameters","defaultPassword");
		defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
		startTimeLarge = getParamValue("TestSuiteParameters","startTimeLarge");
		imdStatusCode = getParamValue("TestSuiteParameters", "statusCode");
	
	// Get AccountNumber from DB corresponding to the username
		accountNumber = getAcountNumberForTheUser(username );
		
	// Set the automatic Backup schedule to Empty or No Schedule.	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
	// Log in to the Web Application and Assert
		jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
	// Select the Automatic backup Option radio button- TBD
		
	
	// Set the  Automatic Backup Schedule to disable on Monday ( A Single day)
		jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, startTimeLarge);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", imdStatusCode);
		
	 
	//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
		logger.info("End of disable Automatic Backup Schedule A Day Test");		

	}
	
	@Test(enabled = true)
	public void endTimeGreaterThan24Hrs() throws Exception{
	
		logger.info("Start disable Automatic Backup Schedule A Day Test");	

	// Declaration and Initialisation
		String username = null ,password = null ,jsonContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,endTimeLarge = null;
		
	// Get the username ,password , defaultAutomaticbackupschedule from test data provider
		username = getParamValue("TestSuiteParameters","defaultUsername");
		password = getParamValue("TestSuiteParameters","defaultPassword");
		defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
		endTimeLarge = getParamValue("TestSuiteParameters","endTimeLarge");
		imdStatusCode = getParamValue("TestSuiteParameters", "statusCode");
	
	// Get AccountNumber from DB corresponding to the username
		accountNumber = getAcountNumberForTheUser(username );
		
	// Set the automatic Backup schedule to Empty or No Schedule.	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
	// Log in to the Web Application and Assert
		jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
	// Select the Automatic backup Option radio button- TBD
		
	
	// Set the  Automatic Backup Schedule to disable on Monday ( A Single day)
		jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, endTimeLarge);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", imdStatusCode);
		
	 
	//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
		logger.info("End of disable Automatic Backup Schedule A Day Test");		

	}
	
	@Test(enabled = true)
	public void daysOfWeekGreaterThan7() throws Exception{
	
		logger.info("Start disable Automatic Backup Schedule A Day Test");	

	// Declaration and Initialisation
		String username = null ,password = null ,jsonContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,daysOfWeekLarge = null;
		
	// Get the username ,password , defaultAutomaticbackupschedule from test data provider
		username = getParamValue("TestSuiteParameters","defaultUsername");
		password = getParamValue("TestSuiteParameters","defaultPassword");
		defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
		daysOfWeekLarge = getParamValue("TestSuiteParameters","dayOfWeekLarge");
		imdStatusCode = getParamValue("TestSuiteParameters", "statusCode");
	
	// Get AccountNumber from DB corresponding to the username
		accountNumber = getAcountNumberForTheUser(username );
		
	// Set the automatic Backup schedule to Empty or No Schedule.	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
	// Log in to the Web Application and Assert
		jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
	// Select the Automatic backup Option radio button- TBD
		
	
	// Set the  Automatic Backup Schedule to disable on Monday ( A Single day)
		jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, daysOfWeekLarge);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", imdStatusCode);
		
	 
	//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
		logger.info("End of disable Automatic Backup Schedule A Day Test");		

	}
	
	@Test(enabled = true)
	public void startTimeGreaterThanEndTime() throws Exception{
	
		logger.info("Start disable Automatic Backup Schedule A Day Test");	

	// Declaration and Initialisation
		String username = null ,password = null ,jsonContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,startTimeGreaterThanEndTime = null;
		
	// Get the username ,password , defaultAutomaticbackupschedule from test data provider
		username = getParamValue("TestSuiteParameters","defaultUsername");
		password = getParamValue("TestSuiteParameters","defaultPassword");
		defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
		startTimeGreaterThanEndTime = getParamValue("TestSuiteParameters","startTimeGreaterThanEndTime");
		imdStatusCode = getParamValue("TestSuiteParameters", "statusCode");
	
	// Get AccountNumber from DB corresponding to the username
		accountNumber = getAcountNumberForTheUser(username );
		
	// Set the automatic Backup schedule to Empty or No Schedule.	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
	// Log in to the Web Application and Assert
		jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
	// Select the Automatic backup Option radio button- TBD
		
	
	// Set the  Automatic Backup Schedule to disable on Monday ( A Single day)
		jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, startTimeGreaterThanEndTime);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", imdStatusCode);
		
	 
	//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
		logger.info("End of disable Automatic Backup Schedule A Day Test");		

	}

	@Test(enabled = true)
	public void negativeStartTimeValue() throws Exception{
	
		logger.info("Start disable Automatic Backup Schedule A Day Test");	

	// Declaration and Initialisation
		String username = null ,password = null ,jsonContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,negativeStartTime = null;
		
	// Get the username ,password , defaultAutomaticbackupschedule from test data provider
		username = getParamValue("TestSuiteParameters","defaultUsername");
		password = getParamValue("TestSuiteParameters","defaultPassword");
		defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
		negativeStartTime = getParamValue("TestSuiteParameters","negativeStartTime");
		imdStatusCode = getParamValue("TestSuiteParameters", "statusCode");
	
	// Get AccountNumber from DB corresponding to the username
		accountNumber = getAcountNumberForTheUser(username );
		
	// Set the automatic Backup schedule to Empty or No Schedule.	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
	// Log in to the Web Application and Assert
		jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
	// Select the Automatic backup Option radio button- TBD
		
	
	// Set the  Automatic Backup Schedule to disable on Monday ( A Single day)
		jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, negativeStartTime);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", imdStatusCode);
		
	 
	//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
		logger.info("End of disable Automatic Backup Schedule A Day Test");		

	}
	
	@Test(enabled = true)
	public void negativeEndTimeValue() throws Exception{
	
		logger.info("Start disable Automatic Backup Schedule A Day Test");	

	// Declaration and Initialisation
		String username = null ,password = null ,jsonContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,negativeEndTime = null;
		
	// Get the username ,password , defaultAutomaticbackupschedule from test data provider
		username = getParamValue("TestSuiteParameters","defaultUsername");
		password = getParamValue("TestSuiteParameters","defaultPassword");
		defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
		negativeEndTime = getParamValue("TestSuiteParameters","negativeEndTime");
		imdStatusCode = getParamValue("TestSuiteParameters", "statusCode");
	
	// Get AccountNumber from DB corresponding to the username
		accountNumber = getAcountNumberForTheUser(username );
		
	// Set the automatic Backup schedule to Empty or No Schedule.	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
	// Log in to the Web Application and Assert
		jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
	// Select the Automatic backup Option radio button- TBD
		
	
	// Set the  Automatic Backup Schedule to disable on Monday ( A Single day)
		jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, negativeEndTime);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", imdStatusCode);
		
	 
	//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
		logger.info("End of disable Automatic Backup Schedule A Day Test");		

	}
	
	@Test(enabled = true)
	public void negativeDaysOfWeek() throws Exception{
	
		logger.info("Start disable Automatic Backup Schedule A Day Test");	

	// Declaration and Initialisation
		String username = null ,password = null ,jsonContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,negativeDayOfWeek = null;
		
	// Get the username ,password , defaultAutomaticbackupschedule from test data provider
		username = getParamValue("TestSuiteParameters","defaultUsername");
		password = getParamValue("TestSuiteParameters","defaultPassword");
		defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
		negativeDayOfWeek = getParamValue("TestSuiteParameters","negativeEndTime");
		imdStatusCode = getParamValue("TestSuiteParameters", "statusCode");
	
	// Get AccountNumber from DB corresponding to the username
		accountNumber = getAcountNumberForTheUser(username );
		
	// Set the automatic Backup schedule to Empty or No Schedule.	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
	// Log in to the Web Application and Assert
		jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
	// Select the Automatic backup Option radio button- TBD
		
	
	// Set the  Automatic Backup Schedule to disable on Monday ( A Single day)
		jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, negativeDayOfWeek);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", imdStatusCode);
		
	 
	//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
		logger.info("End of disable Automatic Backup Schedule A Day Test");		

	}
	
	@Test(enabled = true)
	public void manualBackupSetSchedule() throws Exception{
	
		logger.info("Start disable Automatic Backup Schedule A Day Test");	

	// Declaration and Initialisation
		String username = null ,password = null ,jsonContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,manualBackupSetSchedule = null;
		
	// Get the username ,password , defaultAutomaticbackupschedule from test data provider
		username = getParamValue("TestSuiteParameters","defaultUsername");
		password = getParamValue("TestSuiteParameters","defaultPassword");
		defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
		manualBackupSetSchedule = getParamValue("TestSuiteParameters","manualBackupSetSchedule");
	
	// Get AccountNumber from DB corresponding to the username
		accountNumber = getAcountNumberForTheUser(username );
		
	// Set the automatic Backup schedule to Empty or No Schedule.	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
	// Log in to the Web Application and Assert
		jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
	// Select the Automatic backup Option radio button- TBD
		
	
	// Set the  Automatic Backup Schedule to disable on Monday ( A Single day)
		jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, manualBackupSetSchedule);
		JSONAsserter.assertJSONObjects(jsonContent, "success", "true");
		
	 
	//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
		logger.info("End of disable Automatic Backup Schedule A Day Test");		

	}
	
	@Test(enabled = true)
	public void automaticBackupNotEditable() throws Exception{
	
		logger.info("Start disable Automatic Backup Schedule A Day Test");	

	// Declaration and Initialisation
		String username = null ,password = null ,jsonContent ,accountNumber = null ,defaultAutomaticBackupSchedule = null ,AutomaticBackupNotEditable = null;
		
	// Get the username ,password , defaultAutomaticbackupschedule from test data provider
		username = getParamValue("TestSuiteParameters","defaultUsername");
		password = getParamValue("TestSuiteParameters","defaultPassword");
		defaultAutomaticBackupSchedule = getParamValue("TestSuiteParameters","defaultEmptyAutomaticBackupSchedule");
		AutomaticBackupNotEditable = getParamValue("TestSuiteParameters","AutomaticBackupNotEditable");
	
	// Get AccountNumber from DB corresponding to the username
		accountNumber = getAcountNumberForTheUser(username );
		
	// Set the automatic Backup schedule to Empty or No Schedule.	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
	// Log in to the Web Application and Assert
		jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
	// Select the Automatic backup Option radio button- TBD
		
	
	// Set the  Automatic Backup Schedule to disable on Monday ( A Single day)
		jsonContent = AgentSchedule.setAgentSchedule(username, password, accountNumber, AutomaticBackupNotEditable);
		JSONAsserter.assertJSONObjects(jsonContent,  "success", "true");
		
	 
	//	Reset the automatic Backup schedule to Empty or No Schedule or defualt after test	
	    setDefaultScheduleToEmpty(username, password, accountNumber ,defaultAutomaticBackupSchedule);
		
		logger.info("End of disable Automatic Backup Schedule A Day Test");		

	}
	
	// .. Supporting Methods / Functions ..
	
	// Set the Automatic Backup Schedule to Default 
	
	
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
	
	// Get the Account Number for the User details Provided.
	
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
		super.stophttpTest();
		
	}
}