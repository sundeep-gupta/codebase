package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(priority=9, HPQCID="6029")
public class CancelRetriveTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.CancelRetriveTest");
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		skipTest = true; 
		skipMessage = "This test is skipped because there is an issue " ;
		logger.info("Starting Test, now in startTest..initializing..");
		super.initAccountManagementTest();
		logger.info("Test initialization is completed");
	}
	
	@Parameters({"emailid", "password", "backedupDrive","backedupFolder","commonTestData", "fileSelectedVerificationText","downloadTimeVerificationText"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testCancelRetriveButtonInMyRoamPage(String emailid, String password, String backedupDrive, String backedupFolder, String commonTestData, String fileSelectedVerificationText, String downloadTimeVerificationText) throws Exception
	{
		
		logger.info("Executing actual test method..Trying to login with user naem: " + emailid + " Password: " + password);
		AccountManagementLogin.login(emailid, password);
		logger.info("Trying to navigate to my roam page");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Trying to click on expand collapse button of " + backedupDrive);
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupDrive);
		logger.info("Trying to click on expand collapse button of " + backedupFolder);
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupFolder);
		logger.info("Trying to click on " + commonTestData);
		myRoamPage.clickOnBackedupFolderNode(commonTestData);		
		logger.info("Checking on select all chekcbox for right pane..");
		myRoamPage.checkRetrieveFile();
		logger.info("Clcikon retrived button");
		myRoamPage = myRoamPage.clickOnRetrieve();
		logger.info("Verifying the texts.. '" + fileSelectedVerificationText + "' and '" + downloadTimeVerificationText + "'");
		myRoamPage.isTextPresentFailOnNotFound(fileSelectedVerificationText);
		myRoamPage.isTextPresentFailOnNotFound(downloadTimeVerificationText);
		logger.info("Verfying the selected archive format label..");
		Asserter.assertEquals(myRoamPage.getSelectedArchiveFormatLabel(), MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, "Archive format labels are not equal.." );
		logger.info("Click on continue button");
		myRoamPage.clickOnContinue();
		logger.info("Clciking on return to retrive button");
		myRoamPage.clickOnReturnToRetrieveFromDownloadPage();
		logger.info("Verifying the my roam page title");
		myRoamPage.isTitlePresent("MyRoamPageTitle");
		logger.info("Logging out..");
		AccountManagementLogin.logout();
		logger.info("Test completed successfully..");
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		if(!skipTest){
		logger.info("Executing stop Test");
		super.stopSeleniumTest();
		logger.info("Test completed..");
	}	
	}
	
}
