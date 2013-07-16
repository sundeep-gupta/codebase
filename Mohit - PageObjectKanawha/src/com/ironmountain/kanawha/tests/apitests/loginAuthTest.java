package com.ironmountain.kanawha.tests.apitests;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.commons.CommonUtils;

import com.ironmountain.kanawha.managementapi.apis.AgentEditProfile;
import com.ironmountain.kanawha.managementapi.apis.AccountMessages;

import com.ironmountain.kanawha.managementapi.apis.GetDevices;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.kanawha.managementapi.apis.Logout;
import com.ironmountain.kanawha.managementapi.apis.Search;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

/** Validate Login API Test
 * @author pjames
 *
 */
public class loginAuthTest extends HttpJsonAppTest{
	
	public static final Logger logger = Logger.getLogger(Login.class.getName());
	int responselength = 0;
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	String userName,password,accountNumberString,searchFileName,path,startBackupDate,includeSubFolders = null;
	int accountNumber;
	String noOfFiles = "";
	String jsonContent, pathassert,pathassert2,searchFileName2 = null;
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
		//Loading Test data provider
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "LoginTest.xml");
	}
	
	//Validate single account user login
	@Test(enabled = true)
	public void testSingleAccountUserLogin() throws Exception{
		logger.info("Start test");
		logger.info("Valid user login");
		//Sourcing inputs and outputs from Test data provider
		testInput = TestDataProvider.getTestInput("SingleAccountTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Calling the ValidateLogin API
		jsonContent = Login.login(userName, password);
		logger.info("Validating the authentication result value");
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the logout API
		jsonContent = Logout.logout(userName, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End Test");
	}
	
	//Validate invalid account user login
	@Test(enabled = true)
	public void testInvalidUserLogin() throws Exception{
		logger.info("Start test");
		logger.info("InValid user login");
		//Sourcing inputs and outputs from Test data provider
		testInput = TestDataProvider.getTestInput("InvalidUserLoginTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Calling the ValidateLogin API
		jsonContent = Login.login(userName, password);
		logger.info("Validating the authentication result value");
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "0");
		logger.info("End Test");
	}
	
	//Validate invalid account password login
	@Test(enabled = true)
	public void testInvalidPassLogin() throws Exception{
		logger.info("Start test");
		logger.info("InValid password login");
		//Sourcing inputs and outputs from Test data provider
		testInput = TestDataProvider.getTestInput("InvalidPassLoginTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Calling the ValidateLogin API
		jsonContent = Login.login(userName, password);
		logger.info("Validating the authentication result value");
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "0");
		logger.info("End Test");
	}
	
	//Validate special character account password login
	@Test(enabled = true)
	public void testSpecialCharUserLogin() throws Exception{
		logger.info("Start test");
		logger.info("Special Char user login");
		//Sourcing inputs and outputs from Test data provider
		testInput = TestDataProvider.getTestInput("SpecialCharUserTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		jsonContent = Login.login(userName, password);
		logger.info("Validating the authentication result value");
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the logout API
		jsonContent = Logout.logout(userName, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End Test");
	}
	
	//Validate alphanumeric password user login
	@Test(enabled = true)
	public void testAlphanumericPasswordLogin() throws Exception{
		logger.info("Start test");
		logger.info("InValid user login");
		//Sourcing inputs and outputs from Test data provider
		testInput = TestDataProvider.getTestInput("AlphanumericPasswordLoginTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Calling the ValidateLogin API
		jsonContent = Login.login(userName, password);
		logger.info("Validating the authentication result value");
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the logout API
		jsonContent = Logout.logout(userName, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End Test");
	}
	
	//Validate alphanumeric password user login
	@Test(enabled = true)
	public void testPasswordCaseSensitivity() throws Exception{
		logger.info("Start test");
		logger.info("Case Sensitive Password login");
		//Sourcing inputs and outputs from Test data provider
		testInput = TestDataProvider.getTestInput("PasswordCaseSensitivityTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Calling the ValidateLogin API
		jsonContent = Login.login(userName, password);
		logger.info("Validating the authentication result value");
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "0");
		logger.info("End Test");
	}
	
	//Validate multiple account user login
	@Parameters({"username", "password"})
	@Test(enabled = true)
	public void testMultipleUserLogin() throws Exception{
		logger.info("Start test");
		logger.info("Multiple User Login");
		//Sourcing inputs and outputs from Test data provider
		testInput = TestDataProvider.getTestInput("MultipleAccountTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Calling the ValidateLogin API
		jsonContent = Login.login(userName, password);
		logger.info("Validating the authentication result value");
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the logout API
		jsonContent = Logout.logout(userName, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End Test");
	}
	
	//Validate cancelled account user login	
	@Parameters({"username", "password"})
	@Test(enabled = true)
	public void testCancelledAccLogin() throws Exception{
		logger.info("Start test");
		logger.info("Cancelled Acc Login");
		//Sourcing inputs and outputs from Test data provider
		testInput = TestDataProvider.getTestInput("CancelledUserLoginTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Calling the ValidateLogin API
		jsonContent = Login.login(userName, password);
		logger.info("Validating the authentication result value");
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "2");
		logger.info("End Test");
	}
	
	//Validate on hold account user login
	@Parameters({"username", "password"})
	@Test(enabled = true)
	public void testOnHoldAccLogin() throws Exception{
		logger.info("Start test");
		logger.info("On hold Acc Login");
		//Sourcing inputs and outputs from Test data provider
		testInput = TestDataProvider.getTestInput("OnHoldUserLoginTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Calling the ValidateLogin API
		jsonContent = Login.login(userName, password);
		logger.info("Validating the authentication result value");
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the logout API
		jsonContent = Logout.logout(userName, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End Test");
	}
	
	//Validate get devices after user login
	@Test(enabled = true)
	public void testGetDevicesAfterLogin() throws Exception{
		logger.info("Start test");
		logger.info("Get Devices after user login");
		//Sourcing inputs and outputs from Test data provider
		testInput = TestDataProvider.getTestInput("GetDevicesAfterLoginTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Calling the ValidateLogin API
		jsonContent = Login.login(userName, password);
		logger.info("Validating the authentication result value");
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		jsonContent = GetDevices.getDevices(userName, password);
		int accountNumber = CommonUtils.getAccountNumber(userName);
		String deviceName = CommonUtils.getDeviceName(userName);
		JSONAsserter.assertJSONObjects(jsonContent, "NetworkDeviceList/0/AccountNumber", ""+accountNumber);
		JSONAsserter.assertJSONObjects(jsonContent, "NetworkDeviceList/0/NetworkDeviceName", deviceName);
		//Calling the logout API
		jsonContent = Logout.logout(userName, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End Test");
	}
	
	//Validate edit profile after user login
/*	@Test(enabled = true)
	public void testEditProfileAfterLogin() throws Exception{
		logger.info("Get Devices after user login");
		testInput = TestDataProvider.getTestInput("SearchAfterLoginTest");
		testOutput = TestDataProvider.getTestOutput("SearchAfterLoginTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		jsonContent = LoginAuth.LoginAuth(userName, password);
		logger.info("Validating the authentication result value");
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		int accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		jsonContent = AgentEditProfile.getAgentEditProfile(userName, password, accountNumberString);
		
	}*/
	
	//Validate search after user login
	@Test(enabled = true)
	public void testSearchAfterLogin() throws Exception{
		logger.info("Start test");
		//Sourcing inputs and outputs from Test data provider
		testInput = TestDataProvider.getTestInput("SearchAfterLoginTest");
		testOutput = TestDataProvider.getTestOutput("SearchAfterLoginTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Getting account number from DB
		int accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFolders = testInput.get("includeSubFolders");
		//Calling the ValidateLogin API
		jsonContent = Login.login(userName, password);
		logger.info("Validating the authentication result value");
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders);
		JSONArray responseArr = new JSONArray(jsonContent);
		responselength=responseArr.length();
		String numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
		logger.info(responseArr.getString(0));
		pathassert = testOutput.get("pathassert");
		pathassert2 = testOutput.get("pathassert2");
		searchFileName2 = testOutput.get("searchFileName2");
		//Asserting the response
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Path", pathassert2);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileName",searchFileName2 );
		//Calling the logout API
		jsonContent = Logout.logout(userName, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End Test");
	}
	

	//Validate account messages after user login
	@Test(enabled = true)
	public void testAccMsgsAfterLogin() throws Exception{
		logger.info("Start Account Messages after login test");
		testInput = TestDataProvider.getTestInput("AccountMessageTest");
		testOutput = TestDataProvider.getTestOutput("AccountMessageTest");
	
		//Sourcing inputs and outputs from Test data provider
		userName = testInput.get("userName");
		logger.info(userName);
		password = testInput.get("password");
		String messAssert = testOutput.get("message");
		String messageType = testOutput.get("messageType");
	
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	
		//Calling API's
		//jsonContent = Login.login(userName, password);
		jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	
		//Assertion of Response
		JSONArray responseArr = new JSONArray(jsonContent);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Message",messAssert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageType",messageType);
		//Calling the logout API
		jsonContent = Logout.logout(userName, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End Test");
	}


		
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stophttpTest();
	}


}
