package com.ironmountain.kanawha.tests.apitests;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.managementapi.apis.ContentSearch;
import com.ironmountain.kanawha.managementapi.apis.GetRetrievalSetDownload;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.kanawha.managementapi.apis.Search;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.DownloadUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class GetRetrievalSetTest extends HttpJsonAppTest{
	
	int accountNumber = 0;
	String jsonContent, userName = "",password = "", accountNumberString;
	private static final Logger logger = Logger.getLogger(ContentSearch.class.getName());
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	String fileName2,fileName3,path,path2,startBackupDate,noOfFiles,location = null,location2 = null,location3 = null,fileName, backupDate, fileContent,pathAssert,searchFileName,includeSubFolders,searchScope,caseSensitiveStr;
	Boolean caseSensitive = null;
	String[] backupDateString = new String[100];
	Object[] jsonResponseObjects=new Object[100];
	Object[] backupDateObject=new Object[100];
	String[] backupDateList=new String[100];
	int noOfFilesInt;
	ArrayList<HashMap<String,String>> listOfHashMaps = new ArrayList<HashMap<String,String>>();
				
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
		//TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "RetrivalSet.xml");
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "RetrivalSet.xml");
		//Loading Test data provider
	}
	
	
	

	@Test(enabled = true)
	public void GetRetrievalSetOneKBFile() throws Exception{
	logger.info("Start GetRetrievalSet Sanity Test");	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("GetRetrievalSetTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	fileName = testInput.get("Filename");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt = Integer.parseInt(noOfFiles);
	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
	
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);	
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Search and retrieve
	jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
	backupDateList=getBackupDate(jsonContent, "");
	templist[0]= backupDateList[0];
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);		
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	
	JSONObject response = new JSONObject(jsonContent);	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
			
	@Test(enabled = true)
	public void GetRetrievalOneMBfile() throws Exception{
	logger.info("Start GetRetrievalSet Sanity Test 1");
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("GetRetrievalSetTest1");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	fileName = testInput.get("Filename");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt = Integer.parseInt(noOfFiles);

	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Search and Retrieve
	jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
	backupDateList=getBackupDate(jsonContent, "");
	templist[0]= backupDateList[0];
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	
	JSONObject response = new JSONObject(jsonContent);
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	@Test(enabled = true)
	public void GetRetrievalSetTenMBFile() throws Exception{
	logger.info("Start GetRetrievalSet Sanity Test 2");
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("GetRetrievalSetTest2");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	fileName = testInput.get("Filename");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt = Integer.parseInt(noOfFiles);
	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Search and Retrieve
	jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
	backupDateList=getBackupDate(jsonContent, "");
	templist[0]= backupDateList[0];
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	JSONObject response = new JSONObject(jsonContent);
	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	@Test(enabled = true)
	public void GetRetrievalSetHundredMBFile() throws Exception{
	logger.info("Start GetRetrievalSet Sanity Test 3");
	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("GetRetrievalSetTest3");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	fileName = testInput.get("Filename");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt=Integer.parseInt(noOfFiles);
	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Search and Retrieve
	jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
	backupDateList=getBackupDate(jsonContent, "");
	templist[0]= backupDateList[0];
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	
	JSONObject response = new JSONObject(jsonContent);	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	@Test(enabled = true)
	public void GetRetrievalSetThousandMBFile() throws Exception{
	logger.info("Start GetRetrievalSet Sanity Test 4");
	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("GetRetrievalSetTest4");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	fileName = testInput.get("Filename");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt=Integer.parseInt(noOfFiles);
	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Search and Retrieve
	jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
	backupDateList=getBackupDate(jsonContent, "");
	templist[0]= backupDateList[0];
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	
	JSONObject response = new JSONObject(jsonContent);	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	@Test(enabled = true)
	public void GetRetrievalSetOverTousandMBFile() throws Exception{
	logger.info("Start GetRetrievalSet Sanity Test 5");
	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("GetRetrievalSetTest5");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	fileName = testInput.get("Filename");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt=Integer.parseInt(noOfFiles);
	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	//accountNumber = 101002476;
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Search and Retrieve
	jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
	backupDateList=getBackupDate(jsonContent, "");
	templist[0]= backupDateList[0];
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	
	JSONObject response = new JSONObject(jsonContent);	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
		
	@Test(enabled = true)
	public void MultiFileRetrieval() throws Exception{
	logger.info("Start Multiple File Retrieval Test");
	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("MultiFileRetrieval");
	
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	//fileName = testInput.get("Filename1");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt = Integer.parseInt(noOfFiles);
	String[] fileNames = new String[noOfFilesInt];
	String[] templist = new String[noOfFilesInt];
		
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Search and Retrieve
	for(int index=0;index<noOfFilesInt;index++){
		HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		fileNames[index]= testInput.get("Filename"+(index+1));
		jsonContent = Search.search(userName, password, accountNumberString, fileNames[index], path, backupDate, includeSubFolders);
		backupDateList=getBackupDate(jsonContent, "");
		templist[index]= backupDateList[0];
		pathFileHashMap.put(path,fileNames[index]);
		listOfHashMaps.add(pathFileHashMap);
	}	
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	JSONObject response = new JSONObject(jsonContent);
	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
		
	@Test(enabled = true)
	public void RetrievalSpecificDateTime() throws Exception{
	logger.info("Start Retrieval All, Most Recent and Date Test");
	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("RetrievalAllRecentDate");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	fileName = testInput.get("Filename");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt = Integer.parseInt(noOfFiles);
	String[] templist = new String[noOfFilesInt];
		
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Search and Retrieve
	jsonContent = Search.search(userName, password, accountNumberString,fileName, path, backupDate, includeSubFolders);
	backupDateList=getBackupDate(jsonContent, noOfFiles);
	for(int index=0;index<noOfFilesInt;index++){
		HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		templist[index]= backupDateList[index];
		pathFileHashMap.put(path,fileName);
		listOfHashMaps.add(pathFileHashMap);
	}	
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("All", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	JSONObject response = new JSONObject(jsonContent);
	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	@Test(enabled = true)
	public void FileWithoutExtensionTest() throws Exception{
	logger.info("Start Retrieve File without extension Test");
	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("FileWithoutExtensionTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	fileName = testInput.get("Filename");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt=Integer.parseInt(noOfFiles);
	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Search and Retrieve
	jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
	backupDateList=getBackupDate(jsonContent, "");
	templist[0]= backupDateList[0];
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	JSONObject response = new JSONObject(jsonContent);
	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	@Test(enabled = true)
	public void FileRenameAndRetrieve() throws Exception{
	logger.info("Start Retrieve File Rename Test");
	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("FileRenameTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	fileName = testInput.get("Filename");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	location2 = testInput.get("location2");
	fileName2 = testInput.get("Filename2");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt=Integer.parseInt(noOfFiles);
	String[] fileNames = new String[noOfFilesInt];
	String[] templist = new String[noOfFilesInt];
		
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Search and Retrieve
	for(int index=0;index<noOfFilesInt;index++){
		HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		fileNames[index]= testInput.get("Filename"+(index+1));
		jsonContent = Search.search(userName, password, accountNumberString, fileNames[index], path, backupDate, includeSubFolders);
		backupDateList=getBackupDate(jsonContent, "");
		templist[index]= backupDateList[0];
		pathFileHashMap.put(path,fileNames[index]);
		listOfHashMaps.add(pathFileHashMap);
	}
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	JSONObject response = new JSONObject(jsonContent);
	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
		
	@Test(enabled = true)
	public void WinSevenRetrievalTest() throws Exception{
	logger.info("Start Retrieve File Win 7 Test");
	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("WinSevenTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	fileName = testInput.get("Filename");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt=Integer.parseInt(noOfFiles);
	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Search and Retrieve
	jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
	backupDateList=getBackupDate(jsonContent, "");
	templist[0]= backupDateList[0];
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	
	JSONObject response = new JSONObject(jsonContent);
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	//Validate Incorrect Password during download.
	@Test(enabled = true)
	public void IncorrectPasswordDuringDownload() throws Exception{
		logger.info("Start Incorrect Password during download Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("GetRetrievalSetTest1");
		userName = testInput.get("userName");
		password = testInput.get("password");
		path = testInput.get("path");
		fileName = testInput.get("Filename");
		backupDate = testInput.get("startBackupDate");
		location = testInput.get("location");
		includeSubFolders = testInput.get("includeSubfolder");
		noOfFiles=testInput.get("noOfFiles");
		noOfFilesInt = Integer.parseInt(noOfFiles);
		String[] templist = new String[noOfFilesInt];
		HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
			
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Search and Retrieve
		jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
		backupDateList=getBackupDate(jsonContent, "");
		templist[0]= backupDateList[0];
		pathFileHashMap.put(path,fileName);
		listOfHashMaps.add(pathFileHashMap);	
		password="1connected";
		jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
		boolean res = false;
		if (jsonContent.contains("Retrieve authentication Failed!")){
			res = true;
		}
		Asserter.assertEquals(res, true);
		}
		
	
	//Validate null Password during download.
	@Test(enabled = true)
	public void NullPasswordDuringDownload() throws Exception{
		logger.info("Start Incorrect Password during download Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("GetRetrievalSetTest1");
		userName = testInput.get("userName");
		password = testInput.get("password");
		path = testInput.get("path");
		fileName = testInput.get("Filename");
		backupDate = testInput.get("startBackupDate");
		location = testInput.get("location");
		includeSubFolders = testInput.get("includeSubfolder");
		noOfFiles=testInput.get("noOfFiles");
		noOfFilesInt = Integer.parseInt(noOfFiles);
		String[] templist = new String[noOfFilesInt];
		HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Search and Retrieve
		jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
		backupDateList=getBackupDate(jsonContent, "");
		templist[0]= backupDateList[0];
		pathFileHashMap.put(path,fileName);
		listOfHashMaps.add(pathFileHashMap);	
		password=null;
		jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
		boolean res = false;
		if (jsonContent.contains("Retrieve authentication Failed!")){
			res = true;
		}
		Asserter.assertEquals(res, true);
		}
	
	//Validate blank Password during download.
	@Test(enabled = true)
	public void BlankPasswordDuringDownload() throws Exception{
		logger.info("Start Incorrect Password during download Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("GetRetrievalSetTest1");
		userName = testInput.get("userName");
		password = testInput.get("password");
		path = testInput.get("path");
		fileName = testInput.get("Filename");
		backupDate = testInput.get("startBackupDate");
		location = testInput.get("location");
		includeSubFolders = testInput.get("includeSubfolder");
		noOfFiles=testInput.get("noOfFiles");
		noOfFilesInt = Integer.parseInt(noOfFiles);
		String[] templist = new String[noOfFilesInt];
		HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
			
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		//Search and Retrieve
		jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
		backupDateList=getBackupDate(jsonContent, "");
		templist[0]= backupDateList[0];
		pathFileHashMap.put(path,fileName);
		listOfHashMaps.add(pathFileHashMap);	
		password="";
		jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
		boolean res = false;
		if (jsonContent.contains("Retrieve authentication Failed!")){
			res = true;
		}
		Asserter.assertEquals(res, true);
	}
	
	//Validate Password Case Sensitivity  during download.
	@Test(enabled = true)
	public void PasswordCaseSensitivityDuringDownload() throws Exception{
		logger.info("Start Incorrect Password during download Test");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("GetRetrievalSetTest1");
		userName = testInput.get("userName");
		password = testInput.get("password");
		path = testInput.get("path");
		fileName = testInput.get("Filename");
		backupDate = testInput.get("startBackupDate");
		location = testInput.get("location");
		includeSubFolders = testInput.get("includeSubfolder");
		noOfFiles=testInput.get("noOfFiles");
		noOfFilesInt = Integer.parseInt(noOfFiles);
		String[] templist = new String[noOfFilesInt];
		HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
			
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
		
		//Logging to the Kanawha Web Application
		jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");

		//Search and Retrieve
		jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
		backupDateList=getBackupDate(jsonContent, "");
		templist[0]= backupDateList[0];
		pathFileHashMap.put(path,fileName);
		listOfHashMaps.add(pathFileHashMap);	
		password="1ConnecteD";
		jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
		boolean res = false;
		if (jsonContent.contains("Retrieve authentication Failed!")){
			res = true;
		}
		Asserter.assertEquals(res, true);
	}
	
	//Validate All Revisions
	@Test(enabled = true)
	public void AllRevisionsGetRetrievalSet() throws Exception{
	logger.info("Start All revisions retrieval Test");	
	//Get Data from test data
	testInput = TestDataProvider.getTestInput("GetRetrievalSetTest1");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	fileName = testInput.get("Filename");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt=Integer.parseInt(noOfFiles);
	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
	
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);	
	
	//Calling Login API
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");	
	
	//Search and Retrieve
	jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
	backupDateList=getBackupDate(jsonContent, "");
	templist[0]= backupDateList[0];
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("All", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	
	JSONObject response = new JSONObject(jsonContent);	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	//Validate Specific BackUpDate Retrival
	@Test(enabled = true)
	public void SpecificBackupDateGetRetrievalSet() throws Exception{
	logger.info("Start Specific revision retrieval Test");
	//Get Data from test data
	testInput = TestDataProvider.getTestInput("GetRetrievalSetTest1");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	fileName = testInput.get("Filename");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");	
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt=Integer.parseInt(noOfFiles);
	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
	
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);	
	//Calling Login API
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");	
	
	//Search and Retrieve
	jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
	backupDateList=getBackupDate(jsonContent, "");
	templist[0]= backupDateList[0];
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	JSONObject response = new JSONObject(jsonContent);
	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	//Validate AlphaNumeric password on Retrival
	@Test(enabled = true)
	public void AlphaNumericPwdonRetrieve() throws Exception{
	logger.info("Start Specific revision retrieval Test");
	//Get Data from test data
	testInput = TestDataProvider.getTestInput("AlphaNumericPassTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	fileName = testInput.get("Filename");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt=Integer.parseInt(noOfFiles);
	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
	
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);	
	//Calling Login API
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");	
	
	//Search and Retrieve
	jsonContent = Search.search(userName, password, accountNumberString, fileName, path, backupDate, includeSubFolders);
	backupDateList=getBackupDate(jsonContent, "");
	templist[0]= backupDateList[0];
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	JSONObject response = new JSONObject(jsonContent);
	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	//Retrieve a folder which is of a smaller size
	@Test(enabled = true)
	public void smallFolderRetrieve() throws Exception{
	logger.info("Start Small Folder Retrieve Test");
	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("SmallFolderRetrieveTest");
	userName = testInput.get("userName"); 
	password = testInput.get("password");
	path = testInput.get("path");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	fileName = "";
	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Retrieve
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);
	templist=null;
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	JSONObject response = new JSONObject(jsonContent);
	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	//Retrieve a folder which is of a larger size
	@Test(enabled = true)
	public void largeFolderRetrieve() throws Exception{
	logger.info("Start Large Folder Retrieve Test");
	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("LargeFolderRetrieveTest");
	userName = testInput.get("userName"); 
	password = testInput.get("password");
	path = testInput.get("path");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	fileName = "";
	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Retrieve
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);
	templist=null;
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	JSONObject response = new JSONObject(jsonContent);
	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	//This test case verifies the retrieval of compressed files like jar and zip
	@Test(enabled = true)
	public void compressedFilesRetrievalTest() throws Exception{
	logger.info("Start Compressed Files Retrieval Test");	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("compressedFilesRetrievalTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt = Integer.parseInt(noOfFiles);
	String[] templist = new String[noOfFilesInt];
	String[] fileNames = new String[noOfFilesInt];
	String[] paths = new String[noOfFilesInt];
	
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);	
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Search and Retrieve
	for(int index=0;index<noOfFilesInt;index++){
		HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		fileNames[index]= testInput.get("Filename"+(index+1));
		paths[index]= testInput.get("path"+(index+1));
		jsonContent = Search.search(userName, password, accountNumberString, fileNames[index], paths[index], backupDate, includeSubFolders);
		backupDateList=getBackupDate(jsonContent, "");
		templist[index]= backupDateList[0];
		pathFileHashMap.put(paths[index],fileNames[index]);
		listOfHashMaps.add(pathFileHashMap);
	}	
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("All", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	
	JSONObject response = new JSONObject(jsonContent);	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	//This test case verifies the retrieval of PDF's and NSF's
	@Test(enabled = true)
	public void pdfAndNSFRetrievalTest() throws Exception{
	logger.info("Start PDF and NSF Retrieval Test");	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("PDFAndNSFRetrieve");
	userName = testInput.get("userName");
	password = testInput.get("password");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt = Integer.parseInt(noOfFiles);
	String[] templist = new String[noOfFilesInt];
	String[] fileNames = new String[noOfFilesInt];
	String[] paths = new String[noOfFilesInt];
	
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);	
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Search and Retrieve
	for(int index=0;index<noOfFilesInt;index++){
		HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		fileNames[index]= testInput.get("Filename"+(index+1));
		paths[index]= testInput.get("path"+(index+1));
		jsonContent = Search.search(userName, password, accountNumberString, fileNames[index], paths[index], backupDate, includeSubFolders);
		backupDateList=getBackupDate(jsonContent, "");
		templist[index]= backupDateList[0];
		pathFileHashMap.put(paths[index],fileNames[index]);
		listOfHashMaps.add(pathFileHashMap);
	}	
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	
	JSONObject response = new JSONObject(jsonContent);	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	
	}
	
	//This test case verifies the retrieval of compressed files like jar and zip
	@Test(enabled = true)
	public void officeDocumentsRetrievalTest() throws Exception{
	logger.info("Start Office Documents Retrieval Test");	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("OfficeDocsRetrieveTest");
	userName = testInput.get("userName");
	password = testInput.get("password");
	path = testInput.get("path");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	includeSubFolders = testInput.get("includeSubfolder");
	noOfFiles=testInput.get("noOfFiles");
	noOfFilesInt = Integer.parseInt(noOfFiles);
	String[] fileNames = new String[noOfFilesInt];
	String[] templist = new String[noOfFilesInt];
	
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);	
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");	
	
	//Search and Retrieve
	for(int index=0;index<noOfFilesInt;index++){
		HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		fileNames[index]= testInput.get("Filename"+(index+1));
		jsonContent = Search.search(userName, password, accountNumberString, fileNames[index], path, backupDate, includeSubFolders);
		backupDateList=getBackupDate(jsonContent, "");
		templist[index]= backupDateList[0];
		pathFileHashMap.put(path,fileNames[index]);
		listOfHashMaps.add(pathFileHashMap);
	}	
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	
	JSONObject response = new JSONObject(jsonContent);	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	//Retrieve a folder which has more than 5 thousand files
	@Test(enabled = true)
	public void fiveThousandFilesFolderRetrieve() throws Exception{
	logger.info("Start Large Folder Retrieve Test");
	
	//Getting test user name from test data provider 
	testInput = TestDataProvider.getTestInput("FiveThousandFilesFolderRetrieveTest");
	userName = testInput.get("userName"); 
	password = testInput.get("password");
	path = testInput.get("path");
	backupDate = testInput.get("startBackupDate");
	location = testInput.get("location");
	fileName = "";
	String[] templist = new String[noOfFilesInt];
	HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		
	//Getting account number from DB
	accountNumber = CommonUtils.getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber);
	
	//Logging to the Kanawha Web Application
	jsonContent = Login.login(userName, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	
	//Retrieve
	pathFileHashMap.put(path,fileName);
	listOfHashMaps.add(pathFileHashMap);
	templist=null;
	jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, password, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
	JSONObject response = new JSONObject(jsonContent);
	
	Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
	logger.info(response.get("downloadUrl").toString()+"\n"+path);
	DownloadUtils.downloadFileFromURL(response.get("downloadUrl").toString(), location);
	}
	
	public String[] getBackupDate(String jsonResponse,String noOfFiles) throws JSONException{
		JSONArray responseArr = new JSONArray(jsonContent);
		
		if(noOfFiles==""){
			jsonResponseObjects[0]=responseArr.get(0);
			JSONObject jsonResponseIndividualObjects = new JSONObject(jsonResponseObjects[0].toString());
			backupDateObject[0]=jsonResponseIndividualObjects.getString("BackupDate");
			backupDateString[0]=backupDateObject[0].toString();
			return(backupDateString);
		}
		else{
		int noOfFilesInt =Integer.parseInt(noOfFiles);
		for(int i=0;i<noOfFilesInt;i++){
		jsonResponseObjects[i]=responseArr.get(i);
		JSONObject jsonResponseIndividualObjects = new JSONObject(jsonResponseObjects[i].toString());
		backupDateObject[i]=jsonResponseIndividualObjects.getString("BackupDate");
		backupDateString[i]=backupDateObject[i].toString();
		}
		return(backupDateString);
		}
		
	}
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stophttpTest();
	}

}
