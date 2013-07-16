package com.ironmountain.kanawha.tests.apitests;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.managementapi.apis.EmailSearch;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountBackupDatesTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;


public class EmailSearchTest extends HttpJsonAppTest{
	
	int accountNumber = 0;
	String jsonContent, userName = "",password = "", accountNumberString;
	private static final Logger logger = Logger.getLogger(EmailSearch.class.getName());
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	String searchFileName,path,fileSize,startBackupDate,caseSensitiveStr = null,includeSubFoldersStr = null, searchScope, fileContent;
	Boolean caseSensitive = null,includeSubFolders = null;
	String noOfFiles, pathAssert,searchFileNameAssert,MessageIdAssert;
			
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "EmailSearch.xml");
	}
	
	@Test(enabled = true)
	public void emailSearchSanity() throws Exception{
		logger.info("Start Email Search Sanity Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("EmailSearchSanity");
		testOutput = TestDataProvider.getTestOutput("EmailSearchSanity");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
		pathAssert = testOutput.get("pathassert");
		searchFileNameAssert = testOutput.get("searchFileName");
		MessageIdAssert = testOutput.get("MessageId");
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Path", pathAssert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileName", searchFileNameAssert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageId", MessageIdAssert);
		
		logger.info("End Email Search Sanity Test");				
	}
	
	@Test(enabled = true)
	public void emailSearchCaseSensitive() throws Exception{
		logger.info("Start Email Search Case Sensitive Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("CaseSensitiveSearch");
		testOutput = TestDataProvider.getTestOutput("CaseSensitiveSearch");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Email Search Case Sensitive Test");				
	}
	
	@Test(enabled = true)
	public void includeSubfolderSearch() throws Exception{
		logger.info("Start Email Search Include Subfolder Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("IncludeSubfolderSearch");
		testOutput = TestDataProvider.getTestOutput("IncludeSubfolderSearch");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Email Search Include Subfolder Test");				
	}
	
	@Test(enabled = true)
	public void emailSearchCaseSensitive1() throws Exception{
		logger.info("Start Email Search Case Sensitive Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("CaseSensitiveSearch");
		testOutput = TestDataProvider.getTestOutput("CaseSensitiveSearch");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Email Search Case Sensitive Test");				
	}
	
	@Test(enabled = true)
	public void emailSearchInvalid() throws Exception{
		logger.info("Start Email Search Invalid Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("EmailSearchInvalid");
		testOutput = TestDataProvider.getTestOutput("EmailSearchInvalid");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Email Search Invalid Test");				
	}
	
	@Test(enabled = true)
	public void emailSearchpst() throws Exception{
		logger.info("Start Email Search PST Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("PSTSearch");
		testOutput = TestDataProvider.getTestOutput("PSTSearch");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
	//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Email Search PST Test");				
	}
	
	
	@Test(enabled = true)
	public void emailSearchWildcard() throws Exception{
		logger.info("Start Email Wildcard Search Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("WildcardSearch");
		testOutput = TestDataProvider.getTestOutput("WildcardSearch");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Email Wildcard Search Test");				
	}
	
	@Test(enabled = true)
	public void emailSearchNSF() throws Exception{
		logger.info("Start Email Wildcard Search Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("NSFSearch");
		testOutput = TestDataProvider.getTestOutput("NSFSearch");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Email Wildcard Search Test");				
	}
	
	@Test(enabled = true)
	public void emailSearchCorrupted() throws Exception{
		logger.info("Start Email Corrupted PST Search Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("CorruptedPSTSearch");
		testOutput = TestDataProvider.getTestOutput("CorruptedPSTSearch");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Email Corrupted PST Search Test");				
	}
	
	@Test(enabled = true)
	public void emailSearchChangeext() throws Exception{
		logger.info("Start Email Changed PST Extension Search Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("ChangedExtension");
		testOutput = TestDataProvider.getTestOutput("ChangedExtension");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
	//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Email Changed PST Extension Search Test");				
	}
	
	@Test(enabled = true)
	public void zippedemailSearch() throws Exception{
		logger.info("Start Zipped Email Search Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("ZippedEmail");
		testOutput = TestDataProvider.getTestOutput("ZippedEmail");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
	//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Zipped Email Search Test");				
	}
	
	@Test(enabled = true)
	public void longEmailSearch() throws Exception{
		logger.info("Start Long Email with Rich Text Search Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("LongEmail");
		testOutput = TestDataProvider.getTestOutput("LongEmail");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
	//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Long Email with Rich Text Search Test");				
	}
	
	@Test(enabled = true)
	public void mso2k3EmailSearch() throws Exception{
		logger.info("Start MSO 2003 Email Search Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("MSO2k3Email");
		testOutput = TestDataProvider.getTestOutput("MSO2k3Email");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End MSO 2003 Email Search Test");				
	}
	
	@Test(enabled = true)
	public void attachmentEmailSearch() throws Exception{
		logger.info("Start Email Search Attachment Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("AttachmentEmail");
		testOutput = TestDataProvider.getTestOutput("AttachmentEmail");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Email Search Attachment Test");				
	}
	
	@Test(enabled = true)
	public void infectedEmailSearch() throws Exception{
		logger.info("Start Infected Email Search Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("InfectedEmail");
		testOutput = TestDataProvider.getTestOutput("InfectedEmail");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
	//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Email Search Attachment Test");				
	}
	
	@Test(enabled = true)
	public void appleEmailSearch() throws Exception{
		logger.info("Start Apple Mac Email Search Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("AppleEmail");
		testOutput = TestDataProvider.getTestOutput("AppleEmail");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
	//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Get test input from the test data provider file ContentSearchTest.xml
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFoldersStr = testInput.get("includeSubFolders");
		includeSubFolders = Boolean.parseBoolean("includeSubFoldersStr");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = EmailSearch.emailSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Apple Mac Email Search Test");				
	}
	
}