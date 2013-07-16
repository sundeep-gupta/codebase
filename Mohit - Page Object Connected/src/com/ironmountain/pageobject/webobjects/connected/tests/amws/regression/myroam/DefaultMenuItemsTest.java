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

@SeleniumUITest(HPQCID="5892")
public class DefaultMenuItemsTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.DefaultMenuItemsTest");
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Startign test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
	}
	
	@Parameters({"emailid", "password"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testDefaultMenuItemsInMyRoamPage(String emailid, String password) throws Exception
	{
		logger.info("Actul test method called...Trying to login with email '" + emailid + "' Password '" + password + "'");
		AccountManagementLogin.login(emailid, password);
		logger.info("Navigating to myroam page..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Verifying machine tree is selected by default..");
		Asserter.assertTrue(myRoamPage.isMachineNameTreePaneSelected(), "Bydefault Machine name is not selected");
		logger.info("Verifying drive/folder tree nodes are present..means atleast 1 backup is completed");
		Asserter.assertTrue(myRoamPage.isTreePaneNodePresent("2"), "No Drive/Folder Tree node present after machine name");
		logger.info("Verifying Default Show versiion leabel");
		Asserter.assertEquals(myRoamPage.getSelectedShowVersionsLabel(), "Most Recent", "Most Recent is not Selected By default");
		logger.info("Verifying browse button is highlighted..");
		Asserter.assertTrue(myRoamPage.isBrowseButtonSelected(), "Browse button is not selected by default");
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
