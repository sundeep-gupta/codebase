package com.ironmountain.kanawha.tests.apitests;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.managementapi.apis.ContactSupport;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AgentConfigurationTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

/**
 * @author Rishith.Ramanand
 *
 */
public class ContactSupportTest extends HttpJsonAppTest{
	private static final Logger logger = Logger.getLogger(ContactSupport.class.getName());
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	String userName,password,jsonContent,jsonResponse,profileAndWebsiteSettingsID= "";
	String agentConfigurationID = "";
	AgentConfigurationTable agentConfigurationObject = new AgentConfigurationTable(DatabaseServer.COMMON_SERVER);
	static int accountNumber = 0;
		
	
@BeforeSuite(alwaysRun= true)
public void startTest() throws Exception {
	super.inithttpTest();
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber("contactsupport@api.com");
	TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata","ContactSupport.xml");
	}

//This test case verifies the simple contact support get functionality
@Test
public void supportInfoGetTest()throws Exception{
	logger.info("Start supportInfoGetTest");
	testInput = TestDataProvider.getTestInput("supportInfoGetTest");

	//sourcing inputs and outputs from Test data provider
	//Could not source this input through xml because of the whitespaces \r \n and \t
	String supportInfo = "&lt;p&gt;You can contact Support using one of the following methods:&lt;/p&gt;"
        +"\n\t&lt;ul&gt;"
        +"\n\t&lt;li&gt;Email: simpleget@contact.com&lt;/li&gt;"
        +"\n\t&lt;li&gt;Phone: 999-999-9999&lt;/li&gt;"
        +"\n\t&lt;/ul&gt;"
        +"\n\t&lt;p&gt;Technical Support representatives are available to help you Monday "
		+"\n\tthrough Friday, 08:00 AM to 06:00 PM.&lt;/p&gt;";
	logger.info(supportInfo);
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	profileAndWebsiteSettingsID = testInput.get("webSiteSettings");
	agentConfigurationID = testInput.get("agentConfigurationID");
	
	//Getting account number from DB
	agentConfigurationObject.updateProfileandWebsiteSettings(profileAndWebsiteSettingsID, agentConfigurationID);
		
	//Calling API's
	jsonContent=Login.login(userName, password);
	System.out.println(accountNumber);
	jsonContent=ContactSupport.getSupportInfo(userName, password, accountNumber);
	
	//Asserting for Response
	JSONAsserter.assertJSONObjects(jsonContent, "ContactForSupport", supportInfo);
	logger.info("Stop supportInfoGetTest");
}

//This test case verifies the getting empty html tags in contact support 
@Test
public void supportInfoEmptyHtmlTagsOnlyGetTest()throws Exception{
	logger.info("Start supportInfoHtmlTagsOnlyGetTest");
	testInput = TestDataProvider.getTestInput("supportInfoHtmlTagsOnlyGetTest");
	testOutput = TestDataProvider.getTestOutput("supportInfoHtmlTagsOnlyGetTest");

	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	profileAndWebsiteSettingsID = testInput.get("webSiteSettings");
	jsonResponse = testOutput.get("jsonResponse");
	agentConfigurationID = testInput.get("agentConfigurationID");
	
	//Getting account number from DB
	agentConfigurationObject.updateProfileandWebsiteSettings(profileAndWebsiteSettingsID, agentConfigurationID);
		
	//Calling API's
	jsonContent=Login.login(userName, password);
	jsonContent=ContactSupport.getSupportInfo(userName, password, accountNumber);
	
	//Asserting for Response
	
	JSONAsserter.assertJSONObjects(jsonContent, "ContactForSupport", jsonResponse);
	logger.info("Stop supportInfoHtmlTagsOnlyGetTest");
}

//This test case verifies the getting plain text in contact support
@Test
public void supportInfoPlainTextGetTest()throws Exception{
	logger.info("Start supportInfoPlainTextGetTest");
	testInput = TestDataProvider.getTestInput("supportInfoPlainTextGetTest");
	testOutput = TestDataProvider.getTestOutput("supportInfoPlainTextGetTest");

	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	profileAndWebsiteSettingsID = testInput.get("webSiteSettings");
	agentConfigurationID = testInput.get("agentConfigurationID");
	jsonResponse = testOutput.get("jsonResponse");
	
	//Getting account number from DB
	agentConfigurationObject.updateProfileandWebsiteSettings(profileAndWebsiteSettingsID, agentConfigurationID);
		
	//Calling API's
	jsonContent=Login.login(userName, password);
	jsonContent=ContactSupport.getSupportInfo(userName, password, accountNumber);
	
	//Asserting for Response
	JSONAsserter.assertJSONObjects(jsonContent, "ContactForSupport", jsonResponse);
	logger.info("Stop supportInfoPlainTextGetTest");
}

//This test case verifies the getting url in contact support
@Test
public void supportInfoURLGetTest()throws Exception{
	logger.info("Start supportInfoURLGetTest");
	testInput = TestDataProvider.getTestInput("supportInfoURLGetTest");

	//sourcing inputs and outputs from Test data provider
	//Could not source this input through xml because of the whitespaces \r \n and \t
	String supportInfo = "&lt;p&gt;You can contact Support using one of the following methods:&lt;/p&gt;"
        +"\n\t&lt;ul&gt;"
        +"\n\t&lt;li&gt;Email:urlget@support.com&lt;/li&gt;"
        +"\n\t&lt;li&gt;Phone: 123-456-7890&lt;/li&gt;"
        +"\n\t&lt;/ul&gt;"
        +"\n\t&lt;p&gt;Technical Support representatives are available to help you Monday "
		+"\n\tthrough Friday, 08:00 AM to 06:00 PM.&lt;/p&gt;"
		+"\nhttp://google.com";
	logger.info(supportInfo);
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	profileAndWebsiteSettingsID = testInput.get("webSiteSettings");
	agentConfigurationID = testInput.get("agentConfigurationID");
	
	//Getting account number from DB
	agentConfigurationObject.updateProfileandWebsiteSettings(profileAndWebsiteSettingsID, agentConfigurationID);
		
	//Calling API's
	jsonContent=Login.login(userName, password);
	jsonContent=ContactSupport.getSupportInfo(userName, password, accountNumber);
	
	//Asserting for Response
	JSONAsserter.assertJSONObjects(jsonContent, "ContactForSupport", supportInfo);
	logger.info("Stop supportInfoURLGetTest");
}

//This test case verifies the getting default value in contact support
@Test
public void supportInfoDefaultValuesGetTest()throws Exception{
	logger.info("Start supportInfoDefaultValuesGetTest");
	testInput = TestDataProvider.getTestInput("supportInfoDefaultValuesGetTest");

	//sourcing inputs and outputs from Test data provider
	//Could not source this input through xml because of the whitespaces \r \n and \t
	String supportInfo = "&lt;p&gt;You can contact Support using one of the following methods:&lt;/p&gt;"
        +"\n\t&lt;ul&gt;"
        +"\n\t&lt;li&gt;Email: xxx@xxx&lt;/li&gt;"
        +"\n\t&lt;li&gt;Phone: xxx-xxx-xxxx&lt;/li&gt;"
        +"\n\t&lt;/ul&gt;"
        +"\n\t&lt;p&gt;Technical Support representatives are available to help you Monday "
		+"\n\tthrough Friday, xx:xx AM to xx:xx PM.&lt;/p&gt;";
	logger.info(supportInfo);
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	profileAndWebsiteSettingsID = testInput.get("webSiteSettings");
	agentConfigurationID = testInput.get("agentConfigurationID");
	
	//Getting account number from DB
	agentConfigurationObject.updateProfileandWebsiteSettings(profileAndWebsiteSettingsID, agentConfigurationID);
		
	//Calling API's
	jsonContent=Login.login(userName, password);
	jsonContent=ContactSupport.getSupportInfo(userName, password, accountNumber);
	
	//Asserting for Response
	JSONAsserter.assertJSONObjects(jsonContent, "ContactForSupport", supportInfo);
	logger.info("Stop supportInfoDefaultValuesGetTest");
}

@AfterMethod(alwaysRun= true)
public void stopTest() throws Exception {
	super.stophttpTest();
}
}
