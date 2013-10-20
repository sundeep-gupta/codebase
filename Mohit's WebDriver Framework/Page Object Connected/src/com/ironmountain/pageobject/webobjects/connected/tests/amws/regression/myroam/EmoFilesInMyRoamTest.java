package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.MyRoam;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(HPQCID="5894")
public class EmoFilesInMyRoamTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.EmoFilesInMyRoamTest");
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
	}
	
	@Parameters({"emailid", "password", "commonTestData", "pstFileName"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testEmoFilesInMyRoamPage(String emailid, String password, String commonTestData, String pstFileName) throws Exception
	{
		logger.info("Actul test method called...Trying to login with emial '" + emailid + "' Password '" + password + "'");
		AccountManagementLogin.login(emailid, password);
		logger.info("Navigating to myroam page..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("searching for.." + commonTestData);
		MyRoam.searchFiles(commonTestData);
		logger.info("Verifying the PST file '" + pstFileName + "' present in the list..");
		myRoamPage.isTextPresentFailOnNotFound(pstFileName);
		logger.info("Verifying '" + pstFileName + "' doesn't have tool tip ");
		Asserter.assertTrue(myRoamPage.isEmoPstFilePresent(), "The Tool Tip for EMO file is not Present!! 'Note: This can occur even if the File is backedup as Non-Optimized'");
		logger.info("Logging of from account management..");
		AccountManagementLogin.logout();
		logger.info("Test completed successfully...");
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("Stopping session...");
		super.stopSeleniumTest();
		logger.info("Session ended...");	}
	
}
