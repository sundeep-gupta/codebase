package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;


import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.MyRoam;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountManagementLoginPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(HPQCID="5994")
public class AccessMyRoamInTwoBrowsersTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.AccessMyRoamInTwoBrowsersTest");
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Starting the Test now in startTest method");
		super.initAccountManagementTest();
	}
	
	@Parameters({"emailid", "password", "commonTestData"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testAccessMyRoamInTwoBrowsers(String emailid, String password, String commonTestData) throws Exception
	{
		logger.info("Starting Actual test method");
		accMgmtHomePage = AccountManagementLogin.login(emailid, password);
		logger.info("After login try to Check the Summary Page Title");
		accMgmtHomePage.isTitlePresentFailOnNotFound("SummaryPageTitle");
		logger.info("Summary Page Found, Opening the new browser window");
		accMgmtHomePage.openWindow(applicationUrl, "NewBrowser");
		AccountManagementLoginPage newLoginPage = (AccountManagementLoginPage) PageFactory.getNewPage(AccountManagementLoginPage.class);
		newLoginPage.selectWindow("NewBrowser");
		logger.info("From new window, trying to verify the loggin page is opened");
		newLoginPage.isTitlePresentFailOnNotFound("LoginPageTitle");
		accMgmtHomePage = AccountManagementLogin.login(emailid, password);
		logger.info("Verifing the login is successful and summary page title is displyed");
		accMgmtHomePage.isTitlePresentFailOnNotFound("SummaryPageTitle");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("From summary tring to navigate to MyRoam");
		myRoamPage.isTitlePresentFailOnNotFound("MyRoamPageTitle");
		logger.info("Now in MyRoam page..");
		
		accMgmtHomePage.selectMainWindow();
		logger.info("Trying to give Control back to the first window");
		accMgmtHomePage.isTitlePresentFailOnNotFound("SummaryPageTitle");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Veryfied Summary Page, now moving to myroam..");
		myRoamPage.isTitlePresentFailOnNotFound("MyRoamPageTitle");
		logger.info("MyRoam page found..Selecting second window");
		myRoamPage.selectWindow("NewBrowser");
		myRoamPage = MyRoam.selectFilesAndGoToRetriveOption(commonTestData);
		myRoamPage.isTitlePresentFailOnNotFound("MyRoamDownloadPageTitle");
		logger.info("In second window selected few files and moved to next page..");
		logger.info("Selecting first window");
		myRoamPage.selectMainWindow();
		logger.info("First window selected and verifying the page is still myroam");
		myRoamPage.isTitlePresentFailOnNotFound("MyRoamPageTitle");
		myRoamPage = MyRoam.selectFilesAndGoToRetriveOption(commonTestData);
		myRoamPage.isTitlePresentFailOnNotFound("MyRoamDownloadPageTitle");
		logger.info("In second window selected few files and moved to next page..");
		myRoamPage.selectWindow("NewBrowser");
		myRoamPage.clickOnContinue();
		myRoamPage.isTitlePresentFailOnNotFound("MyRoamPageTitle");
		myRoamPage.closeWindow();
		logger.info("Second winodw is closed..");
		
		logger.info("Control back to First window");
		myRoamPage.selectMainWindow();
		myRoamPage.clickOnContinue();
		logger.info("Clicking on continue button...");
		myRoamPage.isTitlePresentFailOnNotFound("MyRoamPageTitle");
		AccountManagementLogin.logout();
		logger.info("Test method is completed successfully...");
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("Executign stop method");
		super.stopSeleniumTest();
		logger.info("Stop called..");
		logger.info("Test Completed..");
	}
	
	
}
