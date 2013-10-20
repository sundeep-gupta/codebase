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
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(priority=9, HPQCID="5992")
public class FileSelectionAndUserLogoutTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.FileSelectionAndUserLogoutTest");
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Startign test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
	}
	
	@Parameters({"emailid", "password", "backedupDrive","backedupFolder"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testFileSelectionAndUserLogout(String emailid, String password, String backedupDrive, String backedupFolder) throws Exception
	{
		logger.info("Actual test method called...Trying to login with email '" + emailid + "' Password '" + password + "'");
		AccountManagementLogin.login(emailid, password);
		logger.info("Navigating to myroam page..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Expanding backup drive.." + backedupDrive);
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupDrive);
		logger.info("Clicking on backedup folder.." + backedupFolder);
		myRoamPage.clickOnBackedupFolderNode(backedupFolder);
		logger.info("Verifying backedup folder tree node selection for.." + backedupFolder);
		Asserter.assertTrue(myRoamPage.isBackedupFolderTreeNodeSelected(backedupFolder), "Folder is not selected which is not expected");
		myRoamPage.checkRetrieveFile();
		logger.info("Selecting files are clicking on retrieve button..");
		myRoamPage = myRoamPage.clickOnRetrieve();
		logger.info("Logging of from account management..");
		AccountManagementLogin.logout();
		
		logger.info("Logging again to aaccount management..");
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Navigated to myroam..");
		logger.info("Verifying the Machien tree selection..");
		Asserter.assertTrue(myRoamPage.isMachineNameTreePaneSelected(), "The previous selection retained which is not expected");
		logger.info("Verifying the backedup folder tree selection..");
		Asserter.assertFalse(myRoamPage.isBackedupFolderTreeNodeSelected(backedupFolder), "The previous selection retained which is not expected");
		logger.info("Logging of from account management..");
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
