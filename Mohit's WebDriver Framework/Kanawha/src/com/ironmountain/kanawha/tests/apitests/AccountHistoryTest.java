package com.ironmountain.kanawha.tests.apitests;

import java.io.StringReader;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;
import java.util.TimeZone;

import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.testng.annotations.BeforeMethod;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.ironmountain.kanahwa.exceptions.handler.ApiExceptionHandler;
import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.managementapi.apis.AccountHistory;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountUserLogsTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;

public class AccountHistoryTest extends HttpJsonAppTest
{
	private static final Logger logger = Logger.getLogger(AccountHistoryTest.class.getName());
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	//private static HashMap<String, String> testOutput = new HashMap<String,String>();
	AccountUserLogsTable accountUserLogs = new AccountUserLogsTable(DatabaseServer.COMMON_SERVER);
	//ActivityTable activity = new ActivityTable(DatabaseServer.COMMON_SERVER);
	//AccountSizeTable accountSize = new AccountSizeTable(DatabaseServer.COMMON_SERVER);
	//String userName,password,jsonContent= "";
	int accountNumber = 0;
	String typeStart = "StartTime";
	ArrayList<String> backupStartTime  = null;
	ArrayList<String> backupDatesList = null;
	
	//HashMap< Integer, String> mapBackupPathID = new HashMap< Integer, String>();
	
	String [] EventTypeArray =
	{
			/*0 =*/ "Backup",
			/*1 =*/ "Restore",
			/*2 =*/ "Heal",
			/*3 =*/ "None",
			/*4 =*/ "Settings",
			/*5 =*/ "Registration",
			/*6 =*/ "Rules",
			/*7 =*/ "Synchronization",
			/*8 =*/ "Upgrade",
			/*9 =*/ "AccountRecovery" 
	};
	
	String [] EventStatusArray =
	{
			/*0 =*/ "Canceled",
			/*1 =*/ "Completed",
			/*2 =*/ "CompletedWithWarnings",
			/*3 =*/ "CompletedWithErrors",
			/*4 =*/ "Incomplete",
			/*5 =*/ "SyncCancelled",
		   	/*6 =*/ "ErrorParsingXML"
	};
	
  /*  String [] EventDetailsTagNames =
	{
			0 = "Error",
			1 = "Warning"
	};*/
	
    String activityID = "Activity_ID"; //This is the ID in the LogsBundle.js file for any non-backup activity.
    
	String [] NotificationTypes = 
	{
			/*0 =*/ "Error",
			/*1 =*/ "Warning",
			/*2 =*/ "Activity"
	};
	
	static final int FilesToBackupSummaryId = 1216499252;
	static final int SizeAfterCompressionSumaryId = 1216499256;
	static final int FilesNotBackedupSummaryId = 1216499506;
	static final int SizeAfterOptimizationSummaryId =1216499510;
	static final int BackupSetSizeSummaryId = 1216499512;
		
	DocumentBuilderFactory detailsFactory = DocumentBuilderFactory.newInstance();
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception
	{
		super.inithttpTest();
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "AccountHistory.xml");
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historySummaryTestBigAcc() throws Exception
	{
		logger.info("Start historySummaryTestBigAcc");
		testInput = TestDataProvider.getTestInput("historySummaryTestBigAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		
		int HistorySumSize = Integer.parseInt(testInput.get("historySummarySize"));
		
		validateHistorySummary( userName, password, HistorySumSize );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historySummaryTestMACAcc() throws Exception
	{
		logger.info("Start historySummaryTestMACAcc");
		testInput = TestDataProvider.getTestInput("historySummaryTestMACAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		
		int HistorySumSize = Integer.parseInt(testInput.get("historySummarySize"));
		
		validateHistorySummary( userName, password, HistorySumSize );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historySummaryTestEmptyAcc() throws Exception
	{
		logger.info("Start historySummaryTestEmptyAcc");
		testInput = TestDataProvider.getTestInput("historySummaryTestEmptyAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		
		int HistorySumSize = Integer.parseInt(testInput.get("historySummarySize"));
		
		validateHistorySummary( userName, password, HistorySumSize );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historySummaryTestOneDay() throws Exception
	{
		logger.info("Start historySummaryTestOneDay");
		testInput = TestDataProvider.getTestInput("historySummaryTestOneDay");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		
		int HistorySumSize = Integer.parseInt(testInput.get("historySummarySize"));
		
		validateHistorySummary( userName, password, HistorySumSize );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historySummaryTestAllDates() throws Exception
	{
		logger.info("Start historySummaryTestAllDates");
		testInput = TestDataProvider.getTestInput("historySummaryTestAllDates");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		
		int HistorySumSize = Integer.parseInt(testInput.get("historySummarySize"));
		
		validateHistorySummary( userName, password, HistorySumSize );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historySummaryTestTenDates() throws Exception
	{
		logger.info("Start historySummaryTestTenDates");
		testInput = TestDataProvider.getTestInput("historySummaryTestTenDates");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		
		int HistorySumSize = Integer.parseInt(testInput.get("historySummarySize"));
		
		validateHistorySummary( userName, password, HistorySumSize );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historySummaryTestCancelAcc() throws Exception
	{
		logger.info("Start historySummaryTestCancelAcc");
		testInput = TestDataProvider.getTestInput("historySummaryTestCancelAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		
		int HistorySumSize = Integer.parseInt(testInput.get("historySummarySize"));
		
		validateHistorySummary( userName, password, HistorySumSize );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historySummaryTestOnHoldAcc() throws Exception
	{
		logger.info("Start historySummaryTestOnHoldAcc");
		testInput = TestDataProvider.getTestInput("historySummaryTestOnHoldAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		
		int HistorySumSize = Integer.parseInt(testInput.get("historySummarySize"));
		
		validateHistorySummary( userName, password, HistorySumSize );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyNotificationsTestBigAcc() throws Exception
	{
		logger.info("Start historyNotificationsTestBigAcc");
		testInput = TestDataProvider.getTestInput("historyNotificationsTestBigAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		//Get The Backup History Notifications
		
		validateHistoryNotifications( userName, password);
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyNotificationsTestMACAcc() throws Exception
	{
		logger.info("Start historyNotificationsTestMACAcc");
		testInput = TestDataProvider.getTestInput("historyNotificationsTestMACAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		//Get The Backup History Notifications
		
		validateHistoryNotifications( userName, password);
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyNotificationsTestEmptyAcc() throws Exception
	{
		logger.info("Start historyNotificationsTestEmptyAcc");
		testInput = TestDataProvider.getTestInput("historyNotificationsTestEmptyAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		//Get The Backup History Notifications
		
		validateHistoryNotifications( userName, password);
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyNotificationsTestOneDay() throws Exception
	{
		logger.info("Start historyNotificationsTestOneDay");
		testInput = TestDataProvider.getTestInput("historyNotificationsTestOneDay");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		//Get The Backup History Notifications
		
		validateHistoryNotifications( userName, password);
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyNotificationsTestCancelAcc() throws Exception
	{
		logger.info("Start historyNotificationsTestCancelAcc");
		testInput = TestDataProvider.getTestInput("historyNotificationsTestCancelAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		//Get The Backup History Notifications
		
		validateHistoryNotifications( userName, password);
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyNotificationsTestOnHoldAcc() throws Exception
	{
		logger.info("Start historyNotificationsTestOnHoldAcc");
		testInput = TestDataProvider.getTestInput("historyNotificationsTestOnHoldAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		loginAndValidateBackupDates( userName, password );
		//Get The Backup History Notifications
		
		validateHistoryNotifications( userName, password);
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyFileListTestBigAcc() throws Exception
	{
		logger.info("Start historyFileListTestBigAcc");
		testInput = TestDataProvider.getTestInput("historyFileListTestBigAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		//Getting account number from DB
		loginAndValidateBackupDates( userName, password );
		
		//getBackupPathsFromDB(accountNumber);
		
		//Get The Backup History File List
		validateFileList( userName, password );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyFileListTestMACAcc() throws Exception
	{
		logger.info("Start historyFileListTestMACAcc");
		testInput = TestDataProvider.getTestInput("historyFileListTestMACAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		//Getting account number from DB
		loginAndValidateBackupDates( userName, password );
		
		//getBackupPathsFromDB(accountNumber);
		
		//Get The Backup History File List
		validateFileList( userName, password );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyFileListTestEmptyAcc() throws Exception
	{
		logger.info("Start historyFileListTestEmptyAcc");
		testInput = TestDataProvider.getTestInput("historyFileListTestEmptyAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		//Getting account number from DB
		loginAndValidateBackupDates( userName, password );
		
		//getBackupPathsFromDB(accountNumber);
		
		//Get The Backup History File List
		validateFileList( userName, password );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyFileListTestOneDay() throws Exception
	{
		logger.info("Start historyFileListTestOneDay");
		testInput = TestDataProvider.getTestInput("historyFileListTestOneDay");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		//Getting account number from DB
		loginAndValidateBackupDates( userName, password );
		
		//getBackupPathsFromDB(accountNumber);
		
		//Get The Backup History File List
		validateFileList( userName, password );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyFileListTestCancelAcc() throws Exception
	{
		logger.info("Start historyFileListTestCancelAcc");
		testInput = TestDataProvider.getTestInput("historyFileListTestCancelAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		//Getting account number from DB
		loginAndValidateBackupDates( userName, password );
		
		//getBackupPathsFromDB(accountNumber);
		
		//Get The Backup History File List
		validateFileList( userName, password );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyFileListTestOnHoldAcc() throws Exception
	{
		logger.info("Start historyFileListTestOnHoldAcc");
		testInput = TestDataProvider.getTestInput("historyFileListTestOnHoldAcc");
		//testOutput = TestDataProvider.getTestOutput("historyMainTest");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		
		//Getting account number from DB
		loginAndValidateBackupDates( userName, password );
		
		//getBackupPathsFromDB(accountNumber);
		
		//Get The Backup History File List
		validateFileList( userName, password );
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyTestZeroAccNum() throws Exception
	{
		logger.info("Start historyTestZeroAccNum");
		testInput = TestDataProvider.getTestInput("historyTestZeroAccNum");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		String errorCode = testInput.get("expectedErrorCode");
		
		String jsonContent = Login.login(userName, password);
		
		accountNumber = 0;
		logger.info("Calling GetHistoryDates api");
		jsonContent = AccountHistory.GetHistoryDates(userName, password, accountNumber);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		String fromDate = "2011-08-08", toDate = "2011-08-08";
		
		logger.info("Calling GetHistorySummary api");
		jsonContent = AccountHistory.GetHistorySummary(userName, password, accountNumber, fromDate, toDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		logger.info("Calling GetHistoryNotifications api");
		jsonContent = AccountHistory.GetHistoryNotifications(userName, password, accountNumber, fromDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		logger.info("Calling GetHistoryFileDetails api");
		jsonContent = AccountHistory.GetHistoryFileDetails(userName, password, accountNumber, toDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyTestMinusOneAccNum() throws Exception
	{
		logger.info("Start historyTestMinusOneAccNum");
		testInput = TestDataProvider.getTestInput("historyTestMinusOneAccNum");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		String errorCode = testInput.get("expectedErrorCode");
		
		String jsonContent = Login.login(userName, password);
		
		accountNumber = -1;
		logger.info("Calling GetHistoryDates api");
		jsonContent = AccountHistory.GetHistoryDates(userName, password, accountNumber);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		String fromDate = "2011-08-08", toDate = "2011-08-08";
		
		logger.info("Calling GetHistorySummary api");
		jsonContent = AccountHistory.GetHistorySummary(userName, password, accountNumber, fromDate, toDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		logger.info("Calling GetHistoryNotifications api");
		jsonContent = AccountHistory.GetHistoryNotifications(userName, password, accountNumber, fromDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		logger.info("Calling GetHistoryFileDetails api");
		jsonContent = AccountHistory.GetHistoryFileDetails(userName, password, accountNumber, toDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyTestRandomNegativeAccNum() throws Exception
	{
		logger.info("Start historyTestRandomNegativeAccNum");
		testInput = TestDataProvider.getTestInput("historyTestRandomNegativeAccNum");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		String errorCode = testInput.get("expectedErrorCode");
		
		String jsonContent = Login.login(userName, password);
		
		Random accNumGenerator = new Random();
	
		accountNumber = accNumGenerator.nextInt( 1000000000 ) * -1;
		logger.info("Calling GetHistoryDates api");
		jsonContent = AccountHistory.GetHistoryDates(userName, password, accountNumber);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		String fromDate = "2011-08-08", toDate = "2011-08-08";
		
		logger.info("Calling GetHistorySummary api");
		jsonContent = AccountHistory.GetHistorySummary(userName, password, accountNumber, fromDate, toDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		logger.info("Calling GetHistoryNotifications api");
		jsonContent = AccountHistory.GetHistoryNotifications(userName, password, accountNumber, fromDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		logger.info("Calling GetHistoryFileDetails api");
		jsonContent = AccountHistory.GetHistoryFileDetails(userName, password, accountNumber, toDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyTestRandomPositiveAccNum() throws Exception
	{
		logger.info("Start historyTestRandomPositiveAccNum");
		testInput = TestDataProvider.getTestInput("historyTestRandomPositiveAccNum");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		String errorCode = testInput.get("expectedErrorCode");
		
		String jsonContent = Login.login(userName, password);
		
		Random accNumGenerator = new Random();
	
		accountNumber = accNumGenerator.nextInt( 100000000 );
		logger.info("Calling GetHistoryDates api");
		jsonContent = AccountHistory.GetHistoryDates(userName, password, accountNumber);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		String fromDate = "2011-08-08", toDate = "2011-08-08";
		
		logger.info("Calling GetHistorySummary api");
		jsonContent = AccountHistory.GetHistorySummary(userName, password, accountNumber, fromDate, toDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		logger.info("Calling GetHistoryNotifications api");
		jsonContent = AccountHistory.GetHistoryNotifications(userName, password, accountNumber, fromDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		logger.info("Calling GetHistoryFileDetails api");
		jsonContent = AccountHistory.GetHistoryFileDetails(userName, password, accountNumber, toDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
	}
	
	@org.testng.annotations.Test(enabled = true)
	public void historyTestInvalidDates() throws Exception
	{
		logger.info("Start historyTestInvalidDates");
		testInput = TestDataProvider.getTestInput("historyTestInvalidDates");
		
		//sourcing inputs and outputs from Test data provider
		String userName = testInput.get("userName");
		logger.info(userName);
		String password = testInput.get("password");
		String errorCode = testInput.get("expectedErrorCode");
		
		String accNum = testInput.get("accountNumber");
		if(null == accNum )
			accountNumber = CommonUtils.getAccountNumber(userName);
		else
			accountNumber = Integer.parseInt(accNum);
		
		String jsonContent = Login.login(userName, password);
		
		String fromDate = "InvalidDate", toDate = "2011-08-08";
		
		logger.info("Calling GetHistorySummary api with invalid fromDate");
		jsonContent = AccountHistory.GetHistorySummary(userName, password, accountNumber, fromDate, toDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		logger.info("Calling GetHistorySummary api with invalid toDate");
		jsonContent = AccountHistory.GetHistorySummary(userName, password, accountNumber, toDate, fromDate);
		
		logger.info("Calling GetHistorySummary api with invalid fromDate and toDate");
		jsonContent = AccountHistory.GetHistorySummary(userName, password, accountNumber, fromDate, fromDate);
		
		logger.info("Calling GetHistoryNotifications api with invalid date");
		jsonContent = AccountHistory.GetHistoryNotifications(userName, password, accountNumber, fromDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
		
		logger.info("Calling GetHistoryFileDetails api invalid date");
		jsonContent = AccountHistory.GetHistoryFileDetails(userName, password, accountNumber, fromDate);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", errorCode);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", ApiExceptionHandler.getErrorMessage(errorCode));
	}

	private void loginAndValidateBackupDates( String userName, String password ) throws Exception
	{
		//Getting account number from DB
		
		String accNum = testInput.get("accountNumber");
		if(null == accNum )
			accountNumber = CommonUtils.getAccountNumber(userName);
		else
			accountNumber = Integer.parseInt(accNum);
		
		//Calling API's
		logger.info("Calling login api");
		String jsonContent = Login.login(userName, password);
		logger.info("Calling GetHistoryDates api");
		jsonContent = AccountHistory.GetHistoryDates(userName, password, accountNumber);
		
		//Sourcing Event dates from DB
		backupStartTime = accountUserLogs.returnStartEndTime(typeStart, accountNumber);
		backupDatesList = new ArrayList<String>();
		for( int i = 0, j = 0; i < backupStartTime.size(); i++ )
		{
			String BackupDate = backupStartTime.get( i ).substring(0, 10);
			if( !backupDatesList.contains( BackupDate ))
			{
				JSONAsserter.assertJSONObjects(jsonContent, ""+j , BackupDate);
				backupDatesList.add(BackupDate);
				j++;
			}
		}
	}
	
	private void validateHistorySummary( String userName, String password, int numDates ) throws Exception
	{
		boolean getSummary = true;
		int backupDatesDone = 0, backupDatesTotal;
		backupDatesTotal = backupDatesList.size();
		while( getSummary && !backupDatesList.isEmpty() )
		{
			String fromDate = null, toDate = null;
			if( 0 != numDates || -1 != numDates )
			{
				if(1 < ( (backupDatesTotal - backupDatesDone) / numDates ) )
				{
					fromDate = backupDatesList.get( backupDatesTotal - backupDatesDone - 1 );
					toDate = backupDatesList.get(backupDatesTotal - backupDatesDone - numDates );
					
					backupDatesDone += numDates;
					
					getSummary = true;
				}
				else
				{
					fromDate = backupDatesList.get( backupDatesTotal - backupDatesDone - 1 );
					toDate = backupDatesList.get( 0 );
					
					backupDatesDone = backupDatesTotal;
					getSummary = false;
				}
			}
			else if( 0 != numDates )
			{
				fromDate = backupDatesList.get( backupDatesTotal - 1 );
				toDate = backupDatesList.get( 0 );
				
				backupDatesDone = backupDatesTotal;
				getSummary = false;
			}
			else
			{
				logger.error("The number of dates to get Sumamry for is: " +numDates +".\nThis is for Null as date value and should be hadled by the test case seperately.");
				Asserter.assertTrue( 0 != numDates );
			}
			
			String jsonContent = AccountHistory.GetHistorySummary(userName, password, accountNumber, fromDate, toDate );
			JSONArray summaryArray = new JSONArray( jsonContent );
			
			int i = 0;
			do
			{
				JSONObject summaryObject = summaryArray.getJSONObject( i );
				Asserter.assertEquals( summaryObject.getString("date"), backupDatesList.get( backupDatesTotal - backupDatesDone + i ));
				ResultSet historySummary = accountUserLogs.returnEventsForDate(accountNumber, backupDatesList.get( backupDatesTotal - backupDatesDone + i ) );
				
				boolean assertedStatus = false, backupSetSizeChecked = false;;
				
				long backupSizeAfterCompression = 0, backupSizeAfterOptimization = 0;
				while(historySummary.next())
				{
					if( 0 != historySummary.getInt("Type"))
						continue;
					
					String detailsXML = "<test>" + historySummary.getString("Details") + "</test>";
					logger.info( "Event Details XML from DB: " + detailsXML );
					NodeList summaryList = returnElementListForTag(detailsXML, "lineItem");
					
					logger.info("XML Date is: " +  backupDatesList.get( backupDatesTotal - backupDatesDone + i ));
					logger.info("JSON Date is: " + summaryObject.getString("date"));
					
					for( int j = 0; j < summaryList.getLength(); j++ )
					{
						Node lineItemNode = summaryList.item(j);
						
						int summaryId = Integer.parseInt(lineItemNode.getAttributes().item(0).getNodeValue());
						NodeList argList = lineItemNode.getChildNodes().item( 0 ).getChildNodes();
						
						switch( summaryId )
						{
							case BackupSetSizeSummaryId:
								if( !backupSetSizeChecked )
								{
									Asserter.assertEquals( summaryObject.getString("backupsetSize" ), argList.item( 0 ).getTextContent());
									backupSetSizeChecked = true;
								}
								break;
							case FilesNotBackedupSummaryId:
								//TBD
								break;
							case FilesToBackupSummaryId:
								//TBD
								break;
							case SizeAfterOptimizationSummaryId:
								backupSizeAfterOptimization += Long.parseLong(argList.item( 0 ).getTextContent());
								break;
							case SizeAfterCompressionSumaryId:
								backupSizeAfterCompression += Long.parseLong(argList.item( 0 ).getTextContent());
								break;
							default:
								break;
						}
					}
					if( !assertedStatus )
					{
						int status = Integer.parseInt(historySummary.getString("Status"));
						Asserter.assertEquals( summaryObject.getString("backupStatus"), EventStatusArray[ status ]);
						assertedStatus = true;
					}
				}
				
				if( !assertedStatus )
				{
					historySummary.first();
					int status = Integer.parseInt(historySummary.getString("Status"));
					Asserter.assertEquals( summaryObject.getString("backupStatus"), EventTypeArray[ status ]);
					assertedStatus = true;
				}
				
				DecimalFormat formatForGB = new DecimalFormat("###.##");
				
				long optimizedSizeKB = backupSizeAfterOptimization / 1024, optimizedSizeMB = backupSizeAfterOptimization / (1024 * 1024);
				double optimizedSizeGB = (double)backupSizeAfterOptimization / (1024 * 1024 *1024);
				
				if( 0 != optimizedSizeKB  )
					if( 0 != optimizedSizeMB )
						if( 1 < optimizedSizeGB )
							Asserter.assertEquals(summaryObject.getString("backupSizeAfterOptimization"), formatForGB.format(optimizedSizeGB) + "GB" );
						else
							Asserter.assertEquals(summaryObject.getString("backupSizeAfterOptimization"), Long.toString(optimizedSizeMB) + "MB" );
					else
						Asserter.assertEquals(summaryObject.getString("backupSizeAfterOptimization"), Long.toString(optimizedSizeKB) + "KB" );
				else
					Asserter.assertEquals(summaryObject.getString("backupSizeAfterOptimization"), Long.toString(backupSizeAfterOptimization) + "B" );
				
				
				long compressedSizeKB = backupSizeAfterCompression / 1024, compressedSizeMB = backupSizeAfterCompression / (1024 * 1024);
				double compressedSizeGB = (double)backupSizeAfterCompression / (1024 * 1024 *1024);
				
				if( 0 != compressedSizeKB  )
					if( 0 != compressedSizeMB )
						if( 1 < compressedSizeGB )
							Asserter.assertEquals(summaryObject.getString("backupSizeAfterCompression"), formatForGB.format(compressedSizeGB) + "GB" );
						else
							Asserter.assertEquals(summaryObject.getString("backupSizeAfterCompression"), Long.toString(compressedSizeMB) + "MB" );
					else
						Asserter.assertEquals(summaryObject.getString("backupSizeAfterCompression"), Long.toString(compressedSizeKB) + "KB" );
				else
					Asserter.assertEquals(summaryObject.getString("backupSizeAfterCompression"), Long.toString(backupSizeAfterCompression) + "B" );
				
				i++;
			}while( i < summaryArray.length() );
		}
	}
	
	private void validateHistoryNotifications (String userName, String password ) throws Exception
	{
		for( int i = 0; i < backupDatesList.size(); i++ )
		{
			String jsonContent = AccountHistory.GetHistoryNotifications(userName, password, accountNumber, backupDatesList.get( i ));
			JSONArray notificationsArray = new JSONArray( jsonContent );
			
			ResultSet historyNotifications = accountUserLogs.returnEventsForDate(accountNumber, backupDatesList.get( i ));
			
			int notificationsArrayCounter = 0;
			while(historyNotifications.next())
			{
				for(; notificationsArrayCounter < notificationsArray.length(); )
				{
					JSONObject notificationObject=null;
					if( 0 != historyNotifications.getInt("type") )
					{
						notificationObject = notificationsArray.getJSONObject( notificationsArrayCounter++ );
						Asserter.assertEquals(notificationObject.getString("type"), NotificationTypes[ 2 ]);
						
						DateFormat DBFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
						DBFormat.setTimeZone(TimeZone.getTimeZone("GMT"));
						
						long activityTime = DBFormat.parse(historyNotifications.getString( "StartTime" )).getTime() + getDCTimeDiffFromGMTInMilliSeconds();
						
						Asserter.assertEquals(notificationObject.getString("time"), DateUtils.getUTCDateFromTDateLongInGMT(activityTime));
						Asserter.assertEquals(notificationObject.getString("detailID"), activityID);
						
						JSONArray argsArray = notificationObject.getJSONArray("args");
						Asserter.assertEquals( argsArray.length(),  2 );
						int activityType = historyNotifications.getInt( "type");
						Asserter.assertEquals( argsArray.get( 0 ), EventTypeArray[ activityType ] );
						int activityStatus = historyNotifications.getInt( "status");
						Asserter.assertEquals( argsArray.get( 1 ), EventStatusArray[ activityStatus ] );
					}
					else
					{
						for( String tag : NotificationTypes )
						{
							boolean notificationsIncremented = false;
							if( tag.equals( NotificationTypes[ 2 ]))
							{
								if( !notificationsIncremented )
									notificationsArrayCounter++;
								continue;
							}
							
							String detailsXML = "<test>" + historyNotifications.getString("Details") + "</test>";
							NodeList notificationsList = returnElementListForTag(detailsXML, tag);
						
							if( 0 < notificationsList.getLength() )
							{
								for( int k = 0; k < notificationsList.getLength(); k++ )
								{
									notificationObject = notificationsArray.getJSONObject( notificationsArrayCounter + k );
									if( ! notificationObject.getString("type" ).equalsIgnoreCase(tag))
										continue;
									
									String eventDate1 = notificationsList.item(k).getAttributes().item( 0 ).getNodeValue();
									String eventDate = DateUtils.getUTCDateFromTDateStringInGMT(eventDate1);
									
									Asserter.assertEquals(notificationObject.getString("date"), eventDate);
									Asserter.assertEquals(notificationObject.getString( "detailID" ), notificationsList.item(k).getChildNodes().item(0).getAttributes().item( 0 ).getNodeValue());
									JSONArray argsArray = notificationObject.getJSONArray("args");
									
									NodeList argsList =  notificationsList.item(k).getChildNodes().item(0).getChildNodes();
									
									Asserter.assertEquals(argsArray.length(), argsList.getLength() );
									
									for( int l = 0; l < argsArray.length(); l++ )
									{
										Asserter.assertEquals(argsArray.get( l ), argsList.item(l).getNodeValue() );
									}
								}
								notificationsArrayCounter+=notificationsList.getLength();
								notificationsIncremented = true;
							}
						}
					}
				}
			}
		}
	}
	
	private void validateFileList(String userName, String password ) throws Exception
	{
		for( int i = 0; i < backupDatesList.size(); i++ )
		{
			String jsonContent = AccountHistory.GetHistoryFileDetails(userName, password, accountNumber, backupDatesList.get( i ) );
			JSONArray fileDetailsArray = new JSONArray(jsonContent);

			ResultSet fileListFromDB = getFileListForDateFromDB(accountNumber, backupDatesList.get( i ));
			HashMap <String, String> DBFileListMap = new HashMap <String, String>();
			
			int DbFileCount = 0, JSONFileCount = 0;;
			while(fileListFromDB.next())
			{
				DbFileCount++;
				String expectedFileListKey = fileListFromDB.getString("fileName") + fileListFromDB.getString("name") + DateUtils.getUTCDateFromTDateStringInGMT(fileListFromDB.getString("tdate"));
				DBFileListMap.put(expectedFileListKey, fileListFromDB.getString("fileName"));
			}
			
			fileListFromDB.close();
			
			for ( int j = 0; j < fileDetailsArray.length(); j++ )
			{
				//Asserter.assertTrue( fileListFromDB.next(), "File list returned from API is more than the DB File list" );
				
				JSONObject fileDetails = fileDetailsArray.getJSONObject( j );
				
				
				if( fileDetails.get( "type" ).equals(""))
				{
					JSONFileCount++;
					String actualFileListKey = fileDetails.getString( "fileName" ) + fileDetails.getString( "filePath" ) + fileDetails.getString( "time" );
					Asserter.assertTrue(DBFileListMap.containsKey(actualFileListKey), "File in JSON response not present in DB");
				}
			}
			
			Asserter.assertEquals(JSONFileCount, DbFileCount);
		}
	}
	
	private NodeList returnElementListForTag( String detailsXML, String tag ) throws Exception
	{
		Document eventDetailsDoc = detailsFactory.newDocumentBuilder().parse( new InputSource( new StringReader( detailsXML )));
		
		return eventDetailsDoc.getElementsByTagName( tag);
	}
	
	private ResultSet getFileListForDateFromDB(int accountNumber, String date) throws Exception
	{
		long TDate = DateUtils.getTdateFromUTCDate( date ) / 1000; //TDate in Seconds
		long nextTDate = TDate + 86400; // Add seconds for 24 hrs
		QueryExecutor qe = new QueryExecutor(DatabaseServer.COMMON_SERVER, "DIRECTORY");
		
		String query = "SELECT DISTINCT FileName, name, TDate, Mdate, OrigSize, FileAttributeData, pn.name FROM FileIndex fi (NOLOCK) JOIN PathNames pn (NOLOCK)" +
				" ON pn.NameID = fi.PathID WHERE Kind IN (0, 2, 15) AND Type NOT IN (11, 10, 4) AND account='" +accountNumber+"' and (tdate>'"+TDate+"' and tdate < '"+nextTDate+"') and filename <> '.' " +
						"order by pn.name asc, FileName asc, TDate desc";
		
		ResultSet res = qe.executeQuery(query);
		
		return res;
	}
	
	private long getDCTimeDiffFromGMTInMilliSeconds() throws SQLException
	{
		//String query = "select datediff(millisecond, SYSDATETIME(), SYSUTCDATETIME())";
		String query = "select datediff(second, GETDATE(), GETUTCDATE())";
		QueryExecutor qe = new QueryExecutor(DatabaseServer.COMMON_SERVER, "DIRECTORY");
		ResultSet res = qe.executeQuery(query);
		res.next();
		return res.getLong(1)*1000;
	}
}
