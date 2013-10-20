package com.ironmountain.kanawha.tests.apitests;

import java.util.HashMap;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.managementapi.apis.AgentSettings;
import com.ironmountain.kanawha.managementapi.apis.UserRules;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountBackupDatesTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;


public class UserRulesTest extends HttpJsonAppTest{
	
	int accountNumber;
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	String jsonContent, userName = "",password = "", accountNumberString,validator="",resp1="";
	String rulesCategory,  AfterFileCreatedDate, AfterFileModifiedDate, BeforeFileCreatedDate,BeforeFileModifiedDate, ExcludeFileExtension, ExcludeFolderPath,  FileExtension, FileName, FolderPath, Name;
	int Id, FileCreatedWithinLastSpecificDays,FileModifiedWithinLastSpecificDays, RuleOrder, RuleType,Category;
	long ExcludeFileSize;
	
	
	private static final Logger logger = Logger.getLogger(UserRulesTest.class.getName());
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "UserRulesTDP.xml");
		
		//Getting test user details from test data provider 
		testInput = TestDataProvider.getTestInput("advancedRule");
		userName = testInput.get("userName");
		password = testInput.get("password");
		rulesCategory = testInput.get("rulesCategory");
		AfterFileCreatedDate = testInput.get("AfterFileCreatedDate");
		AfterFileModifiedDate = testInput.get("AfterFileModifiedDate");
		BeforeFileCreatedDate = testInput.get("BeforeFileCreatedDate");
		BeforeFileModifiedDate = testInput.get("BeforeFileModifiedDate");
		ExcludeFileExtension = testInput.get("ExcludeFileExtension");
		ExcludeFolderPath = testInput.get("ExcludeFolderPath");
		FileExtension = testInput.get("FileExtension");
		FileName = testInput.get("FileName");
		FolderPath = testInput.get("FolderPath");
		Name = testInput.get("Name");
		validator = testInput.get("Validator");
		Id = Integer.parseInt(testInput.get("Id"));
		FileCreatedWithinLastSpecificDays = Integer.parseInt(testInput.get("FileCreatedWithinLastSpecificDays"));
		FileModifiedWithinLastSpecificDays = Integer.parseInt(testInput.get("FileModifiedWithinLastSpecificDays"));
		RuleOrder = Integer.parseInt(testInput.get("RuleOrder"));
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		Category = Integer.parseInt(testInput.get("Category"));
		ExcludeFileSize = Integer.parseInt(testInput.get("ExcludeFileSize"));
		
		}	
	
	@Test(enabled = true)
	public void createBasicRule() throws Exception{
		logger.info("Start Basic Rule Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("basicRule");
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=1;
		BasicRules[1]=2;
		BasicRules[2]=3;
		BasicRules[3]=4;
		BasicRules[4]=5;
		BasicRules[5]=6;
		BasicRules[6]=7;
		BasicRules[7]=8;
		BasicRules[8]=9;
		BasicRules[9]=10;
		BasicRules[10]=11;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter	
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
		
	}
	
	@Test(enabled = true)
	public void includeBasicRule() throws Exception{
		logger.info("Start Basic Rule Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("basicRule");
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=1;
		BasicRules[1]=2;
		BasicRules[2]=3;
		BasicRules[3]=4;
		BasicRules[4]=5;
		BasicRules[5]=6;
		BasicRules[6]=7;
		BasicRules[7]=8;
		BasicRules[8]=9;
		BasicRules[9]=10;
		BasicRules[10]=11;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter	
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
		
	}
	
	@Test(enabled = true)
	public void createAdvancedRule() throws Exception{
		logger.info("Start Advanced Rule Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		int[] BasicRules = new int[11]; 
		BasicRules[0]=1;
		BasicRules[1]=2;
		BasicRules[2]=3;
		BasicRules[3]=4;
		BasicRules[4]=5;
		BasicRules[5]=6;
		BasicRules[6]=7;
		BasicRules[7]=8;
		BasicRules[8]=9;
		BasicRules[9]=10;
		BasicRules[10]=11;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
		
	} 	
	
	@Test(enabled = true)
	public void renameAdvancedRule() throws Exception{
		logger.info("Start Rename Rule Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("renameRule");
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		Name = testInput.get("Name");
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=1;
		BasicRules[1]=2;
		BasicRules[2]=3;
		BasicRules[3]=4;
		BasicRules[4]=5;
		BasicRules[5]=6;
		BasicRules[6]=7;
		BasicRules[7]=8;
		BasicRules[8]=9;
		BasicRules[9]=10;
		BasicRules[10]=11;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
	}
	
	@Test(enabled = true)
	public void renameBasicRule() throws Exception{
		logger.info("Start Rename Basic Rule Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("renamebasicRule");
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		Name = testInput.get("Name");
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=1;
		BasicRules[1]=2;
		BasicRules[2]=3;
		BasicRules[3]=4;
		BasicRules[4]=5;
		BasicRules[5]=6;
		BasicRules[6]=7;
		BasicRules[7]=8;
		BasicRules[8]=9;
		BasicRules[9]=10;
		BasicRules[10]=11;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
					
		//Validating the rule created using the setter
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
	}
	@Test(enabled = true)
	
	public void specialCharactersinRuleName() throws Exception{
		logger.info("Start Special Character Rule Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("specialRule");
		ExcludeFileExtension = testInput.get("ExcludeFileExtension");
		ExcludeFolderPath = testInput.get("ExcludeFolderPath");
		FileExtension = testInput.get("FileExtension");
		FileName = testInput.get("FileName");
		FolderPath = testInput.get("FolderPath");
		Name = testInput.get("Name");
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=1;
		BasicRules[1]=2;
		BasicRules[2]=3;
		BasicRules[3]=4;
		BasicRules[4]=5;
		BasicRules[5]=6;
		BasicRules[6]=7;
		BasicRules[7]=8;
		BasicRules[8]=9;
		BasicRules[9]=10;
		BasicRules[10]=11;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter	
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
		
	}
	
	@Test(enabled = true)
	public void deleteBasicRule() throws Exception{
		logger.info("Start Delete Basic Rule Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("deletebasicRule");
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		rulesCategory = testInput.get("rulesCategory");
		AfterFileCreatedDate = testInput.get("AfterFileCreatedDate");
		AfterFileModifiedDate = testInput.get("AfterFileModifiedDate");
		BeforeFileCreatedDate = testInput.get("BeforeFileCreatedDate");
		BeforeFileModifiedDate = testInput.get("BeforeFileModifiedDate");
		ExcludeFileExtension = testInput.get("ExcludeFileExtension");
		ExcludeFolderPath = testInput.get("ExcludeFolderPath");
		FileExtension = testInput.get("FileExtension");
		FileName = testInput.get("FileName");
		FolderPath = testInput.get("FolderPath");
		Name = testInput.get("Name");
		validator = testInput.get("Validator");
		Id = Integer.parseInt(testInput.get("Id"));
		FileCreatedWithinLastSpecificDays = Integer.parseInt(testInput.get("FileCreatedWithinLastSpecificDays"));
		FileModifiedWithinLastSpecificDays = Integer.parseInt(testInput.get("FileModifiedWithinLastSpecificDays"));
		RuleOrder = Integer.parseInt(testInput.get("RuleOrder"));
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		Category = Integer.parseInt(testInput.get("Category"));
		ExcludeFileSize = Integer.parseInt(testInput.get("ExcludeFileSize"));
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=0;
		BasicRules[1]=0;
		BasicRules[2]=0;
		BasicRules[3]=0;
		BasicRules[4]=0;
		BasicRules[5]=0;
		BasicRules[6]=0;
		BasicRules[7]=0;
		BasicRules[8]=0;
		BasicRules[9]=0;
		BasicRules[10]=0;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter	
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
		
	}
	
	@Test(enabled = true)
	public void deleteAdvancedRule() throws Exception{
		logger.info("Start Delete Basic Rule Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("deleteadvRule");
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		rulesCategory = testInput.get("rulesCategory");
		AfterFileCreatedDate = testInput.get("AfterFileCreatedDate");
		AfterFileModifiedDate = testInput.get("AfterFileModifiedDate");
		BeforeFileCreatedDate = testInput.get("BeforeFileCreatedDate");
		BeforeFileModifiedDate = testInput.get("BeforeFileModifiedDate");
		ExcludeFileExtension = testInput.get("ExcludeFileExtension");
		ExcludeFolderPath = testInput.get("ExcludeFolderPath");
		FileExtension = testInput.get("FileExtension");
		FileName = testInput.get("FileName");
		FolderPath = testInput.get("FolderPath");
		Name = testInput.get("Name");
		validator = testInput.get("Validator");
		Id = Integer.parseInt(testInput.get("Id"));
		FileCreatedWithinLastSpecificDays = Integer.parseInt(testInput.get("FileCreatedWithinLastSpecificDays"));
		FileModifiedWithinLastSpecificDays = Integer.parseInt(testInput.get("FileModifiedWithinLastSpecificDays"));
		RuleOrder = Integer.parseInt(testInput.get("RuleOrder"));
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		Category = Integer.parseInt(testInput.get("Category"));
		ExcludeFileSize = Integer.parseInt(testInput.get("ExcludeFileSize"));
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=0;
		BasicRules[1]=0;
		BasicRules[2]=0;
		BasicRules[3]=0;
		BasicRules[4]=0;
		BasicRules[5]=0;
		BasicRules[6]=0;
		BasicRules[7]=0;
		BasicRules[8]=0;
		BasicRules[9]=0;
		BasicRules[10]=0;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter	
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
		
	}
	
	@Test(enabled = true)
	public void editBasicRule() throws Exception{
		logger.info("Start Edit Basic Rule Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("editbasicRule");
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		Name = testInput.get("Name");
		AfterFileCreatedDate = testInput.get("AfterFileCreatedDate");
		AfterFileModifiedDate = testInput.get("AfterFileModifiedDate");
		BeforeFileCreatedDate = testInput.get("BeforeFileCreatedDate");
		BeforeFileModifiedDate = testInput.get("BeforeFileModifiedDate");
		ExcludeFileExtension = testInput.get("ExcludeFileExtension");
		ExcludeFolderPath = testInput.get("ExcludeFolderPath");
		FileExtension = testInput.get("FileExtension");
		FileName = testInput.get("FileName");
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=1;
		BasicRules[1]=2;
		BasicRules[2]=3;
		BasicRules[3]=4;
		BasicRules[4]=5;
		BasicRules[5]=6;
		BasicRules[6]=7;
		BasicRules[7]=8;
		BasicRules[8]=9;
		BasicRules[9]=10;
		BasicRules[10]=11;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
	}
	
	@Test(enabled = true)
	public void editAdvancedRule() throws Exception{
		logger.info("Start Edit Advanced Rule Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("editadvRule");
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		Name = testInput.get("Name");
		AfterFileCreatedDate = testInput.get("AfterFileCreatedDate");
		AfterFileModifiedDate = testInput.get("AfterFileModifiedDate");
		BeforeFileCreatedDate = testInput.get("BeforeFileCreatedDate");
		BeforeFileModifiedDate = testInput.get("BeforeFileModifiedDate");
		ExcludeFileExtension = testInput.get("ExcludeFileExtension");
		ExcludeFolderPath = testInput.get("ExcludeFolderPath");
		FileExtension = testInput.get("FileExtension");
		FileName = testInput.get("FileName");
		FolderPath = testInput.get("FolderPath");
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=1;
		BasicRules[1]=2;
		BasicRules[2]=3;
		BasicRules[3]=4;
		BasicRules[4]=5;
		BasicRules[5]=6;
		BasicRules[6]=7;
		BasicRules[7]=8;
		BasicRules[8]=9;
		BasicRules[9]=10;
		BasicRules[10]=11;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
	}
	
	@Test(enabled = true)
	public void createBasicRulewithoutname() throws Exception{
		logger.info("Start Basic Rule Without Name Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("basicRulewithoutname");
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		Name = testInput.get("Name");
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=1;
		BasicRules[1]=2;
		BasicRules[2]=3;
		BasicRules[3]=4;
		BasicRules[4]=5;
		BasicRules[5]=6;
		BasicRules[6]=7;
		BasicRules[7]=8;
		BasicRules[8]=9;
		BasicRules[9]=10;
		BasicRules[10]=11;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter	
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
		
	}
	
	@Test(enabled = true)
	public void createAdvRulewithoutname() throws Exception{
		logger.info("Start Advanced Rule Without Name Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("advRulewithoutname");
		Name = testInput.get("Name");
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=1;
		BasicRules[1]=2;
		BasicRules[2]=3;
		BasicRules[3]=4;
		BasicRules[4]=5;
		BasicRules[5]=6;
		BasicRules[6]=7;
		BasicRules[7]=8;
		BasicRules[8]=9;
		BasicRules[9]=10;
		BasicRules[10]=11;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter	
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
		
	}
	
	@Test(enabled = true)
	public void increaseRulePriority() throws Exception{
		logger.info("Start Basic Rule Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("increaseRulepriority");
		Id = Integer.parseInt(testInput.get("Id"));
		RuleOrder = Integer.parseInt(testInput.get("RuleOrder"));
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		Name = testInput.get("Name");
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=1;
		BasicRules[1]=2;
		BasicRules[2]=3;
		BasicRules[3]=4;
		BasicRules[4]=5;
		BasicRules[5]=6;
		BasicRules[6]=7;
		BasicRules[7]=8;
		BasicRules[8]=9;
		BasicRules[9]=10;
		BasicRules[10]=11;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter	
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
		
	}
	
	@Test(enabled = true)
	public void decreaseRulePriority() throws Exception{
		logger.info("Start Basic Rule Test");
		
		
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("decreaseRulepriority");
		Id = Integer.parseInt(testInput.get("Id"));
		RuleOrder = Integer.parseInt(testInput.get("RuleOrder"));
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		Name = testInput.get("Name");
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=1;
		BasicRules[1]=2;
		BasicRules[2]=3;
		BasicRules[3]=4;
		BasicRules[4]=5;
		BasicRules[5]=6;
		BasicRules[6]=7;
		BasicRules[7]=8;
		BasicRules[8]=9;
		BasicRules[9]=10;
		BasicRules[10]=11;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter	
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
		
	}
	
	@Test(enabled = true)
	public void createCopyofRule() throws Exception{
		logger.info("Start Basic Rule Without Name Test");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Setting the parameters for rules
		testInput = TestDataProvider.getTestInput("copyofRule");
		RuleType = Integer.parseInt(testInput.get("RuleType"));
		Name = testInput.get("Name");
		validator = testInput.get("Validator");
		int[] BasicRules = new int[11]; 
		BasicRules[0]=1;
		BasicRules[1]=2;
		BasicRules[2]=3;
		BasicRules[3]=4;
		BasicRules[4]=5;
		BasicRules[5]=6;
		BasicRules[6]=7;
		BasicRules[7]=8;
		BasicRules[8]=9;
		BasicRules[9]=10;
		BasicRules[10]=11;
		jsonContent = UserRules.setUserRules(userName, password,accountNumberString, rulesCategory, AfterFileCreatedDate, AfterFileModifiedDate, BasicRules, BeforeFileCreatedDate, BeforeFileModifiedDate, Category, ExcludeFileExtension, ExcludeFileSize, ExcludeFolderPath, FileCreatedWithinLastSpecificDays, FileExtension, FileModifiedWithinLastSpecificDays, FileName, FolderPath, Id, Name, RuleType, RuleOrder);
		
		//Validating the rule created using the setter	
		jsonContent = UserRules.getUserRules(userName, password, accountNumberString, rulesCategory);
		JSONObject response = new JSONObject(jsonContent);
		resp1 = response.toString();
		Asserter.assertEquals(resp1, validator);
		
	}
	
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stophttpTest();
	}	
}