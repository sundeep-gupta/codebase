package com.ironmountain.kanawha.tests.home;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.connected.supportcenter.tests.accounts.AccountStatusChangeTest;
import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.pages.KanawhaHomePage;
import com.ironmountain.kanawha.pages.KanawhaLoginPage;
import com.ironmountain.kanawha.pages.SettingsPage;
import com.ironmountain.kanawha.tests.KanawhaTest;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountMessageTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.PushedMessageTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.StoredProcedures;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

@SeleniumUITest
public class AccountMessagesTest extends KanawhaTest{
	
	private static final Logger logger = Logger.getLogger(AccountMessagesTest.class.getName());
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	AccountMessageTable accountMessageObject = new AccountMessageTable(DatabaseServer.COMMON_SERVER);
	PushedMessageTable pushedMessageObject = new PushedMessageTable(DatabaseServer.COMMON_SERVER);
	StoredProcedures storeProcedureObject = new StoredProcedures(DatabaseServer.COMMON_SERVER);
	CustomerTable customer = new CustomerTable(DatabaseServer.COMMON_SERVER);
	
		
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		logger.info("Starting Account Messages Tests");
		
	}

	/**
	 * Tests to verify the summary page
	 * 
	 * @param Username
	 * @param Password
	 * @throws Exception
	 */
	@Parameters( {"username", "password"})
	@Test(enabled = true)
	public void verifyAccountMessages(String username, String password) throws Exception {
		
		logger.info("Started verifyAccountMessages test");
		String acStatus = customer.getAccountStatus(CommonUtils.getAccountNumber(username));
		logger.info("Account Status: " + acStatus);
		if(!acStatus.equals("A")) {
			logger.info("Activating Account");
			activateAccount(username,password);
		}
		
		CommonUtils.deleteAccountMessagesFromDB(username);
		
		super.initKanawhaTest("firefox");
		KanawhaHomePage homePage = KanawhaLoginPage.login(username, password);
		homePage.waitForPageLoad();
		homePage.waitForElementPresent("xpath:" + homePage.getLocator("HomePage.EmptyMessagesTableMessage"),1,20);
		verifyMessagesPanelLayout(homePage);
		Assert.assertEquals(homePage.isElementPresent("xpath:" + homePage.getLocator("HomePage.EmptyMessagesTableMessage")), true, "Invalid Message Table Content");
		SettingsPage settingsPage = homePage.gotoSettingsPage();
		sourceMessagesAndAddToDB(username);
		
		settingsPage.gotoHomePage();
		homePage.waitForPageLoad();
		ArrayList<?> dbMessages = CommonUtils.getAccountMessagesFromDB(username);
		ArrayList<?> uiMessages = homePage.getAccountMessages();
		compareAccountMessagesOnUIWithDB(dbMessages, uiMessages);
		compareAccountMessagesOnUIWithGoldenSet(uiMessages);
		
		homePage.logoff();
		logger.info("Completed verifyAccountMessages test");
	}
	
	@Parameters( {"username", "password"})
	@Test(enabled = true)
	public void verifyCanceledAccountMessage(String username, String password) throws Exception {
		
		logger.info("Started verifyCanceledAccountMessages test");
		CommonUtils.deleteAccountMessagesFromDB(username);
		sourceMessagesAndAddToDB(username);
		String acStatus = customer.getAccountStatus(CommonUtils.getAccountNumber(username));
		logger.info("Account Status: " + acStatus);
		if(!acStatus.equals("C")) {
			logger.info("Canceling Account");
			cancelAccount(username,password);
		}
		
		super.initKanawhaTest("firefox");
		KanawhaHomePage homePage = KanawhaLoginPage.login(username, password);
		homePage.waitForPageLoad();
		verifyMessagesPanelLayout(homePage);
		ArrayList<?> uiMessages = homePage.getAccountMessages();
		Assert.assertEquals((uiMessages.size() > 0), true);
		String[] topMostMessageRow = (String[]) uiMessages.get(0);
		
		Assert.assertEquals(topMostMessageRow[3], "Your account has been canceled.", "Unexpected message found in the top row of messages table on UI");
		Assert.assertEquals(topMostMessageRow[0], "failed", "Unexpected message type icon found in the top row of messages table on UI");
		logger.info("Completed verifyCanceledAccountMessages test");
	}

	@Parameters( {"username", "password"})
	@Test(enabled = true)//, dependsOnMethods="verifyAccountMessages")
	public void verifyOnHoldAccountMessageAndSorting(String username, String password) throws Exception {
		
		logger.info("Started verifyOnHoldAccountMessageAndSorting test");
		CommonUtils.deleteAccountMessagesFromDB(username);
		sourceMessagesAndAddToDB(username);
		String acStatus = customer.getAccountStatus(CommonUtils.getAccountNumber(username));
		logger.info("Account Status: " + acStatus);
		if(!acStatus.equals("H")) {
			logger.info("Putting Account On Hold");
			putAccountOnHold(username,password);
		}
		
		super.initKanawhaTest("firefox");
		KanawhaHomePage homePage = KanawhaLoginPage.login(username, password);
		homePage.waitForPageLoad();
		verifyMessagesPanelLayout(homePage);
		ArrayList<?> uiMessages = homePage.getAccountMessages();
		Assert.assertEquals((uiMessages.size() > 0), true);
		String[] topMostMessageRow = (String[]) uiMessages.get(0);
		
		Assert.assertEquals(topMostMessageRow[3], "Your Account has been put on hold.", "Unexpected message found in the top row of messages table on UI");
		Assert.assertEquals(topMostMessageRow[0], "failed", "Unexpected message type icon found in the top row of messages table on UI");
		
		verifySort(homePage);
		logger.info("Completed verifyOnHoldAccountMessageAndSorting test");
	}
	
	private void verifyMessagesPanelLayout(KanawhaHomePage homePage) throws InterruptedException {
		Assert.assertEquals(homePage.getAccountMessagesHeaderText(),"Messages","Unexpected Account Messages Panel Header Text");
		String []columnHeaders = homePage.getAccountMessagesHeaderColumns();
		Assert.assertEquals(columnHeaders[0], "Device Name", "Unexpected column title found for device name column");
		Assert.assertEquals(columnHeaders[1], "Message Date", "Unexpected column title found for Message Date column");
		Assert.assertEquals(columnHeaders[2], "Messages", "Unexpected column title found for Messages column");
	}
	
	private void compareAccountMessagesOnUIWithDB(ArrayList<?> dbMessages, ArrayList<?> uiMessages) {
		logger.info("No of Messages in DB = "+dbMessages.size()+"\nNo of Messages on UI = "+uiMessages.size());
		String []row = null;
		for(int k = 0 ; k < uiMessages.size() ; k++) {
			row = (String[])uiMessages.get(k);
			logger.info("UI "+k+"="+row[3]);
			row = (String[])dbMessages.get(k);
			logger.info("DB"+k+"="+row[1]);
		}
		String [] uiRow = null;
		String [] dbRow = null;
		Boolean found = false;
		for(int i = 0 ; i < dbMessages.size() ; i++) {
			found = false;
			dbRow = (String[])dbMessages.get(i);
			for(int j = 0 ; j < uiMessages.size() ; j++) {
				uiRow = (String[])uiMessages.get(j);
				logger.info("Comparing "+dbRow[1]+" with "+uiRow[3]);
				if(dbRow[1].equals(uiRow[3]) && DateUtils.getKanawhaWebappBackupDateFormat(dbRow[0]).equals(uiRow[2]) && uiRow[0].equals("info")) {
					Assert.assertEquals(dbRow[1],uiRow[3],"Unexpected message in messages table on UI");
					found = true;
					continue;
				}
			}
			if(!found) {
				logger.error(dbRow[1] + " not found on UI");
				Assert.assertEquals(found.booleanValue(), true, dbRow[1] + " not found on UI");
			}
		}// end of for i
		
	}
	
	private void compareAccountMessagesOnUIWithGoldenSet(ArrayList<?> uiMessages) {
		logger.info("No of Messages on UI = "+uiMessages.size());
		Assert.assertEquals(uiMessages.size(), 4, "Incorrect number of technician messages found for account");
		String [] uiRow = null;
		
		for(int j = 0 ; j < uiMessages.size() ; j++) {
			uiRow = (String[])uiMessages.get(j);
			Assert.assertEquals(testInput.containsValue(uiRow[3]), true, uiRow[3]+" not found in GoldenSet");
		}
	}

	private void sourceMessagesAndAddToDB(String username) throws SQLException, InterruptedException {
		int accountNumber = CommonUtils.getAccountNumber(username);
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/myroam/testdata", "AccountMessages.xml");
		testInput = TestDataProvider.getTestInput("verifyAccountMessages");
		CommonUtils.addAccountMessageToDB(accountNumber, "admin", testInput.get("longMessage"),"ascii","active");
		CommonUtils.addAccountMessageToDB(accountNumber, "admin", testInput.get("normalMessage"),"ascii","active");
		CommonUtils.addAccountMessageToDB(accountNumber, "admin", testInput.get("linksMessage"),"ascii","active");
		CommonUtils.addAccountMessageToDB(accountNumber, "admin", testInput.get("unicodeMessage"),"unicode","active");
		CommonUtils.addAccountMessageToDB(accountNumber, "admin", testInput.get("expiredMessage"),"ascii","expired");
	}
	
	private void cancelAccount(String username, String password) throws Exception {
		AccountStatusChangeTest test = new AccountStatusChangeTest();
		test.startTest();
		test.cancelAccount(username, password);
		test.stopTest();
	}

	private void activateAccount(String username, String password) throws Exception {
		AccountStatusChangeTest test = new AccountStatusChangeTest();
		test.startTest();
		test.activateAccount(username, password);
		test.stopTest();
	}
	
	private void putAccountOnHold(String username, String password) throws Exception {
		AccountStatusChangeTest test = new AccountStatusChangeTest();
		test.startTest();
		test.putAccountOnHold(username, password);
		test.stopTest();
	}
	
	private void verifySort(KanawhaHomePage homePage) throws Exception {
		
		logger.info("Started verifying sorting of messages");
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/myroam/testdata", "AccountMessages.xml");
		testOutput = TestDataProvider.getTestOutput("verifyOnHoldAccountMessageAndSorting");
		String [] columns = {"Type","Device","Date","Message"};
		
		//homePage.clickSortBy("Type","asc");
		homePage.clickSortBy("Type");
		ArrayList<?> uiMessages = homePage.getAccountMessages();
		compareAscSortedUIMessagesWithGoldenSet("Type",uiMessages);
		logger.info("DEBUG: About to sort in desc order");Thread.sleep(1000);
		//homePage.clickSortBy("Type","desc");
		homePage.clickSortBy("Type");
		logger.info("DEBUG: get mesgs from UI");Thread.sleep(1000);
		uiMessages = homePage.getAccountMessages();
		logger.info("DEBUG: About to compare");Thread.sleep(1000);
		compareDescSortedUIMessagesWithGoldenSet("Type",uiMessages);
		uiMessages.clear();
		
		for(int i =1 ; i < columns.length ; i++) {
			homePage.clickSortBy(columns[i]);
			uiMessages = homePage.getAccountMessages();
			compareAscSortedUIMessagesWithGoldenSet(columns[i],uiMessages);
			logger.info("DEBUG: About to sort in desc order");Thread.sleep(1000);
			homePage.clickSortBy(columns[i]);
			logger.info("DEBUG: get mesgs from UI");Thread.sleep(1000);
			uiMessages = homePage.getAccountMessages();
			logger.info("DEBUG: About to compare");Thread.sleep(1000);
			compareDescSortedUIMessagesWithGoldenSet(columns[i],uiMessages);
			uiMessages.clear();
		}
	}
	
	private void compareAscSortedUIMessagesWithGoldenSet(String column, ArrayList<?> uiMessages) {
		String regex = "\\|";
		String []ascMessages = testOutput.get(column+"Asc").split(regex);
		String[] uiRow = null;
		Assert.assertEquals(uiMessages.size(), ascMessages.length, "Number of messages on UI not matching with goldenset");
		for(int j = 0 ; j < uiMessages.size() ; j++) {
			uiRow= (String[])uiMessages.get(j);
			logger.info(j+". Comparing " + uiRow[3] +" with " + ascMessages[j]);
			Assert.assertEquals(ascMessages[j].equals(uiRow[3]), true, uiRow[3]+" not found in GoldenSet at index " + j);
		}
	}
	
	private void compareDescSortedUIMessagesWithGoldenSet(String column, ArrayList<?> uiMessages) {
		
		String regex = "\\|";
		String []descMessages = testOutput.get(column+"Desc").split(regex);
		String[] uiRow = null;
		Assert.assertEquals(uiMessages.size(), descMessages.length, "Number of messages on UI not matching with goldenset");
		for(int j = (uiMessages.size()-1) ; j > -1 ; j--) {
			uiRow = (String[])uiMessages.get(j);
			Assert.assertEquals(descMessages[j].equals(uiRow[3]), true, uiRow[3]+" not found in GoldenSet at index " + j);
		}
	}
	
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		logger.info("stop test");
		super.stopWebDriverTest();
	}
	
	@AfterSuite(alwaysRun=true)
	@Parameters( {"username", "password"})
	public void stopSuite(String username, String password) throws Exception {
		logger.info("Completed running Account Messages Test Suite");
		CommonUtils.deleteAccountMessagesFromDB(username);
		String acStatus = customer.getAccountStatus(CommonUtils.getAccountNumber(username));
		logger.info("Account Status: " + acStatus);
		if(!acStatus.equals("A")) {
			logger.info("Activating Account");
			activateAccount(username,password);
		}
	}

}
