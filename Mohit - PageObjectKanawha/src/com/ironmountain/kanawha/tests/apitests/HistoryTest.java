package com.ironmountain.kanawha.tests.apitests;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.httpclient.util.DateUtil;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.managementapi.apis.History;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.kanawha.managementapi.apis.Search;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountBackupDatesTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountProfileTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountSizeTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountUserLogsTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.ActivityTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CdqTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;


public class HistoryTest extends HttpJsonAppTest{
	int accountNumber = 0;
	String dateFormatApiStart,dateFormatApiEnd,dateFormatAPI,jsonContent = null;
	String lastBackupdatedb,lastBackupdateApi,dayOfWeek,returnSizeWithUnits = null;
	String[] dates = null;
	ArrayList<String> resultSetStart,resultSetEnd,returnStartTime,returnEndTime = null;
	String typeStart = "StartTime",typeEnd = "EndTime";
	String myRoamSizeWithUnits = "";
	double myRoamRoundOff = 0;
	AccountUserLogsTable accountLog = new AccountUserLogsTable(DatabaseServer.COMMON_SERVER);
	AccountBackupDatesTable accountBackupObject = new AccountBackupDatesTable(DatabaseServer.COMMON_SERVER);
	AccountSizeTable accountSizeObject = new AccountSizeTable(DatabaseServer.COMMON_SERVER);
	private static final Logger logger = Logger.getLogger(Search.class.getName());
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
		
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
	super.inithttpTest();
	logger.info("loadTestDataXML");
	TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "HistoryTest.xml");
	}

@Parameters({"username", "password"})
@Test(enabled = true)
public void backupHistoryTest(String username,String password) throws Exception{
	logger.info("Start Backup History Test");
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(username);
	logger.info("username="+username+" password="+password+" accountnumber="+accountNumber);
	//Logging to the webapp
	jsonContent = Login.login(username, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	//Calling the viewhistory api
	jsonContent=History.viewHistory(username, password, accountNumber);
	returnStartTime=startEndTime(typeStart,accountNumber);
	returnEndTime=startEndTime(typeEnd,accountNumber);
	logger.info("Asserting for the Start time and End time of all the records");
	validateBackupHistoryList();
	logger.info("Asserting for the type and status of all the records");
	validateTypeStatus();
	//Checking and asserting for Lastbackupdate field
	String accountNumberString = Integer.toString(accountNumber);
	dates = accountBackupObject.getBackupDates(accountNumberString);
	lastBackupdatedb = dates[(dates.length)-1];
	lastBackupdateApi = DateUtils.getKanawhaWebappBackupDateFormat(lastBackupdatedb);
	dayOfWeek = accountBackupObject.getWeekDay(lastBackupdateApi);
	logger.info(dayOfWeek);
	String assertLastBackup=dayOfWeek+" "+lastBackupdateApi;
	logger.info(assertLastBackup);
	logger.info("Asserting for the Last backup date field");
	JSONAsserter.assertJSONObjects(jsonContent, "LastBackupTime",assertLastBackup);
	//Checking and asserting for Total Backups In A Month
	int totalBackups = (new AccountBackupDatesTable(DatabaseServer.COMMON_SERVER).getTotalBackupsInMonth(accountNumberString));
	String totalBackupsString = Integer.toString(totalBackups);
	logger.info("Asserting for the Last backup date field TotalBackupsInMonth");
	JSONAsserter.assertJSONObjects(jsonContent, "TotalBackupsInMonth",totalBackupsString);
	//Asserting for backup size(ToDo)
	/*long backupSize = accountSizeObject.getTipRevisionUncompressed(accountNumberString);
	logger.info(backupSize);
	returnSizeWithUnits = returnSizeWithUnits(backupSize);
	JSONAsserter.assertJSONObjects(jsonContent, "BackupSetSize", returnSizeWithUnits);*/
	//Asserting for number of files protected
	int numOfFiles = accountSizeObject.getTipRevisionNumFiles(accountNumberString);
	String numOfFilesString = Integer.toString(numOfFiles);
	JSONAsserter.assertJSONObjects(jsonContent, "NumFilesProtected", numOfFilesString);
	logger.info("End Backup History test");
}
@Parameters({"username", "password","AccountSizeLimit"})
@Test(enabled = true)
public void accountSizeLimitTest(String username,String password,String AccountSizeLimit) throws Exception{
	logger.info("Start accountSizeLimit Test");
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(username);
	logger.info(accountNumber);
	logger.info("username="+username+" password="+password+" accountnumber="+accountNumber);
	String jsonContent = Login.login(username, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	jsonContent=History.viewHistory(username, password, accountNumber);
	JSONAsserter.assertJSONObjects(jsonContent, "StorageLimit",AccountSizeLimit);
}
@Parameters({"username", "password"})
@Test(enabled = true)
public void accountActivationTimeTest(String username,String password) throws Exception{
	String accountNumberString = "";
	logger.info("Start accountActivation Test");
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(username);
	logger.info(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+username+" password="+password+" accountnumber="+accountNumber);
	String jsonContent = Login.login(username, password);
//	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	jsonContent=History.viewHistory(username, password, accountNumber);
	String activationTimeDB = (new CustomerTable(DatabaseServer.COMMON_SERVER).getAccountStartDate(accountNumberString));
	dateFormatAPI = DateUtils.getKanawhaWebappBackupDateFormat(activationTimeDB);
	logger.info(dateFormatAPI);
	JSONAsserter.assertJSONObjects(jsonContent, "ActivationTime", dateFormatAPI);
	logger.info("End accountActivation Test");
}
@Parameters({"username", "password","mediaType","mediaQuantity"})
@Test(enabled = true)
public void orderMediaTestDvD(String username,String password,String mediaType,String mediaQuantity) throws Exception{
	logger.info("Start orderMedia Test");
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(username);
	logger.info(accountNumber);
	logger.info("username="+username+" password="+password+" accountnumber="+accountNumber);
	String jsonContent = Login.login(username, password);
	//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
	jsonContent=History.viewHistory(username, password, accountNumber);
	String accountNumberString = Integer.toString(accountNumber);
	String mediaTime = (new CdqTable(DatabaseServer.COMMON_SERVER)).getLastMediaOrderDate(accountNumberString);
	dateFormatAPI = DateUtils.getKanawhaWebappBackupDateFormat(mediaTime);
	JSONAsserter.assertJSONObjects(jsonContent, "OrderMediaTime", dateFormatAPI);
	JSONAsserter.assertJSONObjects(jsonContent, "OrderMediaType", mediaType);
	JSONAsserter.assertJSONObjects(jsonContent, "OrderMediaQuantity", mediaQuantity);
}

@Parameters({"usernameCd", "passwordCd","mediaTypeCd","mediaQuantityCd"})
@Test(enabled = true)
public void orderMediaTestCD(String usernameCd,String passwordCd,String mediaTypeCd,String mediaQuantityCd) throws Exception{
	logger.info("Start orderMedia Test");
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(usernameCd);
	logger.info(accountNumber);
	logger.info("username="+usernameCd+" password="+passwordCd+" accountnumber="+accountNumber);
	String jsonContent = Login.login(usernameCd, passwordCd);
	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	jsonContent=History.viewHistory(usernameCd, passwordCd, accountNumber);
	String accountNumberString = Integer.toString(accountNumber);
	String mediaTime = (new CdqTable(DatabaseServer.COMMON_SERVER)).getLastMediaOrderDate(accountNumberString);
	dateFormatAPI = DateUtils.getKanawhaWebappBackupDateFormat(mediaTime);
	JSONAsserter.assertJSONObjects(jsonContent, "OrderMediaTime", dateFormatAPI);
	JSONAsserter.assertJSONObjects(jsonContent, "OrderMediaType", mediaTypeCd);
	JSONAsserter.assertJSONObjects(jsonContent, "OrderMediaQuantity", mediaQuantityCd);
}
//Bug Raised
/*@Parameters({"username", "password"})
@Test(enabled = true)
public void myRoamRetrievalTest(String username,String password) throws Exception{
	String accountNumberString = "";
	ActivityTable activityObject = new ActivityTable(DatabaseServer.COMMON_SERVER);
	logger.info("Start accountActivation Test");
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(username);
	logger.info(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	logger.info("username="+username+" password="+password+" accountnumber="+accountNumber);
	String jsonContent = Login.login(username, password);
	JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
	jsonContent=History.viewHistory(username, password, accountNumber);
	String myRoamRetrievalTimeDb = activityObject.getLastActivityDate(accountNumberString);
	String myRoamRetrievalTimeApi = DateUtils.getKanawhaWebappBackupDateFormat(myRoamRetrievalTimeDb);
	JSONAsserter.assertJSONObjects(jsonContent, "MyRoamRetrieveTime", myRoamRetrievalTimeApi);
	int myRoamNumOfFiles = activityObject.getNumOfFiles(accountNumberString);
	String NumOfFileString = Integer.toString(myRoamNumOfFiles);
	JSONAsserter.assertJSONObjects(jsonContent, "NumMyRoamFiles", NumOfFileString);
	int retrieveSize = activityObject.getOrigSize(accountNumberString);
	returnSizeWithUnits = returnSizeWithUnits(retrieveSize);
	JSONAsserter.assertJSONObjects(jsonContent, "MyRoamRestoreRetrieve", returnSizeWithUnits);
}*/
@AfterMethod(alwaysRun= true)
public void stopTest() throws Exception {
	super.stophttpTest();
	}

public ArrayList<String> startEndTime(String timeType,int accountNumber){
	ArrayList<String> startEndTime = null;
	if(timeType == typeStart){
		resultSetStart= accountLog.returnStartEndTime(typeStart, accountNumber);
		System.out.println(resultSetStart);
		startEndTime=resultSetStart;
	}
	else{
		resultSetEnd= accountLog.returnStartEndTime(typeEnd,accountNumber);
		startEndTime=resultSetEnd;
}
	logger.info(startEndTime);
return startEndTime;
}
public void validateBackupHistoryList() throws SecurityException, IllegalArgumentException, NoSuchFieldException, IllegalAccessException{
	for(int i=0;i<13;i++){
		dateFormatApiStart=DateUtils.getKanawhaWebappBackupDateFormat(resultSetStart.get(i));
		logger.info(dateFormatApiStart);
		dateFormatApiEnd=DateUtils.getKanawhaWebappBackupDateFormat(resultSetEnd.get(i));
		logger.info(dateFormatApiEnd);
		logger.info("Asserting for Start Time #"+(i+1));
			JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/"+i+"/StartTime",dateFormatApiStart);
		logger.info("Asserting for End Time#"+(i+1));
			JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/"+i+"/EndTime",dateFormatApiEnd);
		
		}
}
public void validateTypeStatus() throws SecurityException, IllegalArgumentException, NoSuchFieldException, IllegalAccessException{
	testOutput = TestDataProvider.getTestOutput("HistoryTest");
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/0/Type",testOutput.get("Type1"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/0/Status",testOutput.get("Status2"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/1/Type",testOutput.get("Type1"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/1/Status",testOutput.get("Status3"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/2/Type",testOutput.get("Type1"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/2/Status",testOutput.get("Status1"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/3/Type",testOutput.get("Type1"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/3/Status",testOutput.get("Status4"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/4/Type",testOutput.get("Type1"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/4/Status",testOutput.get("Status6"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/5/Type",testOutput.get("Type1"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/5/Status",testOutput.get("Status4"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/6/Type",testOutput.get("Type1"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/6/Status",testOutput.get("Status5"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/7/Type",testOutput.get("Type2"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/7/Status",testOutput.get("Status4"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/8/Type",testOutput.get("Type1"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/8/Status",testOutput.get("Status4"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/9/Type",testOutput.get("Type1"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/9/Status",testOutput.get("Status2"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/10/Type",testOutput.get("Type4"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/10/Status",testOutput.get("Status4"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/11/Type",testOutput.get("Type1"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/11/Status",testOutput.get("Status4"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/12/Type",testOutput.get("Type3"));
	JSONAsserter.assertJSONObjects(jsonContent, "BackupHistoryList/12/Status",testOutput.get("Status4"));
}
//ToDo
/*public String returnSizeWithUnits(long myRoamRetrievalSize){
	float resultSize = 0;
	if (myRoamRetrievalSize<1024)
	{
		myRoamSizeWithUnits = myRoamRetrievalSize+"B";
	}
	else if(myRoamRetrievalSize>1024 && myRoamRetrievalSize< 1048576){
		resultSize=myRoamRetrievalSize/1024;
		myRoamRoundOff = Math.round(myRoamRetrievalSize);
		myRoamSizeWithUnits = myRoamRoundOff+"KB";
	}
	else if(myRoamRetrievalSize>1048576 && myRoamRetrievalSize<1073741824 ){
		resultSize=myRoamRetrievalSize/1048576;
		myRoamRoundOff = Math.round(myRoamRetrievalSize);
		myRoamSizeWithUnits = myRoamRoundOff+"MB";
	}
	else{
		resultSize=myRoamRetrievalSize/1073741824;
		logger.info(resultSize);
		myRoamRoundOff = Math.round(myRoamRetrievalSize);
		myRoamSizeWithUnits = myRoamRoundOff+" GB";
	}
	logger.info(myRoamSizeWithUnits);
	return myRoamSizeWithUnits;
}*/
}
