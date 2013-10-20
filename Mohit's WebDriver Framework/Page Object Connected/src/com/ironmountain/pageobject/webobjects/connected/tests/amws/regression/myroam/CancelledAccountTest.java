package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;


import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.accounts.Account;
import com.ironmountain.pageobject.webobjects.connected.database.DataBase;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountManagementLoginPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterLoginPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.accounts.AccountSummaryPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest(HPQCID="6010")
public class CancelledAccountTest extends AccountManagementTest{

	private static Logger  logger      = Logger.getLogger("CancelledAccountTest");
	
	private static CommunityTable communityTable = null;	
	private static String communityName= null;
	private static String communityId = null;
	private static String accountNo = null;
	private static String cUser = null;

	
	@Parameters( { "technicianid", "technicianPassword", "myroamcommunity"})
	@Test(groups = { "amws", "myroamsetup" })
	public void testCanceledAccount(String technicianid, String technicianPassword, String community) throws Exception{
		skipTest = true; 
		skipMessage = "This test is skipped because there is an issue " ;
		
		logger.info("Test starting..");
		logger.info("initializing test..");
		super.initAccountManagementTest();
		logger.info("Trying to create an account for Cancellation");
		createAnAccountForCancellation();
		logger.info("From support center, trying to cancel the account");
		new SupportCenterConfig().cancelAccount(technicianid, technicianPassword, community, accountNo);
		logger.info("Account successfully cancelled..");
		logger.info("Trying to login as cancelled user..");
		accMgmtLoginPage = (AccountManagementLoginPage) PageFactory.getNewPage(AccountManagementLoginPage.class);
		logger.info("Trying to Opening Account Management Url: " + applicationUrl);
		accMgmtLoginPage.open(applicationUrl);
		accMgmtHomePage = AccountManagementLogin.login(cUser, "1password");
		logger.info("Verifying the Error message,,,");
		accMgmtHomePage.isTextPresentFailOnNotFound("LoginAccountCanceledMessage");
		logger.info("Test successfuly Completed..");		
	}
	/**
	 * Closing all the database connections
	 */
	@AfterMethod(alwaysRun = true)
	public void closeDataBaseConnections(){
		if(!skipTest){
		DataBase.closeDatabaseConnections(communityTable);
	}
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		if(!skipTest){
		logger.info("Executing stop method ");
		super.stopSeleniumTest();
		logger.info("Session ended...Test completed..");
		}
	}
	
	public void createAnAccountForCancellation() throws Exception{

		cUser = DateUtils.getCurrentTimeAsString() + "@ironmountain.com" ;
		logger.info("Username generated for account is.." + cUser);
		String registrationUrl = TestDataProvider.getTestData("MyRoamRegressionTestRegistrationUrl");
		logger.info("Registration url is..: " + registrationUrl);
		logger.info("Registerign the account...");
		Registration.registerUserIfNotPresentWithRegistrationUrl(registrationUrl, "Cancelation" , "User", cUser, "1password", "1password");
		logger.info("Account Registration completed");
		accMgmtHomePage = AccountManagementLogin.login(cUser, "1password");
		logger.info("Login as user.." + cUser + " trying to get Account number");
		accountNo = accMgmtHomePage.getAccountNumber();
		logger.info("Account number for user: " + cUser + " is :" + accountNo);
		AccountManagementLogin.logout();	
		logger.info("Logged out from account management..");
	}
	

	class SupportCenterConfig extends SupportCenterTest{
		
		public void cancelAccount(String technicianid,
				String technicianPassword, String community, String accountNo) throws Exception{
				logger.info("SupportCenterConfig: opening support center applicaion");				
				supportCenterLoginPage = (SupportCenterLoginPage) PageFactory.getNewPage(SupportCenterLoginPage.class);
				String supportCenteUrl = getSupportCenterUrl();
				logger.info("SupportCenter URL is: " + supportCenteUrl);
				supportCenterLoginPage.open(supportCenteUrl);
				logger.info("SupportCenterConfig: trying to get community id from Community Table");
				communityTable = new CommunityTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
				logger.info("SupportCenterConfig: CommunityTabel is created..");
				communityName = community;
				logger.info("SupportCenterConfig:Trying to get community id from Tabe for  community name: " + communityName);
				communityId = communityTable.getCommunityIDbyCommunityName(communityName);
				logger.info("SupportCenterConfig: community id is: " + communityId);
				supportCenterHomePage = SupportCenterLogin.login(technicianid, technicianPassword);
				logger.info("SupportCenterConfig: logged in to supportcenter and trying to cancel account..");
				AccountSummaryPage summaryPage = Account.cancelAccount(communityId, accountNo, "Cancel Account For Test");
				logger.info("SupportCenterConfig: Account cancelled and trying to click users account online link");
				accMgmtLoginPage = summaryPage.clickOnAccessUsersAccountOnlineLink();
				logger.info("SupportCenterConfig: Verifying the message,,");
				accMgmtLoginPage.isTextPresentFailOnNotFound("You cannot log on because your backup account was canceled. Please contact Support");
				logger.info("SupportCenterConfig: Closing the window");
				accMgmtLoginPage.closeWindow();
				logger.info("SupportCenterConfig: popup message window closed");
				summaryPage.selectRelativeUpFrame();
				summaryPage.selectRelativeUpFrame();
				summaryPage.selectRelativeUpFrame();
				logger.info("SupportCenterConfig: Logging og from support center");
				supportCenterHomePage.clickOnLogOff();
				logger.info("SupportCenterConfig: Logged off from support center");
			    logger.info("SupportCenterConfig: Account cancelled..");
	    }	
	}	
}
