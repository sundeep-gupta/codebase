package com.ironmountain.kanawha.tests.apitests;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.managementapi.apis.GetBackupDates;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.kanawha.managementapi.apis.Search;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONConverter;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountBackupDatesTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class SearchTest extends HttpJsonAppTest{
	private static final Logger logger = Logger.getLogger(Search.class.getName());
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	String userName,password,accountNumberString,searchFileName,path,startBackupDate,includeSubFolders = null;
	int accountNumber;
	String noOfFiles = "";
	int responselength = 0;
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "SearchTest.xml");
		
		//Getting test user name from test data provider 
		testInput = TestDataProvider.getTestInput("SimplePosTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
	}
	@Test(enabled = true)
	public void SimplePosTest() throws Exception{
		logger.info("Start SimplePosTest");
		String pathassert,pathassert2,searchFileName2 = null;
		testInput = TestDataProvider.getTestInput("SimplePosTest");
		testOutput = TestDataProvider.getTestOutput("SimplePosTest");
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFolders = testInput.get("includeSubFolders");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		String jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
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
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Path", pathassert2);
		//JSONAsserter.assertJSONObjects(responseArr.getString(1), "Path", pathassert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileName",searchFileName2 );
		//JSONAsserter.assertJSONObjects(responseArr.getString(1), "FileName",searchFileName );
		logger.info("End SimplePosTest");
	}
	
	@Test(enabled = true)
	public void MultiInstancesExtensionsTest() throws Exception{
		logger.info("Start MultiInstancesExtensions Test");
		String pathassert1,pathassert2,noOfFiles = "";
		testInput = TestDataProvider.getTestInput("MultiInstancesExtensionsTest");
		testOutput = TestDataProvider.getTestOutput("MultiInstancesExtensionsTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFolders = testInput.get("includeSubFolders");
		noOfFiles = testOutput.get("noOfFiles");
		pathassert1 = testOutput.get("pathassert1");
		pathassert2 = testOutput.get("pathassert2");
		String jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders);
		JSONArray responseArr = new JSONArray(jsonContent);
		responselength=responseArr.length();
		String numoffiles = Integer.toString(responselength);
		Asserter.assertEquals(numoffiles,noOfFiles);
		//for(int index =0;index < 5;index ++){
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Path", pathassert1);
		//}
		JSONAsserter.assertJSONObjects(responseArr.getString(4), "Path", pathassert2);
		logger.info("End MultiInstancesExtensions Test");
	}
	
	@Test(enabled = true)
	public void SpecialCharactersTest() throws Exception{
		logger.info("Start SpecialCharacters Test");
		String searchFileName1,searchFileName2,searchFileName3,searchFileName4,searchFileName5,searchFileName6,searchFileName7,searchFileName8,searchFileName9,searchFileName10=null;
		testInput = TestDataProvider.getTestInput("SpecialCharactersTest");
		testOutput = TestDataProvider.getTestOutput("SpecialCharactersTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		searchFileName1 = testInput.get("searchFileName1");
		searchFileName2 = testInput.get("searchFileName2");
		searchFileName3 = testInput.get("searchFileName3");
		searchFileName4 = testInput.get("searchFileName4");
		searchFileName5 = testInput.get("searchFileName5");
		searchFileName6 = testInput.get("searchFileName6");
		searchFileName7 = testInput.get("searchFileName7");
		searchFileName8 = testInput.get("searchFileName8");
		searchFileName9 = testInput.get("searchFileName9");
		searchFileName10 = testInput.get("searchFileName10");
		String pathassert = testOutput.get("pathassert");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFolders = testInput.get("includeSubFolders");
		String jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName1+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName1, path, startBackupDate, includeSubFolders);
		JSONArray responseArr = new JSONArray(jsonContent);
		responselength=responseArr.length();
		noOfFiles = testOutput.get("noOfFiles");
		String numfiles = Integer.toString(responselength);
		Asserter.assertEquals(numfiles, noOfFiles);
		logger.info(responseArr.getString(0));
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Path",pathassert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileName",searchFileName1);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName2+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName2, path, startBackupDate, includeSubFolders);
		JSONArray responseArr2 = new JSONArray(jsonContent);
		int responselength2=responseArr2.length();
		noOfFiles = testOutput.get("noOfFiles");
		numfiles = Integer.toString(responselength2);
		Asserter.assertEquals(numfiles, noOfFiles);
		logger.info(responseArr2.getString(0));
		JSONAsserter.assertJSONObjects(responseArr2.getString(0), "FileName",searchFileName2);
		JSONAsserter.assertJSONObjects(responseArr2.getString(0), "Path",pathassert);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName3+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName3, path, startBackupDate, includeSubFolders);
		JSONArray responseArr3 = new JSONArray(jsonContent);
		int responselength3=responseArr3.length();
		noOfFiles = testOutput.get("noOfFiles");
		numfiles = Integer.toString(responselength3);
		Asserter.assertEquals(numfiles, noOfFiles);
		logger.info(responseArr3.getString(0));
		JSONAsserter.assertJSONObjects(responseArr3.getString(0), "FileName",searchFileName3);
		JSONAsserter.assertJSONObjects(responseArr3.getString(0), "Path",pathassert);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName4+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName4, path, startBackupDate, includeSubFolders);
		JSONArray responseArr4 = new JSONArray(jsonContent);
		int responselength4=responseArr4.length();
		noOfFiles = testOutput.get("noOfFiles");
		numfiles = Integer.toString(responselength4);
		Asserter.assertEquals(numfiles, noOfFiles);
		logger.info(responseArr4.getString(0));
		JSONAsserter.assertJSONObjects(responseArr4.getString(0), "FileName",searchFileName4);
		JSONAsserter.assertJSONObjects(responseArr4.getString(0), "Path",pathassert);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName5+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName5, path, startBackupDate, includeSubFolders);
		JSONArray responseArr5 = new JSONArray(jsonContent);
		int responselength5=responseArr5.length();
		noOfFiles = testOutput.get("noOfFiles");
		numfiles = Integer.toString(responselength5);
		Asserter.assertEquals(numfiles, noOfFiles);
		logger.info(responseArr5.getString(0));
		JSONAsserter.assertJSONObjects(responseArr5.getString(0), "FileName",searchFileName5);
		JSONAsserter.assertJSONObjects(responseArr5.getString(0), "Path",pathassert);
		//issue with "_"
		/*logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName6+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumber, searchFileName6, path, startBackupDate, includeSubFolders);
		JSONArray responseArr6 = new JSONArray(jsonContent);
		int responselength6=responseArr6.length();
		noOfFiles = testOutput.get("noOfFiles");
		numfiles = Integer.toString(responselength6);
		Asserter.assertEquals(numfiles, noOfFiles);
		logger.info(responseArr6.getString(0));
		JSONAsserter.assertJSONObjects(responseArr6.getString(0), "FileName",searchFileName6);
		JSONAsserter.assertJSONObjects(responseArr6.getString(0), "Path",pathassert);*/
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName7+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName7, path, startBackupDate, includeSubFolders);
		JSONArray responseArr7 = new JSONArray(jsonContent);
		int responselength7=responseArr7.length();
		noOfFiles = testOutput.get("noOfFiles");
		numfiles = Integer.toString(responselength7);
		Asserter.assertEquals(numfiles, noOfFiles);
		logger.info(responseArr7.getString(0));
		JSONAsserter.assertJSONObjects(responseArr7.getString(0), "FileName",searchFileName7);
		JSONAsserter.assertJSONObjects(responseArr7.getString(0), "Path",pathassert);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName8+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName8, path, startBackupDate, includeSubFolders);
		JSONArray responseArr8 = new JSONArray(jsonContent);
		int responselength8=responseArr8.length();
		noOfFiles = testOutput.get("noOfFiles");
		numfiles = Integer.toString(responselength8);
		Asserter.assertEquals(numfiles, noOfFiles);
		logger.info(responseArr8.getString(0));
		JSONAsserter.assertJSONObjects(responseArr8.getString(0), "FileName",searchFileName8);
		JSONAsserter.assertJSONObjects(responseArr8.getString(0), "Path",pathassert);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName9+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName9, path, startBackupDate, includeSubFolders);
		JSONArray responseArr9 = new JSONArray(jsonContent);
		int responselength9=responseArr9.length();
		noOfFiles = testOutput.get("noOfFiles");
		numfiles = Integer.toString(responselength9);
		Asserter.assertEquals(numfiles, noOfFiles);
		logger.info(responseArr9.getString(0));
		JSONAsserter.assertJSONObjects(responseArr9.getString(0), "FileName",searchFileName9);
		JSONAsserter.assertJSONObjects(responseArr9.getString(0), "Path",pathassert);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName10+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName10, path, startBackupDate, includeSubFolders);
		JSONArray responseArr10 = new JSONArray(jsonContent);
		int responselength10=responseArr10.length();
		noOfFiles = testOutput.get("noOfFiles");
		numfiles = Integer.toString(responselength10);
		Asserter.assertEquals(numfiles, noOfFiles);
		logger.info(responseArr10.getString(0));
		JSONAsserter.assertJSONObjects(responseArr10.getString(0), "FileName",searchFileName10);
		JSONAsserter.assertJSONObjects(responseArr10.getString(0), "Path",pathassert);
		logger.info("End SpecialCharacters Test");
	}
	
	//Bug raised by Mohit
	@Test(enabled = true)
	public void EmoTest() throws Exception{
		logger.info("Start EmoTest");
		String searchFileNamePST,searchFileNameNSF = "";
		testInput = TestDataProvider.getTestInput("EmoTest");
		testOutput = TestDataProvider.getTestOutput("EmoTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);
		searchFileNamePST = testInput.get("searchFileNamePST");
		searchFileNameNSF = testInput.get("searchFileNameNSF");
		path = testInput.get("path");
		noOfFiles = testOutput.get("noOfFiles");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFolders = testInput.get("includeSubFolders");
		String pathassert = testOutput.get("pathassert");
		String jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumberString+" filename="+searchFileNamePST+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileNamePST, path, startBackupDate, includeSubFolders);
		JSONArray responseArr = new JSONArray(jsonContent);
		responselength=responseArr.length();
		String resLength = Integer.toString(responselength);
		Asserter.assertEquals(resLength, noOfFiles);
		logger.info(responseArr.getString(0));
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileName",searchFileNamePST );
		logger.info(pathassert);
		//JSONAsserter.assertJSONObjects(responseArr.getString(0), "Path",pathassert);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Path", pathassert);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumberString+" filename="+searchFileNameNSF+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileNameNSF, path, startBackupDate, includeSubFolders);
		JSONArray responseArr2 = new JSONArray(jsonContent);
		int responselength2=responseArr2.length();
		resLength = Integer.toString(responselength2);
		Asserter.assertEquals(resLength, noOfFiles);
		logger.info(responseArr2.getString(0));
		JSONAsserter.assertJSONObjects(responseArr2.getString(0), "FileName",searchFileNameNSF );
		logger.info(pathassert);
		JSONAsserter.assertJSONObjects(responseArr2.getString(0), "Path",pathassert);
		logger.info("End EmoTest");
	}
	
	@Test(enabled = true)
	public void WildCharTest() throws Exception{
		logger.info("Start WildCharTest");
		testInput = TestDataProvider.getTestInput("WildCharTest");
		testOutput = TestDataProvider.getTestOutput("WildCharTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		searchFileName = testInput.get("searchFileName1");
		String searchFileName2 = testInput.get("searchFileName2");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFolders = testInput.get("includeSubFolders");
		noOfFiles = testOutput.get("noOfFiles");
		String jsonContent = Login.login(userName, password);
	//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength=responseArr.length();
		String numfiles = Integer.toString(responselength);
		Asserter.assertEquals(numfiles, noOfFiles);
		for(int i=0;i<3;i++){
			logger.info(responseArr.getString(i));
			JSONAsserter.assertJSONObjects(responseArr.getString(i), "Path", path);
		}
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName2+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName2, path, startBackupDate, includeSubFolders);
		JSONArray responseArr2 = new JSONArray(jsonContent);
		int responselength2=responseArr2.length();
		String numfiles2 = Integer.toString(responselength);
		Asserter.assertEquals(numfiles2, noOfFiles);
		for(int i=0;i<3;i++){
			logger.info(responseArr.getString(i));
			JSONAsserter.assertJSONObjects(responseArr2.getString(i), "Path", path);
		}
		logger.info("End WildCharTest");
	}
	
	
	@Test(enabled = true)
	public void BackupDateTest() throws Exception{
		logger.info("Start BackupDateTest");
		String startBackupDateAll,startBackupDateRecent,startBackupDateSpecific,pathassertall1,pathassertall2,searchFileName2,searchFileName3,pathassertspecific = null;
		testInput = TestDataProvider.getTestInput("BackupDateTest");
		testOutput = TestDataProvider.getTestOutput("BackupDateTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		searchFileName = testInput.get("searchFileName");
		searchFileName2 = testInput.get("searchFileName2");
		searchFileName3 = testOutput.get("searchFileName3");
		path = testInput.get("path");
		pathassertall1 = testOutput.get("pathassertall1");
		pathassertall2 = testOutput.get("pathassertall2");
		pathassertspecific = testOutput.get("pathassertspecific");
		startBackupDateAll = testInput.get("startBackupDateAll");
		startBackupDateRecent = testInput.get("startBackupDateRecent");
		//startBackupDateSpecific = testInput.get("startBackupDateSpecific");
		logger.info("Getting the backupdate dynamically from the DB");
		String jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		logger.info("Account number is "+ accountNumberString);
		jsonContent = GetBackupDates.getBackupDates(userName, password, accountNumberString);
		Object jsonobj = JSONConverter.json(jsonContent, "DateList/0/UTCDate");
		startBackupDateSpecific = jsonobj.toString();
		logger.info("Specific Backup Date is " + startBackupDateSpecific);
		
		
		includeSubFolders = testInput.get("includeSubFolders");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDateAll+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName, path, startBackupDateAll, includeSubFolders);
		JSONArray responseArr = new JSONArray(jsonContent);
		int responselength1=responseArr.length();
		String numFiles = Integer.toString(responselength1);
		String noOfFilesall = testOutput.get("noOfFilesall"); 
		Asserter.assertEquals(numFiles, noOfFilesall);
		logger.info(pathassertall1);
		logger.info(responseArr.getString(0));
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "FileName",searchFileName3);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Path",pathassertall2);
	//	JSONAsserter.assertJSONObjects(responseArr.getString(1), "FileName",searchFileName);
	//	JSONAsserter.assertJSONObjects(responseArr.getString(1), "Path",pathassertall1);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDateRecent+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName, path, startBackupDateRecent, includeSubFolders);
		JSONArray responseArr2 = new JSONArray(jsonContent);
		int responselength2=responseArr2.length();
		numFiles = Integer.toString(responselength2);
		String noOfFilesrecent = testOutput.get("noOfFilesrecent"); 
		Asserter.assertEquals(numFiles, noOfFilesrecent);
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName2+" path="+path+" startbackupdate="+startBackupDateSpecific+" includesubfolders="+includeSubFolders);
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName2, path, startBackupDateSpecific, includeSubFolders);
		JSONArray responseArr3 = new JSONArray(jsonContent);
		int responselength3=responseArr3.length();
		numFiles = Integer.toString(responselength3);
		String noOfFilesspecific = testOutput.get("noOfFilesspecific"); 
		Asserter.assertEquals(numFiles, noOfFilesspecific);
		logger.info(pathassertall1);
		logger.info(responseArr3.getString(0));
		JSONAsserter.assertJSONObjects(responseArr3.getString(0), "FileName",searchFileName2);
		JSONAsserter.assertJSONObjects(responseArr3.getString(0), "Path",pathassertspecific);
		logger.info("End BackupDateTest");
	}
	
	@Test(enabled = true)
	public void Neg2Test() throws Exception{
		logger.info("Start Neg2Test");
		testInput = TestDataProvider.getTestInput("Neg2Test");
		testOutput = TestDataProvider.getTestOutput("Neg2Test");
		userName = testInput.get("userName");
		password = testInput.get("password");
		searchFileName = testInput.get("searchFileName");
		path = testInput.get("path");
		startBackupDate = testInput.get("startBackupDate");
		includeSubFolders = testInput.get("includeSubFolders");
		logger.info("username="+userName+" password="+password+" accountnumber="+accountNumber+" filename="+searchFileName+" path="+path+" startbackupdate="+startBackupDate+" includesubfolders="+includeSubFolders);
		String jsonContent = Login.login(userName, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		jsonContent = Search.search(userName, password, accountNumberString, searchFileName, path, startBackupDate, includeSubFolders);
		JSONArray responseArr = new JSONArray(jsonContent);
		responselength=responseArr.length();
		noOfFiles = testOutput.get("noOfFiles");
		String numFiles = Integer.toString(responselength);
		Asserter.assertEquals(numFiles, noOfFiles);
		logger.info("End Neg2Test");
	}
	//To Do when exception handling is done in the framework
	/*@Parameters({"userNameNeg", "passwordNeg","accountNumberNeg","searchFileNameNeg","pathNeg","startBackupDateNeg","includeSubFoldersNeg"})
	@Test(enabled = true)
	public void NegativeTest(String userNameNeg,String passwordNeg,String accountNumberNeg, String searchFileNameNeg,String pathNeg,String startBackupDateNeg,String includeSubFoldersNeg) throws Exception{
		logger.info("Start NegativeTest");
		logger.info("username="+userNameNeg+" password="+passwordNeg+" accountnumber="+accountNumberNeg+" filename="+searchFileNameNeg+" path="+pathNeg+" startbackupdate="+startBackupDateNeg+" includesubfolders="+includeSubFoldersNeg);
		String jsonContent = Login.login(userNameNeg, passwordNeg);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		jsonContent = Search.search(userNameNeg, passwordNeg, accountNumberNeg, searchFileNameNeg, pathNeg, startBackupDateNeg, includeSubFoldersNeg);
		logger.info("End NegativeTest");
	}*/
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stophttpTest();
	}

}
