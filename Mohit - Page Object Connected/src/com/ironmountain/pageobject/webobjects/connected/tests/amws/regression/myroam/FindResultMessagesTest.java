package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import org.apache.log4j.Logger;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(HPQCID="5997")
public class FindResultMessagesTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.FindResultMessagesTest");
	
	private String invalidFile  = "Checking invalid Filex";
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Startign test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
	}
	
	@Parameters({"emailid", "password", "lookinFolder","backedupFile"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testFindResultMessagesInMyRoamPage(String emailid, String password, String lookinFolder, String backedupFile) throws Exception
	{
		logger.info("Actul test method called...Trying to login with email '" + emailid + "' Password '" + password + "'");
		AccountManagementLogin.login(emailid, password);
		logger.info("Navigating to myroam page..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Verifing FindFiles Area..");
		Asserter.assertFalse(myRoamPage.isFindFilesAreaDisplayed(), "Find area was displayed but not expected to display");
		logger.info("Clicking on find button");
		myRoamPage.clickOnFindBtn();
		logger.info("Verifing FindFiles Area..");
		Asserter.assertTrue(myRoamPage.isFindFilesAreaDisplayed(), "Find area is not displayed but expected to display");
		Asserter.assertFalse(myRoamPage.isFindNextButtonEnabled(), "Find Next Button is enabled which is not expected!!!");
		Asserter.assertFalse(myRoamPage.isFindPreviousButtonEnabled(), "Find Previous Button is enabled which is not expected!!!");
		logger.info("Entering Search Text.." + backedupFile);
		myRoamPage.enterSearchText(backedupFile );
		logger.info("Checking FindNextButton Status..");
		Asserter.assertTrue(myRoamPage.isFindNextButtonEnabled(), "Find Next Button is disabled which is not expected!!!");
		logger.info("Clicking on Find next button");
		myRoamPage.clickOnFindNextBtn();
		logger.info("Verifyin the look in folder..");
		Asserter.assertTrue(myRoamPage.getLookInFolder().contains(lookinFolder), "Looking Folder is not correct!!");
		myRoamPage.enterSearchText(invalidFile );
		logger.info("Entered an invalid search text...and clicking on findnext button");
		myRoamPage.clickOnFindNextBtn();
		logger.info("Verifing the error message...");
		Assert.assertEquals(myRoamPage.getErrorMessagesInRed(),"Cannot find file or folder");
		logger.info("Logging out from application...");
		AccountManagementLogin.logout();
		logger.info("Test completed successfully...");
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("Stopping session...");
		super.stopSeleniumTest();
		logger.info("Session ended...");
	}
	
}
