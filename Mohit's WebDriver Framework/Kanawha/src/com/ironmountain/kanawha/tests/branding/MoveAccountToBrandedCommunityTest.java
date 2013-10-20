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

public class MoveAccountToBrandedCommunityTest extends KanawhaTest{
	private static final Logger logger = Logger.getLogger(MoveAccountToBrandedCommunityTest.class.getName());
	CommunityTable community = new CommunityTable(DatabaseServer.COMMON_SERVER);
	BrandingUtils scBrand = new BrandingUtils();
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	private static HashMap<String, String> brandingOutputData = new HashMap<String,String>();
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		logger.info("Starting MoveAccountToBrandedCommunityTest.");
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/branding/testdata", "branding.xml");
		testInput = TestDataProvider.getTestInput("moveAccountToBrandedCommunity");
		brandingOutputData = TestDataProvider.getTestOutput("BrandingData");
		super.initWebDriverTest(scBrand.getSupportCenterLogoutURL(), "");
	}
	
	/**
	 * This test moves an account between branded and (un)branded communities and verifies its effect each time
	 * @throws Exception
	 */
	@Test(enabled = true)
	public void moveAccountToBrandedCommunity() throws Exception {
		
		BrandingUtils scBrand = new BrandingUtils();
		this.updateCommunityForAccount(testInput.get("username"), testInput.get("communityName"));// doing this to undo the effect of any previous account movement in account migration tests
		
		// Move account from unbranded to branded
		scBrand.resetBranding(testInput.get("communityName"));
		scBrand.verifyBrandingInfo(testInput.get("username"),testInput.get("password"), null,null,null);
		
		scBrand.applyBranding(testInput.get("targetCommunity"),FileUtils.getBaseDirectory() + testInput.get("imagePath2"), testInput.get("siteName2"),testInput.get("poweredByLogo2"));
		this.updateCommunityForAccount(testInput.get("username"), testInput.get("targetCommunity"));
		scBrand.verifyBrandingInfo(testInput.get("username"),testInput.get("password"), brandingOutputData.get("batMan"),testInput.get("siteName2"),brandingOutputData.get("autonomyPowerdByLogo"));
		
		// Move account from branded to unbranded
		this.updateCommunityForAccount(testInput.get("username"), testInput.get("communityName"));
		scBrand.verifyBrandingInfo(testInput.get("username"),testInput.get("password"), null,null,null);
		
		//Move account from branded to branded
		scBrand.applyBranding(testInput.get("communityName"),FileUtils.getBaseDirectory() + testInput.get("imagePath1"), testInput.get("siteName1"),testInput.get("poweredByLogo1"));
		scBrand.verifyBrandingInfo(testInput.get("username"),testInput.get("password"), brandingOutputData.get("spiderMan"),testInput.get("siteName1"),brandingOutputData.get("autonomyPowerdByLogo"));
		this.updateCommunityForAccount(testInput.get("username"), testInput.get("targetCommunity"));
		scBrand.verifyBrandingInfo(testInput.get("username"),testInput.get("password"), brandingOutputData.get("batMan"),testInput.get("siteName2"),brandingOutputData.get("autonomyPowerdByLogo"));
		
		this.updateCommunityForAccount(testInput.get("username"), testInput.get("communityName"));// doing this to undo the effect of any previous account movement in account migration tests
	}
	
	private void updateCommunityForAccount(String username, String targetCommunity) throws Exception {
		CommonUtils.updateAccountCommunity(username, targetCommunity);
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
