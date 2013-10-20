package com.ironmountain.kanawha.tests.apitests;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.managementapi.apis.AgentSettings;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;


public class AgentSettingsTest extends HttpJsonAppTest{
	
	int accountNumber = 0;
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	String jsonContent, userName = "",password = "", accountNumberString;
	
	private static final Logger logger = Logger.getLogger(AgentSettingsTest.class.getName());
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "AgentSettingsTest.xml");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("defaultOptions");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
	}
	
	//Test caseID: 42902 This test will validate the default settings of Agent Settings.
	@Test(enabled = true)
	public void defaultOptions() throws Exception{
		logger.info("Start Default Agent Settings Test");
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		jsonContent = AgentSettings.getAgentSettings(userName, password, accountNumberString);
		JSONObject response = new JSONObject(jsonContent);
		
		// To test that ShowTaskbarIcon is 1 (checked) by default and other options are 0 (unchecked)
		Assert.assertEquals(response.get("BackupOverDialup"),"0","Incorrect Settings");
		Assert.assertEquals(response.get("ManualBackupOverDialup"),"0","Incorrect Settings");
		Assert.assertEquals(response.get("ShowTaskbarIcon"),"1","Incorrect Settings");
	} 
	
	//Test caseID:42901 This is to test API accepts input BackupOverDialup=0, ManualBackupOverDialup=0, ShowTaskbarIcon=1
	@Test(enabled = true)
	 public void mutualExclusivity1() throws Exception{
		logger.info("Start Agent Settings Test 1");
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);	
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		// To test that all the three options are mutually exclusive and the option can be checked or unchecked without depending on the state of the other option.
		String manualBackupOverDialup = "0", backupOverdialup = "0", showTaskbar = "1";
		jsonContent = AgentSettings.setAgentSettings(userName, password, accountNumberString, manualBackupOverDialup, backupOverdialup, showTaskbar);
		jsonContent = AgentSettings.getAgentSettings(userName, password, accountNumberString);
		JSONObject response = new JSONObject(jsonContent);
		Assert.assertEquals(response.get("BackupOverDialup"),"0","Incorrect Settings");
		Assert.assertEquals(response.get("ManualBackupOverDialup"),"0","Incorrect Settings");
		Assert.assertEquals(response.get("ShowTaskbarIcon"),"1","Incorrect Settings");
	}
	
	//Test caseID:42901 This is to test API accepts input BackupOverDialup=1, ManualBackupOverDialup=0, ShowTaskbarIcon=0
	@Test(enabled = true)
	 public void mutualExclusivity2() throws Exception{
		logger.info("Start Agent Settings Test 2");
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
	//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		// To test that all the three options are mutually exclusive and the option can be checked or unchecked without depending on the state of the other option.
		String manualBackupOverDialup = "0", backupOverdialup = "1", showTaskbar = "0";
		jsonContent = AgentSettings.setAgentSettings(userName, password, accountNumberString, manualBackupOverDialup, backupOverdialup, showTaskbar);
		jsonContent = AgentSettings.getAgentSettings(userName, password, accountNumberString);
		JSONObject response = new JSONObject(jsonContent);
		Assert.assertEquals(response.get("BackupOverDialup"),"1","Incorrect Settings");
		Assert.assertEquals(response.get("ManualBackupOverDialup"),"0","Incorrect Settings");
		Assert.assertEquals(response.get("ShowTaskbarIcon"),"0","Incorrect Settings");
	}
	
	//Test caseID:42901 This is to test API accepts input BackupOverDialup=0, ManualBackupOverDialup=1, ShowTaskbarIcon=0
	@Test(enabled = true)
	 public void mutualExclusivity3() throws Exception{
		logger.info("Start Agent Settings Test 3");
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
	//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		// To test that all the three options are mutually exclusive and the option can be checked or unchecked without depending on the state of the other option.
		String manualBackupOverDialup = "1", backupOverdialup = "0", showTaskbar = "0";
		jsonContent = AgentSettings.setAgentSettings(userName, password, accountNumberString, manualBackupOverDialup, backupOverdialup, showTaskbar);
		jsonContent = AgentSettings.getAgentSettings(userName, password, accountNumberString);
		JSONObject response = new JSONObject(jsonContent);
		Assert.assertEquals(response.get("BackupOverDialup"),"0","Incorrect Settings");
		Assert.assertEquals(response.get("ManualBackupOverDialup"),"1","Incorrect Settings");
		Assert.assertEquals(response.get("ShowTaskbarIcon"),"0","Incorrect Settings");
	}
	
	//Test caseID:42900 This is to test API accepts input BackupOverDialup=1, ManualBackupOverDialup=1, ShowTaskbarIcon=0
	@Test(enabled = true)
	 public void multiCombination1() throws Exception{
		logger.info("Start Agent Settings Test 4");
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
	//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		// To test that all the three options can be checked or unchecked without depending on the state of the other option.
		String manualBackupOverDialup = "1", backupOverdialup = "1", showTaskbar = "0";
		jsonContent = AgentSettings.setAgentSettings(userName, password, accountNumberString, manualBackupOverDialup, backupOverdialup, showTaskbar);
		jsonContent = AgentSettings.getAgentSettings(userName, password, accountNumberString);
		JSONObject response = new JSONObject(jsonContent);
		Assert.assertEquals(response.get("BackupOverDialup"),"1","Incorrect Settings");
		Assert.assertEquals(response.get("ManualBackupOverDialup"),"1","Incorrect Settings");
		Assert.assertEquals(response.get("ShowTaskbarIcon"),"0","Incorrect Settings");
	}
	
	//Test caseID:42900 This is to test API accepts input BackupOverDialup=0, ManualBackupOverDialup=1, ShowTaskbarIcon=1
	@Test(enabled = true)
	 public void multiCombination2() throws Exception{
		logger.info("Start Agent Settings Test 5");
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		// To test that all the three options can be checked or unchecked without depending on the state of the other option.
		String manualBackupOverDialup = "1", backupOverdialup = "0", showTaskbar = "1";
		jsonContent = AgentSettings.setAgentSettings(userName, password, accountNumberString, manualBackupOverDialup, backupOverdialup, showTaskbar);
		jsonContent = AgentSettings.getAgentSettings(userName, password, accountNumberString);
		JSONObject response = new JSONObject(jsonContent);
		Assert.assertEquals(response.get("BackupOverDialup"),"0","Incorrect Settings");
		Assert.assertEquals(response.get("ManualBackupOverDialup"),"1","Incorrect Settings");
		Assert.assertEquals(response.get("ShowTaskbarIcon"),"1","Incorrect Settings");
	}
	
	//Test caseID:42900 This is to test API accepts input BackupOverDialup=1, ManualBackupOverDialup=1, ShowTaskbarIcon=1
	@Test(enabled = true)
	 public void multiCombination3() throws Exception{
		logger.info("Start Agent Settings Test 6");
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		// To test that all the three options can be checked or unchecked without depending on the state of the other option.
		String manualBackupOverDialup = "1", backupOverdialup = "1", showTaskbar = "1";
		jsonContent = AgentSettings.setAgentSettings(userName, password, accountNumberString, manualBackupOverDialup, backupOverdialup, showTaskbar);
		jsonContent = AgentSettings.getAgentSettings(userName, password, accountNumberString);
		JSONObject response = new JSONObject(jsonContent);
		Assert.assertEquals(response.get("BackupOverDialup"),"1","Incorrect Settings");
		Assert.assertEquals(response.get("ManualBackupOverDialup"),"1","Incorrect Settings");
		Assert.assertEquals(response.get("ShowTaskbarIcon"),"1","Incorrect Settings");
	}
	
	//Test caseID:42900 This is to test API accepts input BackupOverDialup=0, ManualBackupOverDialup=0, ShowTaskbarIcon=0
	@Test(enabled = true)
	 public void multiCombination4() throws Exception{
		logger.info("Start Agent Settings Test 7");
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);		
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		// To test that all the three options can be checked or unchecked without depending on the state of the other option.
		String manualBackupOverDialup = "0", backupOverdialup = "0", showTaskbar = "0";
		jsonContent = AgentSettings.setAgentSettings(userName, password, accountNumberString, manualBackupOverDialup, backupOverdialup, showTaskbar);
		jsonContent = AgentSettings.getAgentSettings(userName, password, accountNumberString);
		JSONObject response = new JSONObject(jsonContent);
		Assert.assertEquals(response.get("BackupOverDialup"),"0","Incorrect Settings");
		Assert.assertEquals(response.get("ManualBackupOverDialup"),"0","Incorrect Settings");
		Assert.assertEquals(response.get("ShowTaskbarIcon"),"0","Incorrect Settings");
	}
	
	//Test caseID:42898 Post non-Boolean values to the API
	@Test(enabled = true)
	 public void nonBoolean() throws Exception{
		logger.info("Start Agent Settings Test 8");
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);	
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		// The agentpreferences API should accept only Boolean (0,1) values for checking or unchecking the option. But it currently accepts and returns non-boolean values.
		// Needs automation rework after CECSGH-1671  is fixed.
		String manualBackupOverDialup = "5", backupOverdialup = "3", showTaskbar = "2";
		jsonContent = AgentSettings.setAgentSettings(userName, password, accountNumberString, manualBackupOverDialup, backupOverdialup, showTaskbar);
		JSONObject response = new JSONObject(jsonContent);
		Assert.assertEquals(response.get("ImdStatusCode"),1007, "Incorrect ImdStatus Code");
		Assert.assertEquals(response.get("ImdStatusDescription"),"Invalid body parameters.", "Invalid Imd Status Description");
		//jsonContent = AgentSettings.getAgentSettings(userName, password, accountNumberString);
		//Assert.assertEquals(response.get("BackupOverDialup"),"0","Incorrect Settings");
		//Assert.assertEquals(response.get("ManualBackupOverDialup"),"0","Incorrect Settings");
		//Assert.assertEquals(response.get("ShowTaskbarIcon"),"0","Incorrect Settings");
	}
	
	
	//Test caseID: N/A This clean-up test and will revert the agent options to default after test execution  
	@Test(enabled = true)
	 public void revertToDefault() throws Exception{
		logger.info("Start Agent Settings Test 9");
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);		
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		// To set the options back to default state so that other tests are not affected and the same test is re-runnable.
		String manualBackupOverDialup = "0", backupOverdialup = "0", showTaskbar = "1";
		jsonContent = AgentSettings.setAgentSettings(userName, password, accountNumberString, manualBackupOverDialup, backupOverdialup, showTaskbar);
		jsonContent = AgentSettings.getAgentSettings(userName, password, accountNumberString);
		JSONObject response = new JSONObject(jsonContent);
		Assert.assertEquals(response.get("BackupOverDialup"),"0","Incorrect Settings");
		Assert.assertEquals(response.get("ManualBackupOverDialup"),"0","Incorrect Settings");
		Assert.assertEquals(response.get("ShowTaskbarIcon"),"1","Incorrect Settings");
	}
		
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stophttpTest();
	}	
}