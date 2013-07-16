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

@SeleniumUITest(priority=23, HPQCID="5987")
public class ToolTipMessageTest extends AccountManagementTest {

	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
	}
	
	@Parameters({"emailid", "password"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testCancelRetriveButtonInMyRoamPage(String emailid, String password) throws Exception
	{
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		Asserter.assertTrue(myRoamPage.isBrowseButtonToolTipTextPresent(), "Browse Button Tooltip Not Found");
		Asserter.assertTrue(myRoamPage.isFindButtonToolTipTextPresent(), "Find Button Tooltip Not Found");
		Asserter.assertTrue(myRoamPage.isShowVersionsButtonToolTipTextPresent(), "Show Versions Button Tooltip Not Found");
		Asserter.assertTrue(myRoamPage.isRetrieveButtonToolTipTextPresent(), "Retrieve Button Tooltip Not Found");		
		AccountManagementLogin.logout();
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}
	
	
}
