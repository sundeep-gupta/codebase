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

@SeleniumUITest(priority=20, HPQCID="5954")
public class FindButtonsBehaviorByChangingTextTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.FindButtonsBehaviorByChangingTextTest");
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Startign test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
	}
	
	@Parameters({"emailid", "password", "backedupDrive", "backedupFolder", "searchText", "searchFile", "searchFileFolder"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testCancelRetriveButtonInMyRoamPage(String emailid, String password, String backedupDrive, String backedupFolder, String searchText, String searchFile, String searchFileFolder) throws Exception
	{
		logger.info("Actul test method called...Trying to login with email '" + emailid + "' Password '" + password + "'");
		AccountManagementLogin.login(emailid, password);
		logger.info("Navigating to myroam page..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Clicking on find button..");
		myRoamPage.clickOnFindBtn();
		logger.info("Verifying the find area, nextbutton, previosu button etc..");
		Asserter.assertTrue(myRoamPage.isFindFilesAreaDisplayed(), "Find Files Area is not Displayed");
		Asserter.assertFalse(myRoamPage.isFindNextButtonEnabled(), "FindNext Button is enabled");
		Asserter.assertFalse(myRoamPage.isFindPreviousButtonEnabled(), "Find Previous Button is enabled");
		logger.info("Entering search text.." + searchText);
		myRoamPage.enterSearchText(searchText);
		logger.info("Clicking on findnext button");
		myRoamPage.clickOnFindNextBtn();
		logger.info("Verifying the results..");
		Asserter.assertTrue(myRoamPage.isBackedupFolderTreeNodeSelected(searchFileFolder), "BackedupFolder Not Highlighted");
		Asserter.assertTrue(myRoamPage.isBackedupFolderInRightPaneSelected(searchFile), "Folder/File Not Selected");
		Asserter.assertFalse(myRoamPage.isFindPreviousButtonEnabled(), "Find Previous Button is enabled");
		logger.info("Clicking on find next button again..");
		myRoamPage.clickOnFindNextBtn();
		logger.info("Verifying the FindPrevious button status..");
		Asserter.assertTrue(myRoamPage.isFindPreviousButtonEnabled(), "Find Previous Button is not enabled");
		logger.info("Entering the search file text again..");
		myRoamPage.enterSearchText(searchFile);
		logger.info("Verifing the FindPreviosu button status..");
		Asserter.assertFalse(myRoamPage.isFindPreviousButtonEnabled(), "Find Previous Button is enabled");
		logger.info("Clicking on findnext button");
		myRoamPage.clickOnFindNextBtn();
		logger.info("Verifing the Lookup Folder...");
		Asserter.assertTrue(myRoamPage.getLookInFolder().contains(searchFileFolder), "Looking Folder is not correct!! expected.." + searchFileFolder);
		logger.info("");
		Assert.assertEquals(myRoamPage.getErrorMessagesInRed(),"Finished searching for file or folder");
		logger.info("Clickon on Backedup Drive node.." + backedupDrive);
		myRoamPage.clickOnBackedupFolderNode(backedupDrive);
		logger.info("Verifing the results..");
		Asserter.assertFalse(myRoamPage.isFindPreviousButtonEnabled(), "Find Previous Button is enabled");
		Asserter.assertFalse(myRoamPage.isFindNextButtonEnabled(), "FindNext Button is enabled");
		Assert.assertTrue(myRoamPage.isBackedupItemPresentInRightPane(backedupFolder), "BackedupFolder is not listed in right pane");
		logger.info("Entering the search text..");
		myRoamPage.enterSearchText(searchText);
		logger.info("Clciking on find next button..");
		myRoamPage.clickOnFindNextBtn();
		logger.info("Verifying the results..");
		Asserter.assertTrue(myRoamPage.isBackedupFolderTreeNodeSelected(searchFileFolder), "BackedupFolder Not Highlighted");
		Asserter.assertTrue(myRoamPage.isBackedupFolderInRightPaneSelected(searchFile), "Folder/File Not Selected");
		AccountManagementLogin.logout();
		logger.info("Test completed successfully..");
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("Stopping session...");
		super.stopSeleniumTest();
		logger.info("Session ended...");
	}
	
	
}
