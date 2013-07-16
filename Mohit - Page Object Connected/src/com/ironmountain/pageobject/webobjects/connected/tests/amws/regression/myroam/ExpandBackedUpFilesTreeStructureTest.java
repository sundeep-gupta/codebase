package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.utils.ListUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(HPQCID="5893")
public class ExpandBackedUpFilesTreeStructureTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.ExpandBackedUpFilesTreeStructureTest");
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Startign test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
	}
	
	@Parameters({"emailid", "password", "backedupDrive", "backedupFolder", "subFolders", "filesInBackedupFolder"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testExpandBackedUpFilesTreeStructureInMyRoamPage(String emailid, String password, String backedupDrive, String backedupFolder, String subFolders, String backedupFoldersAndFilesList) throws Exception
	{
		logger.info("Actul test method called...Trying to login with emial '" + emailid + "' Password '" + password + "'");
		String[] backedUpFolders = ListUtils.getStringListAsArray(StringUtils.toStringArrayList(subFolders));
		String[] bFilesList = ListUtils.getStringListAsArray(StringUtils.toStringArrayList(backedupFoldersAndFilesList));
		AccountManagementLogin.login(emailid, password);
		logger.info("Navigating to myroam page..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Expanding backup drive.." + backedupDrive);
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupDrive);
		logger.info("Clicking on backedup folder.." + backedupFolder);
		myRoamPage.clickOnBackedupFolderNode(backedupFolder);
		logger.info("Verifying the backedup files list from left tree....");
		for (int i = 0; i < backedUpFolders.length; i++) {
			myRoamPage.isTextPresentFailOnNotFound(backedUpFolders[i]);
			Asserter.assertFalse(myRoamPage.isBackedupFolderPresent(backedUpFolders[i]),"Folder is present in the Left tree");
		}		
		logger.info("Expanding backedupfoldr.." + backedupFolder);
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupFolder);
		logger.info("Verifying the folders in left pane..");
		for (int i = 0; i < backedUpFolders.length; i++) {
			Asserter.assertTrue(myRoamPage.isBackedupFolderPresent(backedUpFolders[i]),"Folder is not present in the Left tree");
		}	
		logger.info("Clicking on backedup folder.." + backedupFolder);
		myRoamPage.clickOnBackedupFolderNode(backedupFolder);
		logger.info("Verifing the backed up files..");
		for (int i = 0; i < bFilesList.length; i++) {
			Asserter.assertTrue(myRoamPage.isTextPresentFailOnNotFound(bFilesList[i]));
		}
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
