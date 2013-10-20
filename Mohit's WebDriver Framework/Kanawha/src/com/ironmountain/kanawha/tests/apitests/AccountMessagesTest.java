package com.ironmountain.kanawha.tests.apitests;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.managementapi.apis.AccountMessages;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.kanawha.managementapi.apis.Logout;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountMessageTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.PushedMessageTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.StoredProcedures;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class AccountMessagesTest extends HttpJsonAppTest{
	private static final Logger logger = Logger.getLogger(AccountMessagesTest.class.getName());
	ArrayList<HashMap<String, String>> list1 = new ArrayList<HashMap<String,String>>();
	HashMap<String, String> hashmap1= new HashMap<String, String>();
	HashMap<String, String> hashmap2 = new HashMap<String, String>();
	HashMap<String, String> hashmap3 = new HashMap<String, String>();
	HashMap<String, String> hashmap4 = new HashMap<String, String>();
	HashMap<String, String> hashmap5 = new HashMap<String, String>();
	String[] usernames = {"autouser1@api.com","autouser2@api.com","onholdacc@test.com"};
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	AccountMessageTable accountMessageObject = new AccountMessageTable(DatabaseServer.COMMON_SERVER);
	PushedMessageTable pushedMessageObject = new PushedMessageTable(DatabaseServer.COMMON_SERVER);
	StoredProcedures storeProcedureObject = new StoredProcedures(DatabaseServer.COMMON_SERVER);
	String userName,password,jsonContent,userName2,password2= "";
	int accountNumber = 0;
	
	String result,messageId,messageStatusRead,messageStatusUnread,messageStatusDelete = null;
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "AccountMessages.xml");
		testInput = TestDataProvider.getTestInput("groupMessageTest");
		CommonUtils.deleteMessagesForAllAccountsFromDB(usernames);
	}

//This test case tests the long messages i.e. messages of length 1000 characters
@Test
public void messageLongTest() throws Exception{
		logger.info("Start messageLongTest");
		String messAssert,messageType,Technician,accountNumberString = "";
		testInput = TestDataProvider.getTestInput("messLongTest");
		testOutput = TestDataProvider.getTestOutput("messLongTest");
	
		//sourcing inputs and outputs from Test data provider
		userName = testInput.get("userName");
		logger.info(userName);
		password = testInput.get("password");
		messAssert = testInput.get("message");
		messageStatusRead = testInput.get("messageState");
		messageType = testOutput.get("messageType");
		Technician = testInput.get("Technician");
	
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
	
		//Inserting rows to DB
		accountMessageObject.insertRow(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
		String[] createDate = accountMessageObject.getPushedId(accountNumberString);
		logger.info(createDate[0]);
		pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);
	
		//Calling API's
		logger.info("Calling login api");
		jsonContent = Login.login(userName, password);
		logger.info("Calling SetAccountMessages api");
		messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
		logger.info(messageId);
		logger.info(messageStatusRead);
		hashmap1.put(messageId,messageStatusRead);
		list1.add(hashmap1);
		jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
		logger.info("The message is set to the state read");
		logger.info("Calling getAccountMessages api");
		jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
		
		//Assertion of Response
		JSONArray responseArr = new JSONArray(jsonContent);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "Message",messAssert);
		logger.info(DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]));
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageDate", DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]));	
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageType",messageType);
		JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageState",messageStatusRead);
		jsonContent = Logout.logout(userName, password);
	}

//This test case verifies the webapp number of messages display limit
@Test
public void messageDisplayLimitTest() throws Exception{
	logger.info("Start messageDisplayLimitTest");
	String messAssert,accountNumberString,messageType,Technician = "";
	int index = 0;
	testInput = TestDataProvider.getTestInput("messFiftyDateTest");
	testOutput = TestDataProvider.getTestOutput("messFiftyDateTest");
	
	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	messageType = testOutput.get("messageType");
	Technician = testInput.get("Technician");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	
	//Inserting rows to DB
	for(index = 0;index<50;index++){
	accountMessageObject.insertRow(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert+(index+1), createDate[0]);
	}
	
	//Calling API's
	String[] pushedId=accountMessageObject.getPushedIDJoin(accountNumberString);
	jsonContent = Login.login(userName, password);
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	
	//Assertion of Response
	JSONArray responseArr = new JSONArray(jsonContent);
	for(index=0;index<50;index++){
	System.out.println(messAssert+(50-index));
	System.out.println(responseArr.getString(index));
	JSONAsserter.assertJSONObjects(responseArr.getString(index), "Message",messAssert+(50-index));
	logger.info("Date #"+(index+1)+":"+DateUtils.getKanawhaWebappBackupDateFormat(pushedId[index]));
	JSONAsserter.assertJSONObjects(responseArr.getString(index), "MessageDate",DateUtils.getKanawhaWebappBackupDateFormat(pushedId[index]));
	JSONAsserter.assertJSONObjects(responseArr.getString(index), "MessageType",messageType);
	}
	jsonContent = Logout.logout(userName, password);
}
/*@org.testng.annotations.Test(enabled = true)
public void unicodeTest() throws Exception{
	logger.info("Start unicodeTest");
	String messAssert,messageType,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("unicodeTest");
	testOutput = TestDataProvider.getTestOutput("unicodeTest");
	
	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	messageType = testOutput.get("messageType");
	Technician = testInput.get("Technician");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	
	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRowUnicode(Technician, messAssert, createDate[0]);
	
	//Calling API's
	jsonContent = Login.login(userName, password);
	jsonContent = GetAccountMessages.getAccountMessages(userName, password, accountNumber);
	
	//Assertion of Response
	JSONArray responseArr = new JSONArray(jsonContent);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "Message",messAssert);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageDate",DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]));
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageType",messageType);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}*/

//This test case verifies the webapp behaviour when no messages are present
@Test
public void noMessageTest() throws Exception{
	logger.info("Start unicodeTest");
	testInput = TestDataProvider.getTestInput("noMessageTest");
	testOutput = TestDataProvider.getTestOutput("noMessageTest");
	
	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	String responselength = testOutput.get("responselength");
	//String messageType = testOutput.get("messageType");
	logger.info(responselength);
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	
	//Calling API's
	jsonContent = Login.login(userName, password);
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	
	//Assertion of Response
	JSONArray responseArr = new JSONArray(jsonContent);
	int resposeArrlength = responseArr.length();
	int responseLengthint = Integer.parseInt(responselength);
	Asserter.assertEquals(resposeArrlength, responseLengthint);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies the latest message is always displayed at the top
@Test
public void topMessageTest() throws Exception{
	logger.info("Start topMessageTest");
	testInput = TestDataProvider.getTestInput("topMessageTest");
	testOutput = TestDataProvider.getTestOutput("topMessageTest");
	
	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	String messAssert = testInput.get("message");
	messageStatusRead = testInput.get("messageStateRead");
	messageStatusUnread = testInput.get("messageStateUnread");
	String messageType = testOutput.get("messageType");
	String Technician = testInput.get("Technician");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	String accountNumberString = Integer.toString(accountNumber);
	
	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);
	
	//Calling API's
	jsonContent = Login.login(userName, password);
	logger.info("Calling SetAccountMessages api");
	logger.info("Setting the message status to read");
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusRead);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	
	//Asserting for the message state read
	JSONArray responseArr = new JSONArray(jsonContent);
	logger.info(messAssert);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageState",messageStatusRead);
	
	//Setting the message state to unread
	logger.info("Calling SetAccountMessages api");
	logger.info("Setting the message status to Unread");
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusUnread);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	
	//Assertion of Response
	logger.info(messAssert);
	JSONArray responseArr2 = new JSONArray(jsonContent);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "Message",messAssert);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageType",messageType);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageDate",DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]));
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageState",messageStatusUnread);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how webapp behaves when multiple technicians send messages
@Test
public void multipleTechnicianTest() throws Exception{
	logger.info("Start multiTechTest");
	testInput = TestDataProvider.getTestInput("multiTechTest");
	testOutput = TestDataProvider.getTestOutput("multiTechTest");
	
	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	String messAssert = testInput.get("message");
	String messageType = testOutput.get("messageType");
	String Technician = testInput.get("Technician");
	String Technician2 = testInput.get("Technician1");
	String Technician3 = testInput.get("Technician2");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	String accountNumberString = Integer.toString(accountNumber);
	
	//Inserting rows to DB of Technician admin
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert+" "+Technician, createDate[0]);
	
	//Inserting rows to DB of Technician tech1
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician2, messAssert+" "+Technician2, createDate[0]);
	
	//Inserting rows to DB of Technician tech2
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician3, messAssert+" "+Technician3, createDate[0]);
	
	//Calling API's
	jsonContent = Login.login(userName, password);
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	
	//Assertion of Response
	JSONArray responseArr = new JSONArray(jsonContent);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "Message",messAssert+" "+Technician3);
	JSONAsserter.assertJSONObjects(responseArr.getString(1), "Message",messAssert+" "+Technician2);
	JSONAsserter.assertJSONObjects(responseArr.getString(2), "Message",messAssert+" "+Technician);
	for(int index=0;index<3;index++){
	JSONAsserter.assertJSONObjects(responseArr.getString(2-index), "MessageDate",DateUtils.getKanawhaWebappBackupDateFormat(createDate[2-index]));
	JSONAsserter.assertJSONObjects(responseArr.getString(2-index), "MessageType",messageType);
	}
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how webapp behaves when a message is sent to a group of accounts
@Test
public void groupMessageTest() throws Exception{
	//Expects a set of 2 accounts to be grouped
	logger.info("Start messLongTest");
	String accountNumberString = "";
	testInput = TestDataProvider.getTestInput("groupMessageTest");
	testOutput = TestDataProvider.getTestOutput("groupMessageTest");
	
	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName1");
	logger.info(userName);
	password = testInput.get("password1");
	userName2 = testInput.get("userName2");
	logger.info(userName);
	password2 = testInput.get("password2");
	String messAssert = testInput.get("message");
	messageStatusRead = testInput.get("messageState");
	messageStatusUnread = testInput.get("messageState2");
	String messageType = testOutput.get("messageType");
	String Technician = testInput.get("Technician");
	
	//Assertion for the first account in the Group
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	
	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);
	
	//Calling API's
	jsonContent = Login.login(userName, password);
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusRead);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
    
	//Assertion of Response
	JSONArray responseArr = new JSONArray(jsonContent);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "Message",messAssert);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageDate",DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]));
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageType",messageType);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageState",messageStatusRead);
	
	//Assertion for the second account in the Group
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName2);
	accountNumberString = Integer.toString(accountNumber);
	
	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate2 = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate2[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate2[0]);
	
	//Calling API's
	jsonContent = Login.login(userName2, password2);
	jsonContent = AccountMessages.getAccountMessages(userName2, password2, accountNumber);
	
	//Assertion of Response
	JSONArray responseArr2 = new JSONArray(jsonContent);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "Message",messAssert);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageType",messageType);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageDate",DateUtils.getKanawhaWebappBackupDateFormat(createDate2[0]));
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageState",messageStatusUnread);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how webapp behaves when a message expires
@Test
public void messageExpireTest() throws Exception{
	logger.info("Start messExpireTest");
	testInput = TestDataProvider.getTestInput("messExpireTest");
	testOutput = TestDataProvider.getTestOutput("messExpireTest");
	
	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	String Message = testInput.get("message");
	String responseLength = testOutput.get("responseLength");
	logger.info(Message);
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	String accountString = Integer.toString(accountNumber);
	
	//Inserting rows to DB
	accountMessageObject.insertExpiredMessage(accountNumber);
	String[] dateval = accountMessageObject.getPushedId(accountString);
	logger.info(dateval);
	pushedMessageObject.insertExpiredMessage(Message, dateval[0]);
	storeProcedureObject.executePurgePushedMessages();
	
	//Calling API's
	jsonContent = Login.login(userName, password);
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	
	//Assertion of Response
	JSONArray responseArray = new JSONArray(jsonContent);
	int responseLengthInt = responseArray.length();
	String assertLengthString = Integer.toString(responseLengthInt);
	Asserter.assertEquals(assertLengthString, responseLength);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how webapp displays an account on hold message
@Test
public void accountOnHoldTest() throws Exception{
	logger.info("Start accountHoldTest");
	testInput = TestDataProvider.getTestInput("accountHoldTest");
	testOutput = TestDataProvider.getTestOutput("accountHoldTest");
	
	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	String messAssert = testOutput.get("message");
	String messageType = testOutput.get("messageType");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	
	//Calling API's
	jsonContent = Login.login(userName, password);
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	
	//Assertion of Response
	JSONArray responseArr = new JSONArray(jsonContent);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "Message",messAssert);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageType",messageType);
	jsonContent = Logout.logout(userName, password);
}

//This test case verifies how webapp behaves when an unread message is deleted
@Test
public void messageUnreadDeleteTest() throws Exception{
	logger.info("Start messLongTest");
	String messAssert,messageType,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("messUnreadDeleteTest");
	testOutput = TestDataProvider.getTestOutput("messUnreadDeleteTest");

	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	messageStatusUnread = testInput.get("messageStateUnread");
	messageStatusDelete=testInput.get("messageStateDelete");
	messageType = testOutput.get("messageType");
	Technician = testInput.get("Technician");
	result = testInput.get("result");

	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	logger.info(accountNumber);
	accountNumberString = Integer.toString(accountNumber);

	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);

	//Calling API's
	logger.info("Calling login api");
	jsonContent = Login.login(userName, password);
	logger.info("Calling getAccountMessages api");
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);

	//Assertion of Response
	JSONArray responseArr = new JSONArray(jsonContent);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "Message",messAssert);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageDate", DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]));	
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageType",messageType);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageState",messageStatusUnread);
	
	//Changing message state to delete
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusDelete);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state Delete");

	
	//Asserting for message deleted
	JSONAsserter.assertJSONObjects( jsonContent,"success",result);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how webapp behaves when a read message is deleted
@Test
public void messageReadDeleteTest() throws Exception{
	logger.info("Start messLongTest");
	String messAssert,messageType,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("messUnreadDeleteTest");
	testOutput = TestDataProvider.getTestOutput("messUnreadDeleteTest");

	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	messageStatusRead = testInput.get("messageStateUnread");
	messageStatusDelete=testInput.get("messageStateDelete");
	messageType = testOutput.get("messageType");
	Technician = testInput.get("Technician");
	result = testInput.get("result");

	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	logger.info(accountNumber);
	accountNumberString = Integer.toString(accountNumber);

	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);

	//Calling API's
	logger.info("Calling login api");
	jsonContent = Login.login(userName, password);
	logger.info("Calling SetAccountMessages api");
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusRead);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state read");
	logger.info("Calling getAccountMessages api");
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);

	//Assertion of Response
	JSONArray responseArr = new JSONArray(jsonContent);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "Message",messAssert);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageDate", DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]));	
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageType",messageType);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageState",messageStatusRead);
	
	//Changing message state to delete
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusDelete);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state Delete");
	
	//Asserting for message deleted
	JSONAsserter.assertJSONObjects(jsonContent, "success",result);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how webapp behaves when a deleted message is changed to unread
@Test
public void messageDeleteReadTest() throws Exception{
	logger.info("Start messLongTest");
	String messAssert,messageType,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("messDeleteReadTest");
	testOutput = TestDataProvider.getTestOutput("messDeleteReadTest");

	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	messageStatusRead = testInput.get("messageStateRead");
	messageStatusDelete=testInput.get("messageStateDelete");
	messageType = testOutput.get("messageType");
	Technician = testInput.get("Technician");
	result = testInput.get("result");

	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	logger.info(accountNumber);
	accountNumberString = Integer.toString(accountNumber);

	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);

	//Calling API's
	logger.info("Calling login api");
	jsonContent = Login.login(userName, password);
	logger.info("Calling SetAccountMessages api");
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusDelete);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state Delete");

	//Assertion of Response
	JSONAsserter.assertJSONObjects(jsonContent, "success",result);
	
	//Changing message state to Read
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusRead);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state read");
	logger.info("Calling getAccountMessages api");
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	
	//Asserting for message read
	JSONArray responseArr2 = new JSONArray(jsonContent);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "Message",messAssert);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageDate", DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]));	
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageType",messageType);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageState",messageStatusRead);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how webapp behaves when a deleted message is changed to read
@Test
public void messageDeleteUnreadTest() throws Exception{
	logger.info("Start messLongTest");
	String messAssert,messageType,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("messDeleteUnreadTest");
	testOutput = TestDataProvider.getTestOutput("messDeleteUnreadTest");

	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	messageStatusUnread = testInput.get("messageStateUnread");
	messageStatusDelete=testInput.get("messageStateDelete");
	messageType = testOutput.get("messageType");
	Technician = testInput.get("Technician");
	result = testInput.get("result");

	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	logger.info(accountNumber);
	accountNumberString = Integer.toString(accountNumber);

	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);

	//Calling API's
	logger.info("Calling login api");
	jsonContent = Login.login(userName, password);
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusDelete);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state delete");


	//Assertion of Response
	JSONAsserter.assertJSONObjects(jsonContent, "success",result);
	
	
	//Changing message state to Unread
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusUnread);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state Unread");
	logger.info("Calling getAccountMessages api");
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	
	//Asserting for message deleted
	JSONArray responseArr2 = new JSONArray(jsonContent);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "Message",messAssert);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageDate", DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]));	
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageType",messageType);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageState",messageStatusUnread);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies the success value when a read message is deleted
@Test
public void messageDeleteReadOnlyTest() throws Exception{
	logger.info("Start messLongTest");
	String messAssert,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("messDeleteReadOnlyTest");
	testOutput = TestDataProvider.getTestOutput("messDeleteReadOnlyTest");

	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	messageStatusRead = testInput.get("messageStateRead");
	messageStatusDelete=testInput.get("messageStateDelete");
	Technician = testInput.get("Technician");
	result = testInput.get("result");

	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	logger.info(accountNumber);
	accountNumberString = Integer.toString(accountNumber);

	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);

	//Calling API's
	logger.info("Calling login api");
	jsonContent = Login.login(userName, password);
	logger.info("Calling SetAccountMessages api");
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusRead);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state read");
	
	//Assertion of Response
	JSONAsserter.assertJSONObjects(jsonContent, "success",result);
		
	//Changing message state to Read
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusDelete);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state delete");
		
	//Asserting for message deleted
	JSONAsserter.assertJSONObjects(jsonContent, "success",result);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies the success value when an unread message is deleted
@Test
public void messageDeleteUnreadOnlyTest() throws Exception{
	logger.info("Start messLongTest");
	String messAssert,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("messDeleteUnreadOnlyTest");
	testOutput = TestDataProvider.getTestOutput("messDeleteUnreadOnlyTest");

	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	messageStatusUnread = testInput.get("messageStateUnread");
	messageStatusDelete=testInput.get("messageStateDelete");
	Technician = testInput.get("Technician");
	result = testInput.get("result");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	logger.info(accountNumber);
	accountNumberString = Integer.toString(accountNumber);

	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);

	//Calling API's
	logger.info("Calling login api");
	jsonContent = Login.login(userName, password);
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusUnread);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state Unread");
	
	//Assertion of Response
	JSONAsserter.assertJSONObjects(jsonContent, "success",result);
	
	//Changing message state to Delete
	messageId=DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(messageId,messageStatusDelete);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state delete");

	
	//Asserting for message deleted
	JSONAsserter.assertJSONObjects(jsonContent, "success",result);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how webapp behaves when a wrong message state is provided as input to the set api
@Test
public void messageWrongMessageStateTest() throws Exception{
	logger.info("Start messLongTest");
	String messAssert,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("messWrongMessStateTest");
	testOutput = TestDataProvider.getTestOutput("messWrongMessStateTest");

	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	messageStatusRead = testInput.get("messageState");
	Technician = testInput.get("Technician");
	result = testInput.get("result");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	logger.info(accountNumber);
	accountNumberString = Integer.toString(accountNumber);

	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);

	//Calling API's
	logger.info("Calling login api");
	jsonContent = Login.login(userName, password);
	logger.info("Calling SetAccountMessages api");
	messageId=createDate[0];
	hashmap1.put(messageId,messageStatusRead);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state which is incorrect");

	//Assertion of Response
	JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription",result);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how webapp behaves when a wrong message id is provided as input to the set api
@Test
public void messageWrongMessageIdTest() throws Exception{
	logger.info("Start messLongTest");
	String messAssert,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("messWrongMessIdTest");
	testOutput = TestDataProvider.getTestOutput("messWrongMessIdTest");

	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	messageStatusRead = testInput.get("messageState");
	Technician = testInput.get("Technician");
	result = testInput.get("result");
	String wrongMessageId = DateUtils.getKanawhaWebappBackupDateFormat("2011-07-14 12:43:44");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	logger.info(accountNumber);
	accountNumberString = Integer.toString(accountNumber);

	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);

	//Calling API's
	logger.info("Calling login api");
	jsonContent = Login.login(userName, password);
	logger.info("Calling SetAccountMessages api");
	hashmap1.put(wrongMessageId,messageStatusRead);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state which is incorrect");
	
	//Assertion of Response
	JSONAsserter.assertJSONObjects(jsonContent, "success",result);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how webapp behaves when a message group is deleted
@Test
public void messageGroupDeleteTest() throws Exception{
	logger.info("Start messFiftyTest");
	String messAssert,accountNumberString,Technician = "";
	int index = 0;
	testInput = TestDataProvider.getTestInput("messGroupDeleteTest");
	testOutput = TestDataProvider.getTestOutput("messGroupDeleteTest");
	
	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	Technician = testInput.get("Technician");
	messageStatusDelete = testInput.get("messageStateDelete");
	result = testInput.get("result");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	
	//Inserting rows to DB
	for(index = 0;index<5;index++){
	accountMessageObject.insertRow(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert+(index+1), createDate[0]);
	}
	
	//Calling API's
	String[] pushedId=accountMessageObject.getPushedId(accountNumberString);
	jsonContent = Login.login(userName, password);
	hashmap1.put (DateUtils.getKanawhaWebappBackupDateFormat(pushedId[0]),messageStatusDelete);
	hashmap2.put (DateUtils.getKanawhaWebappBackupDateFormat(pushedId[1]),messageStatusDelete);
	hashmap3.put (DateUtils.getKanawhaWebappBackupDateFormat(pushedId[2]),messageStatusDelete);
	hashmap4.put (DateUtils.getKanawhaWebappBackupDateFormat(pushedId[3]),messageStatusDelete);
	hashmap5.put (DateUtils.getKanawhaWebappBackupDateFormat(pushedId[4]),messageStatusDelete);
	list1.add(hashmap1);
	list1.add(hashmap2);
	list1.add(hashmap3);
	list1.add(hashmap4);
	list1.add(hashmap5);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("All the five messages are set to delete");
	
	//Assertion of Response
	JSONAsserter.assertJSONObjects(jsonContent, "success",result);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how webapp behaves when an empty message id is provided as input to the set api
@Test
public void messageIdEmptyValueTest() throws Exception{
	logger.info("Start messLongTest");
	String messAssert,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("messIdEmptyValueTest");
	testOutput = TestDataProvider.getTestOutput("messIdEmptyValueTest");

	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	Technician = testInput.get("Technician");
	result = testInput.get("result");
	String emptyMessageId="";
	messageStatusRead = testInput.get("messageStateRead");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	logger.info(accountNumber);
	accountNumberString = Integer.toString(accountNumber);

	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);

	//Calling API's
	logger.info("Calling login api");
	jsonContent = Login.login(userName, password);
	logger.info("Calling SetAccountMessages api");
	messageId = DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	hashmap1.put(emptyMessageId,messageStatusRead);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state which is incorrect");
	
	//Assertion of Response
	JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode",result);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how webapp behaves when a null message state is provided as input to the set api
@Test
public void messageStateNullValueTest() throws Exception{
	logger.info("Start messLongTest");
	String messAssert,messageType,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("messStateNullValueTest");
	testOutput = TestDataProvider.getTestOutput("messStateNullValueTest");

	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	messageType = testOutput.get("messageType");
	Technician = testInput.get("Technician");
	result = testInput.get("result");
	String emptyMessageState=null;
	messageStatusUnread = testInput.get("messageStateUnread");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	logger.info(accountNumber);
	accountNumberString = Integer.toString(accountNumber);

	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);

	//Calling API's
	logger.info("Calling login api");
	jsonContent = Login.login(userName, password);
	messageId = DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]);
	logger.info("Calling SetAccountMessages api");
	hashmap1.put(messageId,emptyMessageState);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	logger.info("The message is set to the state which is incorrect");
	
	//Assertion of Response
	logger.info(messAssert);
	JSONArray responseArr2 = new JSONArray(jsonContent);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "Message",messAssert);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageType",messageType);
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageDate",DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]));
	JSONAsserter.assertJSONObjects(responseArr2.getString(0), "MessageState",messageStatusUnread);
	logger.info("End Test");
}

//This test case verifies how webapp behaves when a null message id is provided as input to the set api
@Test
public void messageIdNullValueTest() throws Exception{
	logger.info("Start messLongTest");
	String messAssert,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("messIdNullValueTest");
	testOutput = TestDataProvider.getTestOutput("messIdNullValueTest");

	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	Technician = testInput.get("Technician");
	result = testInput.get("statusCode");
	String emptyMessageId=null;
	messageStatusRead = testInput.get("messageStateRead");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	logger.info(accountNumber);
	accountNumberString = Integer.toString(accountNumber);

	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);

	//Calling API's
	logger.info("Calling login api");
	jsonContent = Login.login(userName, password);
	logger.info("Calling SetAccountMessages api");
	hashmap1.put(emptyMessageId,messageStatusRead);
	list1.add(hashmap1);
	jsonContent = AccountMessages.setMessageStatus(userName, password,list1, accountNumberString);
	logger.info("The message is set to the state which is incorrect");
	
	//Assertion of Response
	JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode",result);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how webapp behaves when account number is provided as 0 in the uri
@Test
public void noAccountNumberTest() throws Exception{
	logger.info("Start noAccountNumberTest");
	testInput = TestDataProvider.getTestInput("noAccountNumberTest");
		
	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	result = testInput.get("statusCode");
		
	//Setting account number to 0
	accountNumber = 0;
	
	//Calling API's
	jsonContent = Login.login(userName, password);
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	
	//Assertion of Response
	JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", result);
	logger.info("End Test");
}

//This test case verifies how the url is displayed as message on the webapp
@Test
public void urlMessagesTest() throws Exception{
	logger.info("Start urlMessagesTest");
	String messAssert,messageType,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("urlMessagesTest");
	testOutput = TestDataProvider.getTestOutput("urlMessagesTest");
	
	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	messAssert = testInput.get("message");
	messageType = testOutput.get("messageType");
	Technician = testInput.get("Technician");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	
	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messAssert, createDate[0]);
	
	//Calling API's
	jsonContent = Login.login(userName, password);
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	
	//Assertion of Response
	JSONArray responseArr = new JSONArray(jsonContent);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "Message",messAssert);
	logger.info("Date to be compared with json response is: "+DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]));
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageDate",DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]));
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageType",messageType);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

//This test case verifies how the url is displayed as message on the webapp
@Test
public void messageHTMLTagTest() throws Exception{
	logger.info("Start messHTMLTagTest");
	String messAssert,messageType,Technician,accountNumberString = "";
	testInput = TestDataProvider.getTestInput("messageHTMLTagTest");
	testOutput = TestDataProvider.getTestOutput("messageHTMLTagTest");
	
	//sourcing inputs and outputs from Test data provider
	userName = testInput.get("userName");
	logger.info(userName);
	password = testInput.get("password");
	String messInsert = testInput.get("message");
	messAssert = "&lt;p&gt;You can contact Support using one of the following methods:&lt;/p&gt;";
	messageType = testOutput.get("messageType");
	Technician = testInput.get("Technician");
	
	//Getting account number from DB
	accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userName);
	accountNumberString = Integer.toString(accountNumber);
	
	//Inserting rows to DB
	accountMessageObject.insertRow(accountNumber);
	accountNumberString = Integer.toString(accountNumber);
	String[] createDate = accountMessageObject.getPushedId(accountNumberString);
	logger.info(createDate[0]);
	pushedMessageObject.insertRow(Technician, messInsert, createDate[0]);
	
	//Calling API's
	jsonContent = Login.login(userName, password);
	jsonContent = AccountMessages.getAccountMessages(userName, password, accountNumber);
	
	//Assertion of Response
	JSONArray responseArr = new JSONArray(jsonContent);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "Message",messAssert);
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageDate",DateUtils.getKanawhaWebappBackupDateFormat(createDate[0]));
	JSONAsserter.assertJSONObjects(responseArr.getString(0), "MessageType",messageType);
	jsonContent = Logout.logout(userName, password);
	logger.info("End Test");
}

@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stophttpTest();
		CommonUtils.deleteMessagesForAllAccountsFromDB(usernames);
		}
}

