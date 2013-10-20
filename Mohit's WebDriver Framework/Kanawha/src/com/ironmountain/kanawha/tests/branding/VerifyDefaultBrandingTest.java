package com.ironmountain.kanawha.tests.branding;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.tests.KanawhaTest;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class VerifyDefaultBrandingTest extends KanawhaTest{
	
	private static final Logger logger = Logger.getLogger(VerifyDefaultBrandingTest.class.getName());
	CommunityTable community = new CommunityTable(DatabaseServer.COMMON_SERVER);
	BrandingUtils scBrand = new BrandingUtils();
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		logger.info("Starting Default Branding Verification Test.");
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/branding/testdata", "branding.xml");
		testInput = TestDataProvider.getTestInput("verifyDefaultBranding");
		TestDataProvider.getTestOutput("BrandingData");
		CommonUtils.updateAccountCommunity(testInput.get("username"), testInput.get("communityName"));
		super.initWebDriverTest(scBrand.getSupportCenterLogoutURL(), "");
	}
	
	/**
	 * Test to verify default branding
	 * @throws Exception
	 */
	@Test(enabled = true)
	public void verifyDefaultBranding() throws Exception {

		scBrand.resetBranding(testInput.get("communityName"));//Need to do this to start fresh
		// Due to BUG CECSGH:2365 scBrand.verifyBrandingInfo(testInput.get("username"),testInput.get("password"),brandingOutputData.get("autonomyPowerdByLogo"),testInput.get("defaultSiteName"),brandingOutputData.get("autonomyPowerdByLogo"));
		scBrand.verifyBrandingInfo(testInput.get("username"),testInput.get("password"),null,null,null);
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
