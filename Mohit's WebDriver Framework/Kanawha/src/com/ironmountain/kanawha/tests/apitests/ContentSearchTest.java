package com.ironmountain.kanawha.tests.apitests;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.managementapi.apis.ContentSearch;
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


public class ContentSearchTest extends HttpJsonAppTest{
	
	int accountNumber = 0;
	String jsonContent, userName = "",password = "", accountNumberString;
	private static final Logger logger = Logger.getLogger(ContentSearch.class.getName());
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	String searchFileName,path,fileSize,startBackupDate,caseSensitiveStr = null,includeSubFolders = null, searchScope, fileContent;
	Boolean caseSensitive = null;
	String noOfFiles, pathAssert,searchFileNameAssert,fileSizeAssert;
			
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "ContentSearchTest.xml");
	}
	
	@Test(enabled = true)
	public void contentSearchSanity() throws Exception{
		logger.info("Start Content Search Sanity Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("ContentSearchSanity");
		testOutput = TestDataProvider.getTestOutput("ContentSearchSanity");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
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
		includeSubFolders = testInput.get("includeSubFolders");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
		pathAssert = testOutput.get("pathassert");
		searchFileNameAssert = testOutput.get("searchFileName");
		fileSizeAssert = testOutput.get("fileSize");
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Path", pathAssert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileName", searchFileNameAssert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileSize", fileSizeAssert);
		
		logger.info("End Content Search Sanity Test");				
	}			
	
	@Test(enabled = true)
	public void caseSensitiveSearch() throws Exception{
		logger.info("Start Case Sensitive Content Search Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("CaseSensitiveSearch");
		testOutput = TestDataProvider.getTestOutput("CaseSensitiveSearch");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
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
		includeSubFolders = testInput.get("includeSubFolders");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles");
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		Asserter.assertEquals(numoffiles, noOfFiles);
		caseSensitiveStr = testInput.get("caseSensitive2"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr2 = new JSONArray(jsonContent);
		responselength = responseArr2.length();
		numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles2");
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		Asserter.assertEquals(numoffiles, noOfFiles);
		
		logger.info("End Case Sensitive Content Search Test");				
	}
	
	@Test(enabled = true)
	public void exSubfolderSearch() throws Exception{
		logger.info("Start Content Search exclude subfolder Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("exSubfolderSearch");
		testOutput = TestDataProvider.getTestOutput("exSubfolderSearch");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
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
		includeSubFolders = testInput.get("includeSubFolders");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		
		//Providing the test input to the API
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles");
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		Asserter.assertEquals(numoffiles, noOfFiles);
		
		logger.info("End Content Search exclude subfolder Test");				
	}
	
	@Test(enabled = true)
	public void inSubfolderSearch() throws Exception{
		logger.info("Start Content Search include subfolder Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("inSubfolderSearch");
		testOutput = TestDataProvider.getTestOutput("inSubfolderSearch");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
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
		includeSubFolders = testInput.get("includeSubFolders");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles");
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		Asserter.assertEquals(numoffiles, noOfFiles);
		pathAssert = testOutput.get("pathassert");
		searchFileNameAssert = testOutput.get("searchFileName");
		fileSizeAssert = testOutput.get("fileSize");
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Path", pathAssert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileName", searchFileNameAssert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileSize", fileSizeAssert);
				
		logger.info("End Content Search include subfolder Test");				
	}
	
	@Test(enabled = true)
	public void contentSearchScope() throws Exception{
		logger.info("Start Content Search Scope Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("ContentSearchScope");
		testOutput = TestDataProvider.getTestOutput("ContentSearchScope");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
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
		includeSubFolders = testInput.get("includeSubFolders");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
		fileContent = testInput.get("fileContent2");
		includeSubFolders = testInput.get("includeSubFolders2");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr2 = new JSONArray(jsonContent);
		responselength = responseArr2.length();
		numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles2");
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		Asserter.assertEquals(numoffiles, noOfFiles);
		pathAssert = testOutput.get("pathassert");
		searchFileNameAssert = testOutput.get("searchFileName");
		fileSizeAssert = testOutput.get("fileSize");
		JSONAsserter.assertJSONObjects(responseArr2.getString(0), "Path", pathAssert);
		JSONAsserter.assertJSONObjects(responseArr2.getString(0), "FileName", searchFileNameAssert);
		JSONAsserter.assertJSONObjects(responseArr2.getString(0), "FileSize", fileSizeAssert);
		
		logger.info("End Content Search Scope Test");				
	}
	
	@Test(enabled = true)
	public void contentSearchInvalid() throws Exception{
		logger.info("Start Content Search Invalid Input Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("ContentSearchInvalid");
		testOutput = TestDataProvider.getTestOutput("ContentSearchInvalid");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
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
		includeSubFolders = testInput.get("includeSubFolders");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles");
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		Asserter.assertEquals(numoffiles, noOfFiles);
		fileContent = testInput.get("fileContent2");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr2 = new JSONArray(jsonContent);
		responselength = responseArr2.length();
		numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles2");
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		Asserter.assertEquals(numoffiles, noOfFiles);
		pathAssert = testOutput.get("pathassert");
		searchFileNameAssert = testOutput.get("searchFileName");
		fileSizeAssert = testOutput.get("fileSize");
		JSONAsserter.assertJSONObjects(responseArr2.getString(0), "Path", pathAssert);
		JSONAsserter.assertJSONObjects(responseArr2.getString(0), "FileName", searchFileNameAssert);
		JSONAsserter.assertJSONObjects(responseArr2.getString(0), "FileSize", fileSizeAssert);
		logger.info("End Content Search Invalid Input Test");				
	}
	
	@Test(enabled = true)
	public void contentSearchWildChar() throws Exception{
		logger.info("Start Content Search Wild Card Character Input Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("ContentSearchWildChar");
		testOutput = TestDataProvider.getTestOutput("ContentSearchWildChar");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
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
		includeSubFolders = testInput.get("includeSubFolders");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles");
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		Asserter.assertEquals(numoffiles, noOfFiles);
		fileContent = testInput.get("fileContent2");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr2 = new JSONArray(jsonContent);
		responselength = responseArr2.length();
		numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles2");		
		Asserter.assertEquals(numoffiles, noOfFiles);
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		pathAssert = testOutput.get("pathassert");
		searchFileNameAssert = testOutput.get("searchFileName");
		fileSizeAssert = testOutput.get("fileSize");
		JSONAsserter.assertJSONObjects(responseArr2.getString(0), "Path", pathAssert);
		JSONAsserter.assertJSONObjects(responseArr2.getString(0), "FileName", searchFileNameAssert);
		JSONAsserter.assertJSONObjects(responseArr2.getString(0), "FileSize", fileSizeAssert);
				
		searchFileNameAssert = testOutput.get("searchFileName2");
		fileSizeAssert = testOutput.get("fileSize2");
		JSONAsserter.assertJSONObjects(responseArr2.getString(1), "Path", pathAssert);
		JSONAsserter.assertJSONObjects(responseArr2.getString(1), "FileName", searchFileNameAssert);
		JSONAsserter.assertJSONObjects(responseArr2.getString(1), "FileSize", fileSizeAssert);
				
		searchFileNameAssert = testOutput.get("searchFileName3");
		fileSizeAssert = testOutput.get("fileSize3");
		JSONAsserter.assertJSONObjects(responseArr2.getString(2), "Path", pathAssert);
		JSONAsserter.assertJSONObjects(responseArr2.getString(2), "FileName", searchFileNameAssert);
		JSONAsserter.assertJSONObjects(responseArr2.getString(2), "FileSize", fileSizeAssert);
		
		
		logger.info("End Content Search Wild Card Character Input Test");				
	}
	
	@Test(enabled = true)
	public void contentSearchUnicode() throws Exception{
		logger.info("Start Content Search Unicode Character Input Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("ContentSearchUnicode");
		testOutput = TestDataProvider.getTestOutput("ContentSearchUnicode");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
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
		includeSubFolders = testInput.get("includeSubFolders");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles");
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		Asserter.assertEquals(numoffiles, noOfFiles);
				
		logger.info("End Content Search Unicode Character Input Test");				
	}	
	
	@Test(enabled = true)
	public void contentSearchversion() throws Exception{
		logger.info("Start Content Search Version Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("ContentSearchVersion");
		testOutput = TestDataProvider.getTestOutput("ContentSearchVersion");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
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
		includeSubFolders = testInput.get("includeSubFolders");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles");
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		Asserter.assertEquals(numoffiles, noOfFiles);		
		fileContent = testInput.get("fileContent2");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr2 = new JSONArray(jsonContent);
		int responselength2 = responseArr2.length();
		numoffiles = Integer.toString(responselength2);
		noOfFiles = testOutput.get("noOfFiles2");
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		Asserter.assertEquals(numoffiles, noOfFiles); 
				
		logger.info("End Content Search Version Test");				
	}	
	
	@Test(enabled = true)
	public void contentSearchSendOnce() throws Exception{
		logger.info("Start Content Search Send Once Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("ContentSearchSendOnce");
		testOutput = TestDataProvider.getTestOutput("ContentSearchSendOnce");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
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
		includeSubFolders = testInput.get("includeSubFolders");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles");
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		Asserter.assertEquals(numoffiles, noOfFiles);
		pathAssert = testOutput.get("pathassert");
		searchFileNameAssert = testOutput.get("searchFileName");
		fileSizeAssert = testOutput.get("fileSize");
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Path", pathAssert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileName", searchFileNameAssert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileSize", fileSizeAssert);
		
		logger.info("End Content Search Sanity Test");				
	}
	
	@Test(enabled = true)
	public void contentSearchMacOS() throws Exception{
		logger.info("Start Content Search Mac OS Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("ContentSearchSMacOS");
		testOutput = TestDataProvider.getTestOutput("ContentSearchSMacOS");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
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
		includeSubFolders = testInput.get("includeSubFolders");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		noOfFiles = testOutput.get("noOfFiles");
		
		//Capturing the API response and validating them against the response in the test data provider ContentSearchTest.xml
		Asserter.assertEquals(numoffiles, noOfFiles);
		pathAssert = testOutput.get("pathassert");
		searchFileNameAssert = testOutput.get("searchFileName");
		fileSizeAssert = testOutput.get("fileSize");
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Path", pathAssert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileName", searchFileNameAssert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileSize", fileSizeAssert);
		
		logger.info("End Content Search Mac OS Test");				
	}
	
	@Test(enabled = true)
	public void contentSearchMultiDrive() throws Exception{
		logger.info("Start Content Search Sanity Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("ContentSearchMultiDrive");
		testOutput = TestDataProvider.getTestOutput("ContentSearchMultiDrive");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
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
		includeSubFolders = testInput.get("includeSubFolders");
		caseSensitiveStr = testInput.get("caseSensitive"); 
		caseSensitive = Boolean.parseBoolean(caseSensitiveStr);
		searchScope = testInput.get("searchScope"); 
		fileContent = testInput.get("fileContent");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders+" caseSensitive="+caseSensitive+" searchScope="+searchScope+" fileContent="+fileContent);
		
		//Providing the test input to the API
		jsonContent = ContentSearch.contentSearch(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders, caseSensitive, searchScope, fileContent);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength = responseArr.length();
		String numoffiles = Integer.toString(responselength);
		
		//Capturing the API response and validating them against the response in the test data provider
		noOfFiles = testOutput.get("noOfFiles");
		Asserter.assertEquals(numoffiles, noOfFiles);
		pathAssert = testOutput.get("pathassert");
		searchFileNameAssert = testOutput.get("searchFileName");
		fileSizeAssert = testOutput.get("fileSize");
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Path", pathAssert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileName", searchFileNameAssert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileSize", fileSizeAssert);
		
		logger.info("End Content Search Sanity Test");				
	}			
	
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stophttpTest();
	}	
}