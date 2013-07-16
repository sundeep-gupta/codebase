package com.ironmountain.kanawha.tests.branding;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.json.JSONException;
import org.json.JSONObject;
import org.openqa.selenium.By;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.connected.supportcenter.pages.ApplyBrandingPage;
import com.ironmountain.connected.supportcenter.pages.ApplyBrandingResultPage;
import com.ironmountain.connected.supportcenter.pages.CommunityStatusPage;
import com.ironmountain.connected.supportcenter.pages.RenameCommunityPage;
import com.ironmountain.connected.supportcenter.pages.SCHomePage;
import com.ironmountain.connected.supportcenter.pages.SCLoginPage;
import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.managementapi.apis.GetBrandingInfo;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.kanawha.tests.KanawhaTest;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class RenameBrandedCommunityTest extends KanawhaTest{
	private static final Logger logger = Logger.getLogger(RenameBrandedCommunityTest.class.getName());
	CommunityTable community = new CommunityTable(DatabaseServer.COMMON_SERVER);
	BrandingUtils scBrand = new BrandingUtils();
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	private static HashMap<String, String> brandingOutputData = new HashMap<String,String>();
	
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		logger.info("Starting Rename Branded Community Test.");
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/branding/testdata", "branding.xml");
		testInput = TestDataProvider.getTestInput("renameBrandedCommunity");
		brandingOutputData = TestDataProvider.getTestOutput("BrandingData");
		CommonUtils.updateAccountCommunity(testInput.get("username"), testInput.get("communityName"));
		super.initWebDriverTest(scBrand.getSupportCenterLogoutURL(), "");
	}
	

	/**
	 * This test applies branding to a community, renames the community and then verifies its effect on an account under it
	 * @throws Exception
	 */
	@Test(enabled = true)
	public void renameBrandedCommunity() throws Exception {
		logger.info("communityName="+testInput.get("communityName"));
		//Apply Branding to amws with the image name and text sourced from branding.xml. And verify the new branding settings
		scBrand.applyBranding(testInput.get("communityName"),FileUtils.getBaseDirectory() + testInput.get("imagePath"), testInput.get("siteName"),testInput.get("poweredByLogo"));
		scBrand.verifyBrandingInfo(testInput.get("username"),testInput.get("password"), brandingOutputData.get("spiderMan"),testInput.get("siteName"),brandingOutputData.get("autonomyPowerdByLogo"));
		
		//Now rename the same community
		renameCommunity(testInput.get("communityName"),testInput.get("communityNewName"));
		scBrand.verifyBrandingInfo(testInput.get("username"),testInput.get("password"), brandingOutputData.get("spiderMan"),testInput.get("siteName"),brandingOutputData.get("autonomyPowerdByLogo"));
		//Restore the community name. Required for sanity of subsequent tests
		restoreCommunityName(testInput.get("communityNewName"), testInput.get("communityName"));
	}
	
	/**
	 * This method renames a given community through Support Center UI
	 * @param communityCurrentName
	 * @param communityNewName
	 * @throws Exception
	 */
	private void renameCommunity(String communityCurrentName, String communityNewName) throws Exception {
		String testCommunity = community.getCommunityIDbyCommunityName(communityCurrentName);
		WebDriverPage blankPage = new WebDriverPage();
		blankPage.goTo(scBrand.getSupportCenterURL());
		
		logger.info("Login to Support Center");
		SCHomePage homePage = SCLoginPage.login(PropertyPool.getProperty("scadmin"), PropertyPool.getProperty("scpassword"));
		homePage.waitForElementPresent("frame[name='AppBody']", 1, 20);
		
		//open http://10.145.12.133/supportcenter/Detail.asp?type=2&amp;value=3&amp;community=3&amp;menuchoice=310
		logger.info("Open " + PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/Detail.asp?type=2&value="+testCommunity+"&community="+testCommunity+"&menuchoice=310");
		homePage.goTo(PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/Detail.asp?type=2&value="+testCommunity+"&community="+testCommunity+"&menuchoice=310");
	
		RenameCommunityPage renameCommunityPage = (RenameCommunityPage) PageFactory.initElements(getDriver(), RenameCommunityPage.class);
		renameCommunityPage.switchToDefaultContent();
		logger.info("AppBody present? " + renameCommunityPage.isElementPresent("name:AppBody"));
		if(renameCommunityPage.isElementPresent("name:AppBody")){ renameCommunityPage.switchToFrame("AppBody"); 
			logger.info("NodeView present? " + renameCommunityPage.isElementPresent("name:NodeView"));
			if(renameCommunityPage.isElementPresent("name:NodeView")){ renameCommunityPage.switchToFrame("NodeView"); 
				logger.info("NodeDetails present? " + renameCommunityPage.isElementPresent("name:NodeDetails"));
				if(renameCommunityPage.isElementPresent("name:NodeDetails")){ renameCommunityPage.switchToFrame("NodeDetails"); }
			}
		}
		else {
			logger.info("Selecting AppBody.NodeView.NodeDetails");
			renameCommunityPage.switchToFrame("AppBody.NodeView.NodeDetails");
		}
		renameCommunityPage.waitForPageLoad();
		renameCommunityPage.typeCommunityName(communityNewName);
		renameCommunityPage.clickSave();
		
		CommunityStatusPage communityStatusPage = (CommunityStatusPage) PageFactory.initElements(getDriver(), CommunityStatusPage.class);
		Thread.sleep(5000);
		communityStatusPage.switchToDefaultContent();
		logger.info("AppBody present? " + communityStatusPage.isElementPresent("name:AppBody"));
		if(communityStatusPage.isElementPresent("name:AppBody")){ communityStatusPage.switchToFrame("AppBody"); 
			logger.info("NodeView present? " + communityStatusPage.isElementPresent("name:NodeView"));
			if(communityStatusPage.isElementPresent("name:NodeView")){ communityStatusPage.switchToFrame("NodeView"); 
				logger.info("NodeDetails present? " + communityStatusPage.isElementPresent("name:NodeDetails"));
				if(communityStatusPage.isElementPresent("name:NodeDetails")){ communityStatusPage.switchToFrame("NodeDetails"); }
			}
		}
		else {
			logger.info("Selecting AppBody.NodeView.NodeDetails");
			communityStatusPage.switchToFrame("AppBody.NodeView.NodeDetails");
		}
		communityStatusPage.switchToDefaultContent();
		communityStatusPage.switchToFrame("AppHeader");
		
		communityStatusPage.findElement(communityStatusPage.getDriver(), By.xpath("//a[text()='LOG OFF']")).click(); Thread.sleep(1000);
	}
	
	/**
	 * This method renames a given community with CommunityNewName
	 * @param communityCurrentName
	 * @param communityNewName
	 * @throws Exception
	 */
	private void restoreCommunityName(String communityCurrentName, String communityNewName) throws Exception {
		String testCommunity = community.getCommunityIDbyCommunityName(communityCurrentName);
		WebDriverPage blankPage = new WebDriverPage();
		blankPage.goTo(scBrand.getSupportCenterURL());
		
		logger.info("Login to Support Center");
		SCHomePage homePage = SCLoginPage.login(PropertyPool.getProperty("scadmin"), PropertyPool.getProperty("scpassword"));
		homePage.waitForElementPresent("frame[name='AppBody']", 1, 20);
		
		//open http://10.145.12.133/supportcenter/Detail.asp?type=2&amp;value=3&amp;community=3&amp;menuchoice=310
		logger.info("Open " + PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/Detail.asp?type=2&value="+testCommunity+"&community="+testCommunity+"&menuchoice=310");
		homePage.goTo(PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/Detail.asp?type=2&value="+testCommunity+"&community="+testCommunity+"&menuchoice=310");
	
		RenameCommunityPage renameCommunityPage = (RenameCommunityPage) PageFactory.initElements(getDriver(), RenameCommunityPage.class);
		renameCommunityPage.switchToDefaultContent();
		logger.info("AppBody present? " + renameCommunityPage.isElementPresent("name:AppBody"));
		if(renameCommunityPage.isElementPresent("name:AppBody")){ renameCommunityPage.switchToFrame("AppBody"); 
			logger.info("NodeView present? " + renameCommunityPage.isElementPresent("name:NodeView"));
			if(renameCommunityPage.isElementPresent("name:NodeView")){ renameCommunityPage.switchToFrame("NodeView"); 
				logger.info("NodeDetails present? " + renameCommunityPage.isElementPresent("name:NodeDetails"));
				if(renameCommunityPage.isElementPresent("name:NodeDetails")){ renameCommunityPage.switchToFrame("NodeDetails"); }
			}
		}
		else {
			logger.info("Selecting AppBody.NodeView.NodeDetails");
			renameCommunityPage.switchToFrame("AppBody.NodeView.NodeDetails");
		}
		renameCommunityPage.waitForPageLoad();
		renameCommunityPage.typeCommunityName(communityNewName);
		renameCommunityPage.clickSave();
		
		CommunityStatusPage communityStatusPage = (CommunityStatusPage) PageFactory.initElements(getDriver(), CommunityStatusPage.class);
		Thread.sleep(5000);
		communityStatusPage.switchToDefaultContent();
		logger.info("AppBody present? " + communityStatusPage.isElementPresent("name:AppBody"));
		if(communityStatusPage.isElementPresent("name:AppBody")){ communityStatusPage.switchToFrame("AppBody"); 
			logger.info("NodeView present? " + communityStatusPage.isElementPresent("name:NodeView"));
			if(communityStatusPage.isElementPresent("name:NodeView")){ communityStatusPage.switchToFrame("NodeView"); 
				logger.info("NodeDetails present? " + communityStatusPage.isElementPresent("name:NodeDetails"));
				if(communityStatusPage.isElementPresent("name:NodeDetails")){ communityStatusPage.switchToFrame("NodeDetails"); }
			}
		}
		else {
			logger.info("Selecting AppBody.NodeView.NodeDetails");
			communityStatusPage.switchToFrame("AppBody.NodeView.NodeDetails");
		}
		communityStatusPage.switchToDefaultContent();
		communityStatusPage.switchToFrame("AppHeader");
		
		communityStatusPage.findElement(communityStatusPage.getDriver(), By.xpath("//a[text()='LOG OFF']")).click(); Thread.sleep(1000);
	}
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		logger.info("Completed a branding test.");
		super.stopWebDriverTest();
	}
	@AfterSuite(alwaysRun = true)
	public void stopSuite() throws Exception {
		logger.info("Completed Branding Tests");
		super.stopAllWebDriverTest();
	}

}
