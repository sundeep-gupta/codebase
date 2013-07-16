package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;


/*
 * This test will fail due an existing issue
 */

@SeleniumUITest(HPQCID="19429", defectIds={""})
public class SelectFolderSortByFunctionalityTest extends AccountManagementTest {

	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
	}
	
	@Parameters({"emailid", "password", "backedupDrive","backedupFolder"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testSelectFolderSortByFunctionality(String emailid, String password, String backedupDrive, String backedupFolder) throws Exception
	{
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		myRoamPage.clickOnBackedupFolderNode(backedupDrive );	
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupDrive);
		myRoamPage.clickOnBackedupFolderNode(backedupFolder);
		myRoamPage.checkBackedupFolderFromLeftTree(backedupFolder);
		Asserter.assertTrue(myRoamPage.isBackedupFolderFromTreeChecked(backedupFolder));
		myRoamPage.clickOnNameColumn();
		Asserter.assertTrue(myRoamPage.isBackedupFolderFromTreeChecked(backedupFolder), "Selected state is not maintained after sort.");
		AccountManagementLogin.logout();
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}
	
}
