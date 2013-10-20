package com.ironmountain.connected.supportcenter.tests.accounts;

import org.apache.log4j.Logger;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.connected.supportcenter.pages.AccountStatusPage;
import com.ironmountain.connected.supportcenter.pages.AccountSummaryPage;
import com.ironmountain.connected.supportcenter.pages.ApplyBrandingPage;
import com.ironmountain.connected.supportcenter.pages.ApplyBrandingResultPage;
import com.ironmountain.connected.supportcenter.pages.SCHomePage;
import com.ironmountain.connected.supportcenter.pages.SCLoginPage;
import com.ironmountain.connected.supportcenter.tests.SupportCenter8xTest;
import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class ApplyBrandingTest extends SupportCenter8xTest{
	
	private static final Logger logger = Logger.getLogger(ApplyBrandingTest.class.getName());
	CustomerTable customer = new CustomerTable(DatabaseServer.COMMON_SERVER);
	CommunityTable community = new CommunityTable(DatabaseServer.COMMON_SERVER);
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		logger.info("Started Apply Branding Tests\nOpening Support Center ...");
		//super.initSupportCenter8xTest("iexplore");
	}

	@Parameters({"communityName", "imagePath"})
	@Test(enabled = true)
	public void testApplyBranding(String communityName, String imagePath) throws Exception {
		logger.info("Started testApplyBranding Test");
		super.initSupportCenter8xTest("iexplore");
		String testCommunity = community.getCommunityIDbyCommunityName(communityName);
		logger.info("Login to Support Center");
		SCHomePage homePage = SCLoginPage.login(PropertyPool.getProperty("scadmin"), PropertyPool.getProperty("scpassword"));
		homePage.waitForElementPresent("frame[name='AppBody']", 1, 20);
		//open http://10.145.12.133/supportcenter/Detail.asp?type=2&amp;value=3&amp;community=3&amp;menuchoice=313
		logger.info("Open " + PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/Detail.asp?type=2&value="+testCommunity+"&community="+testCommunity+"&menuchoice=313");
		homePage.goTo(PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/Detail.asp?type=2&value="+testCommunity+"&community="+testCommunity+"&menuchoice=313");
		ApplyBrandingPage applyBrandingPage = (ApplyBrandingPage) PageFactory.initElements(getDriver(), ApplyBrandingPage.class);
		//acStatusPage.switchToFrame("AppBody.NodeView.NodeDetails");
		applyBrandingPage.switchToFrame("AppBody");
		applyBrandingPage.switchToFrame("NodeView");
		applyBrandingPage.switchToFrame("NodeDetails");
		applyBrandingPage.waitForPageLoad();
		logger.info("Type " + imagePath);
		applyBrandingPage.typeSiteHeaderImagePath(imagePath);
		logger.info("Click Apply");
		applyBrandingPage.clickApply();
		ApplyBrandingResultPage applyBrandingResultPage = (ApplyBrandingResultPage) PageFactory.initElements(getDriver(), ApplyBrandingResultPage.class);
		Thread.sleep(5000);
		applyBrandingResultPage.switchToDefaultContent();
		applyBrandingResultPage.switchToFrame("AppBody");
		applyBrandingResultPage.switchToFrame("NodeView");
		/*applyBrandingResultPage.switchToFrame("NodeDetails");*/
		applyBrandingResultPage.waitForPageLoad();
		logger.info("Verify Apply Branding Result Message");
		Assert.assertEquals(applyBrandingResultPage.getApplyBrandingResultMessage(),"Community Successfully Branded. New branding settings were applied to the community. Any subcommunities without customized branding will use this community's branding. The dctomcat service can now be restarted to see any changes to Account Management branding, otherwise branding changes will refresh automatically in five minutes.","Issue with Apply Branding");
		applyBrandingResultPage.clickOK();
		//applyBrandingResultPage.close();
		logger.info("Completed testApplyBranding Test");
	}
	
	@Parameters({"communityName"})
	@Test(enabled = true)
	public void testResetBranding(String communityName) throws Exception {
		logger.info("Started testResetBranding Test");
		super.initSupportCenter8xTest("firefox");
		
		String testCommunity = community.getCommunityIDbyCommunityName(communityName);
		
		logger.info("Login to Support Center");
		SCHomePage homePage = SCLoginPage.login(PropertyPool.getProperty("scadmin"), PropertyPool.getProperty("scpassword"));
		homePage.waitForElementPresent("frame[name='AppBody']", 1, 20);

		//open http://10.145.12.133/supportcenter/Detail.asp?type=2&amp;value=3&amp;community=3&amp;menuchoice=313
		logger.info("Open " + PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/Detail.asp?type=2&value="+testCommunity+"&community="+testCommunity+"&menuchoice=313");
		homePage.goTo(PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/Detail.asp?type=2&value="+testCommunity+"&community="+testCommunity+"&menuchoice=313");
		ApplyBrandingPage applyBrandingPage = (ApplyBrandingPage) PageFactory.initElements(getDriver(), ApplyBrandingPage.class);
		applyBrandingPage.switchToFrame("AppBody");
		applyBrandingPage.switchToFrame("NodeView");
		applyBrandingPage.switchToFrame("NodeDetails");
		applyBrandingPage.waitForPageLoad();
		
		//applyBrandingPage.typeSiteHeaderImagePath(imagePath);
		//applyBrandingPage.switchToDefaultContent();
		if(applyBrandingPage.getResetButtonStatus()) {
		 
			logger.info("Click Reset Branding");
			applyBrandingPage.clickResetBranding();

			ApplyBrandingResultPage applyBrandingResultPage = (ApplyBrandingResultPage) PageFactory.initElements(getDriver(), ApplyBrandingResultPage.class);
			Thread.sleep(5000);
			applyBrandingResultPage.switchToDefaultContent();
			applyBrandingResultPage.switchToFrame("AppBody");
			applyBrandingResultPage.switchToFrame("NodeView");
			applyBrandingResultPage.waitForPageLoad();

			logger.info("Verify Reset Branding Result Message");
			Assert.assertEquals(applyBrandingResultPage.getResetBrandingResultMessage(),"The community's branding was reset to the default. Any subcommunities without customized branding will use the default branding. The Apache DCTomcat service can now be restarted to see changes reflected in the Account Management WebSite settings, otherwise branding changes will refresh automatically in five minutes.","Issue with Apply Branding");
			applyBrandingResultPage.clickOK();
			applyBrandingResultPage.close();
		}
		else {
			applyBrandingPage.close();
		}
		
		logger.info("Completed testResetBranding Test");
	}
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		logger.info("Completed a Branding Action.");
		super.stopWebDriverTest();
	}

}
