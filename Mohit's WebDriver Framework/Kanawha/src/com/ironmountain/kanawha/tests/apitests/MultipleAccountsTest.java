package com.ironmountain.kanawha.tests.apitests;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.managementapi.apis.ChangeLogonInfo;
import com.ironmountain.kanawha.managementapi.apis.ContentSearch;
import com.ironmountain.kanawha.managementapi.apis.GetRetrievalSetDownload;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.kanawha.managementapi.apis.MultipleAccounts;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONConverter;
import com.ironmountain.pageobject.pageobjectrunner.utils.DownloadUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

public class MultipleAccountsTest extends HttpJsonAppTest{
	
	int accountNumber = 0;
	String jsonContent, userName = "",password = "", accountNumberString;
	private static final Logger logger = Logger.getLogger(ContentSearch.class.getName());
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	String cancelledAccNumber,onHoldAccNumber,accNumber,networkDeviceName,deviceType,agentVersion,dataUsageMBLimit, newEmailID, dataUsageBytes;
	Boolean caseSensitive = null;
				
	@BeforeSuite
	public void startTest() throws Exception {
		super.inithttpTest();
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "MultipleAccountTest.xml");
	}
	
	//Validating that cancelled account is not listed
	@Test(enabled = true)
	public void testMultipleAccountsforCancelledAcc() throws Exception{
	logger.info("Start cancelled account is not listed Test");
	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("MultipleAccCancelledTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	cancelledAccNumber = testInput.get("cancelledAccNumber");	
	//Calling the login API
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Calling the multiple account API
	jsonContent = MultipleAccounts.getAccounts(userName, password);
	//Asserting that the cancelled account is not listed.
	for (int i = 0; i < 10; i++) {
		Object jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/AccountNumber");
		String accNumber = jsonobj.toString();
		jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/Status");
		String status = jsonobj.toString();
		if (accNumber.contentEquals(cancelledAccNumber)){
		Assert.assertEquals("Cancelled", status, "The Status is incorrect");
		}
	}
	logger.info("Completed the test");	
	}
	
	//Validating that On hold account is listed
	@Test(enabled = true)
	public void testMultipleAccountsforOnHoldAcc() throws Exception{
	logger.info("Start cancelled account is not listed Test");	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("MultipleAccOnHoldTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	onHoldAccNumber = testInput.get("onHoldAccNumber");	
	//Calling the login API
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");	
	//Calling the multiple account API
	jsonContent = MultipleAccounts.getAccounts(userName, password);
	//Asserting that the On hold account is listed.
	for (int i = 0; i < 10; i++) {
		Object jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/AccountNumber");
		String accNumber = jsonobj.toString();
		jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/Status");
		String status = jsonobj.toString();
		if (accNumber.contentEquals(onHoldAccNumber)){
		Assert.assertEquals("OnHold", status, "The Status is incorrect");
		}
	}
	logger.info("Completed the test");	
	}
	
	//Validating Active Account without any backup
	@Test(enabled = true)
	public void testMultipleAccountsforActiveAccwobackup() throws Exception{
	logger.info("Start Active Account without any backup Test");	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("MultipleAccountsforActiveAccwobackupTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	accNumber = testInput.get("accNumber");	
	//Calling the login API
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");	
	//Calling the multiple account API
	jsonContent = MultipleAccounts.getAccounts(userName, password);
	//Asserting that the On hold account is listed.
	for (int i = 0; i < 10; i++) {
		Object jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/AccountNumber");
		String actualAccNumber = jsonobj.toString();
		jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/Status");
		String status = jsonobj.toString();
		if (actualAccNumber.contentEquals(accNumber)){
		Assert.assertEquals("Active", status, "The Status is incorrect");
		}
	}
	logger.info("Completed the test");	
	}
	
	//Validating Multiple Accounts for Completed Status
	@Test(enabled = true)
	public void testMultipleAccountsforCompletedStatus() throws Exception{
	logger.info("Start cancelled account is not listed Test");	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("MultipleAccountsforCompletedStatusTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	accNumber = testInput.get("accNumber");	
	networkDeviceName = testInput.get("networkDeviceName");
	deviceType = testInput.get("deviceType");
	agentVersion = testInput.get("AgentVersion");
	dataUsageMBLimit = testInput.get("DataUsageMBLimit");
	//Calling the login API
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");	
	//Calling the multiple account API
	jsonContent = MultipleAccounts.getAccounts(userName, password);
	for (int i = 0; i < 10; i++) {
		Object jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/AccountNumber");
		String actualAccNumber = jsonobj.toString();
		jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/LastSuccessfulBackupDate");
		String status = jsonobj.toString();
		jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/NetworkDeviceName");
		String networkDevice = jsonobj.toString();
		jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/DeviceType");
		String deviceTy = jsonobj.toString();
		jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/AgentVersion");
		String agentVer = jsonobj.toString();
		jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/DataUsageLimitInBytes");
		String dataUsageLimit = jsonobj.toString();
		if (actualAccNumber.contentEquals(accNumber)){
		Assert.assertEquals("Completed", status, "The Status is incorrect");
		Assert.assertEquals(networkDevice, networkDeviceName, "The networkDevice is incorrect");
		Assert.assertEquals(deviceTy, deviceType, "The device type is incorrect");
		Assert.assertEquals(agentVer, agentVersion, "The agent version is incorrect");
		Assert.assertEquals(dataUsageLimit, dataUsageMBLimit, "The agent version is incorrect");	
		}
	}
	logger.info("Completed the test");	
	}
	
	
	//Validating 1MB Data Usage Limit Setting
	@Test(enabled = true)
	public void testMultipleAccountsDataUsageLimitSetting() throws Exception{
	logger.info("Start cancelled account is not listed Test");	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("MultipleAccountsDataUsageLimitSettingTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	accNumber = testInput.get("accNumber");	
	networkDeviceName = testInput.get("networkDeviceName");
	deviceType = testInput.get("deviceType");
	agentVersion = testInput.get("AgentVersion");
	dataUsageMBLimit = testInput.get("DataUsageMBLimit");
	//Calling the login API
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");	
	//Calling the multiple account API
	jsonContent = MultipleAccounts.getAccounts(userName, password);
	//Asserting that the List Of Device Details.
	for (int i = 0; i < 10; i++) {
		Object jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/AccountNumber");
		String actualAccNumber = jsonobj.toString();
		jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/DataUsageLimitInBytes");
		String dataUsageLimit = jsonobj.toString();
		if (actualAccNumber.contentEquals(accNumber)){
		Assert.assertEquals(dataUsageLimit, dataUsageMBLimit, "The Data Usage Limit is incorrect");	
		}
	}
	logger.info("Completed the test");	
	}
	
	
	//Validating Data Usage 
	@Test(enabled = true)
	public void testMultipleAccountsDataUsage() throws Exception{
	logger.info("Start cancelled account is not listed Test");	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("MultipleAccountsDataUsageTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	accNumber = testInput.get("accNumber");	
	networkDeviceName = testInput.get("networkDeviceName");
	deviceType = testInput.get("deviceType");
	agentVersion = testInput.get("AgentVersion");
	dataUsageBytes = testInput.get("DataUsageInBytes");
	//Calling the login API
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");	
	//Calling the multiple account API
	jsonContent = MultipleAccounts.getAccounts(userName, password);
	//Asserting that the List Of Device Details.
	for (int i = 0; i < 10; i++) {
		Object jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/AccountNumber");
		String actualAccNumber = jsonobj.toString();
		jsonobj = JSONConverter.json(jsonContent, "ListOfDeviceDetails/"+i+"/DataUsageInBytes");
		String dataUsage = jsonobj.toString();
		if (actualAccNumber.contentEquals(accNumber)){
		Assert.assertEquals(dataUsage, dataUsageBytes, "The Data Usage Limit is incorrect");	
		}
	}
	logger.info("Completed the test");	
	}
	
	//Change User Name for Multiple Accounts
	@Test(enabled = true)
	public void testChangeUserNameforMultipleAccounts() throws Exception{
		logger.info("Change password with username as password Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("ChangeUserNameforMultipleAccountsTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		newEmailID = testInput.get("newEmailID");
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountPassword(newEmailID, password, "");
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		//Calling the Login API after change password
		jsonContent = Login.login(userName, userName);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Reset the UserName.
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, password, "");
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End of test");
	}
	
	//Validate Signature
	@Test(enabled = true)
	public void testMultipleAccountsForInvalidUserNameAfterAuthorisation() throws Exception{
	logger.info("Start Active Account without any backup Test");	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("MultipleAccountsforActiveAccwobackupTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	accNumber = testInput.get("accNumber");	
	//Calling the login API
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");	
	//Calling the multiple account API
	jsonContent = MultipleAccounts.getAccounts("Invalid", password);
	JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", "1001");
	logger.info("Completed the test");	
	}
	
	@AfterSuite
	public void stopTest() throws Exception {
		super.stophttpTest();
	}

}
