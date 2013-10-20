package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter;

import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

/**
 * @author Jinesh Devasia
 *
 */

@SeleniumUITest
public class SampleSupportCenterTest extends SupportCenterTest{

	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initSupportCenterTest();
	}
	
	@Test(groups={"samples", "all", "sc"})
	public void testLogin() throws Exception
	{
		supportCenterHomePage = SupportCenterLogin.login("admin", "1Connected");
		supportCenterHomePage.selectAppBodyNodeViewNodeHeaderFrame();
		Assert.assertTrue(supportCenterHomePage.isTextPresent(""));
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.clickOnLogOff();
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}	
	
}
