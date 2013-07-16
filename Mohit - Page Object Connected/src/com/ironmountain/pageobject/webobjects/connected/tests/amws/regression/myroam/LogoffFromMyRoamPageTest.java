package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(priority=22, HPQCID="5919")
public class LogoffFromMyRoamPageTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.LogoffFromMyRoamPageTest");
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Starting test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
	}
	
	@Parameters({"emailid", "password"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testCancelRetriveButtonInMyRoamPage(String emailid, String password) throws Exception
	{
		logger.info("Actul test method called...Trying to login with email '" + emailid + "' Password '" + password + "'");
		AccountManagementLogin.login(emailid, password);
		logger.info("Navigating to myroam page..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		myRoamPage.isTitlePresentFailOnNotFound("MyRoamPageTitle");
		logger.info("Logging of from account management..");
		accMgmtLoginPage = AccountManagementLogin.logout();
		accMgmtLoginPage.isTitlePresentFailOnNotFound("LoginPageTitle");	
		logger.info("Test completed successfully...");
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("Stopping session...");
		super.stopSeleniumTest();
		logger.info("Session ended...");
	}
	
	
}
