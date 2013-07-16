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

@SeleniumUITest(HPQCID="5921")
public class FileSelectionOnLeftPaneTest extends AccountManagementTest {
	
	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.FileSelectionOnLeftPaneTest");
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Startign test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
	}
	
	@Parameters({"emailid", "password", "backedupDrive", "backedupFolder"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testFileSelectionOnLeftPane(String emailid, String password, String backedupDrive, String backedupFolder) throws Exception
	{
		logger.info("Actul test method called...Trying to login with email '" + emailid + "' Password '" + password + "'");
		AccountManagementLogin.login(emailid, password);
		logger.info("Navigating to myroam page..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Checking the backup Driver from left pane.." + backedupDrive);
		myRoamPage.checkBackedupFolderFromLeftTree(backedupDrive);
		logger.info("Verifying the backedup drive checkbox status..");
		Asserter.assertTrue(myRoamPage.isAllBackupFoldersFromRightPaneChecked(), "Backup folders unchecked it should be checked");
		logger.info("Expanding backedup drive.." + backedupDrive);
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupDrive);
		logger.info("Clicking on backedup folder.." + backedupFolder);
		myRoamPage.clickOnBackedupFolderNode(backedupFolder);
		logger.info("Checking on backedup folder.." + backedupFolder);
		myRoamPage.checkBackedupFolderFromLeftTree(backedupFolder);
		logger.info("Verifing the checkbox status..");
		Asserter.assertTrue(myRoamPage.isAllBackupFoldersFromRightPaneChecked(), "Backup folders unchecked it should be checked");
		logger.info("Unchecking the checkbox of " + backedupFolder);
		myRoamPage.unCheckBackedupFolderFromLeftTree(backedupFolder);
		logger.info("Verifying the checkbox status of.. "+ backedupFolder);
		Asserter.assertTrue(myRoamPage.isAllBackupFoldersFromRightPaneUnChecked(), "Backup folders checked it should be unchecked");
		logger.info("Logging out from Application..");
		AccountManagementLogin.logout();
		logger.info("Test Completed Successfully...");
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("Stopping session...");
		super.stopSeleniumTest();
		logger.info("Session ended...");
	}
	
}
