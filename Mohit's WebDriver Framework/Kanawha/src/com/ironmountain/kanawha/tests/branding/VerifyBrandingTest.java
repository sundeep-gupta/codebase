package com.ironmountain.kanawha.tests.branding;

import org.apache.log4j.Logger;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.connected.supportcenter.tests.accounts.ApplyBrandingTest;
import com.ironmountain.kanawha.pages.KanawhaHomePage;
import com.ironmountain.kanawha.pages.KanawhaLoginPage;
import com.ironmountain.kanawha.tests.KanawhaTest;
import com.ironmountain.kanawha.tests.home.AccountMessagesTest;

public class VerifyBrandingTest extends KanawhaTest {
	private static final Logger logger = Logger.getLogger(AccountMessagesTest.class.getName());
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		logger.info("Starting a Branding Test.");
	}
	
	/**
	 * Test to verify default branding on Kanawha home page
	 * @param username
	 * @param password
	 * @throws Exception
	 */
	@Parameters( {"username", "password"})
	@Test(enabled = true)
	public void verifyDefaultBranding(String username, String password) throws Exception {
		ApplyBrandingTest applyBranding = new ApplyBrandingTest();
		applyBranding.testResetBranding("sprint15");
		super.initKanawhaTest("firefox");
		KanawhaHomePage homePage = KanawhaLoginPage.login(username, password);
		homePage.waitForPageLoad();
		Assert.assertEquals(homePage.getLogoImage(), "images/framework/irmlogo.png", "Invalid Brand logo. Community must have default branding for this test.");
	}
	
	/**
	 * Test to verify branding on Kanawha home page
	 * @param username
	 * @param password
	 * @throws Exception
	 */
	@Parameters( {"username", "password"})
	@Test(enabled = true)
	public void verifyBranding(String username, String password) throws Exception {
		ApplyBrandingTest applyBranding = new ApplyBrandingTest();
		applyBranding.testApplyBranding("sprint15", "C:\\workspace\\PageObjectKanawha\\resources\\SiteImageHeaderSpiderMan.png");
		super.initKanawhaTest("firefox");
		KanawhaHomePage homePage = KanawhaLoginPage.login(username, password);
		homePage.waitForPageLoad();
		Assert.assertEquals(homePage.getLogoImage(), "images/framework/branding/3/irmlogo.png", "Invalid Brand logo. Is the community branded? If yes, is it branded with the right image?");
	}
	
	/**
	 * Test to Apply, Reset, verify branding on Kanawha home page
	 * @param username
	 * @param password
	 * @throws Exception
	 */
	@Parameters( {"username", "password"})
	@Test(enabled = true)
	public void verifyApplyAndResetBranding(String username, String password) throws Exception {
		ApplyBrandingTest applyBranding1 = new ApplyBrandingTest();
		applyBranding1.testApplyBranding("sprint15", "C:\\workspace\\PageObjectKanawha\\resources\\SiteImageHeaderSpiderMan.png");
		super.initKanawhaTest("firefox");
		KanawhaHomePage homePage1 = KanawhaLoginPage.login(username, password);
		homePage1.waitForPageLoad();
		Assert.assertEquals(homePage1.getLogoImage(), "images/framework/branding/3/irmlogo.png", "Invalid Brand logo. Is the community branded? If yes, is it branded with the right image?");
		homePage1.close();
		
		ApplyBrandingTest applyBranding2 = new ApplyBrandingTest();
		applyBranding2.testResetBranding("sprint15");
		super.initKanawhaTest("firefox");
		KanawhaHomePage homePage2 = KanawhaLoginPage.login(username, password);
		homePage2.waitForPageLoad();
		Assert.assertEquals(homePage2.getLogoImage(), "images/framework/irmlogo.png", "Invalid Brand logo. Community must have default branding for this test.");
		homePage2.close();
	}
	
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		logger.info("Completed a branding test.");
		super.stopWebDriverTest();
	}
	@AfterSuite(alwaysRun = true)
	public void stopSuite() throws Exception {
		logger.info("Completed Branding Tests\nClosing Support Center and AMWS...");
		super.stopAllWebDriverTest();
	}
}
