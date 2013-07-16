package com.ironmountain.connected.tests.basictests;


import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.connected.pages.GryphonLoginPage;
import com.ironmountain.connected.tests.GryphonTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;

@SeleniumUITest
public class LoginTest extends GryphonTest{
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.initGryphonTest();
	}

	/**
	 * Tests to verify the summary page
	 * 
	 * @param Username
	 * @param Password
	 * @throws Exception
	 */
	@Parameters( {"username", "password"})
	@Test(enabled = true, groups = { "gryphontest" })
	public void testLoginPage(String username, String password) throws Exception {		
		gryHomePage = GryphonLoginPage.login(username, password);
		Asserter.assertEquals(gryHomePage.verifyTitle(), true);
		gryHomePage.selectHomePage();
		gryHomePage.selectReportsPage();
		gryHomePage.selectAssetReportsOverView();
		gryHomePage.selectGridEleUnderAssetReportsOverviewandSelectViewByFileClasses();
		Asserter.assertEquals(gryHomePage.verifyViewByClassesTabisPresent(), true);
	}

	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stopWebDriverTest();
	}

}
